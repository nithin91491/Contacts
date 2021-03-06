//
//  AddOrEditContactWireFrame.swift
//  Contacts
//
//  Created by Nithin on 07/05/18.
//  Copyright © 2018 Nithin. All rights reserved.
//

import UIKit


class AddOrEditContactWireFrame: AddOrEditContactWireFrameProtocol {
    static func createAddOrEditContactModule(with contact:ContactModel?, listRefreshDelegate:ContactListRefreshDelegate?, detailsRefreshDelegate:ContactDetailsRefreshDelegate?) -> UIViewController{
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        if let navVc = storyBoard.instantiateViewController(withIdentifier: "AddOrEditContactViewNav") as? UINavigationController, let view = navVc.childViewControllers.first as? AddOrEditContactViewProtocol {
            
            let presenter:AddOrEditContactPresenterProtocol & AddOrEditContactInteractorOutputProtocol = AddOrEditContactPresenter()
            let interactor:AddOrEditContactInteractorInputProtocol & AddOrEditContactDataManagerOutputProtocol = AddOrEditContactInteractor()
            let wireFrame : AddOrEditContactWireFrameProtocol = AddOrEditContactWireFrame()
            let dataManager:AddOrEditContactDataManagerInputProtocol = AddOrEditContactDataManager()
            
            view.presenter = presenter
            
            presenter.view = view
            presenter.interactor = interactor
            presenter.wireFrame = wireFrame
            
            //Set refresh delegates
            presenter.contactListRefreshDelegate = listRefreshDelegate
            presenter.contactDetailsRefreshDelegate = detailsRefreshDelegate
            
            interactor.presenter = presenter
            interactor.dataManager = dataManager
            interactor.contact = contact
            
            dataManager.dataManagerOutput = interactor
            
            return navVc as UIViewController
            
        }
        
        
        return UIViewController()
    }
    
    
}
