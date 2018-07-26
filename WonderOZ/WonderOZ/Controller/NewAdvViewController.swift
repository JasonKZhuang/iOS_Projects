//
//  NewAdvViewController.swift
//  WonderOZ
//
//  Created by Zhangzixi on 2018/1/23.
//  Copyright © 2018年 iOSWorld. All rights reserved.
//

import UIKit

class NewAdvViewController: UIViewController
{
    var advName:String?
    var advLocation:String?
    var advPositon:Coordinate  = Coordinate()
    var advCategory:String?
    var Picker_index:Int = 0
    var advDesc:String?
    var advImageName:String?
    var advDistance:Double = 0
    
    
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var locationText: UITextField!
    @IBOutlet weak var cateText: UITextField!
    @IBOutlet weak var descriptText: UITextView!
    @IBOutlet weak var catePickerView: UIPickerView!
    @IBOutlet weak var adventureImageView: UIImageView!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        cateText.allowsEditingTextAttributes = false
    }
    
    @IBAction func titleEdited(_ sender: UITextField)
    {
        self.advName = sender.text
    }
    
    @IBAction func locationEdited(_ sender: UITextField)
    {
        self.advLocation  = sender.text
        if self.advLocation == ""
        {
            return
        }
        //Rule: All UI Code must happen on the main thread
        let myLocationService: LocationService = LocationService(apiKey: AppDelegate.myGoogleMapKey)
        //This method is off the main thread
        myLocationService.getLocationByAddress(arg_Address: self.advLocation! )
        {
            (in_coordinate) in
            //Todo: get back to the main thread
            DispatchQueue.main.async
            {
               self.advPositon.latitude    = (in_coordinate?.latitude)!
               self.advPositon.longitude   = (in_coordinate?.longitude)!
                //print(in_coordinate)
                self.advDistance = AdventureDB.dbInstance.calculateDistance(targetLatitude: self.advPositon.latitude, targetLongitude: self.advPositon.longitude)
            }
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        if textField == self.cateText
        {
            self.catePickerView.isHidden = false
            textField.endEditing(true)
        }
    }
    
    
    @IBAction func saveFunc(_ sender: Any)
    {
        if self.advName == "" || self.advName == nil
        {
            popOverWindow(msg: "Please input the Adventure Name!")
            self.titleText.backgroundColor = UIColor.yellow
            return;
        }
        
        if self.advLocation == "" || self.advLocation == nil
        {
            popOverWindow(msg: "Please input the Adventure Address,Like Discovery Parks Melbourne")
            self.locationText.backgroundColor = UIColor.yellow
            return;
        }
        
        if self.cateText.text == ""
        {
            popOverWindow(msg: "Please select a category!")
            self.cateText.backgroundColor = UIColor.yellow
            return;
        }else
        {
            advCategory = self.cateText.text
        }
        
        
        if adventureImageView.image != nil
        {
            self.advImageName = "img_\(NSUUID().uuidString).png"
        }else
        {
            popOverWindow(msg: "Please take a photo or select one from Library!")
            return
        }
        
        let new_adventure: Adventure = Adventure(itemId: 0, category: Category.camping)
        new_adventure.title         = self.advName!
        new_adventure.address       = self.advLocation!
        new_adventure.mapPosition.latitude  = self.advPositon.latitude
        new_adventure.mapPosition.longitude = self.advPositon.longitude
        new_adventure.category      = getCategory(cateName: self.advCategory!)
        new_adventure.rate          = 0
        new_adventure.distance      = self.advDistance
        new_adventure.favourite     = false
        //new_adventure.itemImages    = [adventureImageView.image!]
        new_adventure.imageNames    = [advImageName!]
        new_adventure.description   = self.descriptText.text!
        new_adventure.comments      = [Comment]()

        if AdventureDB.dbInstance.addAdventure(adv: new_adventure) == false
        {
            popOverWindow(msg: "Adding a new Adventure failed!")
            return
        }
        
        FileManageHelper.instance.saveImage(imageName: self.advImageName!, data: self.adventureImageView.image!)
        //self.saveImage(imageName: self.advImageName!)
        
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    
    func getCategory(cateName: String) -> Category
    {
        //var cate_string = ["camping", "fishing", "hiking", "surfing", "biking", "diving"]
        switch cateName {
        case "camping":
            return Category.camping
        case "fishing":
            return Category.fishing
        case "hiking":
            return Category.hiking
        case "surfing":
            return Category.surfing
        case "biking":
            return Category.biking
        case "diving":
            return Category.diving
        default:
            return Category.camping
        }
    
    }
    
    @IBAction func camaraClicked(_ sender: UIButton)
    {
        CameraHandler.shared.showActionSheet(vc: self)
        CameraHandler.shared.imagePickedBlock = { (image) in
            self.adventureImageView.image = image
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
    
    @IBAction func handleTap(sender: UITapGestureRecognizer? = nil)
    {
        // handling code
        self.titleText.resignFirstResponder();
        self.locationText.resignFirstResponder();
        self.catePickerView.resignFirstResponder();
        self.descriptText.resignFirstResponder();
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        self.view.endEditing(true)
    }

}
