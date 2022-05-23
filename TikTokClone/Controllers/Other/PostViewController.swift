//
//  PostViewController.swift
//  TikTokClone
//
//  Created by unthinkable-mac-0025 on 18/05/22.
//

import UIKit

class PostViewController: UIViewController {

    let model : PostModel
    
    init(model : PostModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder : NSCoder) {
        fatalError()
    }
}


// MARK: - Lifecycle Methods
extension PostViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let colors : [UIColor] = [
            .red, .green, .orange, .blue, .white, .systemPink
        ]
        
        view.backgroundColor = colors.randomElement()
    }
}
