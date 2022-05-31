//
//  SignInViewController.swift
//  TikTokClone
//
//  Created by unthinkable-mac-0025 on 18/05/22.
//

import UIKit

class SignInViewController: UIViewController {
    
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
    
    private let emailField = AuthField(type: .email)
    private let passwordField = AuthField(type: .password)
    
    private let signInBUtton = AuthButton(type: .signIn, title: nil)
    private let signUpButton = AuthButton(type: .plain, title: "New User? Create Account")
    private let forgotPasswordButton = AuthButton(type: .plain, title: "Forgot Password")
}


// MARK: - LifeCycle Methods
extension SignInViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Sign In"
        view.backgroundColor = .systemBackground
        
        addSubViews()
        configureFields()
        configureButtons()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        emailField.becomeFirstResponder()
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
        emailField.frame = CGRect(
            x: 20,
            y: logoImageView.bottom+30,
            width: view.width-40,
            height: 55
        )
        passwordField.frame = CGRect(
            x: 20,
            y: emailField.bottom+15,
            width: view.width-40,
            height: 55
        )
        signInBUtton.frame = CGRect(
            x: 20,
            y: passwordField.bottom+20,
            width: view.width-40,
            height: 55
        )
        forgotPasswordButton.frame = CGRect(
            x: 20,
            y: signInBUtton.bottom+40,
            width: view.width-40,
            height: 55
        )
        signUpButton.frame = CGRect(
            x: 20,
            y: forgotPasswordButton.bottom+5,
            width: view.width-40,
            height: 55
        )
        
    }
    
    
}


// MARK: - Private Methods
private extension SignInViewController {
    
    func configureFields() {
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
        emailField.inputAccessoryView = toolBar
        passwordField.inputAccessoryView = toolBar
    }
    
    @objc func didTapKeyBoardToolBarDoneButton(){
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
    }
    
    func addSubViews() {
        view.addSubview(logoImageView)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(signInBUtton)
        view.addSubview(forgotPasswordButton)
        view.addSubview(signUpButton)
    }
    
    func configureButtons(){
        signInBUtton.addTarget(self, action: #selector(didTapSignInButton), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(didTapSignUpButton), for: .touchUpInside)
        forgotPasswordButton.addTarget(self, action: #selector(didTapForgotPasswordButton), for: .touchUpInside)
    }
    
    @objc func didTapSignInButton() {
        didTapKeyBoardToolBarDoneButton()
        
        guard let email = emailField.text,
        let password = passwordField.text,
        !email.trimmingCharacters(in: .whitespaces).isEmpty,
        !password.trimmingCharacters(in: .whitespaces).isEmpty,
        password.count >= 6
        else {
            
            let alert = UIAlertController(title: "Woops", message: "Please Enter a valid email/password to SignIn", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
            present(alert, animated: true)
            return
        }
        
        AuthManager.shared.signIn(with: email, password: password) { loggedIn in
            
            if loggedIn {
                //Dismiss login if loginIn is sucessfull
            }else{
                //Show error
            }
            
        }
    }
    
    @objc func didTapSignUpButton() {
        didTapKeyBoardToolBarDoneButton()
        
        //Push the SignUp Sceen
        let vc = SignUpViewController()
        vc.title = "Create Account"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func didTapForgotPasswordButton() {
        
    }
}


// MARK: - UITextFieldDelegate Methods
extension SignInViewController : UITextFieldDelegate {
    
}
