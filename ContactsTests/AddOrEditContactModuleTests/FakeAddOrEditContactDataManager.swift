//
//  FakeAddOrEditContactDataManager.swift
//  ContactsTests
//
//  Created by Nithin on 09/05/18.
//  Copyright © 2018 Nithin. All rights reserved.
//

import Foundation
@testable import Contacts

class FakeAddOrEditContactDataManager:AddOrEditContactDataManagerInputProtocol {
    
    var requestManager: RequestManagerProtocol {
        return RequestManager()
    }
    
    var dataManagerOutput: AddOrEditContactDataManagerOutputProtocol?
    
    var createContactInvoked = false
    
    var updateContactInvoked = false
    
    var success = true
    
    func createContact(firstName: String, lastName: String?, email: String?, phoneNumber: String) {
        
        createContactInvoked = true
        
        if success {
            dataManagerOutput?.didUpdateContact()
        } else {
            dataManagerOutput?.onError()
        }
    }
    
    func updateContact(_ contact: ContactModel) {
        updateContactInvoked = true
        
        if success{
            dataManagerOutput?.didUpdateContact()
        } else {
            dataManagerOutput?.onError()
        }
 
    }
    
    
}
