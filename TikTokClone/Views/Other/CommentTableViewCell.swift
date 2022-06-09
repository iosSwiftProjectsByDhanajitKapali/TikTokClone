//
//  CommentTableViewCell.swift
//  TikTokClone
//
//  Created by unthinkable-mac-0025 on 24/05/22.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    
    static let identifier = "CommentTableViewCell"
    
    // MARK: - UI Components
    private let avatarImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let commentLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .label
        return label
    }()
    
    private let dateLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .secondaryLabel
        return label
    }()
    
    //Intiaizers
    override init(style : UITableViewCell.CellStyle, reuseIdentifier : String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        clipsToBounds = true
        
        backgroundColor = .secondarySystemBackground
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(avatarImageView)
        contentView.addSubview(commentLabel)
        contentView.addSubview(dateLabel)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}


// MARK: - Lifecyle Methods
extension CommentTableViewCell {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .systemBackground
        
        commentLabel.sizeToFit()
        dateLabel.sizeToFit()
        
        let imageSize : CGFloat = 45
        avatarImageView.frame = CGRect(
            x: 10,
            y: 5, //(contentView.height-imageSize)/2,
            width: imageSize,
            height: imageSize)
        
        let commentLabelHeight = min(contentView.height - dateLabel.top, commentLabel.height)
        commentLabel.frame = CGRect(
            x: avatarImageView.right + 10,
            y: 5,
            width: contentView.width - avatarImageView.right - 10,
            height: commentLabelHeight
        )
        dateLabel.frame = CGRect(
            x: avatarImageView.right + 10,
            y: commentLabel.bottom,
            width: dateLabel.width,
            height: dateLabel.height
        )
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        avatarImageView.image = nil
        commentLabel.text = nil
        dateLabel.text = nil
    }
}


// MARK: - Public Methods
extension CommentTableViewCell {
    
    func configure(with model : PostComment) {
        commentLabel.text = model.text
        dateLabel.text = .date(with: model.date)
        if let url = model.user.profilePictureURL {
            print(url)
        }else{
            avatarImageView.image = UIImage(systemName: "person.circle")
        }
    }
}
