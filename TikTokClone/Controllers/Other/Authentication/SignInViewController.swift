//
//  SignInViewController.swift
//  TikTokClone
//
//  Created by unthinkable-mac-0025 on 18/05/22.
//

import UIKit

class SignInViewController: UIViewController {
    
    // MARK: - Public Data Members
    public var completion : (() -> Void)?
    
}


// MARK: - LifeCycle Methods
extension SignInViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Sign In"
        view.backgroundColor = .systemBackground
        
    }
}
