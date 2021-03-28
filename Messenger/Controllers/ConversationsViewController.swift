//
//  ViewController.swift
//  Messenger
//
//  Created by Xunnun on 27/3/21.
//  Copyright © 2021 USER. All rights reserved.
//

import UIKit
import FirebaseAuth

class ConversationsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        validateAuth()
    }
    private func validateAuth(){
        if FirebaseAuth.Auth.auth().currentUser == nil {
                 let vc = LoginViewController()
                 let nav = UINavigationController(rootViewController: vc)
                 nav.modalPresentationStyle = .fullScreen
                 present(nav, animated: false)
                  
                 }
    }
   
}

