//
//  AddOrEditContactInteractor.swift
//  Contacts
//
//  Created by Nithin on 07/05/18.
//  Copyright © 2018 Nithin. All rights reserved.
//

import Foundation

class AddOrEditContactInteractor: AddOrEditContactInteractorInputProtocol {
    var presenter: AddOrEditContactInteractorOutputProtocol?
    
    var dataManager: AddOrEditContactDataManagerInputProtocol?
    
    func createContact(firstName:String, lastName:String?, email:String?, phoneNumber:String){
        dataManager?.createContact(firstName: firstName, lastName: lastName, email: email, phoneNumber: phoneNumber)
    }
    
    func updateContact(_ contact: ContactModel) {
        dataManager?.updateContact(contact)
    }
}


extension AddOrEditContactInteractor : AddOrEditContactDataManagerOutputProtocol {
    func didUpdateContact() {
        presenter?.didUpdateContact()
    }
    
    func onError() {
        presenter?.onError()
    }
    
    
}
