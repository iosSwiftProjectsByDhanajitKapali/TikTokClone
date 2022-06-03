//
//  NotificationsViewController.swift
//  TikTokClone
//
//  Created by unthinkable-mac-0025 on 18/05/22.
//

import UIKit

class NotificationsViewController: UIViewController {

    
    // MARK: - Private Data Members
    private var notifications = [NotificationModel]()
    
    
    // MARK: - UI Components
    private let notNotificationsLabel : UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.text = "No Notifications"
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    private let tableView : UITableView = {
        let tableView = UITableView()
        tableView.isHidden = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(NotificationPostLikeTableViewCell.self, forCellReuseIdentifier: NotificationPostLikeTableViewCell.identifier)
        tableView.register(NotificationPostCommentTableViewCell.self, forCellReuseIdentifier: NotificationPostCommentTableViewCell.identifier)
        tableView.register(NotificationUserFollowTableViewCell.self, forCellReuseIdentifier: NotificationUserFollowTableViewCell.identifier)
        return tableView
    }()
    
    private let spinner : UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.tintColor = .white
        spinner.startAnimating()
        return spinner
    }()
    
}


// MARK: - Lifecycle Methods
extension NotificationsViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(notNotificationsLabel)
        view.addSubview(tableView)
        view.addSubview(spinner)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        fetchNotifications()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
        notNotificationsLabel.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        notNotificationsLabel.center = view.center
        spinner.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        spinner.center = view.center
    }
    
}


// MARK: - Private Methods
private extension NotificationsViewController {
    
    func fetchNotifications() {
        DatabaseManager.shared.getNotifications { [weak self]notifications in
            DispatchQueue.main.async {
                self?.spinner.stopAnimating()
                self?.spinner.isHidden = true
                self?.notifications = notifications
                self?.updateUI()
            }
            
        }
    }
    
    func updateUI() {
        if notifications.isEmpty {
            notNotificationsLabel.isHidden = false
            tableView.isHidden = true
            
        }else {
            notNotificationsLabel.isHidden = true
            tableView.isHidden = false
        }
        
        tableView.reloadData()
    }
    
}


// MARK: - UITableViewDelegate, UITableViewDataSource Methods
extension NotificationsViewController : UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = notifications[indexPath.row]
        
        switch model.type {
        case .postLike(let postname):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: NotificationPostLikeTableViewCell.identifier,
                for: indexPath
            ) as? NotificationPostLikeTableViewCell else {
                return tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            }
            cell.configure(with: postname, model : model)
            return cell
            
        case .userFollow(let username):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: NotificationUserFollowTableViewCell.identifier,
                for: indexPath
            ) as? NotificationUserFollowTableViewCell else {
                return tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            }
            cell.configure(with: username, model : model)
            return cell
            
        case .postComment(let postname):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: NotificationPostCommentTableViewCell.identifier,
                for: indexPath
            ) as? NotificationPostCommentTableViewCell else {
                return tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            }
            cell.configure(with: postname, model : model)
            return cell
        }
            
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
