//
//  ProfileData.swift
//  WonderOZ
//
//  Created by Zhangzixi on 2018/1/22.
//  Copyright © 2018年 iOSWorld. All rights reserved.
//

import Foundation
import UIKit

class ProfileData
{
    
    var Username  : String;
    var Useremail : String;
    var Useraddress : String;
    var Userphone : String;
    var Userimage : UIImage;
    var UserimagePath : String;
    
    static let profileInstance = ProfileData();
    
    var storedData : ProfileData?;
    
   
    init()
    {
        self.Username       = "WonderOZ";
        self.Useremail      = "WonderOZ@gmail.com"
        self.Useraddress    = "123 Ave St"
        self.Userphone      = "0450252105"
        self.Userimage      = UIImage(named:"logo.jpg")!
        self.UserimagePath  = "profile.png"
    }
    
}
