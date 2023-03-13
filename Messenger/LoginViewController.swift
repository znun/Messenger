//
//  ViewController.swift
//  Messenger
//
//  Created by Mahmudul Hasan on 11/3/23.
//

import UIKit
import ProgressHUD

class LoginViewController: UIViewController {
   //MARK: - IBOutlets
    
    //labels
    
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var passwordLbl: UILabel!
    @IBOutlet weak var repeatPasswordLbl: UILabel!
    @IBOutlet weak var signUpLbl: UILabel!
    
    //textfields
    
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var repeatPasswordTxtField: UITextField!
    
    //Buttons
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var resendEmailBtn: UIButton!
    @IBOutlet weak var signUpBtn: UIButton!
    
    //Views
    @IBOutlet weak var repeatPasswordLineView: UIView!
    
    //MARK: - Vars
    var isLogin = true
    
    //MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUIFor(login: true)
        setupTextFieldDelegates()
        setupBackgroundTap()
    }
    
    //MARK: - IBActions
    @IBAction func loginBtnPressed(_ sender: Any) {
        if isDataInputedFor(type: isLogin ? "login" : "register") {
           
            isLogin ? loginUser() : registerUser()
        } else {
            ProgressHUD.showFailed("All Fields are required")
        }
    }
    
    @IBAction func forgotPasswordBtnPressed(_ sender: Any) {
        if isDataInputedFor(type: "password") {
            resetPassword()
            
        } else {
            ProgressHUD.showFailed("Email is required")
        }
    }
    
    @IBAction func resendEmailBtnPressed(_ sender: Any) {
        if isDataInputedFor(type: "password") {
           resendVerificationEmail()
        } else {
            ProgressHUD.showFailed("Email is required")
        }
    }
    
    @IBAction func signUpBtnPressed(_ sender: UIButton) {
        updateUIFor(login: sender.titleLabel?.text == "Login")
        isLogin.toggle()
    }
    
    //MARK: - Setup
    private func setupTextFieldDelegates() {
        emailTxtField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        passwordTxtField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        repeatPasswordTxtField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        updatePlaceholderLabels(textField)
    }
    
    private func setupBackgroundTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func backgroundTap() {
        view.endEditing(false)
    }
    //MARK: - Animation
    
    private func updateUIFor(login: Bool) {
        loginBtn.setImage(UIImage(named: login ? "loginBtn" : "registerBtn"), for: .normal)
        signUpBtn.setTitle(login ? "Signup" : "Login", for: .normal)
        signUpLbl.text = login ? "Don't have an account?" : "Have an Account?"
        
        UIView.animate(withDuration: 0.5) {
            self.repeatPasswordTxtField.isHidden = login
            self.repeatPasswordLbl.isHidden = login
            self.repeatPasswordLineView.isHidden = login
        }
    }
    private func updatePlaceholderLabels(_ textField: UITextField) {
        switch textField {
        case emailTxtField:
            emailLbl.text = textField.hasText ? "Email" : ""
            
        case passwordTxtField:
            passwordLbl.text = textField.hasText ? "Password" : ""
            
        default:
            repeatPasswordLbl.text = textField.hasText ? "Repeat Password" : ""
        }
        
        
    }
    
    //MARK: - Helpers
    private func isDataInputedFor(type: String) -> Bool {
        switch type {
        case "login":
            return emailTxtField.text != "" && passwordTxtField.text != ""
        case "registration":
            return emailTxtField.text != "" && passwordTxtField.text != "" && repeatPasswordTxtField.text != ""
        default:
            return emailTxtField.text != ""
        }
    }
    
    private func loginUser() {
        FirebaseUserListener.shared.loginUserWithEmail(email: emailTxtField.text!, password: passwordTxtField.text!) { error, isEmailVerified in
            
            if error == nil {
                if isEmailVerified {
                    ProgressHUD.showSucceed("Successfully logged in")
                    self.goToApp()
                } else {
                    ProgressHUD.showFailed("Please verify email")
                    self.resendEmailBtn.isHidden = false
                }
            } else {
                ProgressHUD.showFailed(error!.localizedDescription)
            }
        }
    }
    
    private func registerUser() {
        if passwordTxtField.text! == repeatPasswordTxtField.text! {
            
            FirebaseUserListener.shared.registerUserWith(email: emailTxtField.text!, password: passwordTxtField.text!) { (error) in
                
                if error == nil {
                    ProgressHUD.showSuccess("varification email sent")
                    self.resendEmailBtn.isHidden = false
                }
            }
        } else {
            ProgressHUD.showError("the password don't match")
        }
    }
    
    private func resetPassword() {
        FirebaseUserListener.shared.resetPasswordFor(email: emailTxtField.text!) { (error) in
            if error == nil {
                ProgressHUD.showSuccess("Reset link send to email")
            } else {
                ProgressHUD.showFailed(error!.localizedDescription)
            }
        }
    }
    
    private func resendVerificationEmail() {
        FirebaseUserListener.shared.resendVerificationEmail(email: emailTxtField.text!) { (error) in
            if error == nil {
                ProgressHUD.showSuccess("New verification email sent")
            } else {
                ProgressHUD.showFailed(error!.localizedDescription)
            }
        }
    }
    
    //MARK: - Navigation
    private func goToApp() {
        print("go to app")
    }
    
    
}

