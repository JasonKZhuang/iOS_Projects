//
//  AdventureDB.swift
//  WonderOZ
//
//  Created by Jason-Zhuang on 26/1/18.
//  Copyright © 2018 iOSWorld. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

class AdventureDB
{
    static let dbInstance = AdventureDB(argName: "WonderOZ");
    
    static var myLatitude:Double  = -37.495304
    static var myLongitude:Double = 149.945254
    
    //the name of the application
    let applicationName: String;
    
    //The adventure category Array
    var adventureCategories: [CategoryClass]?;
    
    var cate_string = ["camping", "fishing", "hiking", "surfing", "biking", "diving"]
    
    //The all adventure Array
    var adventureList : [Adventure]?;
    
    //The database directory
    var databasePath = NSString()
    
    init(argName:String)
    {
        self.applicationName = argName;
        createDatabase()
        self.adventureCategories = initAdventureCategories();
    }
    
    // Create the database
    func createDatabase()
    {
        // Get a reference to the file manager
        let filemgr  = FileManager.default
        
        // Get a reference to your documents directory.
        let dirPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)
        
        // Get the path to the documents path
        let docsDir = dirPaths[0]
        
        //set database path
        databasePath = (docsDir as NSString).appendingPathComponent("adventure.db") as NSString
        
        //the reference of database
        var db:FMDatabase?
        
