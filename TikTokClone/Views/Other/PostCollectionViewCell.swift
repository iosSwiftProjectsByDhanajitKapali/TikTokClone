//
//  PostCollectionViewCell.swift
//  TikTokClone
//
//  Created by unthinkable-mac-0025 on 07/06/22.
//

import UIKit
import AVFoundation

class PostCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PostCollectionViewCell"
    
    // MARK: - UI Components
    private let imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let activityIndicator : UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        //indicator.style = .
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(imageView)
        imageView.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    required init?(coder : NSCoder) {
        fatalError()
    }

}

// MARK: - LifeCycle Methods
extension PostCollectionViewCell {
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
        activityIndicator.center = imageView.center
    }
}


// MARK: - Public Methods
extension PostCollectionViewCell {
    
    func configure(with post : PostModel) {
        //Derive the child path and Get download URL
        StorageManager.shared.getDownloadURL(for: post) { result in
            switch result {
            case .success(let url):
                //Generate thumbnail
                let workItem = DispatchWorkItem {
                    //print(Thread.current)
                    print("lol1")
                    let asset = AVAsset(url: url)
                    let generator = AVAssetImageGenerator(asset: asset)
                    do{
                        let cgImage = try generator.copyCGImage(at: .zero, actualTime: nil)
                        DispatchQueue.main.async {
                            print("lol2")
                            self.imageView.image = UIImage(cgImage: cgImage)
                            self.activityIndicator.stopAnimating()
                            self.activityIndicator.removeFromSuperview()
                        }
                    }
                    catch{
                        
                    }
                }
                DispatchQueue.global().asyncAfter(deadline: .now(), execute: workItem)
                //print("lol1")
                
            
            case .failure(let error):
                print("Falied to get downloaded url: \(error)")
            }
            
            
        }
    }
}


// MARK: - Private Methods
extension PostCollectionViewCell {
    
}
