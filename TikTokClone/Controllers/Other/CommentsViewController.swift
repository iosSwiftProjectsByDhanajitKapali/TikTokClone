//
//  CommentsViewController.swift
//  TikTokClone
//
//  Created by unthinkable-mac-0025 on 24/05/22.
//

import UIKit

class CommentsViewController: UIViewController {

    private let post : PostModel
    
    
    //Initalizers
    init(post : PostModel){
        self.post = post
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder : NSCoder){
        fatalError()
    }
    
}


// MARK: - Lifecycle Methods
extension CommentsViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        fetchPostComments()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}


// MARK: - Private Methods
extension CommentsViewController {
    
    func fetchPostComments(){
        
    }
}
