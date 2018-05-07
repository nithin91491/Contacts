//
//  ContactModel.swift
//  Contacts
//
//  Created by Nithin on 04/05/18.
//  Copyright © 2018 Nithin. All rights reserved.
//

import Foundation

struct ContactModel {
    var id:Int
    var firstName:String
    var lastName:String
    var email:String
    var phoneNumber:String
    var isFavourite:Bool
    var url:String
    var profilePicUrl:String
}


extension ContactModel:JSONDecodable{
    init(decoder: JSONDecoder) throws {
        self.id = decoder.valueForKeyPath("id").intValue
        self.firstName = decoder.valueForKeyPath("first_name").stringValue
        self.lastName = decoder.valueForKeyPath("last_name").stringValue
        self.email = decoder.valueForKeyPath("email").stringValue
        self.phoneNumber = decoder.valueForKeyPath("phone_number").stringValue
        self.isFavourite = decoder.valueForKeyPath("favorite").boolValue
        self.url = decoder.valueForKeyPath("url").stringValue
        self.profilePicUrl = decoder.valueForKeyPath("profile_pic").stringValue
    }
}
