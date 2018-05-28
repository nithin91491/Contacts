//
//  ContactListDataManager.swift
//  Contacts
//
//  Created by Nithin on 04/05/18.
//  Copyright © 2018 Nithin. All rights reserved.
//

import Foundation

class ContactListDataManager:ContactListDataManagerInputProtocol{
    
    var dataManagerOutput:ContactListDataManagerOutputProtocol?
    
    var requestManager: RequestManagerProtocol {
        return RequestManager()
    }
    
    func retreiveContactList() {
        requestManager.request(.get, apiPath: .contactsList, httpBody: nil) { (response) in
            switch response {
            case .success(let contactsJson):
                
                var contacts = [ContactModel]()
                
                for contactRaw in contactsJson.arrayValue {
                    do{
                        let contact:ContactModel = try JSONDecoder.decode(json: contactRaw)
                        contacts.append(contact)
                    } catch{
                        print(error.localizedDescription)
                    }
                }
                
                self.dataManagerOutput?.onContactsRetreived(contacts)
                
            case .failure(let error):
                print(error)
                self.dataManagerOutput?.onError()
            }
        }
        
        
    }
}
