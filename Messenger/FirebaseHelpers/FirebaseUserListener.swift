//
//  FirebaseUserListener.swift
//  Messenger
//
//  Created by Mahmudul Hasan on 12/3/23.
//

import Foundation
import Firebase

class FirebaseUserListener {
    static let shared = FirebaseUserListener()
    
    private init () {}
    
    //MARK: - Login
    
    //MARK: - Register
    func registerUserWith(email:String, password: String, completion: @escaping(_ error : Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) {(authDataResult, error) in
            completion(error)
            
            if error == nil {
                //send verification email
                authDataResult!.user.sendEmailVerification{(error) in
                    print("auth email sent with error", error?.localizedDescription)
                }
             //create user an save it
                if authDataResult?.user != nil {
                    let user = User(id: authDataResult!.user.uid , username: email, email: email, pushId: "" , avatarLink: "" , status: "Hey there I'm using Messenger")
                    
                    saveUserLocally(user)
                    self.saveUserToFireStore(user)
                }
            }
            
        }
        
    }
    
    //MARK: - Save users
    func saveUserToFireStore(_ user: User) {
        do {
            print("Check")
            try FirebaseReference(.User).document(user.id).setData(from: user)
        } catch {
            print(error.localizedDescription, "adding user")
        }
    }
    
   
    
    
}
