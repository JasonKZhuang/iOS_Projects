//
//  WonderOZUnitTests.swift
//  WonderOZUnitTests
//
//  Created by Jason-Zhuang on 3/2/18.
//  Copyright © 2018 iOSWorld. All rights reserved.
//

import XCTest
@testable import WonderOZ
class WonderOZUnitTests: XCTestCase
{
    var adventureCategories: [CategoryClass]?
    var advDataBase : AdventureDB!
    
    override func setUp()
    {
        super.setUp()
        initAdvDatabase()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown()
    {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        removeDatabase()
    }
    
    func test_1_AdventureData()
    {
        
        ///get one Adventure By id
        let adv_test_data = AdventureDB.dbInstance.getAdventuresList()
        //print("Title::: \(adv_test_data.itemId)")
        XCTAssert(adv_test_data.count > 0)
        var i : Int = 0
        for temp in adv_test_data
        {
            XCTAssertEqual(temp.title, "Test\(i + 1)")
            XCTAssertEqual(temp.description, "Unit Test No. \(i + 1)")
            XCTAssertEqual(temp.imageNames, ["logo"])
            i = i + 1;
        }
        print("Test 1 : adv Data Test PASS!")
        
    }
    
    func test_2_AdvComment()
    {
        
        let adv_comm_test = AdventureDB.dbInstance.getAdventuresList()
        
        XCTAssert(adv_comm_test.count == 6)
        
        //Store comments in each adventure
        for i in 0...5
        {
            
            AdventureDB.dbInstance.addAdventureComment(advId: adv_comm_test[i].itemId, comment: "Test Comment \(i+1)")
        }
        
        for i in 0...5
        {
            let comm = AdventureDB.dbInstance.getCommentByAdventure(advId: adv_comm_test[i].itemId)
            XCTAssert(AdventureDB.dbInstance.getCommentByAdventure(advId: adv_comm_test[i].itemId).count == 1)
            XCTAssertEqual(comm[0].commentContext, "Test Comment \(i+1)")
            
        }
        
        
        let comment = AdventureDB.dbInstance.getCommentByAdventure(advId: adv_comm_test[0].itemId)
        
        var i : Int = 0
        
        for tmp_comment in comment{
            
            XCTAssertEqual(tmp_comment.commentContext, "Test Comment \(i+1)")
            i = i + 1;
        }
        
        //Delete Comment Operation
        for delete in comment{
            AdventureDB.dbInstance.delAdventureComment(commentId: delete.commentId)
        }
        XCTAssert(AdventureDB.dbInstance.getCommentByAdventure(advId: adv_comm_test[0].itemId).count == 0)
        
        print("Comment Test PASS!")
    }
    
    func test_3_updateAdventure()
    {
        let adv_comm_test = AdventureDB.dbInstance.getAdventuresList()
        if adv_comm_test.count > 0
        {
            let testAdventure:Adventure = adv_comm_test[0]
            let myAdventureID = testAdventure.itemId
            testAdventure.rate = 5
            if AdventureDB.dbInstance.updateAdventure(adv: testAdventure) == true
            {
                XCTAssert(AdventureDB.dbInstance.getAdventure(advId: myAdventureID).rate == 5)
            }
        }
        print("Update Test PASS!")
    }
    
    func test_4_deleteAdventureComments()
    {
        let adv_comm_test = AdventureDB.dbInstance.getAdventuresList()
        if adv_comm_test.count > 0
        {
            let testAdventure:Adventure = adv_comm_test[0]
            let myAdventureID = testAdventure.itemId
            if AdventureDB.dbInstance.getCommentByAdventure(advId: myAdventureID).count > 0
            {
                if AdventureDB.dbInstance.delAdventureComments(advId: myAdventureID) == true
                {
                    XCTAssert(AdventureDB.dbInstance.getCommentByAdventure(advId: myAdventureID).count == 0)
                }
            }
            
        }
        print("Delete Comments Test PASS!")
    }
    
    func initAdvDatabase()
    {
        //Initialise database
        for tmp in AdventureDB.dbInstance.getAdventuresList()
        {
            AdventureDB.dbInstance.delAdventure(advId: tmp.itemId)
        }
        if AdventureDB.dbInstance.getAdventuresList().count == 0{
            print("\n Initialise Database Complete! \n")
        }else{
            print("\n Initialise Database Incomplete! \n")
        }
        
        
        AdventureDB.dbInstance.createDatabase()
        
        for i in 0...5
        {
            let temp = Adventure(itemId: i , category: Category.camping)
            temp.title = "Test\(i + 1)"
            temp.description = "Unit Test No. \(i + 1)"
            temp.imageNames = ["logo"]
            switch i
            {
            case 0:
                temp.category = Category.camping
            case 1:
                temp.category = Category.fishing
            case 2:
                temp.category = Category.hiking
            case 3:
                temp.category = Category.surfing
            case 4:
                temp.category = Category.biking
            case 5:
                temp.category = Category.diving
            default:
                temp.category = Category.camping
            }
            
            if (AdventureDB.dbInstance.addAdventure(adv: temp) == false){
                print("List : \(i + 1) Insert Error!!!")
            }
            
        }
        
        print("Initial database length : \(AdventureDB.dbInstance.getAdventuresList().count)")
        
    }
    
    func removeDatabase()
    {
        
        for tmp in AdventureDB.dbInstance.getAdventuresList()
        {
            AdventureDB.dbInstance.delAdventure(advId: tmp.itemId)
        }
        
        if AdventureDB.dbInstance.getAdventuresList().count == 0{
            print("\n Delete Database Complete! \n")
        }else{
            print("\n Delete Database Incomplete! \n")
        }
        
    }
    
}
