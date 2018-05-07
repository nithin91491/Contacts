//
//  ContactDetailsView.swift
//  Contacts
//
//  Created by Nithin on 04/05/18.
//  Copyright © 2018 Nithin. All rights reserved.
//

import UIKit
import MessageUI

class ContactDetailsView: UIViewController, HUDRenderer {
    
    
    //Outlets
    @IBOutlet weak var contactImageView: UIImageView!
    
    @IBOutlet weak var lblContactName: UILabel!
    
    @IBOutlet weak var btnFavourite: UIButton!
    
    @IBOutlet weak var lblPhoneNumber: UILabel!
    
    @IBOutlet weak var lblEmail: UILabel!
    
    var presenter: ContactDetailsPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        
        let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editContact(_:)))
        self.navigationItem.rightBarButtonItem = editButton
    }
    
    @objc
    func editContact(_ sender:UIBarButtonItem){
        presenter?.editContact()
    }
    
    //IBActions
    @IBAction func didTapMessage(_ sender: UIButton) {
        presenter?.sendSMS()
    }
    
    @IBAction func didTapCall(_ sender: UIButton) {
        presenter?.call()
    }
    
    @IBAction func didTapEmail(_ sender: UIButton) {
        presenter?.email()
    }
    
    @IBAction func didTapFavourite(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        presenter?.toggleFavourite(favourite: sender.isSelected)
    }
    
}


extension ContactDetailsView:ContactDetailsViewProtocol, MFMessageComposeViewControllerDelegate, MFMailComposeViewControllerDelegate {
    
    func displayContactDetails(_ contact: ContactModel) {
        lblContactName.text = contact.firstName + " " + contact.lastName
        lblEmail.text = contact.email
        lblPhoneNumber.text = contact.phoneNumber
        btnFavourite.isSelected = contact.isFavourite
    }
    
    func setProfilePic(_ imageData: Data) {
        contactImageView.image = UIImage(data: imageData)
    }
    
    func onError() {
        self.showAlert(message: "An error occured. Please try again later")
    }
    
    func showLoading() {
        self.showActivityIndicator()
    }
    
    func hideLoading() {
        self.hideActivityIndicator()
    }
    
    func showMessagingController(_ controller: UIViewController) {
        self.present(controller, animated: true, completion: nil)
    }
    
    func showEmailController(_ controller: UIViewController) {
        self.present(controller, animated: true, completion: nil)
    }
    
    //Messaging delegate
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
