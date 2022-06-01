//
//  TabBarViewController.swift
//  TikTokClone
//
//  Created by unthinkable-mac-0025 on 18/05/22.
//

import UIKit

class TabBarViewController: UITabBarController {

    // MARK: - Private Data Members
    private var signInPresented = false
    
}


// MARK: - LifeCycle Methods
extension TabBarViewController{
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpControllers()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !signInPresented {
            presentSignInIfNeeded()
        }
    }
}

// MARK: - Private Methods
private extension TabBarViewController{
    
    func presentSignInIfNeeded() {
        if !AuthManager.shared.isSignIn {   //is user is not signedIn
            signInPresented = true
            let vc = SignInViewController()
            vc.completion = { [weak self] in
                self?.signInPresented = false
            }
            let navVC = UINavigationController(rootViewController: vc)
            navVC.modalPresentationStyle = .fullScreen
            present(navVC, animated: true)
        }
    }
    
    func setUpControllers() {
        let home = HomeViewController()
        let explore = ExploreViewController()
        let camera = CameraViewController()
        let notifications = NotificationsViewController()
        let profile = ProfileViewController(user: User(userName: "self", profilePictureURL: nil, identifier: "abc123"))
        
        //home.title = "Home"
        //explore.title = "Explore"
        notifications.title = "Notifications"
        profile.title = "Profile"
        
        let nav1 = UINavigationController(rootViewController: home)
        let nav2 = UINavigationController(rootViewController: explore)
        let nav3 = UINavigationController(rootViewController: notifications)
        let nav4 = UINavigationController(rootViewController: profile)
        let cameraNav = UINavigationController(rootViewController: camera)
        
        
        //Making the NavBar Transparent
        nav1.navigationBar.backgroundColor = .clear
        nav1.navigationBar.setBackgroundImage(UIImage(), for: .default)
        nav1.navigationBar.shadowImage = UIImage()
        cameraNav.navigationBar.backgroundColor = .clear
        cameraNav.navigationBar.setBackgroundImage(UIImage(), for: .default)
        cameraNav.navigationBar.shadowImage = UIImage()
        
        nav1.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "house"), tag : 1)
        nav2.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "safari"), tag : 2)
        camera.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "camera"), tag : 3)
        nav3.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "bell"), tag : 4)
        nav4.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "person.circle"), tag : 5)
        
        setViewControllers([nav1, nav2, cameraNav, nav3, nav4], animated: true)
    }
}
