//
//  ChatViewController.swift
//  Messenger
//
//  Created by Mahmudul Hasan on 25/3/23.
//

import UIKit
import MessageKit
import InputBarAccessoryView
import Gallery
import RealmSwift


class ChatViewController: MessagesViewController {

    //MARK: - Vars
    private var chatId = ""
    private var recipientId = ""
    private var recipientName = ""
    
    //MARK: - Inits
    init(chatId: String = "", recipientId: String = "", recipientName: String = "") {
        
        super.init(nibName: nil, bundle: nil)
        
        self.chatId = chatId
        self.recipientId = recipientId
        self.recipientName = recipientName
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    

   

}
