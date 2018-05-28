//
//  ContactListInteractorTests.swift
//  ContactsTests
//
//  Created by Nithin on 08/05/18.
//  Copyright © 2018 Nithin. All rights reserved.
//

import XCTest

@testable import Contacts

class ContactListInteractorTests: XCTestCase {
    
    var interactor:ContactListInteractor!
    var fakeDataManager:FakeContactListDataManager!
    var fakePresenter:FakeContactListPresenter!
    
    override func setUp() {
        super.setUp()
        
        interactor = ContactListInteractor()
        fakeDataManager = FakeContactListDataManager()
        fakePresenter = FakeContactListPresenter()
        
        fakeDataManager.dataManagerOutput = interactor
        interactor.presenter = fakePresenter
        interactor.dataManager = fakeDataManager
    }
    
    override func tearDown() {
        interactor = nil
        fakeDataManager = nil
        fakePresenter = nil
        super.tearDown()
    }
    
    
    func testThatInteractorFetchesContactsAndGivesItToPresenter(){
        
        //Simulate a successful network call by setting the flag
        fakeDataManager.networkResponse = true
        
        //Ask Interactor to get contacts list, it should return an empty array of contact model and also set the flag as per what we've coded.
        interactor.retreiveContactList()
        
        XCTAssert(fakeDataManager.retreiveContactsInvoked, "Interactor should call the data manager to retrive contacts list")
        
        XCTAssert(fakePresenter.contactsRetreived, "Interactor should pass contacts to Presenter in case of success")
        
    }
    
    func testThatInteractorPassesErrorToPresenterOnFailure(){
        
        //Simulate a failed network call by setting the flag to false
        fakeDataManager.networkResponse = false
        
        //Ask Interactor to get contacts list, it should invoke error method on presenter
        interactor.retreiveContactList()
        
        XCTAssert(fakeDataManager.retreiveContactsInvoked, "Interactor should call the data manager to retrive contacts list")
        
        XCTAssert((!fakePresenter.contactsRetreived && fakePresenter.errorOccured), "Interactor should invoke error method of presenter on failure.")
        
    }
    
}
