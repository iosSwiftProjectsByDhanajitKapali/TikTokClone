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
        //scrollView.backgroundColor = .red
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
        
    }()
    
    private let forYouPageViewController = UIPageViewController(
        transitionStyle: .scroll,
        navigationOrientation: .vertical,
        options: [:]
    )
    
    private let followingPageViewController = UIPageViewController(
        transitionStyle: .scroll,
        navigationOrientation: .vertical,
        options: [:]
    )
    
    private let segmentedControl : UISegmentedControl = {
        let titles = ["Following", "For You"]
        let control = UISegmentedControl(items: titles)
        control.selectedSegmentIndex = 1
        //control.selectedSegmentTintColor = .white
        return control
    }()
    
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
        horizontalScrollView.contentInsetAdjustmentBehavior = .never
        horizontalScrollView.delegate = self
        horizontalScrollView.contentOffset = CGPoint(x: view.width, y: 0)
        setUpHeaderButtons()
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
    
    func setUpHeaderButtons(){
        segmentedControl.addTarget(self, action: #selector(didChangeSegmentControl(_:)), for: .valueChanged)
        navigationItem.titleView = segmentedControl
    }
    
    @objc func didChangeSegmentControl(_ sender : UISegmentedControl){
        horizontalScrollView.setContentOffset(
            CGPoint(x: view.width * CGFloat(sender.selectedSegmentIndex), y: 0),
            animated: true)
    }
    
    func setUpFollowingFeed(){
        guard let model = followingPosts.first else{
            return
        }
        
        let vc = PostViewController(model: model)
        vc.delegate = self
        followingPageViewController.setViewControllers(
            [vc],
            direction: .forward,
            animated: true,
            completion: nil
        )
        
        followingPageViewController.dataSource = self
        
        //add pagingController as a child
        horizontalScrollView.addSubview(followingPageViewController.view)
        followingPageViewController.view.frame = CGRect(
            x: 0,
            y: 0,
            width: horizontalScrollView.width,
            height: horizontalScrollView.height
        )
        addChild(followingPageViewController)
        followingPageViewController.didMove(toParent: self)
    }
    
    func setUpForYouFeed(){
        guard let model = forYouPosts.first else{
            return
        }
        
        let vc = PostViewController(model: model)
        vc.delegate = self
        forYouPageViewController.setViewControllers(
            [vc],
            direction: .forward,
            animated: true,
            completion: nil
        )
        
        forYouPageViewController.dataSource = self
        
        //add pagingController as a child
        horizontalScrollView.addSubview(forYouPageViewController.view)
        forYouPageViewController.view.frame = CGRect(
            x: view.width,
            y: 0,
            width: horizontalScrollView.width,
            height: horizontalScrollView.height
        )
        addChild(forYouPageViewController)
        forYouPageViewController.didMove(toParent: self)
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
        vc.delegate = self
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
        vc.delegate = self
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


// MARK: - UIScrollViewDelegate Methods
extension HomeViewController : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x == 0 || scrollView.contentOffset.x <= (view.width/2){
            segmentedControl.selectedSegmentIndex = 0
            
        }else if scrollView.contentOffset.x > (view.width/2){
            segmentedControl.selectedSegmentIndex = 1
        }
    }
}


// MARK: - PostViewControllerDelegate Methods
extension HomeViewController : PostViewControllerDelegate {
    func postViewController(_ vc: PostViewController, didTapCommentsButtonFor post: PostModel) {
        //Block Scrolling b/w posts when comments section is open
        horizontalScrollView.isScrollEnabled = false
        if horizontalScrollView.contentOffset.x == 0{
            //Following Section
            followingPageViewController.dataSource = nil
        }else{
            //For-You Section
            forYouPageViewController.dataSource = nil
        }
        
        HapticsManager.shared.vibrateForSelection()
        
        //Present the Comments tray
        let vc = CommentsViewController(post: post)
        vc.delegate = self
        addChild(vc)
        vc.didMove(toParent: self)
        view.addSubview(vc.view)
        let frame : CGRect = CGRect(
            x: 0,
            y: view.height,
            width: view.width,
            height: (view.height * 0.75)
        )
        vc.view.frame = frame
        UIView.animate(withDuration: 0.2) {
            vc.view.frame = CGRect(
                x: 0,
                y: self.view.height - frame.height,
                width: frame.width,
                height: frame.height
            )
        }
    }
    
    func postViewController(_ vc: PostViewController, didTapProfileButtonFor post: PostModel) {
        let user = post.user
        let vc = ProfileViewController(user: user)
        navigationController?.pushViewController(vc, animated: true)
    }
}


// MARK: - CommentsViewControllerDelegate Methods
extension HomeViewController : CommentsViewControllerDelegate {
    func didTapCloseForComments(with viewController: CommentsViewController) {
        //Animate Hide the Comments Tray
        let frame = viewController.view.frame
        UIView.animate(withDuration: 0.2) {
            viewController.view.frame = CGRect(
                x: 0,
                y: self.view.height,
                width: frame.width,
                height: frame.height
            )
        } completion: { [weak self] done in
            if done {
                DispatchQueue.main.async {
                    //and Remove the tray as a child
                    viewController.view.removeFromSuperview()
                    viewController.removeFromParent()
                    
                    //Also Enable the Scolling
                    self?.horizontalScrollView.isScrollEnabled = true
                    self?.followingPageViewController.dataSource = self
                    self?.forYouPageViewController.dataSource = self
                }
                
            }
        }

        
        
    }
}
