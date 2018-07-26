//
//  CategoryViewController.swift
//  WonderOZ
//
//  Created by Jason-Zhuang on 22/1/18.
//  Copyright © 2018 iOSWorld. All rights reserved.
//

import UIKit
import CoreLocation

private let reuseIdentifier = "categoryCell"

class CategoryViewController: UIViewController, CLLocationManagerDelegate 
{
    
    @IBOutlet var collect_View: UICollectionView!
    
    var myCategories = AdventureDB.dbInstance.adventureCategories
    
    private let leftAndRighPadding:CGFloat  = 30.0
    private let numberOfItemsPerRow:CGFloat = 2.0
    private let heightAjustment:CGFloat     = 30.0
    
    
    private let myLocationManager = CLLocationManager()
    override func viewDidLoad()
    {
        super.viewDidLoad()
        collect_View.delegate = self
        collect_View.dataSource = self
        
        myLocationManager.delegate = self;
        myLocationManager.distanceFilter  = kCLLocationAccuracyHundredMeters
        myLocationManager.desiredAccuracy = kCLLocationAccuracyBest;
        myLocationManager.requestAlwaysAuthorization()
        if (CLLocationManager.locationServicesEnabled())
        {
            myLocationManager.startUpdatingLocation()
            print("The Location Service begins to locate. ")
        }
        
    }

    override func viewDidAppear(_ animated: Bool)
    {
        myCategories = AdventureDB.dbInstance.initAdventureCategories();
        collect_View?.reloadData();
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "categoryToList"
        {
            let controller = segue.destination as! AdvTableViewController
            controller.myCategory = sender as? Category
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let currLocation:CLLocation = locations.last!
        if (AdventureDB.myLatitude == currLocation.coordinate.latitude && AdventureDB.myLongitude == currLocation.coordinate.longitude)
        {
            
        }else
        {
            //print("latitude：\(currLocation.coordinate.latitude)")
            AdventureDB.myLatitude = currLocation.coordinate.latitude
            //print("longitude：\(currLocation.coordinate.longitude)")
            AdventureDB.myLongitude = currLocation.coordinate.longitude
            //print("altitude：\(currLocation.altitude)")
            //print("horizontalAccuracy：\(currLocation.horizontalAccuracy)")
            //print("verticalAccuracy：\(currLocation.verticalAccuracy)")
            //print( "course：\(currLocation.course)")
            //print("speed：\(currLocation.speed)")
            AdventureDB.dbInstance.updateAllDistance(myLatitude: currLocation.coordinate.latitude, myLongitude: currLocation.coordinate.longitude)
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
