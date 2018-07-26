//
//  CategoryControllerDelegate.swift
//  WonderOZ
//
//  Created by Zhangzixi on 2018/2/3.
//  Copyright © 2018年 iOSWorld. All rights reserved.
//

import Foundation
import UIKit

private let reuseIdentifier = "categoryCell"

extension CategoryViewController : UICollectionViewDelegate
{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let myCate:CategoryClass = myCategories![indexPath.item]
        
        let advList = AdventureDB.dbInstance.getAdventuresByCategory(category: myCate.categoryIndex);
        
        if  advList.count == 0
        {
            popOverWindow(msg: "This is no Adventure!")
            return
        }
        
        
        self.performSegue(withIdentifier: "categoryToList", sender: myCate.categoryIndex)
    }
    
}

extension CategoryViewController : UICollectionViewDataSource
{
    
    // MARK: UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.myCategories!.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CategoryViewCell
        let cate = myCategories![indexPath.item]
        cell.categoryImage.image = UIImage(named: cate.categoryName)
        cell.categoryName.text = cate.categoryName
        cell.numberOfItems.text = String(cate.adventureList.count) + " adventures"
        return cell
    }
    
}
