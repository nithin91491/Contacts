//
//  ContactListWireFrame.swift
//  Contacts
//
//  Created by Nithin on 04/05/18.
//  Copyright © 2018 Nithin. All rights reserved.
//

import UIKit

class ContactListWireFrame:ContactListWireFrameProtocol{
    
    static func createContactListModule() -> UIViewController {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let navController = storyBoard.instantiateViewController(withIdentifier: "ContactListNavController") as! UINavigationController
     
        if let contactListView = navController.childViewControllers.first as? (ContactListViewProtocol & ContactListRefreshDelegate) {
            
            let presenter:ContactListPresenterProtocol & ContactListInteractorOutputProtocol = ContactListPresenter()
            let interactor : ContactListInteractorInputProtocol & ContactListDataManagerOutputProtocol = ContactListInteractor()
            
            let dataManager: ContactListDataManagerInputProtocol = ContactListDataManager()
            let wireFrame:ContactListWireFrameProtocol = ContactListWireFrame()
            
            contactListView.presenter = presenter
            presenter.view = contactListView
            presenter.interactor = interactor
            presenter.wireFrame = wireFrame
            interactor.dataManager = dataManager
            interactor.presenter = presenter
            dataManager.dataManagerOutput = interactor
            
        }
        
        return navController
    }
    
    func presentContactDetailView(from view: ContactListViewProtocol & ContactListRefreshDelegate, forContactId id: Int) {
        
        //create detail module and get the vc
        let contactDetailView = ContactDetailsWireFrame.createContactDetailModule(id, refreshDelegate: view)
        
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(contactDetailView, animated: true)
        }
        
    }
    
    func presentAddContactScreen(source view:ContactListViewProtocol & ContactListRefreshDelegate){
        let addContactView = AddOrEditContactWireFrame.createAddOrEditContactModule(with: nil, listRefreshDelegate: view, detailsRefreshDelegate: nil)
        
        if let sourceView = view as? UIViewController {
            sourceView.present(addContactView, animated: true, completion: nil)
        }
        
    }
}
