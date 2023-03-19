//
//  EditProfileTableViewController.swift
//  Messenger
//
//  Created by Mahmudul Hasan on 17/3/23.
//

import UIKit
import Gallery
import ProgressHUD

class EditProfileTableViewController: UITableViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var avatarImgView: UIImageView!
    @IBOutlet weak var usernameTxtField: UITextField!
    
    //MARK: - Vars
    var secSpace = 15
    var gallery: GalleryController!
    
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
    
    //MARK: - IBActions
    
    @IBAction func editBtnPressed(_ sender: Any) {
        
        showImageGallery()
    }
    
    
    //MARK: - UpdateUI
    private func showUserInfo() {
        if let user = User.currentUser {
            usernameTxtField.text = user.username
            statusLbl.text = user.status
            
            if user.avatarLink != "" {
                FileStorage.downloadImage(imageUrl: user.avatarLink) { (avatarImage) in
                    self.avatarImgView.image = avatarImage
                }
            }
        }
    }
    
    //MARK: - Configure
    private func configuredTextField() {
        usernameTxtField.delegate = self
        usernameTxtField.clearButtonMode = .whileEditing
    }
    
    //MARK: - Gallery
    private func  showImageGallery() {
        
        self.gallery = GalleryController()
        self.gallery.delegate = self
        
        Config.tabsToShow = [.imageTab]
        Config.Camera.imageLimit = 1
        Config.initialTab = .imageTab
        
        self.present(gallery, animated: true, completion: nil)
    }
    
    //MARK: - UploadImages
    private func uploadAvatarImage(_ image: UIImage) {
        
        let fileDirectory = "Avatars/" + "_\(User.currentId)" + ".jpg"
        
        FileStorage.uploadImage(image, directory: fileDirectory) { (avatarLink) in
            
            if var user = User.currentUser {
                user.avatarLink = avatarLink ?? ""
                saveUserLocally(user)
                FirebaseUserListener.shared.saveUserToFireStore(user)
            }
            
            
            //TODO: Save image locally
            FileStorage.saveLocally(fileData: image.jpegData(compressionQuality: 1.00)! as NSData, fileName: User.currentId)
        }
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

extension EditProfileTableViewController: GalleryControllerDelegate {
    func galleryController(_ controller: Gallery.GalleryController, didSelectImages images: [Gallery.Image]) {
        
        if images.count > 0 {
            images.first!.resolve { (avatarImage) in
                
                if avatarImage != nil {
                    //TODO: upload image
                    self.uploadAvatarImage(avatarImage!)
                    self.avatarImgView.image = avatarImage
                    
                } else {
                    ProgressHUD.showError("Couldn't select image!")
                }
                    
            }
        }
        controller.dismiss(animated: true, completion: nil)
    }
    
    
    func galleryController(_ controller: Gallery.GalleryController, didSelectVideo video: Gallery.Video) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
    func galleryController(_ controller: Gallery.GalleryController, requestLightbox images: [Gallery.Image]) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func galleryControllerDidCancel(_ controller: Gallery.GalleryController) {
        controller.dismiss(animated: true, completion: nil)
    }

}
    
    

