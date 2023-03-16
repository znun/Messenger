//
//  SettingsTableViewController.swift
//  Messenger
//
//  Created by Mahmudul Hasan on 16/3/23.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var appVersionLbl: UILabel!
    
    //MARK: - Vars
    var secSpace = 15
    
    //MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
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
    
    
    //MARK: - IBActions
    
    @IBAction func tellFriendBtn(_ sender: Any) {
        print("Tell a Friend")
    }
    
    @IBAction func tNcBtn(_ sender: Any) {
        print("Terms and Conditions")
    }
    
    @IBAction func logoutBtn(_ sender: Any) {
        print("Logout")
    }
    
    //MARK: - UpdateUI
    private func showUserInfo() {
        
        if let user = User.currentUser {
            usernameLbl.text = user.username
            statusLbl.text = user.status
            appVersionLbl.text = "App Version \(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "")"
            if user.avatarLink != "" {
                //download and set avatar image
                
            }
        }
        
    }
}
