//
//  ViewController.swift
//  TikTokClone
//
//  Created by unthinkable-mac-0025 on 18/05/22.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: - UI Components
    private let horizontalScrollView : UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.backgroundColor = .red
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
        
    }()
    
    private let forYouPagingController = UIPageViewController(
        transitionStyle: .scroll,
        navigationOrientation: .vertical,
        options: [:]
    )
    
    private let followingPagingController = UIPageViewController(
        transitionStyle: .scroll,
        navigationOrientation: .vertical,
        options: [:]
    )
    
    // MARK: - Private Data Members
    private var forYouPosts = PostModel.mockModels()
    private var followingPosts = PostModel.mockModels()

}


// MARK: - Lifecycle Methods
extension HomeViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        view.addSubview(horizontalScrollView)
        
        setUpFeeds()
        horizontalScrollView.contentOffset = CGPoint(x: view.width, y: 0)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        horizontalScrollView.frame = view.bounds
    }
}


// MARK: - Private Methods
private extension HomeViewController{
    func setUpFeeds(){
        horizontalScrollView.contentSize = CGSize(width: view.width * 2, height: view.height)
        setUpFollowingFeed()
        setUpForYouFeed()
    }
    
    func setUpFollowingFeed(){
        guard let model = followingPosts.first else{
            return
        }
        
        followingPagingController.setViewControllers(
            [PostViewController(model: model)],
            direction: .forward,
            animated: true,
            completion: nil
        )
        
        followingPagingController.dataSource = self
        
        //add pagingController as a child
        horizontalScrollView.addSubview(followingPagingController.view)
        followingPagingController.view.frame = CGRect(
            x: 0,
            y: 0,
            width: horizontalScrollView.width,
            height: horizontalScrollView.height
        )
        addChild(followingPagingController)
        followingPagingController.didMove(toParent: self)
    }
    
    func setUpForYouFeed(){
        guard let model = forYouPosts.first else{
            return
        }
        
        forYouPagingController.setViewControllers(
            [PostViewController(model: model)],
            direction: .forward,
            animated: true,
            completion: nil
        )
        
        forYouPagingController.dataSource = self
        
        //add pagingController as a child
        horizontalScrollView.addSubview(forYouPagingController.view)
        forYouPagingController.view.frame = CGRect(
            x: view.width,
            y: 0,
            width: horizontalScrollView.width,
            height: horizontalScrollView.height
        )
        addChild(forYouPagingController)
        forYouPagingController.didMove(toParent: self)
    }
}


// MARK: - UIPageViewControllerDataSource Methods
extension HomeViewController : UIPageViewControllerDataSource{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let currentPost = (viewController as? PostViewController)?.model else {
            return nil
        }
        
        guard let currentPostindex = currentPosts.firstIndex(where: {
            $0.identifier == currentPost.identifier
        }) else{
            return nil
        }
        
        if currentPostindex == 0{
            return nil
        }
        
        let priorPostIndex = currentPostindex-1
        let model = currentPosts[priorPostIndex]
        let vc = PostViewController(model: model)
        return vc
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let currentPost = (viewController as? PostViewController)?.model else {
            return nil
        }
        
        guard let currentPostindex = currentPosts.firstIndex(where: {
            $0.identifier == currentPost.identifier
        }) else{
            return nil
        }
        
        guard currentPostindex < (currentPosts.count-1) else{
            return nil
        }
        
        let nextPostIndex = currentPostindex + 1
        let model = currentPosts[nextPostIndex]
        let vc = PostViewController(model: model)
        return vc
        
    }
    
    var currentPosts : [PostModel] {
        if horizontalScrollView.contentOffset.x == 0{
            //Follfowing
            return followingPosts
        }
        
        return forYouPosts
    }
    
}

