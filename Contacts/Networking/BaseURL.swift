//
//  BaseURL.swift
//  Contacts
//
//  Created by Nithin on 04/05/18.
//  Copyright © 2018 Nithin. All rights reserved.
//

import Foundation


struct BaseURL {
    static let url =  "http://gojek-contacts-app.herokuapp.com"
}

enum ApiPath : CustomStringConvertible {
    case contactsList
    case getContactDetails(id:Int)
    case updateContact(id:Int)
   
    
    var description: String{
        switch self{
        case .contactsList:
            return "/contacts.json"
        case .getContactDetails(let id):
            return "/contacts/\(id).json"
        case .updateContact(let id):
            return "/contacts/\(id).json"
        }
    }
    
}
