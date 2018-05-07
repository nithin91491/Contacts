//
//  ContactDetailsInteractor.swift
//  Contacts
//
//  Created by Nithin on 04/05/18.
//  Copyright © 2018 Nithin. All rights reserved.
//

import Foundation


class ContactDetailsInteractor: ContactDetailsInteractorInputProtocol {
    var presenter: ContactDetailsInteractorOutputProtocol?
    
    var dataManager: ContactDetailsDataManagerInputProtocol?
    
    func retriveContactDetails(_ contactId: Int) {
        dataManager?.retreiveContactDetails(contactId)
    }
    
    func downloadProfilePicFor(url: String) {
        dataManager?.downloadProfilePic(url: url)
    }
    
    func toggleFavourite(contactId:Int, favourite:Bool) {
        dataManager?.toggleFavourite(contactId: contactId, favourite: favourite)
    }
    
}


extension ContactDetailsInteractor:ContactDetailsDataManagerOutputProtocol {
   
    func didRetriveContactDetails(_ contact:ContactModel) {
        presenter?.didRetreiveContactDetails(contact)
    }
    
    func didDownloadProfilePic(_ imageData: Data) {
        presenter?.didDownloadProfilePic(imageData)
    }
    
    func didToggleFavourite() {
        presenter?.didToggleFavourite()
    }
    
    func onError() {
        presenter?.onError()
    }
    
    
}
