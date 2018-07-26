//
//  LocationService.swift
//  WonderOZ
//
//  Created by Jason-Zhuang on 29/1/18.
//  Copyright © 2018 iOSWorld. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

class LocationService
{
    let locationBaseURL: String = "https://maps.googleapis.com/maps/api/place/textsearch/json?query="
    var googleKey: String?
    
    init(apiKey: String)
    {
        self.googleKey = "key=\(apiKey)"
    }
    
    func getLocationByAddress(arg_Address:String, completion: @escaping(Coordinate?) -> Void)
    {
        let originalString = self.locationBaseURL + arg_Address + "&" + self.googleKey!
        
        let urlString: String = originalString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        let locationURL = URL(string: urlString)
        
        let networkProcessor = NetworkProcessor(arg_url: locationURL!)
        
        networkProcessor.downloadJSONFromURL { (jasonDictionary) in
            
            if let dictionary = jasonDictionary
            {
                if let resonseStatus = dictionary["status"] as? String
                {
                    if (resonseStatus == "OK")
                    {
                        if let responseResult = dictionary["results"] as? [Any]
                        {
                            if let responseResult0 = responseResult[0] as? [String: Any]
                            {
                                if let responseGeometry = responseResult0["geometry"] as? [String: Any]
                                {
                                    if let responseLocation = responseGeometry["location"] as? [String: Any]
                                    {
                                        let x = (responseLocation["lat"] as? Double)!
                                        let y = (responseLocation["lng"] as? Double)!
                                        var coordinate:Coordinate = Coordinate()
                                        coordinate.latitude = x
                                        coordinate.longitude = y
                                        completion(coordinate)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            
        }
        
    }
    
}










