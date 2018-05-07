//
//  ContactDetailsWireFrame.swift
//  Contacts
//
//  Created by Nithin on 04/05/18.
//  Copyright © 2018 Nithin. All rights reserved.
//

import UIKit

class ContactDetailsWireFrame:ContactDetailsWireFrameProtocol {
    
    static func createContactDetailModule(_ contactId: Int, refreshDelegate:ContactListRefreshDelegate)-> UIViewController {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        if let contactDetailsView = storyBoard.instantiateViewController(withIdentifier: "ContactDetailsView") as? ContactDetailsViewProtocol {
            
            let presenter:ContactDetailsPresenterProtocol & ContactDetailsInteractorOutputProtocol = ContactDetailsPresenter()
            let interactor : ContactDetailsInteractorInputProtocol & ContactDetailsDataManagerOutputProtocol = ContactDetailsInteractor()

            let dataManager: ContactDetailsDataManagerInputProtocol = ContactDetailsDataManager()
            let wireFrame:ContactDetailsWireFrameProtocol = ContactDetailsWireFrame()
            
            contactDetailsView.presenter = presenter
            presenter.interactor = interactor
            presenter.view = contactDetailsView
            presenter.wireFrame = wireFrame
            presenter.contactId = contactId
            presenter.delegateContactListRefresh = refreshDelegate
            
            interactor.dataManager = dataManager
            interactor.presenter = presenter
            dataManager.dataManagerOutput = interactor
            
            return contactDetailsView as! UIViewController
        }
        
        return UIViewController()
    }
    
    
    func presentEditContactScreen(source view:ContactDetailsViewProtocol, contact: ContactModel) {
        
        let editContactView = AddOrEditContactWireFrame.createAddOrEditContactModule(with: contact)
        
        if let sourceView = view as? UIViewController {
            sourceView.present(editContactView, animated: true, completion: nil)
        }
    }
    
}
