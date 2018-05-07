//
//  ContactListProtocol.swift
//  Contacts
//
//  Created by Nithin on 04/05/18.
//  Copyright © 2018 Nithin. All rights reserved.
//

import UIKit

//Protocol to be conformed by contact list View(viewcontroller)
protocol ContactListViewProtocol:class {
    
    //View should have a reference to presenter to communicate.
    var presenter:ContactListPresenterProtocol? { get set }
    
    //View should implement below methods, so that Interactor can communicate with view.
    func showContacts(_ contacts:[[ContactModel]])
    
    func onError()
    
    func showLoading()
    
    func hideLoading()
    
    func refreshData()
}

//To make sure only viewcontrollers can conform to this protocols
extension ContactListViewProtocol where Self:UIViewController {}

protocol ContactListPresenterProtocol:class {
    var view:(ContactListViewProtocol & ContactListRefreshDelegate)? { get set }
    var interactor:ContactListInteractorInputProtocol? { get set }
    var wireFrame: ContactListWireFrameProtocol? { get set }
    
    //VIEW -> PRESENTER (It means that, View communicates to presenter using below methods)
    func viewDidLoad()
    func showContactDetail(for contactId:Int)
    
}

protocol ContactListWireFrameProtocol:class {
    
    static func createContactListModule() -> UIViewController
    
    //PRESENTER -> WIREFRAME
    func presentContactDetailView(from view:ContactListViewProtocol & ContactListRefreshDelegate, forContactId id:Int)
    
}

 protocol ContactListInteractorInputProtocol:class {
    var presenter:ContactListInteractorOutputProtocol? { get set }
    var dataManager:ContactListDataManagerInputProtocol? { get set }
    
    //PRESENTER -> INTERACTOR
    func retreiveContactList()
    
}

protocol ContactListInteractorOutputProtocol:class {
    //INTERACTOR -> PRESENTER
    func didRetriveContacts(_ contacts:[ContactModel])
    func onError()
    
}

protocol ContactListDataManagerInputProtocol:class {
    var dataManagerOutput:ContactListDataManagerOutputProtocol? { get set }
    
    //INTERACTOR -> DATA MANAGER
    func retreiveContactList()
}

protocol ContactListDataManagerOutputProtocol:class {
    
    //DATA MANAGER -> INTERACTOR
    func onContactsRetreived(_ contacts:[ContactModel])
    func onError()
}
