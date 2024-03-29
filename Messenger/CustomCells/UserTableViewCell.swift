//
//  UserTableViewCell.swift
//  Messenger
//
//  Created by Mahmudul Hasan on 19/3/23.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    //MARK: - IBOutlets
    
    @IBOutlet weak var avatarImgView: UIImageView!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    func configure(user: User) {
        usernameLbl.text = user.username
        statusLbl.text = user.status
        setAvatar(avatarLink: user.avatarLink)
    }
    
    private func setAvatar(avatarLink: String) {
        
        if avatarLink != "" {
            FileStorage.downloadImage(imageUrl: avatarLink) { (avatarImage) in
                self.avatarImgView.image = avatarImage?.circleMasked
            }
        } else {
            self.avatarImgView.image = UIImage(named: "avatar")?.circleMasked
        }
    }

}
