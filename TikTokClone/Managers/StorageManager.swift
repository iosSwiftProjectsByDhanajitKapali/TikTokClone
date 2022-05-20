//
//  StorageManager.swift
//  TikTokClone
//
//  Created by unthinkable-mac-0025 on 18/05/22.
//

import Foundation
import FirebaseStorage

final class StorageManager {
    private init() {}
    public static let shared = StorageManager()
    
    private let database = Storage.storage().reference()

    
    
    // MARK: - Public Methods
    public func getViedoULR(with identifier : String, completion : @escaping(URL) -> Void){
        
    }
    
    
}
