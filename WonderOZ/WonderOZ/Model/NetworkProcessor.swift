//
//  NetworkProcessor.swift
//  WonderOZ
//
//  Created by Jason-Zhuang on 29/1/18.
//  Copyright © 2018 iOSWorld. All rights reserved.
//

import Foundation
class NetworkProcessor
{
    lazy var configuration: URLSessionConfiguration = URLSessionConfiguration.default
    
    lazy var session: URLSession = URLSession(configuration: self.configuration)
    
    let url: URL
    
    init(arg_url:URL)
    {
        self.url = arg_url
    }
    
    typealias JSONDictionaryHandler = (([String:Any]?) -> Void)
    
    func downloadJSONFromURL(_ completion: @escaping JSONDictionaryHandler)
    {
        let request = URLRequest(url: self.url)
        
        let dataTask:URLSessionDataTask = session.dataTask(with: request)
        {
            (data, response, error) in
            
            if error == nil
            {
                if let httpResponse = response as? HTTPURLResponse
                {
                    switch httpResponse.statusCode
                    {
                        case 200:
                            if let data = data
                            {
                                do
                                {
                                    let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                                    completion(jsonDictionary as? [String:Any])
                                }catch{
                                    print("Error procession json data:\(error.localizedDescription)")
                                }
                            }
                        default:
                            print("HTTP Response Code:\(httpResponse.statusCode)")
                    }
                }
            }else
            {
                print("Error:\(error!.localizedDescription)")
            }
        }
        
        dataTask.resume()
    }
}
