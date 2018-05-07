//
//  AddOrEditContactPresenter.swift
//  Contacts
//
//  Created by Nithin on 07/05/18.
//  Copyright © 2018 Nithin. All rights reserved.
//

import Foundation

class AddOrEditContactPresenter: AddOrEditContactPresenterProtocol {
    var view: AddOrEditContactViewProtocol?
    
    var interactor: AddOrEditContactInteractorInputProtocol?
    
    var wireFrame: AddOrEditContactWireFrameProtocol?
    
    var contact: ContactModel? //If it is edit contact, we get the existing contact details else it is nil because its adding a new contact
    
    func viewDidLoad() {
        if let contactUnwrapped = contact {
            view?.displayContactDetails(contactUnwrapped)
        }
    }
    
    func addOrUpdateContact() {
        
    }
    
    
}


extension AddOrEditContactPresenter: AddOrEditContactInteractorOutputProtocol {
    func didUpdateContact() {
        
    }
    
    func onError() {
        
    }
    
    
}
