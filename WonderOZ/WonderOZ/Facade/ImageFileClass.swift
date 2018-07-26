//
//  ImageFileClass.swift
//  WonderOZ
//
//  Created by Jason-Zhuang on 3/2/18.
//  Copyright © 2018 iOSWorld. All rights reserved.
//

import Foundation

class ImageFileClass
{
    func delete(adventurID:Int) -> Bool
    {
        let myAdventure:Adventure = AdventureDB.dbInstance.getAdventure(advId: adventurID)
        if myAdventure.imageNames.count > 0
        {
            let imageName = myAdventure.imageNames[0]
            if FileManageHelper.instance.deleteFile(argFileName: imageName) == true
            {
                return true
            }
        }
        return false
    }
}
