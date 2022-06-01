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
    public func insertUser(with email : String, username : String, completion: @escaping (Bool) -> Void){
        /*
        users : {
         "iosacademy" : {
            email
            posts : []
         }
        }
         */
        
        //Get the "users" key, try inserting new entry, else create root "users"
        database.child("users").observeSingleEvent(of: .value) { [weak self] snapshot in
            guard var usersDictionary = snapshot.value as? [String : Any] else {
                //create users root node
                self?.database.child("users").setValue(
                    [
                        username : [
                            "email" : email
                        ]
                    ]
                ) { error , _ in
                    completion(error == nil)
                }
                
                return
            }
            
            usersDictionary[username] = ["email" : email]
            //save new users object
            self?.database.child("users").setValue(usersDictionary, withCompletionBlock: { error, _ in
                guard error == nil else{
                    completion(false)
                    return
                }
                completion(true)
            })
        }
    }
    
    public func getAllUsers(completion : @escaping([String]) -> Void){
        
    }
    
    
}
