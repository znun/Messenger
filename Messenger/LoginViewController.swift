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
    
    
    //MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextFieldDelegates()
    }
    
    //MARK: - IBActions
    

    @IBAction func loginBtnPressed(_ sender: Any) {
        
    }
    
    @IBAction func forgotPasswordBtnPressed(_ sender: Any) {
    }
    
    @IBAction func resendEmailBtnPressed(_ sender: Any) {
    }
    
    @IBAction func signUpBtnPressed(_ sender: Any) {
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

