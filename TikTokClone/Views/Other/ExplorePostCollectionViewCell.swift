//
//  ExplorePostCollectionViewCell.swift
//  TikTokClone
//
//  Created by unthinkable-mac-0025 on 27/05/22.
//

import UIKit

class ExplorePostCollectionViewCell: UICollectionViewCell {
    static let identifier = "ExplorePostCollectionViewCell"
    
    // MARK: - UI Components
    private let thumbnailImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let captionLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        //label.font = .systemFont(ofSize : 24, weight : .semibold)
        return label
    }()
    
    
    // MARK: - Initializers
    override init(frame : CGRect) {
        super.init(frame: frame)
        contentView.clipsToBounds = true
        contentView.addSubview(thumbnailImageView)
        contentView.addSubview(captionLabel)
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
    }
    
    required init?(coder : NSCoder) {
        fatalError()
    }
    
    
    // MARK: - Lifecycle Methods
    override func layoutSubviews() {
        super.layoutSubviews()
        let captionHeight = contentView.height/5
        thumbnailImageView.frame = CGRect(
            x: 0,
            y: 0,
            width: contentView.width,
            height: contentView.height-captionHeight
        )
        captionLabel.frame = CGRect(
            x: 0,
            y: contentView.height-captionHeight,
            width: contentView.width,
            height: captionHeight
        )
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        thumbnailImageView.image = nil
        captionLabel.text = nil
    }
    
    
    // MARK: - Public Methods
    func configure(with viewModel : ExplorePostViewModel){
        captionLabel.text = viewModel.caption
        thumbnailImageView.image = viewModel.thumbnailImage
    }
}
