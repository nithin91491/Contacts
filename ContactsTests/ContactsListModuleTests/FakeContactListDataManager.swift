//
//  FakeContactListDataManager.swift
//  ContactsTests
//
//  Created by Nithin on 08/05/18.
//  Copyright © 2018 Nithin. All rights reserved.
//

import Foundation
@testable import Contacts

class FakeContactListDataManager:ContactListDataManagerInputProtocol {
    
    weak var dataManagerOutput: ContactListDataManagerOutputProtocol?
    
    var requestManager: RequestManagerProtocol {
        return RequestManager()
    }
    
    var retreiveContactsInvoked:Bool = false
    
    var networkResponse = true
    
    func retreiveContactList() {
        retreiveContactsInvoked = true
        
        if networkResponse {
            dataManagerOutput?.onContactsRetreived([])
        } else {
            dataManagerOutput?.onError()
        }
    }
    
    
}
