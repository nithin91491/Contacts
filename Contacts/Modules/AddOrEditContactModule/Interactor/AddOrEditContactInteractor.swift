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
    
    var contact: ContactModel? //If it is edit contact, we get the existing contact details else it is nil because its adding a new contact
    
    
    func addOrUpdateContact(firstName: String?, lastName: String?, email: String?, phone: String?) {
        
        //LastName and Email are optional parameters
        guard firstName != nil, validateEmail(email: email), validatePhone(number: phone) else {
            presenter?.showValidationError()
            return
        }
        
        if contact == nil {
            dataManager?.createContact(firstName: firstName!, lastName: lastName, email: email, phoneNumber: phone!)
           
        }  else {
            
            contact?.firstName = firstName!
            contact?.lastName = lastName!
            contact?.email = email!
            contact?.phoneNumber = phone!
            
            dataManager?.updateContact(contact!)
        }
    }
    
    //Validations
    func validateEmail(email:String?) -> Bool{
        
        guard email != nil else {
            return true //We make email as an optional parameter.
        }
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email!)
        
    }
    
    func validatePhone(number:String?)->Bool{
        
        guard number != nil else {
            return false
        }
        
        let phoneRegExp = "[0123456789][0-9]{9}"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegExp)
        if phoneTest.evaluate(with: number) {
            
            if (number! as NSString).hasPrefix("0") {
                
                return false
            }
            return true
        }
        return false
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
