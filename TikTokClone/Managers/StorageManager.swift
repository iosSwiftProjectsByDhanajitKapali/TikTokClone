//
//  StorageManager.swift
//  TikTokClone
//
//  Created by unthinkable-mac-0025 on 18/05/22.
//

import UIKit
import FirebaseStorage

final class StorageManager {
    private init() {}
    public static let shared = StorageManager()
    
    private let storageBucket = Storage.storage().reference()

    
    
    // MARK: - Public Methods
    public func getViedoURL(with identifier : String, completion : @escaping(URL) -> Void){
        
    }
    
    public func uploadVideoURL(from url : URL, fileName : String, completion : @escaping (Bool) -> Void){
        guard let username = UserDefaults.standard.string(forKey: "username") else {
            return
        }
        
        storageBucket.child("videos/\(username)/\(fileName)").putFile(
            from: url,
            metadata: nil) { result in
                switch result {
                case .success( _ ):
                    completion(true)
                case .failure(_):
                    completion(false)
                }
            }
    }
    
    public func generateVideoName() -> String{
        let uuidString = UUID().uuidString
        let number = Int.random(in: 0...1000)
        let time = Date().timeIntervalSince1970
        
        return uuidString + "_" + "\(number)" + "_" + "\(time)" + ".mov"
    }
}
