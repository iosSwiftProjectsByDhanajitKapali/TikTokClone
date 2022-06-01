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
    
    public func getUserName(for email : String, completion : @escaping(String?) -> Void){
        database.child("users").observeSingleEvent(of: .value) { snapshot in
            guard let users = snapshot.value as? [String : [String : Any]] else {
                completion(nil)
                return
            }
            
            for(username, value) in users {
                if value["email"] as? String == email {
                    completion(username)
                    break
                }
            }
        }
    }
    
    public func insertPost(fileName : String, caption : String, completion : @escaping (Bool) -> Void) {
        guard let username = UserDefaults.standard.string(forKey: "username") else {
            return
        }
        
        database.child("users").child(username).observeSingleEvent(of: .value) { [weak self] snapshot in
            guard var value = snapshot.value as? [String : Any] else {
                completion(false)
                return
            }
            
            let newEntry = [
                "name" : fileName,
                "caption" : caption
            ]
            
            if var posts = value["posts"] as? [[String:Any]] { //found few previous posts, i.e, "posts" is found
                posts.append(newEntry)
                value["posts"] = posts
                self?.database.child("users").child(username).setValue(value) { error, _ in
                    guard error == nil else {
                        completion(false)
                        return
                    }
                    completion(true)
                }
            }
            else {
                let posts = [newEntry]
                value["posts"] = posts
                self?.database.child("users").child(username).setValue(value) { error, _ in
                    guard error == nil else {
                        completion(false)
                        return
                    }
                    completion(true)
                }
            }
        }
    }
    
    public func getAllUsers(completion : @escaping([String]) -> Void){
        
    }
    
    
}
