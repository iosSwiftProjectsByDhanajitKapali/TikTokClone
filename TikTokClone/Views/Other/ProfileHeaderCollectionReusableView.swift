//
//  ProfileHeaderCollectionReusableView.swift
//  TikTokClone
//
//  Created by unthinkable-mac-0025 on 07/06/22.
//

import UIKit
import SDWebImage

protocol ProfileHeaderCollectionReusableViewDelegate : AnyObject {
    
    func profileHeaderCollectionReusableView(_ header : ProfileHeaderCollectionReusableView, didTapPrimaryButtonWith viewModel : ProfileHeaderViewModel)
    
    func profileHeaderCollectionReusableView(_ header : ProfileHeaderCollectionReusableView, didTapFollowersButtonWith viewModel : ProfileHeaderViewModel)
    
    func profileHeaderCollectionReusableView(_ header : ProfileHeaderCollectionReusableView, didTapFollowingButtonWith viewModel : ProfileHeaderViewModel)
    
    func profileHeaderCollectionReusableView(_ header : ProfileHeaderCollectionReusableView, didTapAvatarFor viewModel : ProfileHeaderViewModel)
    
}

class ProfileHeaderCollectionReusableView: UICollectionReusableView {
    static let identifier = "ProfileHeaderCollectionReusableView"
    
    weak var delegate : ProfileHeaderCollectionReusableViewDelegate?
    
    var viewModel : ProfileHeaderViewModel?
    
    // MARK: - UI Components
    private let avatarImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .secondarySystemBackground
        return imageView
    }()
    
    //Follow/Edit Button
    private let primaryButton : UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 6
        button.layer.masksToBounds = true
        button.setTitle("Follow", for: .normal)
        button.backgroundColor = .systemPink
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    private let followersButton : UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 6
        button.layer.masksToBounds = true
        button.setTitle("0\nFollowers", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.numberOfLines = 2
        button.backgroundColor = .secondarySystemBackground
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    private let followingButton : UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 6
        button.layer.masksToBounds = true
        button.setTitle("0\nFollowing", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.numberOfLines = 2
        button.backgroundColor = .secondarySystemBackground
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        backgroundColor = .systemBackground
        addSubViews()
        configureButtons()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapAvatar))
        avatarImageView.isUserInteractionEnabled = true
        avatarImageView.addGestureRecognizer(tap)
        
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    

    
    
}


// MARK: - LifeCycle Methods
extension ProfileHeaderCollectionReusableView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let avatarSize : CGFloat = 130
        avatarImageView.frame = CGRect(
            x: (width-avatarSize)/2,
            y: 10,
            width: avatarSize,
            height: avatarSize
        )
        avatarImageView.layer.cornerRadius = avatarSize/2
        followersButton.frame = CGRect(
            x: (width-210)/2,
            y: avatarImageView.bottom + 10,
            width: 100,
            height: 60
        )
        followingButton.frame = CGRect(
            x: followersButton.right + 10,
            y: avatarImageView.bottom + 10,
            width: 100,
            height: 60
        )
        primaryButton.frame = CGRect(
            x: (width-220)/2,
            y: followingButton.bottom+15,
            width: 220,
            height: 45
        )
    }
    
}


// MARK: - Public Methods
extension ProfileHeaderCollectionReusableView {
    
    public func configure(with viewModel : ProfileHeaderViewModel) {
        self.viewModel = viewModel
        //Set up our header
        followersButton.setTitle("\(viewModel.followerCount)\nFollowers", for: .normal)
        followingButton.setTitle("\(viewModel.followingCount)\nFollowing", for: .normal)
        
        if let avatarURL = viewModel.avatarImageURL {
            avatarImageView.sd_setImage(with: avatarURL)
        }else {
            avatarImageView.image = UIImage(named: "sampleImage1")
        }
        
        if let isFollowing = viewModel.isFollowing {
            primaryButton.backgroundColor = isFollowing ? .secondarySystemBackground : .systemPink
            primaryButton.setTitle(isFollowing ? "Unfollow" : "Follow" , for: .normal)
            
        } else {
            primaryButton.backgroundColor = .secondarySystemBackground
            primaryButton.setTitle("Edit Profile", for: .normal)
        }
    }
}


// MARK: - Private Methods
extension ProfileHeaderCollectionReusableView {
    
    private func addSubViews() {
        addSubview(avatarImageView)
        addSubview(primaryButton)
        addSubview(followersButton)
        addSubview(followingButton)
    }
    
    private func configureButtons() {
        primaryButton.addTarget(self, action: #selector(didTapPrimaryButton), for: .touchUpInside)
        followersButton.addTarget(self, action: #selector(didTapFollowersButton), for: .touchUpInside)
        followingButton.addTarget(self, action: #selector(didTapFollowingButton), for: .touchUpInside)
    }
    
    //Actions
    @objc private func didTapPrimaryButton() {
        guard let viewModel = self.viewModel else {
            return
        }
        delegate?.profileHeaderCollectionReusableView(self, didTapPrimaryButtonWith: viewModel)
    }
    
    @objc private func didTapFollowersButton() {
        guard let viewModel = self.viewModel else {
            return
        }
        delegate?.profileHeaderCollectionReusableView(self, didTapFollowersButtonWith: viewModel)
    }
    
    @objc private func didTapFollowingButton() {
        guard let viewModel = self.viewModel else {
            return
        }
        delegate?.profileHeaderCollectionReusableView(self, didTapFollowingButtonWith: viewModel)
    }
    
    @objc private func didTapAvatar() {
        guard let viewModel = self.viewModel else {
            return
        }
        delegate?.profileHeaderCollectionReusableView(self, didTapAvatarFor: viewModel)
    }
}
