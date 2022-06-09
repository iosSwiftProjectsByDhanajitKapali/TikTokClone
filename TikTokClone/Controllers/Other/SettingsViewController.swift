//
//  SettingsViewController.swift
//  TikTokClone
//
//  Created by unthinkable-mac-0025 on 18/05/22.
//

import UIKit
import SafariServices

struct SettingsSection {
    let title : String
    let options : [SettingsOption]
}

struct SettingsOption {
    let title : String
    let handler : (() -> Void)
}

class SettingsViewController: UIViewController {

    var sections = [SettingsSection]()
    
    // MARK: - UI Components
    private let tableView : UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        return table
    }()

}


// MARK: - LifeCycle Methods
extension SettingsViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        
        sections = [
            SettingsSection(
                title: "Information",
                options: [
                    SettingsOption(
                        title: "Terms Of Service", handler: { [weak self] in
                            DispatchQueue.main.async {
                                guard let url = URL(string: "https://www.tiktok.com/legal/terms-of-service") else{
                                    return
                                }
                                let vc = SFSafariViewController(url: url)
                                self?.present(vc, animated: true)
                            }
                        }
                    ),
                    SettingsOption(
                        title: "Privacy Policy", handler: { [weak self] in
                            DispatchQueue.main.async {
                                guard let url = URL(string: "https://www.tiktok.com/legal/privacy-policy") else{
                                    return
                                }
                                let vc = SFSafariViewController(url: url)
                                self?.present(vc, animated: true)
                            }
                        }
                    )
                ])
        ]
        
        tableView.delegate = self
        tableView.dataSource = self
        createFooter()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}

            
// MARK: - Private Methods
private extension SettingsViewController {
    
    func createFooter() {
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: 100))
        let button = UIButton(frame: CGRect(x: (view.width-200)/2, y: 25, width: 200, height: 50))
        button.setTitle("Sign Out", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.addTarget(self, action: #selector(didTapSignOut), for: .touchUpInside)
        footer.addSubview(button)
        tableView.tableFooterView = footer
    }
    
    @objc func didTapSignOut() {
        let actionSheet = UIAlertController(
            title: "SignOut",
            message: "Would you like to SignOut?",
            preferredStyle: .actionSheet
        )
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        actionSheet.addAction(UIAlertAction(title: "SignOut", style: .destructive, handler: {[weak self] _ in
            DispatchQueue.main.async {
                AuthManager.shared.signOut { sucess in
                    if sucess {
                        UserDefaults.standard.setValue(nil, forKey: "username")
                        UserDefaults.standard.setValue(nil, forKey: "profile_picture_url")
                        
                        let vc = SignInViewController()
                        let navVC = UINavigationController(rootViewController: vc)
                        navVC.modalPresentationStyle = .fullScreen
                        self?.present(navVC, animated: true)
                        
                        self?.navigationController?.popToRootViewController(animated: true)
                        self?.tabBarController?.selectedIndex = 0
                    }else {
                        //Failed to SignOut
                        let alert = UIAlertController(
                            title: "Woops",
                            message: "Something went wrong while signing out. Please try again later!",
                            preferredStyle: .alert
                        )
                        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                        self?.present(alert, animated: true)
                    }
                }
            }
            
        }))
        present(actionSheet, animated: true)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource Methods
extension SettingsViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = sections[indexPath.section].options[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = model.title
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = sections[indexPath.section].options[indexPath.row]
        model.handler()
    }
    
}
