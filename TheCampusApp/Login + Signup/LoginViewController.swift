//
//  SignupViewController.swift
//  TheCampusApp
//
//  Created by Yogesh Kumar on 22/09/19.
//  Copyright © 2019 Harsh Motwani. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class LoginViewController: UIViewController{
    // MARK:- Constants
    let inputPadding: CGFloat = 20
    let inputHeight: CGFloat = 40
    var stackHeight: CGFloat = 0
    var inputWidth: CGFloat = 0
    var topPadding: CGFloat = 0
    let db = Firestore.firestore()
    
    // MARK:- UI Elements
    
    let header : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = selectedTheme.primaryTextColor
        label.text = "Log In"
        label.textAlignment = .center
        return label
    }()
    
    let emailTextField : UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [.foregroundColor : selectedTheme.primaryPlaceholderColor])
        textField.backgroundColor = selectedTheme.secondaryColor
        textField.textColor = selectedTheme.primaryTextColor
        textField.borderStyle = .roundedRect
        textField.font = .systemFont(ofSize: 18)
        textField.tag = 1
        textField.autocapitalizationType = .none
        textField.keyboardType = .emailAddress
        textField.addTarget(self, action: #selector(checkValidInput), for: .editingChanged)
        return textField
    }()
    
    let passwordTextField : UITextField = {
        let textField = UITextField()
        textField.isSecureTextEntry = true
        textField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [.foregroundColor : selectedTheme.primaryPlaceholderColor])
        textField.backgroundColor = selectedTheme.secondaryColor
        textField.textColor = selectedTheme.primaryTextColor
        textField.borderStyle = .roundedRect
        textField.font = .systemFont(ofSize: 18)
        textField.tag = 2
        textField.addTarget(self, action: #selector(checkValidInput), for: .editingChanged)
        return textField
    }()
    
    let loginButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = selectedAccentColor.secondaryColor
        button.layer.cornerRadius = 5
        button.isEnabled = false
        return button
    }()
    
    let dontHaveAccountButton : UIButton = {
        let button = UIButton()
        let attributedText = NSMutableAttributedString(string: "Don't have an account  ", attributes: [.font: UIFont.systemFont(ofSize: 18), .foregroundColor : selectedTheme.secondaryTextColor])
        attributedText.append(NSAttributedString(string: "Sign Up", attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .medium), .foregroundColor : selectedAccentColor.primaryColor]))
        button.setAttributedTitle(attributedText, for: .normal)
        return button;
    }()
    
    let flag: UILabel = {
        let label = UILabel();
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.text = nil
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    
    // MARK:- Overriden Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = selectedTheme.primaryColor
        
//        if #available(iOS 13, *){
//            self.isModalInPresentation = true
//            self.modalPresentationStyle = .fullScreen
//        }

        flag.frame=CGRect(x: self.view.frame.width/4, y: self.view.frame.height/4, width: self.view.frame.width/2, height: 30)
        view.addSubview(flag)

        // Set Constants
        stackHeight = inputHeight * 3 + inputPadding * 2
        inputWidth = view.frame.width * 0.8
        topPadding = view.frame.height * 0.4
        
        // Setup Delegates
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        // Handle Keyboard Events
        self.hideKeyboardWhenTappedAround()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        // UI
        setupUI()
    }
    
    // MARK:- Setup UI Methods
    func setupUI(){
        setupHeader()
        setupStack()
        setupFooter()
    }
    
    func setupHeader(){
        let height : CGFloat = view.frame.height * 0.10;
        let topPadding: CGFloat = view.frame.height * 0.10;
        let sidePadding : CGFloat = 20
        
        view.addSubview(header)
        
        if #available(iOS 11.0, *) {
            let layoutGuide = view.safeAreaLayoutGuide
            header.anchor(top: layoutGuide.topAnchor, left: layoutGuide.leadingAnchor, right: layoutGuide.trailingAnchor, paddingTop: topPadding, paddingLeft: sidePadding, paddingRight: sidePadding, height: height)
        } else {
            header.anchor(top: view.topAnchor, left: view.leadingAnchor, right: view.trailingAnchor, paddingTop: topPadding, paddingLeft: sidePadding, paddingRight: sidePadding, height: height)
        }
        
    }
    
    func setupStack(){
        let stack = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton])
        loginButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = inputPadding
        
        view.addSubview(stack)
        stack.anchor(top: view.topAnchor, paddingTop: topPadding, height: stackHeight, width: inputWidth)
        stack.centerX(view.centerXAnchor)
    }
    
    func setupFooter(){
        view.addSubview(dontHaveAccountButton)
        if #available(iOS 11.0, *) {
            let layoutGuide = view.safeAreaLayoutGuide
            dontHaveAccountButton.anchor(bottom: layoutGuide.bottomAnchor, left: layoutGuide.leadingAnchor, right: layoutGuide.trailingAnchor, paddingBottom: 5, paddingLeft: 10, paddingRight: 10, height: 50)
        } else {
            dontHaveAccountButton.anchor(bottom: view.bottomAnchor, left: view.leadingAnchor, right: view.trailingAnchor, paddingBottom: 5, paddingLeft: 10, paddingRight: 10, height: 50)
        }
        dontHaveAccountButton.addTarget(self, action: #selector(handleDontHaveAccountButton), for: .touchUpInside)
    }
    
    // MARK:- Triggering Methods
    @objc func handleDontHaveAccountButton(){
        changeToSignUpController()
    }
    
    func changeToSignUpController(signupEmail: String? = nil){
        emailTextField.text = ""
        passwordTextField.text = ""
        loginButton.isEnabled = false;
        loginButton.backgroundColor = selectedAccentColor.secondaryColor;
        let signUpVC = SignupViewController()
        if let email = signupEmail{
            signUpVC.emailTextField.text = email
        }
        navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    @objc func handleLogin(){
        view.endEditing(true)
        self.loginButton.isEnabled = false;
        self.loginButton.backgroundColor = selectedAccentColor.secondaryColor;
        
        guard let email = emailTextField.text           else {return}
        guard let password = passwordTextField.text     else {return}
        SVProgressHUD.setRingThickness(5)
        SVProgressHUD.show()

        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            
            if let error = error{
                print("Login ERROR #1 : \n\n", error)
                self.handleLoginError(error)
                SVProgressHUD.dismiss()
                return;
            }

            guard let user = user?.user else{
                print("Login Error #2 : \n\n")
                return;
            }
            
            UserData.shared.setData(user)
            
            // Go to Main Tab Bar Controller
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
                if let mainTabBarController = UIApplication.shared.keyWindow?.rootViewController as? MainTabBarController{
                    APIService.getUserInfo()
                    mainTabBarController.setupViewControllers()
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
        
    }
    
    // This is triggered when Keyboards shows
    @objc func keyboardWillShow(notification: NSNotification) {
        if self.view.frame.origin.y == 0 {
            self.view.frame.origin.y -= 100
            header.alpha = 0
        }
    }
    
    // This is triggered when keyboards dismisses
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
            header.alpha = 1
        }
    }
    
    // This functions check if input text field in valid
    @objc func checkValidInput(){
        let isValidEmail = emailTextField.text?.count ?? 0 > 0
        let passwordLength = passwordTextField.text?.count ?? 0
        let isValidPassword = (passwordLength >= 6) && (passwordLength <= 16)
        
        if isValidEmail && isValidPassword{
            loginButton.backgroundColor = selectedAccentColor.primaryColor
            loginButton.isEnabled = true
        }
        else{
            loginButton.backgroundColor = selectedAccentColor.secondaryColor
            loginButton.isEnabled = false
        }
    }
    
    func handleLoginError(_ error: Error){
        if let errorCode = AuthErrorCode(rawValue: error._code){
            var errorTitle: String = ""
            var errorMessage: String = ""
            
            let defaultAction = UIAlertAction(title: "Ok", style: .cancel){ _ in
                DispatchQueue.main.async {
                    self.checkValidInput()
                }
            }
            
            var actions = [UIAlertAction]()
            switch(errorCode){
                case .invalidEmail, .invalidSender, .invalidRecipientEmail:
                    errorTitle = "Invalid Email"
                    errorMessage = "Please enter a valid Email."
                    actions.append(defaultAction)
                
                case .userNotFound:
                    errorTitle = "Account does not exist"
                    errorMessage = "Click 'Sign Up' to create an account."
                    
                    let action1 = UIAlertAction(title: "Try Again", style: .cancel, handler: { (_) in
                        self.passwordTextField.text = "";
                    })
                    
                    let action2 = UIAlertAction(title: "Sign Up", style: .default, handler: { (_) in
                        self.changeToSignUpController(signupEmail: self.emailTextField.text)
                    })
                    
                    actions.append(action1)
                    actions.append(action2)
                
                
                case .wrongPassword:
                    errorTitle = "Wrong Password"
                    errorMessage = "Please enter the correct password."
                    actions.append(defaultAction)
                
                case .userDisabled:
                    errorTitle = "Your account has been disabled"
                    errorMessage = "Please Contact Support"
                    actions.append(defaultAction)
                
                case .networkError:
                    errorTitle = "Network Error"
                    errorMessage = "Please make sure you are connected to the Internet."
                    actions.append(defaultAction)
                
                default:
                    errorTitle =  "Unknown error occurred"
                    errorMessage =  "Sorry for the inconvenience."
                    actions.append(defaultAction)
            }
            
            let alertController = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
            
            actions.forEach({ (action) in
                alertController.addAction(action)
            })
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

// MARK:- Extension #1
extension LoginViewController : UITextFieldDelegate{
    
    // Move to next Text Field on pressing return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Try to find next responder
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard and perform signup
            textField.resignFirstResponder()
            handleLogin()
        }
        return false
    }
}
