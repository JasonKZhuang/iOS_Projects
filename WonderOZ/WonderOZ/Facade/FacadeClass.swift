//
//  FacadeDel.swift
//  WonderOZ
//
//  Created by Jason-Zhuang on 3/2/18.
//  Copyright © 2018 iOSWorld. All rights reserved.
//
// Using Facade Pattern to implement del main table and child table and image fi

import Foundation

class FacadeClass
{
    static let selfInstance = FacadeClass()
    
    private var advClass:AdventureClass?
    private var comntClass:CommentClass?
    private var imgClass:ImageFileClass?

    func delete(adventureID:Int) -> Bool
    {
        if self.comntClass?.delete(adventurID: adventureID) == true
        {
            if imgClass?.delete(adventurID: adventureID) == true
            {
                if advClass?.delete(adventurID: adventureID) == true
                {
                    return true
                }
            }
            
        }
        
        return false
    }
    
    init()
    {
        advClass = AdventureClass()
        comntClass = CommentClass()
        imgClass = ImageFileClass()
    }
}
