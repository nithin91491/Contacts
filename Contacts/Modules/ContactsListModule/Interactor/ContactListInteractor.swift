//
//  ContactListInteractor.swift
//  Contacts
//
//  Created by Nithin on 04/05/18.
//  Copyright © 2018 Nithin. All rights reserved.
//

import Foundation

class ContactListInteractor:ContactListInteractorInputProtocol {
    
    weak var presenter:ContactListInteractorOutputProtocol?
    var dataManager:ContactListDataManagerInputProtocol?
    
    func retreiveContactList() {
        dataManager?.retreiveContactList()
    }
}

extension ContactListInteractor:ContactListDataManagerOutputProtocol{
    func onContactsRetreived(_ contacts: [ContactModel]) {
        presenter?.didRetriveContacts(contacts)
    }
    
    func onError() {
        presenter?.onError()
    }
}
