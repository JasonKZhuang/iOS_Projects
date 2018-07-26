//
//  Adventure.swift
//  WonderOz
//
//  Created by Jason-Zhuang on 19/1/18.
//  Copyright © 2018 Zhangzixi. All rights reserved.
//

import Foundation

import UIKit

//to store the map coordinate of an adventure place
struct Coordinate
{
    var latitude:  Double = 0
    var longitude: Double = 0
}

//types of Adventure
enum Category
{
    case camping
    case fishing
    case hiking
    case surfing
    case biking
    case diving
    
    func getDescription() -> String
    {
        switch self
        {
        case .camping:
            return "camping"
        case .fishing:
            return "fishing"
        case .hiking:
            return "hiking"
        case .surfing:
            return "surfing"
        case .biking:
            return "biking"
        case .diving:
            return "diving"
        
        }
    }
}

//the main model class of Adventure
class Adventure
{
    var itemId: Int;
    var title: String;
    var address: String;
    var mapPosition: Coordinate;
    var category: Category;
    var rate: Int;//maxinum value is 5 stars
    var distance: Double;
    var favourite: Bool;
    var itemImages: [UIImage];
    var imageNames: [String];
    var description: String;
    var comments:[Comment];
    
    init(itemId: Int, category: Category)
    {
        self.itemId = itemId;
        self.category = category;
        self.title = "";
        self.address = "";
        self.mapPosition = Coordinate();
        self.rate = 0;
        self.distance = 0;
        self.favourite =  false;
        self.itemImages = [UIImage]();
        self.imageNames  = [];
        self.description = "";
        self.comments = [Comment]();
    }

}





