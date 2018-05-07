//
//  ContactDetailsPresenter.swift
//  Contacts
//
//  Created by Nithin on 04/05/18.
//  Copyright © 2018 Nithin. All rights reserved.
//

import Foundation
import MessageUI

class ContactDetailsPresenter: ContactDetailsPresenterProtocol {
  
    var view: ContactDetailsViewProtocol?
    
    var interactor: ContactDetailsInteractorInputProtocol?
    
    var wireFrame: ContactDetailsWireFrameProtocol?
    
    var contactId:Int!
    
    var contactModel:ContactModel?
    
    weak var delegateContactListRefresh:ContactListRefreshDelegate?
    
    func viewDidLoad() {
        view?.showLoading()
        interactor?.retriveContactDetails(contactId)
    }
    
    func sendSMS() {
        if (MFMessageComposeViewController.canSendText()) {
            let controller = MFMessageComposeViewController()
            controller.body = "Message"
            controller.recipients = [contactModel?.phoneNumber ?? ""]
            controller.messageComposeDelegate = view! as? MFMessageComposeViewControllerDelegate
            view?.showMessagingController(controller)
        }
    }
    
    func call() {
        let mobileNumber = contactModel?.phoneNumber ?? ""
        if let url = NSURL(string: "tel://\(mobileNumber)"), UIApplication.shared.canOpenURL(url as URL) {
            
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }
    
    func email() {
        
        let mailController: MFMailComposeViewController = MFMailComposeViewController()
        mailController.mailComposeDelegate = view! as? MFMailComposeViewControllerDelegate
        mailController.setSubject("")
        mailController.setMessageBody("Sending the mail", isHTML: false)
        mailController.setToRecipients([contactModel?.email ?? ""])
        view?.showEmailController(mailController)
    }
    
    func toggleFavourite(favourite: Bool) {
        interactor?.toggleFavourite(contactId: contactId, favourite: favourite)
    }
    
    func editContact() {
        wireFrame?.presentEditContactScreen(source: view!, contact: contactModel!)
    }
 
}


extension ContactDetailsPresenter:ContactDetailsInteractorOutputProtocol{
    func didRetreiveContactDetails(_ contact: ContactModel) {
        view?.hideLoading()
        self.contactModel = contact
        view?.displayContactDetails(contact)
        interactor?.downloadProfilePicFor(url: contact.profilePicUrl)
    }
    
    func didDownloadProfilePic(_ imageData: Data) {
        view?.setProfilePic(imageData)
    }
    
    func didToggleFavourite() {
        delegateContactListRefresh?.refreshData()
    }
    
    func onError() {
        view?.onError()
    }
}

