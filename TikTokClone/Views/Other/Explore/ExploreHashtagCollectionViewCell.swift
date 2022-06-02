//
//  ExploreHashtagCollectionViewCell.swift
//  TikTokClone
//
//  Created by unthinkable-mac-0025 on 27/05/22.
//

import UIKit

class ExploreHashtagCollectionViewCell: UICollectionViewCell {
    static let identifier = "ExploreHashtagCollectionViewCell"
    
    // MARK: - UI Components
    private let iconImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        //imageView.clipsToBounds = true
        //imageView.layer.masksToBounds = true
        //imageView.backgroundColor = .secondarySystemBackground
        return imageView
    }()
    
    private let hashtagLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize : 20, weight : .medium)
        //label.textAlignment = .center
        return label
    }()
    
    
    // MARK: - Initializers
    override init(frame : CGRect) {
        super.init(frame: frame)
        contentView.clipsToBounds = true
        contentView.addSubview(iconImageView)
        contentView.addSubview(hashtagLabel)
        contentView.backgroundColor = .systemGray5
        contentView.layer.cornerRadius = 10
    }
    
    required init?(coder : NSCoder) {
        fatalError()
    }
    
    
    // MARK: - Leifecycle Methods
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let iconSize : CGFloat = contentView.height/3
        iconImageView.frame = CGRect(
            x: 10,
            y: (contentView.height - iconSize)/2,
            width: iconSize,
            height: iconSize
        ).integral
        
        hashtagLabel.sizeToFit()
        hashtagLabel.frame = CGRect(
            x: iconImageView.right + 10,
            y: 0,
            width: contentView.width - iconImageView.right - 10,
            height: contentView.height
        ).integral
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        hashtagLabel.text = nil
        iconImageView.image = nil
    }
    
    
    // MARK: - Public Methods
    func configure(with viewModel : ExploreHashtagViewModel){
        hashtagLabel.text = viewModel.text
        iconImageView.image = viewModel.icon
    }
}
