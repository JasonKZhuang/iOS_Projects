//
//  AdvTableViewCell.swift
//  WonderOZ
//
//  Created by Jason-Zhuang on 20/1/18.
//  Copyright © 2018 iOSWorld. All rights reserved.
//

import UIKit

class AdvTableViewCell: UITableViewCell
{

    @IBOutlet weak var cellView: UIView!
    
    @IBOutlet weak var adventureImage: UIImageView!
    
    @IBOutlet weak var adventureTitle: UILabel!
    
    @IBOutlet weak var btnFavorite: UIButton!
    
    @IBOutlet weak var star1: UIImageView!
    
    @IBOutlet weak var star2: UIImageView!
    
    @IBOutlet weak var star3: UIImageView!
    
    @IBOutlet weak var star4: UIImageView!
    
    @IBOutlet weak var star5: UIImageView!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }

    
}
