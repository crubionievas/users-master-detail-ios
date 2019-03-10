//
//  UsersMasterDetailUITests.swift
//  UsersMasterDetailUITests
//
//  Created by Carlos Rubio on 07/03/2019.
//  Copyright © 2019 Carlos Rubio. All rights reserved.
//

import XCTest

class UsersMasterDetailUITests: XCTestCase {
    
    var app: XCUIApplication!
    let existancePredicate = NSPredicate(format: "exists == true")

    override func setUp() {
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
    }
    
    // MARK: - Users Use Cases

    func testAccessFirstUser() {
        // Access the first user when users table is loaded
        let usersTable = app.tables.element(boundBy: 1)
        expectation(for: existancePredicate, evaluatedWith: usersTable, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
        
        // Tap the first user and go to its detail
        let firstCell = usersTable.cells.element(boundBy: 0)
        firstCell.tap()
        
        // Check that we are inside user detail
        let userDetailLabel = app.staticTexts["Detail"]
        expectation(for: existancePredicate, evaluatedWith: userDetailLabel, handler: nil)
        waitForExpectations(timeout: 2, handler: nil)
    }

}
