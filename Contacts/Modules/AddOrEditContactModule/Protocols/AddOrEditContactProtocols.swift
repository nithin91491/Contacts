//
//  AddOrEditContactProtocols.swift
//  Contacts
//
//  Created by Nithin on 07/05/18.
//  Copyright © 2018 Nithin. All rights reserved.
//

import UIKit

protocol AddOrEditContactViewProtocol:class {
    
    var presenter:AddOrEditContactPresenterProtocol? { get set }
    
    //PRESENTER -> VIEW
    func displayContactDetails(_ contact:ContactModel)
    func setProfilePic(_ imageData:Data)
    
}

protocol AddOrEditContactPresenterProtocol:class {
    
    var view:AddOrEditContactViewProtocol? { get set }
    var interactor:AddOrEditContactInteractorInputProtocol? { get set }
    var wireFrame:AddOrEditContactWireFrameProtocol? { get set }
    
    var contact:ContactModel? { get set }
    
    //VIEW -> PRESENTER
    func viewDidLoad()
    func addOrUpdateContact()
}

protocol AddOrEditContactWireFrameProtocol:class {
    
    static func createAddOrEditContactModule(with contact:ContactModel?) -> UIViewController
}

protocol AddOrEditContactInteractorInputProtocol:class {
    var presenter:AddOrEditContactInteractorOutputProtocol? { get set }
    var dataManager:AddOrEditContactDataManagerInputProtocol? { get set }
    
    //PRESENTER -> INTERACTOR
    func createContact()
    func updateContact()
}

protocol AddOrEditContactInteractorOutputProtocol:class {
    
    //INTERACTOR -> PRESENTER
    func didUpdateContact()
    func onError()
}

protocol AddOrEditContactDataManagerInputProtocol:class {
    
    var dataManagerOutput: AddOrEditContactDataManagerOutputProtocol? { get set }
    
    func createContact()
    func updateContact()
    
}

protocol AddOrEditContactDataManagerOutputProtocol:class {
    func didUpdateContact()
    func onError()
}


