//
//  AdvDetailViewController.swift
//  WonderOZ
//
//  Created by Jason-Zhuang on 20/1/18.
//  Copyright © 2018 iOSWorld. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class AdvDetailViewController: UIViewController
{
    ////
    var adventure: Adventure?
    var defaultLocation = CLLocation(latitude: -37.495304, longitude: 149.945254)
    var zoomLevel: Float = 10.0
    ///
    @IBOutlet weak var adventureImageView: UIImageView!
    @IBOutlet weak var describtionText: UITextView!
    
    @IBOutlet weak var mapView: GMSMapView!
    
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var adventureTitle: UILabel!
    
    @IBOutlet weak var btnStar1: UIButton!
    @IBOutlet weak var btnStar2: UIButton!
    @IBOutlet weak var btnStar3: UIButton!
    @IBOutlet weak var btnStar4: UIButton!
    @IBOutlet weak var btnStar5: UIButton!
    
    @IBOutlet weak var btnDelte: UIButton!
    
    @IBOutlet weak var bottom_Constraint: NSLayoutConstraint!
    
    ///
    override func viewDidLoad()
    {
        super.viewDidLoad();
        
        self.adventure = AdventureDB.dbInstance.getAdventure(advId: (self.adventure?.itemId)!)
        
        self.adventureTitle.text = self.adventure?.title;
        
        //adventureImageView.image = adventure?.itemImages[0]
        self.adventureImageView.image = FileManageHelper.instance.getImage(argFilename: self.adventure!.imageNames[0])
        
        self.describtionText.text = adventure?.description
        
        //process google map
        var latit:Double = adventure!.mapPosition.latitude
        var longi:Double = adventure!.mapPosition.longitude
        if (latit == 0)
        {
            latit = defaultLocation.coordinate.latitude
        }
        if (longi == 0)
        {
            longi = defaultLocation.coordinate.longitude
        }
        self.defaultLocation = CLLocation(latitude: latit, longitude: longi)
        let myCamera = GMSCameraPosition.camera(withLatitude: latit,
                                                longitude: longi,
                                                zoom: zoomLevel)
        self.mapView.camera = myCamera
        
        showMarker(arg_position: myCamera.target,arg_title: "Melbourne", arg_snippet: "Australia")
        
        
        //
        self.btnStar1.setImage(UIImage(named: "star-small-blank"), for: UIControlState.normal);
        self.btnStar2.setImage(UIImage(named: "star-small-blank"), for: UIControlState.normal);
        self.btnStar3.setImage(UIImage(named: "star-small-blank"), for: UIControlState.normal);
        self.btnStar4.setImage(UIImage(named: "star-small-blank"), for: UIControlState.normal);
        self.btnStar5.setImage(UIImage(named: "star-small-blank"), for: UIControlState.normal);
        //
        tableView.reloadData();
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow(notification: ) ), name: .UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide(notification: ) ), name: .UIKeyboardWillHide, object: nil)
    
    }
    
    @objc func keyBoardWillShow(notification: NSNotification)
    {
        self.bottom_Constraint.constant = 230
    }
    
    @objc func keyBoardWillHide(notification: NSNotification)
    {
        self.bottom_Constraint.constant = 0
    }
    
    //
    @IBAction func btnSend(_ sender: UIButton)
    {
        let advId = self.adventure?.itemId
        let context = inputTextField.text!
        if context==""
        {
            popOverWindow(msg:"Comment cannot be empty!")
            return
        }
        
        if AdventureDB.dbInstance.addAdventureComment(advId: advId!, comment: context) == true
        {
            self.adventure = AdventureDB.dbInstance.getAdventure(advId: advId!)
        }
        inputTextField.text=""
        tableView.reloadData();
        
    }
    
    @IBAction func btnDelete(_ sender: UIButton)
    {
        if AdventureDB.dbInstance.delAdventureComment(commentId: sender.tag) == true
        {
            self.adventure = AdventureDB.dbInstance.getAdventure(advId: (self.adventure?.itemId)!)
        }
        self.tableView.reloadData();
    }
    
    @IBAction func btnStar1Clicked(_ sender: UIButton)
    {
        btnStar1.setImage(UIImage(named: "star-small-fill"), for: UIControlState.normal);
        btnStar2.setImage(UIImage(named: "star-small-blank"), for: UIControlState.normal);
        btnStar3.setImage(UIImage(named: "star-small-blank"), for: UIControlState.normal);
        btnStar4.setImage(UIImage(named: "star-small-blank"), for: UIControlState.normal);
        btnStar5.setImage(UIImage(named: "star-small-blank"), for: UIControlState.normal);
        
        let advId = self.adventure?.itemId
        self.adventure?.rate = 1
        if AdventureDB.dbInstance.updateAdventure(adv: self.adventure!) == true
        {
            self.adventure = AdventureDB.dbInstance.getAdventure(advId: advId!)
        }
    }
    
    @IBAction func btnStar2Clicked(_ sender: UIButton)
    {
        btnStar1.setImage(UIImage(named: "star-small-fill"), for: UIControlState.normal);
        btnStar2.setImage(UIImage(named: "star-small-fill"), for: UIControlState.normal);
        btnStar3.setImage(UIImage(named: "star-small-blank"), for: UIControlState.normal);
        btnStar4.setImage(UIImage(named: "star-small-blank"), for: UIControlState.normal);
        btnStar5.setImage(UIImage(named: "star-small-blank"), for: UIControlState.normal);
        let advId = self.adventure?.itemId
        self.adventure?.rate = 2
        if AdventureDB.dbInstance.updateAdventure(adv: self.adventure!) == true
        {
            self.adventure = AdventureDB.dbInstance.getAdventure(advId: advId!)
        }
    }
    
    @IBAction func btnStar3Clicked(_ sender: UIButton)
    {
        btnStar1.setImage(UIImage(named: "star-small-fill"), for: UIControlState.normal);
        btnStar2.setImage(UIImage(named: "star-small-fill"), for: UIControlState.normal);
        btnStar3.setImage(UIImage(named: "star-small-fill"), for: UIControlState.normal);
        btnStar4.setImage(UIImage(named: "star-small-blank"), for: UIControlState.normal);
        btnStar5.setImage(UIImage(named: "star-small-blank"), for: UIControlState.normal);
        let advId = self.adventure?.itemId
        self.adventure?.rate = 3
        if AdventureDB.dbInstance.updateAdventure(adv: self.adventure!) == true
        {
            self.adventure = AdventureDB.dbInstance.getAdventure(advId: advId!)
        }
    }
    @IBAction func btnStar4Clicked(_ sender: UIButton)
    {
        btnStar1.setImage(UIImage(named: "star-small-fill"), for: UIControlState.normal);
        btnStar2.setImage(UIImage(named: "star-small-fill"), for: UIControlState.normal);
        btnStar3.setImage(UIImage(named: "star-small-fill"), for: UIControlState.normal);
        btnStar4.setImage(UIImage(named: "star-small-fill"), for: UIControlState.normal);
        btnStar5.setImage(UIImage(named: "star-small-blank"), for: UIControlState.normal);
        let advId = self.adventure?.itemId
        self.adventure?.rate = 4
        if AdventureDB.dbInstance.updateAdventure(adv: self.adventure!) == true
        {
            self.adventure = AdventureDB.dbInstance.getAdventure(advId: advId!)
        }
    }
    
    @IBAction func btnStar5Clicked(_ sender: UIButton)
    {
        btnStar1.setImage(UIImage(named: "star-small-fill"), for: UIControlState.normal);
        btnStar2.setImage(UIImage(named: "star-small-fill"), for: UIControlState.normal);
        btnStar3.setImage(UIImage(named: "star-small-fill"), for: UIControlState.normal);
        btnStar4.setImage(UIImage(named: "star-small-fill"), for: UIControlState.normal);
        btnStar5.setImage(UIImage(named: "star-small-fill"), for: UIControlState.normal);
        let advId = self.adventure?.itemId
        self.adventure?.rate = 5
        if AdventureDB.dbInstance.updateAdventure(adv: self.adventure!) == true
        {
            self.adventure = AdventureDB.dbInstance.getAdventure(advId: advId!)
        }
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
    
    @IBAction func btnDeleteClicked(_ sender: UIButton)
    {
        let refreshAlert = UIAlertController(title: "Delete the Adventure", message: "All data releated to the Adventure will be deleted.", preferredStyle: UIAlertControllerStyle.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Delete", style: .default, handler: { (action: UIAlertAction!) in
            //print("Handle Ok logic here")
            if FacadeClass.selfInstance.delete(adventureID: (self.adventure?.itemId)!) == true
            {
                self.navigationController?.popToRootViewController(animated: true)
            }
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))
        
        present(refreshAlert, animated: true, completion: nil)
        
    }
    
    func showMarker(arg_position: CLLocationCoordinate2D, arg_title: String, arg_snippet: String)
    {
        let marker = GMSMarker()
        marker.position = arg_position
        marker.title = arg_title
        marker.snippet = arg_snippet
        marker.map = mapView
    }
    
}
