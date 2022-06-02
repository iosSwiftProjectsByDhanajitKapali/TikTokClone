//
//  NotificationPostLikeTableViewCell.swift
//  TikTokClone
//
//  Created by unthinkable-mac-0025 on 02/06/22.
//

import UIKit

class NotificationPostLikeTableViewCell: UITableViewCell {

    static let identifier = "NotificationPostLikeTableViewCell"
    
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
        label.textColor = .label
        return label
    }()
    
    
    //Initializers
    override init(style : UITableViewCell.CellStyle, reuseIdentifier : String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(postThumbnailImageView)
        contentView.addSubview(label)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        postThumbnailImageView.image = nil
        label.text = nil
    }
    
    func configure(with postFileName : String) {
        
    }
}
