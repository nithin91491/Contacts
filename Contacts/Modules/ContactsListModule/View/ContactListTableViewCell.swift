//
//  ContactListTableViewCell.swift
//  Contacts
//
//  Created by Nithin on 04/05/18.
//  Copyright © 2018 Nithin. All rights reserved.
//

import UIKit

class ContactListTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var contactImageView: UIImageView!
    
    @IBOutlet weak var lblContactName: UILabel!
    
    @IBOutlet weak var btnFavourite: UIButton!
    
    
    @IBAction func favouriteToggled(_ sender: UIButton) {
        
    }
    

    func setContact(_ contact:ContactModel){
        lblContactName.text = contact.firstName + " " + contact.lastName
        btnFavourite.isSelected = contact.isFavourite
        
        let profilePicUrl = BaseURL.url + contact.profilePicUrl
        
        Downloader.shared.downloadIfNotCached(profilePicUrl) { (imageData) in
            self.contactImageView.image = UIImage(data: imageData!)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        contactImageView.image = nil
    }

}
