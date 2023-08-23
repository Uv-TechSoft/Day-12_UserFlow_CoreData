//
//  userlistCell.swift
//  UserFlow_Day12
//
//  Created by Imam MohammadUvesh on 23/11/21.
//

import UIKit

class userlistCell: UITableViewCell {

    @IBOutlet weak var userProfileImage: UIImageView!
    
    @IBOutlet weak var userFirstname: UILabel!
    
    @IBOutlet weak var userLastname: UILabel!
    
    @IBOutlet weak var userEmail: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
}
    
    func userConfig(user: User)
    {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(user.profileImageName ?? "").appendingPathExtension("png").path
        print(path)
        userProfileImage.image = UIImage(contentsOfFile: path ?? "")
        userFirstname.text = user.firstname
        userLastname.text = user.lastname
        userEmail.text = user.email
    }
    
}
