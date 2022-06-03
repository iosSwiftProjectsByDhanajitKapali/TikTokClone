//
//  NotificationPostLikeTableViewCell.swift
//  TikTokClone
//
//  Created by unthinkable-mac-0025 on 02/06/22.
//

import UIKit

protocol NotificationPostLikeTableViewCellDelegate : AnyObject {
    func notificationPostLikeTableViewCell(_ cell : NotificationPostLikeTableViewCell, didTapPostWith identifier : String)
}

class NotificationPostLikeTableViewCell: UITableViewCell {

    static let identifier = "NotificationPostLikeTableViewCell"
    
    weak var delegate : NotificationPostLikeTableViewCellDelegate?
    
    var postID : String?
    
    // MARK: - UI Components
    private let postThumbnailImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let label : UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.layer.masksToBounds = true
        label.textColor = .label
        return label
    }()
    
    private let dateLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .secondaryLabel
        return label
    }()
    
    //Initializers
    override init(style : UITableViewCell.CellStyle, reuseIdentifier : String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(postThumbnailImageView)
        contentView.addSubview(label)
        contentView.addSubview(dateLabel)
        selectionStyle = .none
        
        postThumbnailImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapThumbnail))
        postThumbnailImageView.addGestureRecognizer(tap)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let iconSize : CGFloat = 50
        postThumbnailImageView.frame = CGRect(
            x: 10,
            y: 10,
            width: iconSize,
            height: iconSize
        )
        postThumbnailImageView.layer.cornerRadius = 5
        postThumbnailImageView.layer.masksToBounds = true
        
        label.sizeToFit()
        dateLabel.sizeToFit()
        let labelSize = label.sizeThatFits(CGSize(
            width: contentView.width - 30 - iconSize,
            height: contentView.height
        ))
        label.frame = CGRect(
            x: postThumbnailImageView.right + 10,
            y: 5,
            width: labelSize.width,
            height: labelSize.height
        )
        dateLabel.frame = CGRect(
            x: postThumbnailImageView.right + 10,
            y: label.bottom + 2,
            width: contentView.width - postThumbnailImageView.width,
            height: 40
        )
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        postThumbnailImageView.image = nil
        label.text = nil
        dateLabel.text = nil
    }
    
    @objc func didTapThumbnail() {
        guard let id = postID else {
            return
        }
        delegate?.notificationPostLikeTableViewCell(self, didTapPostWith: id)
    }
    
    func configure(with postFileName : String, model : NotificationModel) {
        postID = postFileName
        postThumbnailImageView.image = UIImage(named: "sampleImage1")
        label.text = model.text
        dateLabel.text = .date(with: model.date)
    }
}