        //if the adventure.db file is not exist
        if !filemgr.fileExists(atPath: databasePath as String)
        {
            // set a reference to the database
            db = FMDatabase(path: databasePath as String)
            
            if db == nil
            {
                print("Error: \(String(describing: db?.lastErrorMessage()))")
                return
            }
            
            // Open the database
            if (db?.open())!
            {
                // Prepare a statement for operating on the database
                var sql_stmt = "CREATE TABLE IF NOT EXISTS ADVENTURES (ID INTEGER PRIMARY KEY AUTOINCREMENT, TITLE TEXT NOT NULL, ADDRESS TEXT, LATITUDE NUMERIC, LONGITUDE NUMERIC, RATE INTEGER, DISTANCE NUMERIC, FAVOURITE INTEGER, DESCRIPTION TEXT,IMAGESPATHS TEXT, CATEGORY INTEGER)"
                
                // Execute the statement
                if !(db?.executeStatements(sql_stmt))!
                {
                    print("Error: \(String(describing: db?.lastErrorMessage()))")
                    return
                }
                //Prepare for create ADVENTURE_COMMENTS table
                sql_stmt = "CREATE TABLE IF NOT EXISTS ADVENTURE_COMMENTS (ID INTEGER PRIMARY KEY AUTOINCREMENT, ADVENTURE_ID INTEGER, COMMENT TEXT, FOREIGN KEY(ADVENTURE_ID) REFERENCES ADVENTURES(ID) )"
                
                // Execute the statement
                if !(db?.executeStatements(sql_stmt))!
                {
                    print("Error: \(String(describing: db?.lastErrorMessage()))")
                    return
                }
                
                // Close the database
                db?.close()
            } else
            {
                print("Error: \(String(describing: db?.lastErrorMessage()))")
                return
            }
        }
        //print(NSHomeDirectory())
    }
    
    //init all Adventure to specific category
    func initAdventureCategories() -> [CategoryClass]
    {
        var returnValue = [CategoryClass]();
        
        let category1: CategoryClass = CategoryClass(categoryName: "camping", adventures: getAdventuresByCategory(category: .camping))
        let category2: CategoryClass = CategoryClass(categoryName: "fishing", adventures: getAdventuresByCategory(category: .fishing))
        let category3: CategoryClass = CategoryClass(categoryName: "hiking" , adventures: getAdventuresByCategory(category: .hiking))
        let category4: CategoryClass = CategoryClass(categoryName: "surfing", adventures: getAdventuresByCategory(category: .surfing))
        let category5: CategoryClass = CategoryClass(categoryName: "biking" , adventures: getAdventuresByCategory(category: .biking))
        let category6: CategoryClass = CategoryClass(categoryName: "diving" , adventures: getAdventuresByCategory(category: .diving))
        
        returnValue.append(category1);
        returnValue.append(category2);
        returnValue.append(category3);
        returnValue.append(category4);
        returnValue.append(category5);
        returnValue.append(category6);
        
        return returnValue;
    }
    
    //get my favourite Categorise
    func getFavouriteCategories() -> [CategoryClass]
    {
        var returnValue = [CategoryClass]();
        
        let category1: CategoryClass = CategoryClass(categoryName: "camping", adventures: getFavouriteAdventures(category: .camping))
        let category2: CategoryClass = CategoryClass(categoryName: "fishing", adventures: getFavouriteAdventures(category: .fishing))
        let category3: CategoryClass = CategoryClass(categoryName: "hiking" , adventures: getFavouriteAdventures(category: .hiking))
        let category4: CategoryClass = CategoryClass(categoryName: "surfing", adventures: getFavouriteAdventures(category: .surfing))
        let category5: CategoryClass = CategoryClass(categoryName: "biking" , adventures: getFavouriteAdventures(category: .biking))
        let category6: CategoryClass = CategoryClass(categoryName: "diving" , adventures: getFavouriteAdventures(category: .diving))
        
        returnValue.append(category1);
        returnValue.append(category2);
        returnValue.append(category3);
        returnValue.append(category4);
        returnValue.append(category5);
        returnValue.append(category6);
        
        return returnValue;
        
    }
    
    //Get a Array of Adventure by category
    func getAdventuresByCategory(category:Category) -> [Adventure]
    {
        var myAdventureList = [Adventure]();
        var myCategory:Int = 0
        switch category
        {
            case .camping:
                myCategory = 1
            case .fishing:
                myCategory = 2
            case .hiking:
                myCategory = 3
            case .surfing:
                myCategory = 4
            case .biking:
                myCategory = 5
            case .diving:
                myCategory = 6
        }
        
        // Get a reference to the database
        let db = FMDatabase(path: databasePath as String)
        if (db.open())
        {
            // Prepare a statement for operating on the database
            let querySQL = " SELECT ID,TITLE,ADDRESS,LATITUDE,LONGITUDE,RATE,DISTANCE,FAVOURITE,DESCRIPTION,IMAGESPATHS,CATEGORY " +
            " FROM ADVENTURES WHERE CATEGORY = ? ORDER BY RATE "
            do
            {
                let results = try db.executeQuery(querySQL, values: [myCategory])
                while results.next()
                {
                    let itemId:Int32    = results.int(forColumn: "ID")
                    let title           = results.string(forColumn: "TITLE")
                    let address         = results.string(forColumn: "ADDRESS")
                    let latitude        = results.double(forColumn: "LATITUDE")
                    let longitude       = results.double(forColumn: "LONGITUDE")
                    let rate:Int32      = results.int(forColumn: "RATE")
                    let distance:Double = results.double(forColumn: "DISTANCE")
                    var fav:Bool        = false
                    if results.int(forColumn: "FAVOURITE") == 1
                    {
                        fav = true
                    }
                    let desc            = results.string(forColumn: "DESCRIPTION")
                    let imageNames      = results.string(forColumn: "IMAGESPATHS")
                    
                    let adventureObject: Adventure = Adventure(itemId: Int(itemId), category: category)
                    adventureObject.title                   = title!
                    adventureObject.address                 = address!
                    adventureObject.mapPosition.latitude    = latitude
                    adventureObject.mapPosition.longitude   = longitude
                    adventureObject.rate                    = Int(rate)
                    adventureObject.distance                = distance
                    adventureObject.favourite               = fav
                    //adventureObject.itemImages              = [FileManageHelper.instance.getImage(argFilename: imageNames!)]
                    adventureObject.imageNames              = [imageNames!]
                    adventureObject.description             = desc!
                    adventureObject.category                = category
                    adventureObject.comments                = getCommentByAdventure(advId:Int(itemId))
                    
                    myAdventureList.append(adventureObject);
                }
            }catch let error as NSError
            {
                print("failed: \(error.localizedDescription)")
            }
            db.close()
        }
        return myAdventureList;
    }
    
    //get my favorite Adventures Array
    func getFavouriteAdventures(category: Category) -> [Adventure]
    {
        var myAdventureList = [Adventure]();
        let tempList = getAdventuresByCategory(category:category)
        for tempObject in tempList
        {
            if tempObject.favourite == true
            {
                myAdventureList.append(tempObject)
            }
        }
        return myAdventureList;
       
    }
    
    //get Array of all Adventure list
    func getAdventuresList() -> [Adventure]
    {
        var myAdventureList = [Adventure]();
        
        let arrCategory = initAdventureCategories()
        
        for temCategory in arrCategory
        {
            myAdventureList = myAdventureList +  temCategory.adventureList
        }
        
        return myAdventureList;
    }
    
    //get one Adventure By id
    func getAdventure(advId:Int) -> Adventure
    {
        let adventureObject = Adventure(itemId:advId,category: Category.camping)
        // Get a reference to the database
        let  db = FMDatabase(path: databasePath as String)
        if (db.open())
        {
            // Prepare a statement for operating on the database
            let querySQL = " SELECT TITLE,ADDRESS,LATITUDE,LONGITUDE,RATE,DISTANCE,FAVOURITE,DESCRIPTION,IMAGESPATHS,CATEGORY " +
                        " FROM ADVENTURES WHERE ID = ? "
            do
            {
                let obj = try db.executeQuery(querySQL, values: [advId])
                if (obj.next())
                {
                    let title           = obj.string(forColumn: "TITLE")
                    let address         = obj.string(forColumn: "ADDRESS")
                    let latitude        = obj.double(forColumn: "LATITUDE")
                    let longitude       = obj.double(forColumn: "LONGITUDE")
                    let rate:Int32      = obj.int(forColumn: "RATE")
                    let distance:Double = obj.double(forColumn: "DISTANCE")
                    //
                    var fav:Bool        = false
                    if obj.int(forColumn: "FAVOURITE") == 1
                    {
                        fav = true
                    }
                    //
                    let imageNames      = obj.string(forColumn: "IMAGESPATHS")
                    let desc            = obj.string(forColumn: "DESCRIPTION")
                    //
                    let record_category:Int32 = obj.int(forColumn: "CATEGORY")
                    var myCategory:Category = Category.camping
                    switch record_category
                    {
                        case 1:
                            myCategory = Category.camping
                        case 2:
                            myCategory = Category.fishing
                        case 3:
                            myCategory = Category.hiking
                        case 4:
                            myCategory = Category.surfing
                        case 5:
                            myCategory = Category.biking
                        case 6:
                            myCategory = Category.diving
                        default:
                            myCategory = Category.camping
                    }
                    
                    //
                    adventureObject.title                   = title!
                    adventureObject.address                 = address!
                    adventureObject.mapPosition.latitude    = latitude
                    adventureObject.mapPosition.longitude   = longitude
                    adventureObject.rate                    = Int(rate)
                    adventureObject.distance                = distance
                    adventureObject.favourite               = fav
                    //adventureObject.itemImages              = [FileManageHelper.instance.getImage(argFilename: imageNames!)]
                    adventureObject.imageNames              = [imageNames!]
                    adventureObject.description             = desc!
                    adventureObject.category                = myCategory
                    adventureObject.comments                = getCommentByAdventure(advId: Int(advId))
                }
            }catch let error as NSError
            {
                print("failed: \(error.localizedDescription)")
            }
            db.close()
        }else
        {
            print("failed: db cannot be opened!")
        }
        
        return adventureObject;
    }
    
    //get comment for an Adventure, parameter is the ID of an Adventure,the return value is an String Array
    func getCommentByAdventure(advId:Int) -> [Comment]
    {
        var commentList = [Comment]()
        // Get a reference to the database
        let db = FMDatabase(path: databasePath as String)
        if (db.open())
        {
            // Prepare a statement for operating on the database
            let querySQL = " SELECT ID, COMMENT FROM ADVENTURE_COMMENTS where ADVENTURE_ID = ? "
            do
            {
                let results = try db.executeQuery(querySQL, values: [advId])
                while results.next()
                {
                    let commentId = results.int(forColumn: "ID")
                    let commentContext = results.string(forColumn: "COMMENT")
                    let obj = Comment(comId:Int(commentId),context:commentContext!,advId:advId)
                    commentList.append(obj)
                }
            }catch let error as NSError
            {
                print("failed: \(error.localizedDescription)")
            }
            db.close()
        }else
        {
            print("failed: db cannot be opened!")
        }
        return commentList
    }
    
    //add a new Adventure
    func addAdventure(adv: Adventure) -> Bool
    {
        var returnValue:Bool = false
        let db = FMDatabase(path: databasePath as String)
        if (db.open())
        {
            // Prepare a statement for operating on the database
            let title       = adv.title
            let address     = adv.address
            let latitude    = adv.mapPosition.latitude
            let longitude   = adv.mapPosition.longitude
            let rate        = adv.rate
            let distance    = adv.distance
            var favorite:Int = 0;
            if adv.favourite
            {
                favorite = 1
            }else
            {
                favorite = 0
            }
            let desc = adv.description
            //
            let imagesPaths:String = adv.imageNames[0]
            //
            var category_flag:Int = 0
            switch adv.category
            {
                case .camping:
                    category_flag = 1
                case .fishing:
                    category_flag = 2
                case .hiking:
                    category_flag = 3
                case .surfing:
                    category_flag = 4
                case .biking:
                    category_flag = 5
                case .diving:
                    category_flag = 6
            }
            
            let insertSQL = "INSERT INTO ADVENTURES  " +
                            "(TITLE, ADDRESS, LATITUDE, LONGITUDE, RATE, DISTANCE, FAVOURITE, DESCRIPTION,IMAGESPATHS, CATEGORY) " +
                            "VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
            
            do
            {
                try db.executeUpdate(insertSQL
                    , values: [title, address, latitude,longitude,rate,distance,favorite,desc,imagesPaths,category_flag]);
                returnValue = true
            }catch let error as NSError
            {
                print("failed: \(error.localizedDescription)")
            }
        } else
        {
            print("Error: \(String(describing: db.lastErrorMessage()))")
        }
        // Close the database
        db.close()
        return returnValue
    }
    
    //delete an Adventure by id
    func delAdventure(advId: Int) -> Bool
    {
        var deleted:Bool = false;
        let db = FMDatabase(path: databasePath as String)
        if (db.open())
        {
            // Prepare a statement for operating on the database
            let query = "DELETE FROM ADVENTURES where ID=?"
            do
            {
                try db.executeUpdate(query, values: [advId])
                deleted = true
            }
            catch
            {
                print(error.localizedDescription)
            }
            db.close()
        }
        return deleted
    }
    
    //update an Adventure
    func updateAdventure(adv:Adventure) -> Bool
    {
        var updated:Bool = false;
        
        let db = FMDatabase(path: databasePath as String)
        
        if (db.open())
        {
            let advId       = adv.itemId
            let title       = adv.title
            let address     = adv.address
            let latitude    = adv.mapPosition.latitude
            let longitude   = adv.mapPosition.longitude
            let rate        = adv.rate
            let distance    = adv.distance
            var favorite_flag:Int = 0;
            //
            if adv.favourite
            {
                favorite_flag = 1
            }else
            {
                favorite_flag = 0
            }
            //
            let desc = adv.description
            //
            let imagesPaths = adv.imageNames[0]
            //
            var category_flag:Int = 0
            switch adv.category
            {
            case .camping:
                category_flag = 1
            case .fishing:
                category_flag = 2
            case .hiking:
                category_flag = 3
            case .surfing:
                category_flag = 4
            case .biking:
                category_flag = 5
            case .diving:
                category_flag = 6
            }
            //
            let query = "update ADVENTURES " +
                        "set TITLE=?, ADDRESS=?,LATITUDE=?,LONGITUDE=?,RATE=?,DISTANCE=?,FAVOURITE=?,DESCRIPTION=?,IMAGESPATHS=?,CATEGORY=? " +
                        "where ID=?"
            do
            {
                try db.executeUpdate(query
                    , values: [title, address, latitude, longitude, rate, distance, favorite_flag, desc,imagesPaths, category_flag, advId])
                updated = true
            }
            catch
            {
                print(error.localizedDescription)
            }
            
            db.close()
        }
        return updated
    }

    //add a comment of the adventure
    func addAdventureComment(advId: Int, comment: String) -> Bool
    {
        var returnValue:Bool = false
        
        let myAdv:Adventure? = getAdventure(advId: advId)
        
        if (myAdv == nil)
        {
            return false
        }
        
        let db = FMDatabase(path: databasePath as String)
        if (db.open())
        {
            // Prepare a statement for operating on the database
            let insertSQL = "INSERT INTO ADVENTURE_COMMENTS (ADVENTURE_ID, COMMENT) VALUES( ?, ? ) "
            do
            {
                try db.executeUpdate(insertSQL, values: [advId, comment]);
                returnValue = true
            }catch let error as NSError
            {
                print("failed: \(error.localizedDescription)")
            }
        } else
        {
            print("Error: \(String(describing: db.lastErrorMessage()))")
        }
        // Close the database
        db.close()
        return returnValue
    }
    
    //delete a comment record by comment id
    func delAdventureComment(commentId: Int) -> Bool
    {
        var deleted:Bool = false;
        let db = FMDatabase(path: databasePath as String)
        if (db.open())
        {
            // Prepare a statement for operating on the database
            let query = "delete from ADVENTURE_COMMENTS where ID=?"
            do
            {
                try db.executeUpdate(query, values: [commentId])
                deleted = true
            }
            catch
            {
                print(error.localizedDescription)
            }
            db.close()
        }
        return deleted
    }
    
    //delete all comments by adventure id
    func delAdventureComments(advId: Int) -> Bool
    {
        var deleted:Bool = false;
        let db = FMDatabase(path: databasePath as String)
        if (db.open())
        {
            // Prepare a statement for operating on the database
            let query = "delete from ADVENTURE_COMMENTS where ADVENTURE_ID=?"
            do
            {
                try db.executeUpdate(query, values: [advId])
                deleted = true
            }
            catch
            {
                print(error.localizedDescription)
            }
            db.close()
        }
        return deleted
    }
    
    //update a comment
    func updateAdventureComment(commentId: Int, comment:String) -> Bool
    {
        var updated:Bool = false;
        let db = FMDatabase(path: databasePath as String)
        if (db.open())
        {
            
            //
            let query = "update ADVENTURE_COMMENTS set COMMENT=? where ID=?"
            do
            {
                try db.executeUpdate(query, values: [comment, commentId])
                updated = true
            }
            catch
            {
                print(error.localizedDescription)
            }
            
            db.close()
        }
        return updated
    }
    
    // update all adventures' distance to the database
    func updateAllDistance(myLatitude:Double,myLongitude:Double) -> Void
    {
        let advList = self.getAdventuresList()
        let currentLocation = CLLocation(latitude: myLatitude, longitude: myLongitude)
        for advObject in advList
        {
            let targetLocation = CLLocation(latitude: advObject.mapPosition.latitude, longitude: advObject.mapPosition.longitude)
            let distance:CLLocationDistance = currentLocation.distance(from: targetLocation)
            //print("The distance between two location is：\(distance)")
            let str = NSString(format:"%.2f",distance/1000)
            advObject.distance = str.doubleValue
            if self.updateAdventure(adv: advObject) == true
            {
                //print("update location successfully!")
            }
        }
        
    }
    
    // calculate the distance between any two locations based on the latitudes and longitudes
    func calculateDistance(myLatitude:Double,myLongitude:Double,targetLatitude:Double,targetLongitude:Double) -> Double
    {
        let currentLocation = CLLocation(latitude: myLatitude, longitude: myLongitude)
        let targetLocation = CLLocation(latitude: targetLatitude, longitude: targetLongitude)
        let distance:CLLocationDistance = currentLocation.distance(from: targetLocation)
        let str = NSString(format:"%.2f",distance/1000)
        return str.doubleValue
    }
    
    // calculate the distance between current user location and the adventure's location based on its latitude and longitude
    func calculateDistance(targetLatitude:Double,targetLongitude:Double) -> Double
    {
        let currentLocation = CLLocation(latitude: AdventureDB.myLatitude, longitude: AdventureDB.myLongitude)
        let targetLocation = CLLocation(latitude: targetLatitude, longitude: targetLongitude)
        let distance:CLLocationDistance = currentLocation.distance(from: targetLocation)
        let str = NSString(format:"%.2f",distance/1000)
        return str.doubleValue
    }
}
