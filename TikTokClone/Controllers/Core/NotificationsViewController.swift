//
//  NotificationsViewController.swift
//  TikTokClone
//
//  Created by unthinkable-mac-0025 on 18/05/22.
//

import UIKit

class NotificationsViewController: UIViewController {

    
    // MARK: - UI Components
    private let textInput : UITextField = {
        let field = UITextField()
        field.backgroundColor = .red
        return field
    }()
    
}


// MARK: - Lifecycle Methods
extension NotificationsViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(textInput)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let textFieldHeight : CGFloat = 40
        textInput.frame = CGRect(
            x: 20,
            y: (view.height - textFieldHeight)/2,
            width: view.width-40,
            height: textFieldHeight
        )
    }
    
}
