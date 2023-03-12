//
//  ViewController.swift
//  Messenger
//
//  Created by Mahmudul Hasan on 11/3/23.
//

import UIKit

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
    }
    
    //MARK: - IBActions
    

    @IBAction func loginBtnPressed(_ sender: Any) {
        
    }
    
    @IBAction func forgotPasswordBtnPressed(_ sender: Any) {
    }
    
    @IBAction func resendEmailBtnPressed(_ sender: Any) {
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
    
    
}

