//
//  FakeContactDetailsPresenter.swift
//  ContactsTests
//
//  Created by Nithin on 08/05/18.
//  Copyright © 2018 Nithin. All rights reserved.
//

import Foundation
@testable import Contacts

class FakeContactDetailsPresenter:ContactDetailsInteractorOutputProtocol {
    
    var contactDetailsRetreived = false
    var errorOccured = false
    var profilePicDownloaded = false
    var favouriteToggled = false
    
    var contact:ContactModel!
    
    func didRetreiveContactDetails(_ contact: ContactModel) {
        contactDetailsRetreived = true
        self.contact = contact
    }
    
    func didDownloadProfilePic(_ imageData: Data) {
        profilePicDownloaded = true
    }
    
    func didToggleFavourite() {
        favouriteToggled = true
    }
    
    func onError() {
        errorOccured = true
    }
    
    
}
