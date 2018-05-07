//
//  ContactDetailsProtocols.swift
//  Contacts
//
//  Created by Nithin on 04/05/18.
//  Copyright © 2018 Nithin. All rights reserved.
//

import UIKit

protocol ContactListRefreshDelegate:class {
    func refreshData()
}

protocol ContactDetailsViewProtocol:class {
    var presenter:ContactDetailsPresenterProtocol? { get set }
    
    //PRESENTER -> VIEW
    func displayContactDetails(_ contact:ContactModel)
    func setProfilePic(_ imageData:Data)
    func onError()
    func showLoading()
    func hideLoading()
    
    func showMessagingController(_ controller:UIViewController)
    func showEmailController(_ controller:UIViewController)
}

protocol ContactDetailsPresenterProtocol:class {
    var view:ContactDetailsViewProtocol? { get set }
    var interactor:ContactDetailsInteractorInputProtocol? { get set }
    var wireFrame:ContactDetailsWireFrameProtocol? { get set }
    
    var contactId:Int! { get set }
    var delegateContactListRefresh:ContactListRefreshDelegate? { get set }
    
    //VIEW -> PRESENTER
    func viewDidLoad()
    func sendSMS()
    func call()
    func email()
    func toggleFavourite(favourite:Bool)
    func editContact()
    
}

protocol ContactDetailsWireFrameProtocol:class {
    static func createContactDetailModule(_ contactId:Int, refreshDelegate:ContactListRefreshDelegate)->UIViewController
    
    func presentEditContactScreen(source view:ContactDetailsViewProtocol, contact: ContactModel)
}

protocol ContactDetailsInteractorInputProtocol:class {
    var presenter:ContactDetailsInteractorOutputProtocol? { get set }
    var dataManager:ContactDetailsDataManagerInputProtocol? { get set }
    
    //PRESENTER -> INTERACTOR
    func retriveContactDetails(_ contactId:Int)
    func downloadProfilePicFor(url:String)
    func toggleFavourite(contactId:Int, favourite:Bool)
}

protocol ContactDetailsInteractorOutputProtocol:class {
    //INTERACTOR -> PRESENTER
    func didRetreiveContactDetails(_ contact:ContactModel)
    func didDownloadProfilePic(_ imageData:Data)
    func didToggleFavourite()
    func onError()
}

protocol ContactDetailsDataManagerInputProtocol:class {
    var dataManagerOutput:ContactDetailsDataManagerOutputProtocol? { get set }
    
    //INTERACTOR -> DATA MANAGER
    func retreiveContactDetails(_ contactId:Int)
    func downloadProfilePic(url:String)
    func toggleFavourite(contactId:Int, favourite:Bool)
}

protocol ContactDetailsDataManagerOutputProtocol:class {
    
    //DATA MANAGER -> INTERACTOR
    func didRetriveContactDetails(_ contact:ContactModel)
    func didDownloadProfilePic(_ imageData:Data)
    func didToggleFavourite()
    func onError()
}
