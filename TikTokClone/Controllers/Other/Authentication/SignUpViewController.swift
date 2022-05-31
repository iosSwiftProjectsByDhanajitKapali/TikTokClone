//
//  SignUpViewController.swift
//  TikTokClone
//
//  Created by unthinkable-mac-0025 on 31/05/22.
//

import UIKit

class SignUpViewController: UIViewController {
    
    // MARK: - Public Data Members
    public var completion : (() -> Void)?
    
    
    // MARK: - UI Components
    private let logoImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "AppIcon")
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private let usernameField = AuthField(type: .username)
    private let emailField = AuthField(type: .email)
    private let passwordField = AuthField(type: .password)
    
    private let signUpBUtton = AuthButton(type: .signUp, title: nil)
    private let termsButton = AuthButton(type: .plain, title: "Terms of Service")
}


// MARK: - LifeCycle Methods
extension SignUpViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Create Account"
        view.backgroundColor = .systemBackground
        
        addSubViews()
        configureFields()
        configureButtons()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        usernameField.becomeFirstResponder()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let imageSize : CGFloat = 100
        logoImageView.frame = CGRect(
            x: (view.width - imageSize)/2,
            y: view.safeAreaInsets.top + 5,
            width: imageSize,
            height: imageSize
        )
        usernameField.frame = CGRect(
            x: 20,
            y: logoImageView.bottom+30,
            width: view.width-40,
            height: 55
        )
        emailField.frame = CGRect(
            x: 20,
            y: usernameField.bottom+15,
            width: view.width-40,
            height: 55
        )
        passwordField.frame = CGRect(
            x: 20,
            y: emailField.bottom+15,
            width: view.width-40,
            height: 55
        )
        signUpBUtton.frame = CGRect(
            x: 20,
            y: passwordField.bottom+20,
            width: view.width-40,
            height: 55
        )
        termsButton.frame = CGRect(
            x: 20,
            y: signUpBUtton.bottom+40,
            width: view.width-40,
            height: 55
        )
        
    }
    
    
}


// MARK: - Private Methods
private extension SignUpViewController {
    
    func configureFields() {
        usernameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        
        let toolBar = UIToolbar(frame: CGRect(
            x: 0,
            y: 0,
            width: view.width,
            height: 50
        ))
        toolBar.items = [UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
                         UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(didTapKeyBoardToolBarDoneButton))
                         
        ]
        toolBar.sizeToFit()
        usernameField.inputAccessoryView = toolBar
        emailField.inputAccessoryView = toolBar
        passwordField.inputAccessoryView = toolBar
    }
    
    @objc func didTapKeyBoardToolBarDoneButton(){
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
    }
    
    func addSubViews() {
        view.addSubview(logoImageView)
        view.addSubview(usernameField)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(signUpBUtton)
        view.addSubview(termsButton)
    }
    
    func configureButtons(){
        signUpBUtton.addTarget(self, action: #selector(didTapSignUpButton), for: .touchUpInside)
        termsButton.addTarget(self, action: #selector(didTapTermsButton), for: .touchUpInside)
    }
    
    @objc func didTapSignUpButton() {
        didTapKeyBoardToolBarDoneButton()
        
        guard let username = usernameField.text,
        let email = emailField.text,
        let password = passwordField.text,
        !username.trimmingCharacters(in: .whitespaces).isEmpty,
        !email.trimmingCharacters(in: .whitespaces).isEmpty,
        !password.trimmingCharacters(in: .whitespaces).isEmpty,
        password.count >= 6,
        !username.contains(".")
        else {
            
            let alert = UIAlertController(title: "Woops", message: "Please Enter a valid username/email/password to SignUp", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
            present(alert, animated: true)
            return
        }
        
        AuthManager.shared.signUp(with: username, emailAdress: email, password: password) { sucess in
            if sucess { //registred the user sucessfully
                
            }else{
                //
            }
        }
    }
    
    @objc func didTapTermsButton() {
        
    }
}


// MARK: - UITextFieldDelegate Methods
extension SignUpViewController : UITextFieldDelegate {
    
}


