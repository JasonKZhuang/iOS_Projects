//
//  AppDelegate.swift
//  WonderOZ
//
//  Created by Jason-Zhuang on 19/1/18.
//  Copyright © 2018 iOSWorld. All rights reserved.
//
// ================================= Kaizhi Zhuang 25/1/18 =======================================//
// If you don't already have the CocoaPods tool, install it on macOS by running the following command from the terminal.
// #sudo gem install cocoapods
// Create a Podfile for the Google Maps SDK for iOS and use it to install the API and its dependencies
// Create a file named Podfile in your project directory. This file defines your project's dependencies.
// Edit the Podfile and add your dependencies. Here is an example which includes the dependencies you need for the Google Maps SDK for iOS and Places API for iOS (optional):
// *****************************************************//
// source 'https://github.com/CocoaPods/Specs.git'      //
// target 'YOUR_APPLICATION_TARGET_NAME_HERE' do        //
//      pod 'GoogleMaps'                                //
//      pod 'GooglePlaces'                              //
// end                                                  //
// *****************************************************//
// Open a terminal and go to the directory containing the Podfile:
// Run the pod install command.
// This will install the APIs specified in the Podfile, along with any dependencies they may have.
// #pod install
// Close Xcode, and then open (double-click) your project's .xcworkspace file to launch Xcode.
// From this time onwards, you must use the .xcworkspace file to open the project.

// error:
//The app's Info.plist must contain both NSLocationAlwaysAndWhenInUseUsageDescription and NSLocationWhenInUseUsageDescription keys with string values explaining to the user how the app uses this data

// Error: Failed to load optimized model - GoogleMaps SDK IOS
// If you have already double-checked the basic setup for the "google maps ios-sdk" with an APIkey for your app's bundle identifier here and still have the same problem
//  then probably you have not enabled the google maps API. Go to your app-project's dashboard on https://console.developers.google.com and click the "ENABLE APIS AND SERVICES". There, under the MAPS section select "the Google maps sdk for ios" and enable it.

import UIKit
import GoogleMaps
import GooglePlaces

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
    var window: UIWindow?
    
    static let myGoogleMapKey:String = "AIzaSyBP7COU_obgA6MWVBIl5z6MSxhM2ochPTw"
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool
    {
        // Override point for customization after application launch.
        var _: AdventureDB = AdventureDB.dbInstance
        
        //Google Place
        GMSPlacesClient.provideAPIKey(AppDelegate.myGoogleMapKey)
        
        //google map
        GMSServices.provideAPIKey(AppDelegate.myGoogleMapKey)
        print("The WonderOZ app has been started!")
        return true
    }

    func applicationWillResignActive(_ application: UIApplication)
    {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication)
    {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication)
    {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication)
    {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication)
    {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

