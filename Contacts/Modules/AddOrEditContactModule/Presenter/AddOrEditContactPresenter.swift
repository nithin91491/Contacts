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
    
    weak var contactListRefreshDelegate:ContactListRefreshDelegate?
    
    weak var contactDetailsRefreshDelegate:ContactDetailsRefreshDelegate?
    
    
    func viewDidLoad() {
        if let contact = interactor?.contact {
            view?.displayContactDetails(contact)
        }
    }
    
    func addOrUpdateContact(firstName:String?, lastName:String?, email:String?, phone:String?){

        view?.showLoading()
        interactor?.addOrUpdateContact(firstName: firstName, lastName: lastName, email: email, phone: phone)
    }

}


extension AddOrEditContactPresenter: AddOrEditContactInteractorOutputProtocol {
    func didUpdateContact() {
        view?.hideLoading()
        view?.showSuccessAlert("Contact saved")
        contactListRefreshDelegate?.refreshData()
        contactDetailsRefreshDelegate?.refreshData()
    }
    
    func onError() {
        view?.hideLoading()
        view?.onError("Could not save the contact. Please try again.")
    }
    
    func showValidationError() {
        view?.hideLoading()
        view?.showValidationErrorMessage("Please enter valid data.")
    }
}
