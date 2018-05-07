//
//  AddOrEditContactWireFrame.swift
//  Contacts
//
//  Created by Nithin on 07/05/18.
//  Copyright © 2018 Nithin. All rights reserved.
//

import UIKit


class AddOrEditContactWireFrame: AddOrEditContactWireFrameProtocol {
    static func createAddOrEditContactModule(with contact: ContactModel?) -> UIViewController {
        
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
            presenter.contact = contact
            
            interactor.presenter = presenter
            interactor.dataManager = dataManager
            
            dataManager.dataManagerOutput = interactor
            
            return navVc as UIViewController
            
        }
        
        
        return UIViewController()
    }
    
    
}
