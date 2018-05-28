//
//  FakeContactDetailsDataManager.swift
//  ContactsTests
//
//  Created by Nithin on 08/05/18.
//  Copyright © 2018 Nithin. All rights reserved.
//

import Foundation
@testable import Contacts

class FakeContactDetailsDataManager : ContactDetailsDataManagerInputProtocol {
    
    weak var dataManagerOutput: ContactDetailsDataManagerOutputProtocol?
    
    var requestManager: RequestManagerProtocol {
        return RequestManager()
    }
    
    var retreiveContactDetailsInvoked = false
    var downloadProfilePicInvoked = false
    var toggleFavouriteInvoked = false
    
    var networkResponse = true
    
    func retreiveContactDetails(_ contactId: Int) {
        retreiveContactDetailsInvoked = true
        
        if networkResponse {
           let contact = ContactModel(id: contactId, firstName: "FirstName", lastName: "LastName", email: "test@email.com", phoneNumber: "9176657947", isFavourite: true, url: "url", profilePicUrl: "picUrl")
            
            dataManagerOutput?.didRetriveContactDetails(contact)
        } else {
            dataManagerOutput?.onError()
        }
    }
    
    func downloadProfilePic(url: String) {
        downloadProfilePicInvoked = true
        dataManagerOutput?.didDownloadProfilePic(Data())
    }
    
    func toggleFavourite(contactId: Int, favourite: Bool) {
        
        toggleFavouriteInvoked = true
        
        networkResponse ? dataManagerOutput?.didToggleFavourite() : dataManagerOutput?.onError()
    }
    
    
}
