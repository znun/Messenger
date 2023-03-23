//
//  RecentTableViewCell.swift
//  Messenger
//
//  Created by Mahmudul Hasan on 21/3/23.
//

import UIKit

class RecentTableViewCell: UITableViewCell {

    //MARK: - IBOutlets
    @IBOutlet weak var avatarImgView: UIImageView!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var lastMessageLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var unreadCounterLbl: UILabel!
    @IBOutlet weak var unreadCounterBG: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        unreadCounterBG.layer.cornerRadius = unreadCounterBG.frame.width / 2
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(recent: RecentChat) {
        
        usernameLbl.text = recent.receiverName
        usernameLbl.adjustsFontSizeToFitWidth = true
        usernameLbl.minimumScaleFactor = 0.9
        
        lastMessageLbl.text = recent.lastMessage
        lastMessageLbl.adjustsFontSizeToFitWidth = true
        lastMessageLbl.numberOfLines = 2
        lastMessageLbl.minimumScaleFactor = 0.9
        
        if recent.unreadCounter != 0 {
            self.unreadCounterLbl.text = "\(recent.unreadCounter))"
            self.unreadCounterBG.isHidden = false
        } else {
            self.unreadCounterBG.isHidden = true
        }
        setAvatar(avatarLink: recent.avatarLink)
        dateLbl.text = timeElapsed(recent.date ?? Date())
        dateLbl.adjustsFontSizeToFitWidth = true
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
