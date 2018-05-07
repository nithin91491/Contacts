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
    
    func createContact() {
        
    }
    
    func updateContact() {
        
    }
    
    
}


extension AddOrEditContactInteractor : AddOrEditContactDataManagerOutputProtocol {
    func didUpdateContact() {
        
    }
    
    func onError() {
        
    }
    
    
}
