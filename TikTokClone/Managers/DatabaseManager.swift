//
//  DatabaseManager.swift
//  TikTokClone
//
//  Created by unthinkable-mac-0025 on 18/05/22.
//

import Foundation
import FirebaseDatabase

final class DatabaseManager {
    private init() {}
    public static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
    
    // MARK: - Public Methods
    public func getAllUsers(completion : @escaping([String]) -> Void){
        
    }
    
    
}
