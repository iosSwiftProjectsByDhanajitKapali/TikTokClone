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
    
    enum AuthError : Error {
        case signInFailed
    }
    
    enum SignInMethod{
        case email
        case facebook
        case google
    }
    public func signIn(with email : String, password : String, completion : @escaping (Result<String, Error>) -> Void){
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            guard result != nil, error == nil else{
                if let error = error {
                    completion(.failure(error))
                }else{
                    completion(.failure(AuthError.signInFailed))
                }
                return
            }
            
            //Successful signIn
            completion(.success(email))
        }
    }
    
    public func signUp(with username : String, emailAdress : String, password : String, completion : @escaping (Bool) -> Void) {
        
        //make sure entered unsername is available
        Auth.auth().createUser(withEmail: emailAdress, password: password) { result, error in
            guard result != nil, error == nil else{
                completion(false)
                return
            }
            
            //Now save the user info into the database
            DatabaseManager.shared.insertUser(with: emailAdress, username: username, completion: completion)
        }
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
