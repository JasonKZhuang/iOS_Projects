//
//  CategoryClass.swift
//  WonderOZ
//
//  Created by Jason-Zhuang on 21/1/18.
//  Copyright © 2018 iOSWorld. All rights reserved.
//

import Foundation

class CategoryClass
{
    var categoryName: String
    
    var categoryIndex: Category
    
    var adventureList: [Adventure]
    
    init(categoryName: String, adventures:[Adventure])
    {
        self.categoryName = categoryName;
        self.adventureList = adventures;
        
        switch categoryName
        {
            case "camping":
                self.categoryIndex = Category.camping
            case "fishing":
                self.categoryIndex = Category.fishing
            case "hiking":
                self.categoryIndex = Category.hiking
            case "surfing":
                self.categoryIndex = Category.surfing
            case "biking":
                self.categoryIndex = Category.biking
            case "diving":
                self.categoryIndex = Category.diving
            default:
                self.categoryIndex = Category.camping
        }
        
    }
    
}
