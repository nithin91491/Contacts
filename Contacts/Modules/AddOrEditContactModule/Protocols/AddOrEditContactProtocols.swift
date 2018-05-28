//
//  AddOrEditContactProtocols.swift
//  Contacts
//
//  Created by Nithin on 07/05/18.
//  Copyright © 2018 Nithin. All rights reserved.
//

import UIKit


protocol ContactDetailsRefreshDelegate:class {
    func refreshData()
}

protocol AddOrEditContactViewProtocol:class {
    
    var presenter:AddOrEditContactPresenterProtocol? { get set }
    
    //PRESENTER -> VIEW
    func displayContactDetails(_ contact:ContactModel)
    func setProfilePic(_ imageData:Data)
    func showValidationErrorMessage(_ message:String)
    func showLoading()
    func hideLoading()
    func onError(_ message:String)
    func dismissScreen()
    func showSuccessAlert(_ message:String)
    
}

protocol AddOrEditContactPresenterProtocol:class {
    
    var view:AddOrEditContactViewProtocol? { get set }
    var interactor:AddOrEditContactInteractorInputProtocol? { get set }
    var wireFrame:AddOrEditContactWireFrameProtocol? { get set }
    
    
    //Delegates for refresh
    var contactListRefreshDelegate:ContactListRefreshDelegate? { get set }
    var contactDetailsRefreshDelegate:ContactDetailsRefreshDelegate? { get set }
    
    //VIEW -> PRESENTER
    func addOrUpdateContact(firstName:String?, lastName:String?, email:String?, phone:String?)
    func viewDidLoad()
}

protocol AddOrEditContactWireFrameProtocol:class {
    
    static func createAddOrEditContactModule(with contact:ContactModel?, listRefreshDelegate:ContactListRefreshDelegate?, detailsRefreshDelegate:ContactDetailsRefreshDelegate?) -> UIViewController
}

protocol AddOrEditContactInteractorInputProtocol:class {
    var presenter:AddOrEditContactInteractorOutputProtocol? { get set }
    var dataManager:AddOrEditContactDataManagerInputProtocol? { get set }
    
    var contact:ContactModel? { get set }
    
    //PRESENTER -> INTERACTOR
    func addOrUpdateContact(firstName:String?, lastName:String?, email:String?, phone:String?)
    
}

protocol AddOrEditContactInteractorOutputProtocol:class {
    
    //INTERACTOR -> PRESENTER
    func didUpdateContact()
    func onError()
    
    func showValidationError()
}

protocol AddOrEditContactDataManagerInputProtocol:class {
    
    var dataManagerOutput: AddOrEditContactDataManagerOutputProtocol? { get set }
    var requestManager:RequestManagerProtocol { get }
    
    func createContact(firstName:String, lastName:String?, email:String?, phoneNumber:String)
    func updateContact(_ contact:ContactModel)
    
}

protocol AddOrEditContactDataManagerOutputProtocol:class {
    func didUpdateContact()
    func onError()
}


