//
//  CourseTestCase.swift
//  WatsMyGradeUITests
//
//  Created by Manthan Shah on 2018-04-27.
//  Copyright © 2018 Manthan Shah. All rights reserved.
//

import XCTest

class CourseTestCase: XCTestCase {
    
    var app = XCUIApplication()
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCreateValidCourse() {
        app.navigationBars.buttons["newCoursePlusButton"].tap()
        
        app.textFields["Code"].tap()
        app.textFields["Code"].typeText("TEST 123")
        app.textFields["Name"].tap()
        app.textFields["Name"].typeText("Theory of Memes")
        app.textFields["Credits"].tap()
        app.textFields["Credits"].typeText("0")
        
        app.buttons["Submit"].tap()
    }
    
    func testCreateEmptyCourse() {
        app.navigationBars.buttons["newCoursePlusButton"].tap()
        
        app.buttons["Submit"].tap()
        
        _ = app.alerts.firstMatch.waitForExistence(timeout: TimeInterval(10))
        XCTAssertEqual(app.alerts.firstMatch.label, "Error")
        app.alerts.firstMatch.buttons["OK"].tap()
    }
    
}
