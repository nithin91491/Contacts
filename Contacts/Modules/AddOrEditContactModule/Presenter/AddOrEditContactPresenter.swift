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
    
    weak var contactListRefreshDelegate:ContactListRefreshDelegate?
    
    weak var contactDetailsRefreshDelegate:ContactDetailsRefreshDelegate?
    
    
    func viewDidLoad() {
        if let contactUnwrapped = contact {
            view?.displayContactDetails(contactUnwrapped)
        }
    }
    
    func addOrUpdateContact(firstName:String?, lastName:String?, email:String?, phone:String?){
        
        //LastName and Email are optional parameters
        guard firstName != nil, validateEmail(email: email), validatePhone(number: phone) else {
            view?.showValidationErrorMessage()
            return
        }
        
        view?.showLoading()
        if contact == nil {
            interactor?.createContact(firstName: firstName!, lastName: lastName, email: email, phoneNumber: phone!)
        }  else {
            
            contact?.firstName = firstName!
            contact?.lastName = lastName!
            contact?.email = email!
            contact?.phoneNumber = phone!
            
            interactor?.updateContact(contact!)
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


extension AddOrEditContactPresenter: AddOrEditContactInteractorOutputProtocol {
    func didUpdateContact() {
        view?.hideLoading()
        view?.dismissScreen()
        contactListRefreshDelegate?.refreshData()
        contactDetailsRefreshDelegate?.refreshData()
    }
    
    func onError() {
        view?.hideLoading()
        view?.onError()
    }
    
    
}
