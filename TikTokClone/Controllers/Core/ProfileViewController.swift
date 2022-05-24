//
//  ProfileViewController.swift
//  TikTokClone
//
//  Created by unthinkable-mac-0025 on 18/05/22.
//

import UIKit

class ProfileViewController: UIViewController {

    let user : User
    
    
    //Intializers
    init(user : User){
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder : NSCoder) {
        fatalError()
    }

}


// MARK: - Lifecylce Methods
extension ProfileViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = user.userName.uppercased()
        view.backgroundColor = .systemBackground

    }
}
