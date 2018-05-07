//
//  AddOrEditContactDataManager.swift
//  Contacts
//
//  Created by Nithin on 07/05/18.
//  Copyright © 2018 Nithin. All rights reserved.
//

import Foundation

class AddOrEditContactDataManager: AddOrEditContactDataManagerInputProtocol {
    var dataManagerOutput: AddOrEditContactDataManagerOutputProtocol?
    
    func createContact(firstName: String, lastName: String?, email: String?, phoneNumber: String) {
        
        var body = ["first_name":firstName, "phone_number":phoneNumber]
        
        if let lastName = lastName {
            body.updateValue(lastName, forKey: "last_name")
        }
        
        if let email = email {
            body.updateValue(email, forKey: "email")
        }
        
        RequestManager.shared.request(.post, apiPath: .createContact, httpBody: body.jsonString()) { (response) in
            switch response {
            case .success:
                self.dataManagerOutput?.didUpdateContact()
            case .failure:
                self.dataManagerOutput?.onError()
            }
        }
        
        
    }
    
    func updateContact(_ contact: ContactModel) {
        
        let body = ["first_name":contact.firstName, "phone_number":contact.phoneNumber, "last_name":contact.lastName, "email":contact.email]
        
        RequestManager.shared.request(.put, apiPath: .updateContact(id: contact.id), httpBody: body.jsonString()) { (response) in
            switch response {
            case .success:
                self.dataManagerOutput?.didUpdateContact()
            case .failure:
                self.dataManagerOutput?.onError()
            }
        }
    }
    
}
