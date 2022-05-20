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
    enum SignInMethod{
        case email
        case facebook
        case google
    }
    public func signIn(with method : SignInMethod){
        
    }
    
    public func signOut(){
        
    }
}
