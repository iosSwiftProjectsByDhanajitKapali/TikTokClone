//
//  ProfileViewController.swift
//  TikTokClone
//
//  Created by unthinkable-mac-0025 on 18/05/22.
//

import UIKit
import ProgressHUD

class ProfileViewController: UIViewController {
    
    var user : User
    
    var isCurrentUserProfile : Bool {
        if let username = UserDefaults.standard.string(forKey: "username") {
            return user.userName.lowercased() == username.lowercased()
        }
        return false
    }
    
    enum PicturePickerType {
        case Camera
        case PhotoLibrary
    }
    
    // MARK: - UI Components
    private let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(
            ProfileHeaderCollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "ProfileHeaderCollectionReusableView"
        )
        collectionView.register(
            UICollectionViewCell.self,
            forCellWithReuseIdentifier: "cell"
        )
        return collectionView
    }()
    
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

        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //Show Settings Icon for LogginIn User
        let username = UserDefaults.standard.string(forKey: "username")?.uppercased() ?? "Me"
        if title == username {
            navigationItem.rightBarButtonItem = UIBarButtonItem(
                image: UIImage(systemName: "gear"),
                style: .done,
                target: self,
                action: #selector(didTapSettings)
            )
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
}


// MARK: - Private Methods
private extension ProfileViewController {
    
    @objc func didTapSettings(){
        let vc = SettingsViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func presentProfilePicturePicker(type : PicturePickerType) {
        let picker = UIImagePickerController()
        picker.sourceType = type == .Camera ? .camera : .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }
}


// MARK: - UICollectionViewDelegate, UICollectionViewDataSource Methods
extension ProfileViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .systemBlue
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        //Open Post
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width : CGFloat = (view.width - 12)/3
        return CGSize(width: width, height: width*1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader,
              let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "ProfileHeaderCollectionReusableView",
                for: indexPath
              ) as? ProfileHeaderCollectionReusableView else {
            return UICollectionReusableView()
        }
        header.delegate = self
        
        //Mock with a ViewModel
        let viewModel = ProfileHeaderViewModel(
            avatarImageURL: user.profilePictureURL,
            followerCount: 120,
            followingCount: 200,
            isFollowing: isCurrentUserProfile ? nil : false
        )
        header.configure(with: viewModel)
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: view.width, height: 300)
    }
}


// MARK: - ProfileHeaderCollectionReusableViewDelegate Methods
extension ProfileViewController : ProfileHeaderCollectionReusableViewDelegate {
    
    func profileHeaderCollectionReusableView(_ header: ProfileHeaderCollectionReusableView, didTapPrimaryButtonWith viewModel: ProfileHeaderViewModel) {
        
        guard let currentUsername = UserDefaults.standard.string(forKey: "username") else {
            return
        }
        
        if self.user.userName == currentUsername {
            //Show Edit Profile Button
            
        }else {
            //Show Follow/Unfollow button
        }
    }
    
    func profileHeaderCollectionReusableView(_ header: ProfileHeaderCollectionReusableView, didTapFollowersButtonWith viewModel: ProfileHeaderViewModel) {
           
        
    }
    
    func profileHeaderCollectionReusableView(_ header: ProfileHeaderCollectionReusableView, didTapFollowingButtonWith viewModel: ProfileHeaderViewModel) {
        
    }
    
    func profileHeaderCollectionReusableView(_ header: ProfileHeaderCollectionReusableView, didTapAvatarFor viewModel:  ProfileHeaderViewModel) {
        
        guard isCurrentUserProfile else {
            return
        }
        
        //Show actionSheet to edit profile picture
        let actionSheet = UIAlertController(title: "Profile Picture", message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            DispatchQueue.main.async {
                self.presentProfilePicturePicker(type: .Camera)
            }
        }))
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { _ in
            DispatchQueue.main.async {
                self.presentProfilePicturePicker(type: .PhotoLibrary)
            }
        }))
        present(actionSheet, animated: true)
    }
    
    
}


// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate Methods
extension ProfileViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true)
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        
        //Upload image update UI
        ProgressHUD.show("Uploading")
        StorageManager.shared.uploadProfilePictue(with: image) { [weak self] result in
            DispatchQueue.main.async {
                guard let strongSelf = self else {
                    return
                }
                switch result {
                case .success(let downloadURL):
                    UserDefaults.standard.setValue(downloadURL.absoluteString, forKey: "profile_picture_url")
                    strongSelf.user = User(
                        userName: strongSelf.user.userName,
                        profilePictureURL: downloadURL,
                        identifier: strongSelf.user.userName
                    )
                    ProgressHUD.showSuccess("Updated")
                    strongSelf.collectionView.reloadData()
                    
                case .failure(_):
                    ProgressHUD.showError("Failed to upload profile picture")
                }
            }
        }
    }
}
