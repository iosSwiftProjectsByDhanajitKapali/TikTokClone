//
//  ExploreUserCollectionViewCell.swift
//  TikTokClone
//
//  Created by unthinkable-mac-0025 on 27/05/22.
//

import UIKit

class ExploreUserCollectionViewCell: UICollectionViewCell {
    static let identifier = "ExploreUserCollectionViewCell"
    
    // MARK: - UI Components
    private let profilePicture : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .secondarySystemBackground
        return imageView
    }()
    
    private let userNameLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize : 18, weight : .light)
        label.textAlignment = .center
        return label
    }()
    
    
    // MARK: - Initializers
    override init(frame : CGRect) {
        super.init(frame: frame)
        contentView.clipsToBounds = true
        contentView.addSubview(profilePicture)
        contentView.addSubview(userNameLabel)
    }
    
    required init?(coder : NSCoder) {
        fatalError()
    }
    
    
    // MARK: - Lifecyle Methods
    override func layoutSubviews() {
        super.layoutSubviews()
        let imageSize : CGFloat = contentView.height - 55
        profilePicture.frame = CGRect(
            x: (contentView.width-imageSize)/2,
            y: 0,
            width: imageSize,
            height: imageSize
        )
        profilePicture.layer.cornerRadius = profilePicture.height/2
        userNameLabel.frame = CGRect(
            x: 0,
            y: profilePicture.bottom,
            width: contentView.width,
            height: 55
        )
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        userNameLabel.text = nil
        profilePicture.image = nil
    }
    
    
    // MARK: - Public Methods
    func configure(with viewModel : ExploreUserViewModel){
        userNameLabel.text = viewModel.userName
        if let url = viewModel.profilePictureURL {
            profilePicture.image = UIImage(systemName: "person.circle")
        }
        else {
            profilePicture.tintColor = .systemBlue
            profilePicture.image = UIImage(systemName: "person.circle")
        }
    }
}
