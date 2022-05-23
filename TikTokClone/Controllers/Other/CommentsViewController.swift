//
//  CommentsViewController.swift
//  TikTokClone
//
//  Created by unthinkable-mac-0025 on 24/05/22.
//

import UIKit

protocol CommentsViewControllerDelegate : AnyObject {
    func didTapCloseForComments(with viewController : CommentsViewController)
}


class CommentsViewController: UIViewController {

    weak var delegate : CommentsViewControllerDelegate?
    
    // MARK: - Private Data Members
    private let post : PostModel
    private var comments = [PostComment]()
    
    // MARK: - UI Components
    private let closeButton : UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private let tableView : UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.register(CommentTableViewCell.self, forCellReuseIdentifier: CommentTableViewCell.identifier)
        return tableView
    }()
    
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
        view.addSubview(closeButton)
        closeButton.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
        view.backgroundColor = .white
        
        fetchPostComments()
        
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        closeButton.frame = CGRect(x: view.width - 45, y: 10, width: 35, height: 35)
        tableView.frame = CGRect(
            x: 0,
            y: closeButton.bottom + 10,
            width: view.width,
            height: view.width)
    }
}


// MARK: - Private Methods
extension CommentsViewController {
    
    @objc func didTapCloseButton(){
        delegate?.didTapCloseForComments(with: self)
    }
    
    func fetchPostComments(){
        //Get the Mock Comments for Now
        comments = PostComment.mockComments()
    }
}


// MARK: - UITableViewDelegate, UITableViewDataSource Methods
extension CommentsViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let comment = comments[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CommentTableViewCell.identifier, for: indexPath) as? CommentTableViewCell else{
            return UITableViewCell()
        }
        cell.configure(with: comment)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    //Delegate Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
