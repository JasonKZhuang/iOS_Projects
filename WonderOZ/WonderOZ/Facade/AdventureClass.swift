//
//  AdventureClass.swift
//  WonderOZ
//
//  Created by Jason-Zhuang on 3/2/18.
//  Copyright © 2018 iOSWorld. All rights reserved.
//

import Foundation

class AdventureClass
{
    func delete(adventurID:Int) -> Bool
    {
       let res = AdventureDB.dbInstance.delAdventure(advId: adventurID)
       return res
    }
}
