//
//  CaptionViewController.swift
//  TikTokClone
//
//  Created by unthinkable-mac-0025 on 01/06/22.
//

import UIKit

class CaptionViewController: UIViewController {

    let videoURL : URL
    
    init(videoURL : URL){
        self.videoURL = videoURL
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder : NSCoder){
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add Caption"
        
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Post",
            style: .done,
            target: self,
            action: #selector(didTapPost)
        )
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

}


// MARK: - Private Methods
private extension CaptionViewController {
    
    @objc func didTapPost() {
        
    }
}
