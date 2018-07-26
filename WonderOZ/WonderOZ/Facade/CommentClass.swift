//
//  CommentClass.swift
//  WonderOZ
//
//  Created by Jason-Zhuang on 3/2/18.
//  Copyright © 2018 iOSWorld. All rights reserved.
//

import Foundation

class CommentClass
{
    func delete(adventurID:Int) -> Bool
    {
        let res = AdventureDB.dbInstance.delAdventureComments(advId: adventurID)
        return res
    }
}
