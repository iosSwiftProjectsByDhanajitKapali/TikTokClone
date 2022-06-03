//
//  NotificationUserFollowTableViewCell.swift
//  TikTokClone
//
//  Created by unthinkable-mac-0025 on 02/06/22.
//

import UIKit

class NotificationUserFollowTableViewCell: UITableViewCell {

    static let identifier = "NotificationUserFollowTableViewCell"
    
    // MARK: - UI Components
    //Avatrr, Label, Follow button
    private let avatarImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let label : UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .label
        return label
    }()
    
    private let dateLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let followButton : UIButton = {
        let button = UIButton()
        button.setTitle("Follow", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    
    
    //Initializers
    override init(style : UITableViewCell.CellStyle, reuseIdentifier : String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(avatarImageView)
        contentView.addSubview(label)
        contentView.addSubview(followButton)
        contentView.addSubview(dateLabel)
        selectionStyle = .none
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let iconSize : CGFloat = 50
        avatarImageView.frame = CGRect(
            x: 10,
            y: 5,
            width: iconSize,
            height: iconSize
        )
        avatarImageView.layer.cornerRadius = 25
        avatarImageView.layer.masksToBounds = true
        followButton.sizeToFit()
        followButton.frame = CGRect(
            x: contentView.width - 110,
            y: 5,
            width: 100,
            height: 35
        )
        label.sizeToFit()
        dateLabel.sizeToFit()
        let labelSize = label.sizeThatFits(CGSize(
            width: contentView.width - 30 - followButton.width - iconSize,
            height: contentView.height
        ))
        label.frame = CGRect(
            x: avatarImageView.right + 10,
            y: 5,
            width: labelSize.width,
            height: labelSize.height
        )
        dateLabel.frame = CGRect(
            x: avatarImageView.right + 10,
            y: label.bottom + 2,
            width: contentView.width - avatarImageView.width - followButton.width,
            height: 40
        )
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImageView.image = nil
        label.text = nil
        dateLabel.text = nil
    }
    
    func configure(with username : String, model : NotificationModel) {
        avatarImageView.image = (UIImage(named: "sampleImage1"))
        label.text = model.text
        dateLabel.text = .date(with: model.date)
    }
}
