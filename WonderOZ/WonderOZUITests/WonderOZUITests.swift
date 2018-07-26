//
//  WonderOZUITests.swift
//  WonderOZUITests
//
//  Created by Jason-Zhuang on 19/1/18.
//  Copyright © 2018 iOSWorld. All rights reserved.
//

import XCTest

class WonderOZUITests: XCTestCase {
        
    override func setUp()
    {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown()
    {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    /*
     *  Check Add new Adventure function
     *  Implementation : Add new adventure in favourite page
     *                   Add new Title, location & description
     *                   Add new photo either by camera or album(Function not support in UI Test)
     *
     *  Test was designed to be passed Text assertion added to check text Input integrity
     */
    func test1_Add_New_adventure()
    {
        
        let app = XCUIApplication()
        let tabBarsQuery = app.tabBars
        tabBarsQuery.buttons["Favorite"].tap()
       
        app.navigationBars["My Favorites"].buttons["Add"].tap()
        
        let elementsQuery = app.scrollViews.otherElements
        
        let inputTheAdventureNameTextField = elementsQuery.textFields["Input the Adventure name"]
        inputTheAdventureNameTextField.tap()
        inputTheAdventureNameTextField.typeText("Discovery Park - Melbourne")
        
        let inputLocationTextField = elementsQuery.textFields["Input location"]
        inputLocationTextField.tap()
        inputLocationTextField.typeText("Discovery Park - Melbourne")
        
        let selectCategoryTextField = elementsQuery.textFields["Select Category"]
        selectCategoryTextField.tap()
        app.pickerWheels.element.adjust(toPickerWheelValue: "fishing")
        
        let textView = elementsQuery.children(matching: .textView).element
        textView.tap()
        textView.typeText("Good Place!")
        
        app/*@START_MENU_TOKEN@*/.scrollViews.containing(.image, identifier:"logo").element/*[[".scrollViews.containing(.button, identifier:\"camara\").element",".scrollViews.containing(.image, identifier:\"logo\").element"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.buttons["camara"]/*[[".scrollViews.buttons[\"camara\"]",".buttons[\"camara\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.sheets.buttons["Cancel"].tap()
        app.navigationBars["WonderOZ.NewAdvView"].buttons["Save"].tap()
        tabBarsQuery.buttons["Category"].tap()
        sleep(1)
        app.collectionViews.cells.otherElements.containing(.image, identifier:"fishing").element.tap()
        sleep(1)
        app.tables.cells.element(boundBy: 0).tap()
        sleep(1)
    }
    
    /*
     *  Check Update Adventure function
     *  Implementation : Update added Adventure
     *                   Add new comments
     *                   Rate for the adventure
     *
     *  Test was designed to be passed Text assertion added to check text Input integrity
     */
    func test2_UpateAdventure()
    {
        
        
        let app = XCUIApplication()
        app.collectionViews.cells.otherElements.containing(.image, identifier:"fishing").element.tap()
        
        app.tables.cells.element(boundBy: 0).tap()
        
        let addingYourCommentsTextField = app.textFields["Adding your comments"]
        addingYourCommentsTextField.tap()
        addingYourCommentsTextField.typeText("I love this place!")
        
        let sendButton = app.buttons["send"]
        sendButton.tap()
        addingYourCommentsTextField.typeText("Good Adventure")
        sendButton.tap()
        app.scrollViews.children(matching: .textView).element.tap()
        
        let discoveryParkMelbourneScrollView = app/*@START_MENU_TOKEN@*/.scrollViews.containing(.staticText, identifier:"Discovery Park - Melbourne").element/*[[".scrollViews.containing(.image, identifier:\"\/Users\/Zhangzixi\/Library\/Developer\/CoreSimulator\/Devices\/EC743373-E1F8-4FCA-A153-910D195D6FFB\/data\/Containers\/Data\/Application\/E1A9E231-6151-4F42-8537-5B67433C58C2\/Documents\/img_6290148F-8CBE-4E6A-85E9-AB1631D0F940.png\").element",".scrollViews.containing(.staticText, identifier:\"Discovery Park - Melbourne\").element"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        discoveryParkMelbourneScrollView.swipeUp()
        discoveryParkMelbourneScrollView.swipeDown()
        
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 0).children(matching: .button).matching(identifier: "star small blank").element(boundBy: 4).tap()
        
        app.navigationBars["WonderOZ.AdvDetailView"].buttons["fishing"].tap()
        app.navigationBars["fishing"].buttons["Category"].tap()
        
        
    }
    
    /*
     *  Check Split View function in Adventure Page
     *  Implementation : Lanscape and Portrait Layout
     *                   Split View function
     *                   Adventure implement in Split View Mode
     *                   Note: Split View only appear for the screen size in iPhone Plus series
     *                         4.8 inch iPhone Screen will not show Split View
     *  Test was designed to be passed Text assertion added to check text Input integrity
     */
    func test3_AdventureSplitLayout()
    {
        
        let app = XCUIApplication()
        let tabBarsQuery = app.tabBars
        tabBarsQuery.buttons["Category"].tap()
        tabBarsQuery.buttons["Adventure"].tap()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .table).element.swipeDown()
        
        let tablesQuery = app.tables
        tablesQuery.cells.element(boundBy: 0).tap()
        
        XCUIDevice.shared.orientation = .landscapeRight
        
        XCUIDevice.shared.orientation = .portrait
        app.navigationBars["WonderOZ.AdvDetailView"].buttons["All Adventures"].tap()
        
    }
    
    /*
     *  Check Delete Adventure function
     *  Implementation : Delete added Adventure
     *
     *  Test was designed to be passed Text assertion added to check text Input integrity
     */
    func test4_delete_adventure()
    {
        let app = XCUIApplication()
        let collectionViewsQuery = app.collectionViews
        let cellsQuery = collectionViewsQuery.cells
        cellsQuery.otherElements.containing(.image, identifier:"camping").element.tap()
        
        let closeButton = collectionViewsQuery.buttons["Close"]
        closeButton.tap()
        
        let fishingElement = cellsQuery.otherElements.containing(.image, identifier:"fishing").element
        fishingElement.tap()
        
        app.tables.cells.element(boundBy: 0).tap()
        
        app.buttons["Del Adventure"].tap()
        app.alerts["Delete the Adventure"].buttons["Delete"].tap()
        
        fishingElement.tap()
        closeButton.tap()
    }
 
    /*
     *  Check Delete Adventure function
     *  Implementation : Update Profile information
     *                   Display Adaptive Layout in Profile and Edit Page
     *
     *  Test was designed to be passed Text assertion added to check text Input integrity
     */
    func test5_ProfileAutoLayerOut()
    {
        let app = XCUIApplication()
        let tabBarsQuery = app.tabBars
        
        let categoryButton = tabBarsQuery.buttons["Category"]
        categoryButton.tap()
        tabBarsQuery.buttons["Profile"].tap()
        sleep(2)
        
        let composeButton = app.navigationBars["Profile"].buttons["Compose"]
        composeButton.tap()
        
        let nameTextField = app.textFields["Name"]
        nameTextField.tap()
        app/*@START_MENU_TOKEN@*/.buttons["Clear text"]/*[[".textFields[\"Name\"].buttons[\"Clear text\"]",".buttons[\"Clear text\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        nameTextField.typeText("Jason Zhuang")
        
        let phoneTextField = app.textFields["Phone"]
        phoneTextField.tap()
        app/*@START_MENU_TOKEN@*/.buttons["Clear text"]/*[[".textFields[\"Name\"].buttons[\"Clear text\"]",".buttons[\"Clear text\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        phoneTextField.typeText("0450253110")
        
        let addressTextField = app.textFields["Address"]
        addressTextField.tap()
        app/*@START_MENU_TOKEN@*/.buttons["Clear text"]/*[[".textFields[\"Name\"].buttons[\"Clear text\"]",".buttons[\"Clear text\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        addressTextField.typeText("150 Collins street")
        
        let emailTextField = app.textFields["Email"]
        emailTextField.tap()
        app/*@START_MENU_TOKEN@*/.buttons["Clear text"]/*[[".textFields[\"Name\"].buttons[\"Clear text\"]",".buttons[\"Clear text\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        emailTextField.typeText("s3535252@student.rmit.edu.au")
        app.buttons["Save"].tap()
        
        sleep(1)
        
        app/*@START_MENU_TOKEN@*/.buttons["camara"]/*[[".scrollViews.buttons[\"camara\"]",".buttons[\"camara\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.sheets.buttons["Cancel"].tap()
        
        XCUIDevice.shared.orientation = .landscapeRight
        sleep(2)
        XCUIDevice.shared.orientation = .portrait
        sleep(2)
        composeButton.tap()
        XCUIDevice.shared.orientation = .landscapeRight
        sleep(2)
        XCUIDevice.shared.orientation = .portrait
        sleep(2)
        app.navigationBars["WonderOZ.EditProfileView"].buttons["Profile"].tap()
        sleep(2)
        categoryButton.tap()
        
    }
 
}
