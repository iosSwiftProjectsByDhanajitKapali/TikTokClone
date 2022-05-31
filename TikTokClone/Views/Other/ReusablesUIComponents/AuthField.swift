//
//  AuthField.swift
//  TikTokClone
//
//  Created by unthinkable-mac-0025 on 31/05/22.
//

import UIKit

class AuthField : UITextField {
    
    enum FieldType {
        case username
        case email
        case password
        
        var title : String {
            switch self {
            case .username:
                return "Username"
            case .email:
                return "Email Adress"
            case .password:
                return "Password"
            }
        }
            
    }
    private let type : FieldType
    
    init(type : FieldType) {
        self.type = type
        super.init(frame: .zero)
        
        configureUI()
    }
    
    required init?(coder : NSCoder){
        fatalError()
    }
    
    private func configureUI(){
        
        if type == .password{
            isSecureTextEntry = true
            
        }else if type == .email{
            keyboardType = .emailAddress
        }
        
        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = 8
        layer.masksToBounds = true
        placeholder = type.title
        
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: height))
        leftViewMode = .always
        
        returnKeyType = .done
        autocorrectionType = .no
        autocapitalizationType = .none
    }
}
