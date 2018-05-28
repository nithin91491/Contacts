//
//  AddOrEditContactInteractorTests.swift
//  ContactsTests
//
//  Created by Nithin on 09/05/18.
//  Copyright © 2018 Nithin. All rights reserved.
//

import XCTest
@testable import Contacts

class AddOrEditContactInteractorTests: XCTestCase {
    
    var interactor:AddOrEditContactInteractor!
    var fakeDataManager:FakeAddOrEditContactDataManager!
    var fakePresenter:FakeAddOrEditContactPresenter!
    
    override func setUp() {
        super.setUp()
        
        interactor = AddOrEditContactInteractor()
        fakeDataManager = FakeAddOrEditContactDataManager()
        fakePresenter = FakeAddOrEditContactPresenter()
        
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
    
    func testThatEmailIsValidatedBeforeSavingContact(){
        
        //Simulate a wrong email
        let existingContact = ContactModel(id: 1, firstName: "Nithin", lastName: "Krishna", email: "nithin.123.com", phoneNumber: "9176657947", isFavourite: true, url: "", profilePicUrl: "")

        //Try to update contact
        interactor.contact = existingContact
        interactor.addOrUpdateContact(firstName: existingContact.firstName, lastName: existingContact.lastName, email: existingContact.email, phone: existingContact.phoneNumber)
        
        //Presenter's validation error method should be invoked on a validation error
        XCTAssert(fakePresenter.validationError, "Presenter's validation error method should be invoked on a validation error")
    }
    
    func testThatPhoneNumberIsValidatedBeforeSavingContact(){
        //Simulate a wrong phone number
        let existingContact = ContactModel(id: 1, firstName: "Nithin", lastName: "Krishna", email: "nithin91491@gmail.com", phoneNumber: "00000444", isFavourite: true, url: "", profilePicUrl: "")
        
        //Try to update contact
        interactor.contact = existingContact
        interactor.addOrUpdateContact(firstName: existingContact.firstName, lastName: existingContact.lastName, email: existingContact.email, phone: existingContact.phoneNumber)
        
        //Presenter's validation error method should be invoked on a validation error
        XCTAssert(fakePresenter.validationError, "Presenter's validation error method should be invoked on a validation error")
    }
    
    func testEditContactDetails(){
        
        //lets take an existing contact
        let existingContact = ContactModel(id: 1, firstName: "Nithin", lastName: "Krishna", email: "nithin91491@gmail.com", phoneNumber: "9176657947", isFavourite: true, url: "", profilePicUrl: "")
        
        //Assign existing contact details to interactor.
        interactor.contact = existingContact
        
        //Call interactor's addOrUpdateContact method
        interactor.addOrUpdateContact(firstName: existingContact.firstName, lastName: existingContact.lastName, email: existingContact.email, phone: existingContact.phoneNumber)
        
        //Interactor's method should invoke update contact method of dataManager according to the business logic
        XCTAssert(fakeDataManager.updateContactInvoked, "Update contact method should be called to update contact")
    }
    
    func testAddContactDetails(){
        
        //When adding new contact, interactor would not have an existing contact.
        interactor.contact = nil
        
        //Call interactor's addOrUpdateContact method
        interactor.addOrUpdateContact(firstName: "Nithin", lastName: "Krishna", email: "nithin91491@gmail.com", phone: "9176657947")
        
        //Interactor's method should invoke  createContact method of dataManager according to the business logic
        XCTAssert(fakeDataManager.createContactInvoked, "Create contact method should be called to create contact")
    }
    
    func testThatSuccessfulNetworkCallInvokesSuccessMethodOfPresenter(){
     
        //lets take adding a new contact
        interactor.contact = nil
        
        //Simulate success by setting the flag
        fakeDataManager.success = true
        
        
        //Call interactor's addOrUpdateContact method
        interactor.addOrUpdateContact(firstName: "Nithin", lastName: "Krishna", email: "nithin91491@gmail.com", phone: "9176657947")
        
        XCTAssert(fakePresenter.contactUpdated, "On success, success method should be called on presenter")
        
    }
    
    func testThatFailedNetworkCallInvokesErrorMethodOfPresenter(){
        
        //lets take adding a new contact
        interactor.contact = nil
        
        //Simulate success by setting the flag
        fakeDataManager.success = false
        
        
        //Call interactor's addOrUpdateContact method
        interactor.addOrUpdateContact(firstName: "Nithin", lastName: "Krishna", email: "nithin91491@gmail.com", phone: "9176657947")
        
        XCTAssert(fakePresenter.error, "On Failure, Error method should be called on presenter")
        
    }
    
}
