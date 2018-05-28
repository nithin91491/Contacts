//
//  ContactDetailsInteractorTests.swift
//  ContactsTests
//
//  Created by Nithin on 08/05/18.
//  Copyright © 2018 Nithin. All rights reserved.
//

import XCTest
@testable import Contacts

class ContactDetailsInteractorTests: XCTestCase {
    
    var interactor:ContactDetailsInteractor!
    var fakeDataManager:FakeContactDetailsDataManager!
    var fakePresenter:FakeContactDetailsPresenter!
    
    override func setUp() {
        super.setUp()
        
        interactor = ContactDetailsInteractor()
        fakeDataManager = FakeContactDetailsDataManager()
        fakePresenter = FakeContactDetailsPresenter()
        
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
    
    func testThatInteractorFetchesContactDetailsAndPassesItToPresenter(){
        
        //Simulate a successful network call by setting the flag
        fakeDataManager.networkResponse = true
        
        //Test fetching contact details
        let contactId = 1
        interactor.retriveContactDetails(contactId)
        
        XCTAssert(fakeDataManager.retreiveContactDetailsInvoked, "Interactor should invoke retreive Contact details method of Data Manager")
        
        XCTAssert(fakePresenter.contactDetailsRetreived, "Interactor should pass contact details to presenter")
        
        XCTAssert(fakePresenter.contact.id == contactId, "We should get a contact details for a given contact id")
        
        //Test downloading profilePic
        interactor.downloadProfilePicFor(url: "url")
        
        XCTAssert(fakeDataManager.downloadProfilePicInvoked, "Interactor should request Data Manager ")
        XCTAssert(fakePresenter.profilePicDownloaded, "Interactor should handover image data to presenter")
        
        
        //Test toggling Favourite
        interactor.toggleFavourite(contactId: contactId, favourite: true)
        
        XCTAssert(fakeDataManager.toggleFavouriteInvoked, "Interactor should request Data Manager ")
        XCTAssert(fakePresenter.favouriteToggled, "Interactor should call back to presenter")
        
    }
    
    func testThatInteractorPassesErrorToPresenterOnFailure(){
        //Simulate a failed network call by setting the flag
        fakeDataManager.networkResponse = false
        
        //Test fetching contact details
        let contactId = 1
        interactor.retriveContactDetails(contactId)
        
        
        XCTAssert(fakeDataManager.retreiveContactDetailsInvoked, "Interactor should invoke retreive Contact details method of Data Manager")
        
        XCTAssert(fakePresenter.errorOccured, "Interactor should pass contact details to presenter")
        
        XCTAssert(fakePresenter.contact == nil, "Contact should be nil on failure")
       
    }
    
}
