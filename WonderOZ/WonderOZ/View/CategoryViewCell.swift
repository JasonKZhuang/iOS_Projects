//
//  CategoryViewCell.swift
//  WonderOZ
//
//  Created by Jason-Zhuang on 22/1/18.
//  Copyright © 2018 iOSWorld. All rights reserved.
//

import UIKit

class CategoryViewCell: UICollectionViewCell
{
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var effectView: UIVisualEffectView!
    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var numberOfItems: UILabel!
    
    var myCategory: CategoryClass?
    {
        didSet
        {
            updateUI()
        }
    }
    
    func updateUI()
    {
        categoryImage.image = UIImage(named: myCategory!.categoryName);
    }
}
