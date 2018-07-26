//
//  ProfileManageHelper.swift
//  WonderOZ
//
//  Created by Jason-Zhuang on 2/2/18.
//  Copyright © 2018 iOSWorld. All rights reserved.
//

import Foundation

struct profileStruct
{
    public var name = "name"
    let phone = "phone"
    let address = "address"
    let email = "email"
    let photofile = "photofile"
    
    init()
    {
        
        
    }
}

class ProfileManageHelper
{
    static let myInstance = ProfileManageHelper()
    let plistFileName:String = "profile"
    let profileImageName:String = "profile.png"
    let constantProfileStruct: profileStruct;
    
    var profileFilePath:String?
    {
        guard let path = Bundle.main.path(forResource: plistFileName, ofType: "plist") else { return .none }
        return path
    }
    
    private init()
    {
        self.constantProfileStruct = profileStruct()
    }
    
    func readProfile() -> (name:String,phone:String,address:String,email:String,photofile:String)
    {
        var returnProfile = (name:constantProfileStruct.name,phone:constantProfileStruct.photofile,address:constantProfileStruct.address
            ,email:constantProfileStruct.email,photofile:constantProfileStruct.photofile)
        
        let fileManager = FileManager.default
        
        if fileManager.fileExists(atPath: profileFilePath!)
        {
            let dict = NSMutableDictionary(contentsOfFile: profileFilePath!)
            for (_, value) in dict!.enumerated()
            {
                //print("Key is: \(key) & Value is: \(value)")
                let tempValue = value;
                
                print("key is \(tempValue.key) && value is \(tempValue.value)")
                
                switch tempValue.key as! String
                {
                    case constantProfileStruct.name:
                        if tempValue.value as! String == ""
                        {
                            returnProfile.name = "User Name"
                        }else
                        {
                            returnProfile.name = tempValue.value as! String
                        }
                    case constantProfileStruct.phone:
                        returnProfile.phone = tempValue.value as! String
                    case constantProfileStruct.address:
                        returnProfile.address = tempValue.value as! String
                    case constantProfileStruct.email:
                        returnProfile.email = tempValue.value as! String
                    case constantProfileStruct.photofile:
                        returnProfile.photofile = self.profileImageName
                    default: break
                    
                }
                
 
            }
            
        }
        
        return returnProfile
    }
    
    
    func updateRecord(argProfile:ProfileData)
    {
        let fileManager = FileManager.default
        
        if fileManager.fileExists(atPath: profileFilePath!)
        {
           
        }else
        {
            if FileManageHelper.instance.createPlistFile() == true
            {
                
            }else
            {
                return
            }
        }
        
        let dict = NSMutableDictionary(contentsOfFile: profileFilePath!)
        
        // Update the value
        dict?[constantProfileStruct.name] = argProfile.Username
        dict?[constantProfileStruct.email] = argProfile.Useremail
        dict?[constantProfileStruct.address] = argProfile.Useraddress
        dict?[constantProfileStruct.phone] = argProfile.Userphone
        dict?[constantProfileStruct.photofile] = argProfile.UserimagePath
        
        // Write the dictionary back to the plist
        dict?.write(toFile: profileFilePath!, atomically: false)
    }
    
    
    
    
}

