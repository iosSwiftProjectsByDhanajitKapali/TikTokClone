//
//  UserListViewController.swift
//  TikTokClone
//
//  Created by unthinkable-mac-0025 on 18/05/22.
//

import UIKit

class UserListViewController: UIViewController {
    
    public var users = [String]()
    
    // MARK: - Private Data Members
    enum ListType : String {
        case followers
        case following
    }
    private let user : User
    private let type : ListType
    
    
    // MARK: - UI Components
    private let tableView : UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private let noUsersLabel : UILabel = {
        let label = UILabel()
        label.text = "No Users"
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        return label
    }()
    
    
    // MARK: - Initializers
    init(type : ListType, user : User) {
        self.type = type
        self.user = user
        
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}


// MARK: - LifeCycle Methods
extension UserListViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        switch type {
        case .followers:
            title = "Followers"
        case .following:
            title = "Following"
        }
        
        if users.isEmpty {
            view.addSubview(noUsersLabel)
            noUsersLabel.sizeToFit()
            
        }else {
            view.addSubview(tableView)
            tableView.delegate = self
            tableView.dataSource = self
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if tableView.superview == view {
            tableView.frame = view.bounds
            
        }else {
            noUsersLabel.center = view.center
        }
        
    }
}


// MARK: - UITableViewDelegate, UITableViewDataSource Methods
extension UserListViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = users[indexPath.row].lowercased()
        cell.selectionStyle = .none
        return cell
    }
    
    
}
