//
//  ContactListPresenter.swift
//  Contacts
//
//  Created by Nithin on 04/05/18.
//  Copyright © 2018 Nithin. All rights reserved.
//

import Foundation

class ContactListPresenter:ContactListPresenterProtocol{
    
    weak var view:(ContactListViewProtocol & ContactListRefreshDelegate)?
    var interactor:ContactListInteractorInputProtocol?
    var wireFrame: ContactListWireFrameProtocol?
    
    
    func viewDidLoad() {
        view?.showLoading()
        interactor?.retreiveContactList()
    }
    
    func showContactDetail(for contactId: Int) {
        wireFrame?.presentContactDetailView(from: view!, forContactId: contactId)
    }
}

extension ContactListPresenter:ContactListInteractorOutputProtocol{
    func didRetriveContacts(_ contacts: [ContactModel]) {
        view?.hideLoading()
        
        //Grouping contacts based on the first letter of their firstName
        let groupedDict = Dictionary(grouping: contacts) { (contact) -> Character  in
            return contact.firstName.first!
        }
        
        var groupedContacts = [[ContactModel]]()
        
        groupedDict.keys.sorted().forEach{ key in
            groupedContacts.append(groupedDict[key]!)
        }
        
        //Send grouped contacts to View
        view?.showContacts(groupedContacts)
    }
    
    func onError() {
        view?.hideLoading()
        view?.onError()
    }
}
