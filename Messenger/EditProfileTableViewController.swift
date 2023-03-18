//
//  EditProfileTableViewController.swift
//  Messenger
//
//  Created by Mahmudul Hasan on 17/3/23.
//

import UIKit

class EditProfileTableViewController: UITableViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var avatarImgView: UIImageView!
    @IBOutlet weak var usernameTxtField: UITextField!
    
    //MARK: - Vars
    var secSpace = 15
    
    //MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        configuredTextField()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        showUserInfo()
    }
    
    //MARK: - TableView Delegates
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView()
        headerView.backgroundColor = .white
        
        return headerView
    }
    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        else {
            return CGFloat(secSpace / 10)
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        else {
            return CGFloat(secSpace / 10)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //TODO:  show status view
    }
    
    //MARK: - UpdateUI
    private func showUserInfo() {
        if let user = User.currentUser {
            usernameTxtField.text = user.username
            statusLbl.text = user.status
            
            if user.avatarLink != "" {
                //set avatar
            }
        }
    }
    
    //MARK: - Configure
    private func configuredTextField() {
        usernameTxtField.delegate = self
        usernameTxtField.clearButtonMode = .whileEditing
    }

}

extension EditProfileTableViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameTxtField {
            
            if textField.text != "" {
                if var user = User.currentUser {
                    user.username = textField.text!
                    saveUserLocally(user)
                    FirebaseUserListener.shared.saveUserToFireStore(user)
                }
            }
            textField.resignFirstResponder()
            return false
        }
        return true
    }
}
