//
//  PopupViewController.swift
//  WonderOZ
//
//  Created by Jason-Zhuang on 22/1/18.
//  Copyright © 2018 iOSWorld. All rights reserved.
//

import UIKit

class PopupViewController: UIViewController
{

    var mess:String = "Message";
    
    @IBOutlet weak var popUpMessage: UILabel!
    
    override func viewDidLoad()
    {
        popUpMessage.text = mess;
    }

    @IBAction func btnClose(_ sender: UIButton)
    {
        self.view.removeFromSuperview();
    }
    
    
}
