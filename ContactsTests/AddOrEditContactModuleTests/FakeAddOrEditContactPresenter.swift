//
//  FakeAddOrEditContactPresenter.swift
//  ContactsTests
//
//  Created by Nithin on 09/05/18.
//  Copyright © 2018 Nithin. All rights reserved.
//

import Foundation
@testable import Contacts

class FakeAddOrEditContactPresenter:AddOrEditContactInteractorOutputProtocol {
    
    var validationError = false
    
    var contactUpdated = false
    
    var error = false
    
    
    func didUpdateContact() {
        contactUpdated = true
    }
    
    func onError() {
        error = true
    }
    
    func showValidationError() {
        validationError = true
    }
    
    
}
