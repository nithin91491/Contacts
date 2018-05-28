//
//  FakeContactListPresenter.swift
//  ContactsTests
//
//  Created by Nithin on 08/05/18.
//  Copyright © 2018 Nithin. All rights reserved.
//

import Foundation
@testable import Contacts

class FakeContactListPresenter: ContactListInteractorOutputProtocol {
    
    var contactsRetreived = false
    
    var errorOccured = false
    
    func didRetriveContacts(_ contacts: [ContactModel]) {
        contactsRetreived = true
    }
    
    func onError() {
        errorOccured = true
    }
}
