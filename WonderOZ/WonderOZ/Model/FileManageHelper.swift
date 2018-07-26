//
//  FileManageHelper.swift
//  WonderOZ
//
//  Created by Jason-Zhuang on 31/1/18.
//  Copyright © 2018 iOSWorld. All rights reserved.
//

import Foundation
import UIKit

class FileManageHelper
{
    
    static var instance = FileManageHelper()
    
    // Get a reference to the file manager
    let filemgr  = FileManager.default
    
    var myCurrentWorkPath: NSString = ""
    var myCurrentDocumentPath: NSString = ""
    var myTempDirectory: NSString = ""
    
    init()
    {
        // Get a reference to your current working directory.
        self.myCurrentWorkPath = filemgr.currentDirectoryPath as NSString
        //print("Current work Directory is \(myCurrentWorkPath)")
        
        // Get a reference to your documents directory.
        let dirPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)
        self.myCurrentDocumentPath = dirPaths[0] as NSString
        //print("myCurrentDocumentPath is \(myCurrentDocumentPath)")
        
        // Get a reference to the temp directory has a special method
        self.myTempDirectory = NSTemporaryDirectory() as NSString
        //print("Temporary Directory is \(myTempDirectory)")
        
    }
    
    func getImage(argFilename: String) -> UIImage
    {
        var returnValue : UIImage?
        if argFilename == ""
        {
            returnValue = UIImage(named: "logo.jpg")
            return returnValue!
        }
        
        let imagePath = self.myCurrentDocumentPath.appendingPathComponent(argFilename)
        
        if filemgr.fileExists(atPath: imagePath)
        {
            returnValue = UIImage(contentsOfFile: imagePath)
        }else
        {
            returnValue = UIImage(named: "logo.jpg")
            print("Panic! No Image!")
        }
        return returnValue!
    }
    
    func saveImage(imageName: String, data:UIImage)
    {
        //create an instance of the FileManager
        let fileManager = FileManager.default
        
        //get the image path
        let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(imageName)
        
        //get the PNG data for this image, gets the PNG data version of the file, which is how its stored.
        let data = UIImagePNGRepresentation(data)
        
        //store it in the document directory fileManager.createFile(atPath: imagePath as String, contents: data, attributes: nil)
        fileManager.createFile(atPath: imagePath as String, contents: data, attributes: nil)
    }
    
    func fileExists(argFilename: String) -> Bool
    {
        let filePath = self.myCurrentDocumentPath.appendingPathComponent(argFilename)
        if filemgr.fileExists(atPath: filePath)
        {
            return true
        } else {
            return false
        }
    }

    func createFile(argFileName: String, argFileData: Data)
    {
        if self.fileExists(argFilename: argFileName) == false
        {
            let filePath = self.myCurrentDocumentPath.appendingPathComponent(argFileName)
            filemgr.createFile(atPath: filePath as String, contents: argFileData, attributes: nil)
        }else
        {
            print("File has existed!")
        }
    }
    
    func deleteFile(argFileName: String) -> Bool
    {
        let filePath = self.myCurrentDocumentPath.appendingPathComponent(argFileName)
        if self.fileExists(argFilename: argFileName) == false
        {
            return false
        }
        
        do
        {
            try self.filemgr.removeItem(atPath: filePath)
            print("Removal successful")
            return true
        } catch let error
        {
            print("Error: \(error.localizedDescription)")
            return false
        }
    }
    
    func createPlistFile() -> Bool
    {
        
        let filePath = self.myCurrentDocumentPath.appendingPathComponent("profile.plist")
        if(!filemgr.fileExists(atPath: filePath))
        {
            let ss:profileStruct = profileStruct()
            let data : [String: String] = [
                ss.name: "WonderOZ",
                ss.phone: "",
                ss.address: "",
                ss.email: "WonderOZ@gmail.com",
                // any other key values
            ]
            
            let someData = NSDictionary(dictionary: data)
            let isWritten = someData.write(toFile: filePath, atomically: true)
            return isWritten
        } else
        {
            print("file exists")
            return false
        }
            
        
    }
    
}
