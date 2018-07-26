//
//  EditProfileViewController.swift
//  WonderOZ
//
//  Created by Jason-Zhuang on 22/1/18.
//  Copyright © 2018 iOSWorld. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController
{
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtUserAddress: UITextField!
    @IBOutlet weak var txtUserPhone: UITextField!
    @IBOutlet weak var txtUserEmail: UITextField!
    
    @IBOutlet weak var labName: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let myProfile = ProfileManageHelper.myInstance.readProfile()
        self.txtUserName.text       = myProfile.name
        self.txtUserEmail.text      = myProfile.email
        self.txtUserAddress.text    = myProfile.address
        self.txtUserPhone.text      = myProfile.phone
        self.profileImage.image     = FileManageHelper.instance.getImage(argFilename: myProfile.photofile)

    }
    
    
    @IBAction func btnSave(_ sender: UIButton)
    {
        let userName    = self.txtUserName.text;
        let userEmail   = self.txtUserEmail.text;
        let userAddress = self.txtUserAddress.text;
        let userPhone   = self.txtUserPhone.text;
        
        if userName != ""
        {
            ProfileData.profileInstance.Username = userName!;
        }else
        {
            popOverWindow(msg: "The user name can not be null!");
            self.labName.text = "Name:(*)"
            self.labName.textColor = UIColor.red;
            return;
        }
        
        if userEmail != ""
        {
            ProfileData.profileInstance.Useremail = userEmail!;
        }
        if userAddress != ""
        {
            ProfileData.profileInstance.Useraddress = userAddress!;
        }
        if userPhone != ""
        {
            ProfileData.profileInstance.Userphone = userPhone!;
        }
        
        ProfileManageHelper.myInstance.updateRecord(argProfile: ProfileData.profileInstance)
        
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        self.view.endEditing(true)
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
