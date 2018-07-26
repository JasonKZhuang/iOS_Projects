//
//  ProfileViewController.swift
//  WonderOZ
//
//  Created by Jason-Zhuang on 22/1/18.
//  Copyright © 2018 iOSWorld. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController
{
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblEmail: UILabel!
    
    @IBOutlet weak var lblAddress: UILabel!
    
    @IBOutlet weak var lblPhone: UILabel!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        let myProfile = ProfileManageHelper.myInstance.readProfile()
        self.lblName.text  = myProfile.name
        self.lblEmail.text = myProfile.email
        self.lblAddress.text = myProfile.address
        self.lblPhone.text = myProfile.phone
        self.profileImage.image = FileManageHelper.instance.getImage(argFilename: ProfileManageHelper.myInstance.profileImageName)
    }
    
    
    @IBAction func openCamara(_ sender: UIButton)
    {
        CameraHandler.shared.showActionSheet(vc: self)
        CameraHandler.shared.imagePickedBlock = { (image) in
            self.profileImage.image = image
            FileManageHelper.instance.saveImage(imageName: ProfileManageHelper.myInstance.profileImageName, data:image)
        }
    }
    
    func popOverWindow(msg:String)
    {
        let popOverVC = UIStoryboard(name:"Main", bundle:nil);
        let pp = popOverVC.instantiateViewController(withIdentifier: "sbPopUpId") as! PopupViewController;
        pp.mess = msg;
        pp.view.frame = self.view.frame;
        self.addChildViewController(pp);
        self.view.addSubview(pp.view);
        pp.didMove(toParentViewController: self);
    }
}




