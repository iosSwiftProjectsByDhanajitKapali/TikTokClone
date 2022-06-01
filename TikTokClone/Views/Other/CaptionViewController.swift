//
//  CaptionViewController.swift
//  TikTokClone
//
//  Created by unthinkable-mac-0025 on 01/06/22.
//

import UIKit
import ProgressHUD

class CaptionViewController: UIViewController {

    let videoURL : URL
    
    //Initializers
    init(videoURL : URL){
        self.videoURL = videoURL
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder : NSCoder){
        fatalError()
    }

}


// MARK: - LifeCycle Methods
extension CaptionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add Caption"
        
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Post",
            style: .done,
            target: self,
            action: #selector(didTapPost)
        )
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}


// MARK: - Private Methods
private extension CaptionViewController {
    
    @objc func didTapPost() {
        //Generate a video name that is unique based on id
        let newVideoName = StorageManager.shared.generateVideoName()
        
        ProgressHUD.show("Posting")
        
        //Upload video
        StorageManager.shared.uploadVideoURL(from: videoURL, fileName: newVideoName) { sucess in
            DispatchQueue.main.async { [weak self] in
                if sucess {
                    //Update database
                    DatabaseManager.shared.insertPost(fileName: newVideoName) { dataBaseUpdated in
                        if dataBaseUpdated {
                            HapticsManager.shared.vibrate(for: .success)
                            ProgressHUD.dismiss()
                            //Reset camera and switch to feed
                            self?.navigationController?.popToRootViewController(animated: true)
                            self?.tabBarController?.selectedIndex = 0
                            self?.tabBarController?.tabBar.isHidden = false
                            print("Uploaded the Video")
                        }else {
                            HapticsManager.shared.vibrate(for: .error)
                            ProgressHUD.dismiss()
                            //Show error alert
                            let alert = UIAlertController(
                                title: "Woops",
                                message: "We were unable to upload your video. Please try again later.",
                                preferredStyle: .alert
                            )
                            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
                            self?.present(alert, animated: true)
                        }
                    }
                    
                }else{
                    HapticsManager.shared.vibrate(for: .error)
                    ProgressHUD.dismiss()
                    //Show an alert
                    let alert = UIAlertController(
                        title: "Woops",
                        message: "We were unable to upload your video. Please try again later.",
                        preferredStyle: .alert
                    )
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
                    self?.present(alert, animated: true)
                }
            }
        }
    }
}
