//
//  AuthenticationManager.swift
//  TikTokClone
//
//  Created by unthinkable-mac-0025 on 18/05/22.
//

import Foundation
import FirebaseAuth

final class AuthManager{
    private init(){}
    public static let shared = AuthManager()
    
    
    // MARK: - Public Methods
    public var isSignIn : Bool {
        return Auth.auth().currentUser != nil   //nil means signed-out
    }
    
    enum SignInMethod{
        case email
        case facebook
        case google
    }
    public func signIn(with email : String, password : String, completion : @escaping (Bool) -> Void){
        
    }
    
    public func signOut(completion : (Bool) -> Void){
        do {
            try Auth.auth().signOut()
            completion(true)
        } catch  {
            print(error)
            completion(false)
        }
    }
}
