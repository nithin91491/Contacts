//
//  ContactsUITests.swift
//  ContactsUITests
//
//  Created by Nithin on 03/05/18.
//  Copyright © 2018 Nithin. All rights reserved.
//

import XCTest

class ContactsUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()

        app.launch()
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAddNewContactPage(){
        
        //We check the favourite button of contact to see if contacts are loaded or not
        let favouriteButton = app.buttons["favourite"]
        
        let exists = NSPredicate(format: "exists==1")
        
        expectation(for: exists, evaluatedWith: favouriteButton, handler: nil)
        
        //Wait for contacts to load from API
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssert(favouriteButton.exists)
        
        //Tap on the add button
        let addButton = app.buttons["Add"]
        addButton.tap()
        
        //Enter all the fields data
        let firstName = app.textFields["firstName"]
        firstName.tap()
        firstName.typeText("Nithin")
        
                let lastName = app.textFields["lastName"]
        lastName.tap()
        lastName.typeText("Krishna")
        
        let mobile = app.textFields["mobile"]
        mobile.tap()
        mobile.typeText("9176657947")
        
        let email = app.textFields["email"]
        email.tap()
        email.typeText("nithin91491@gmail.com")
        
        let doneButton = app.buttons["Done"]
        doneButton.tap()
        
        let alert = app.alerts["Success"]
        
        //We expect an alert
        expectation(for: exists, evaluatedWith: alert, handler: nil)
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssert(alert.exists)
        
        XCTAssert(alert.staticTexts["Contact saved"].exists)
        
        //Dismiss alert
        alert.buttons["OK"].tap()
        
    }
    
    func testDataVaildation(){
        //We check the favourite button of contact to see if contacts are loaded or not
        let favouriteButton = app.buttons["favourite"]
        
        let exists = NSPredicate(format: "exists==1")
        
        expectation(for: exists, evaluatedWith: favouriteButton, handler: nil)
        
        //Wait for contacts to load from API
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssert(favouriteButton.exists)
        
        //Tap on the add button
        let addButton = app.buttons["Add"]
        addButton.tap()
        
        //Enter all the fields data
        let firstName = app.textFields["firstName"]
        firstName.tap()
        firstName.typeText("Nithin")
        
        let lastName = app.textFields["lastName"]
        lastName.tap()
        lastName.typeText("Krishna")
        
        let mobile = app.textFields["mobile"]
        mobile.tap()
        mobile.typeText("000000435000000")
        
        let email = app.textFields["email"]
        email.tap()
        email.typeText("nithin.krishna.com")
        
        let doneButton = app.buttons["Done"]
        doneButton.tap()
        
        let alert = app.alerts["Failure"]
        
        //We expect an alert
        expectation(for: exists, evaluatedWith: alert, handler: nil)
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssert(alert.exists)
        
        XCTAssert(alert.staticTexts["Please enter valid data."].exists)
        
        //Dismiss alert
        alert.buttons["OK"].tap()
        
        //Close the screen
        let cancelButton = app.buttons["Cancel"]
        cancelButton.tap()
        
    }
    
}
