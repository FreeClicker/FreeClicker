//
//  Utilities.swift
//  FreeClicker-iOS
//
//  Created by Andrew Arpasi on 11/19/16.
//  Copyright © 2016 Andrew Arpasi. All rights reserved.
//

import UIKit
import SwiftyJSON

class Utilities: NSObject {
    
    static let serverURL = "http://192.168.43.179:6969"
    
    class func performTextBasedRequestToServer(route: String, method: String, body: String, callback: @escaping (Data?, URLResponse?, NSError?) -> Void)
    {
        let url = URL(string: serverURL + route)
        let request:NSMutableURLRequest = NSMutableURLRequest(url: url!)
        request.httpMethod = method
        request.httpBody = body.data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {(data, response, error) in
            print("==request==")
            if(data != nil)
            {
                print(String(data: data!, encoding: String.Encoding.utf8) ?? "error")
                callback(data,response,error as NSError?)
            }
            else
            {
                print("data nil")
            }
        })
        task.resume()
    }
    
    class func performJSONBasedRequestToServer(route: String, method: String, JSON: JSON, callback: @escaping (Data?, URLResponse?, NSError?) -> Void)
    {
        let url = URL(string: serverURL + route)
        let request:NSMutableURLRequest = NSMutableURLRequest(url: url!)
        request.httpMethod = method
        request.httpBody = JSON.string?.data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {(data, response, error) in
            print("==request==")
            if(data != nil)
            {
                print(String(data: data!, encoding: String.Encoding.utf8) ?? "error")
                callback(data,response,error as NSError?)
            }
            else
            {
                print("data nil")
            }
        })
        task.resume()
    }
    
    class func getVisibleViewController(_ rootVC: UIViewController?) -> UIViewController? {
        
        var rootViewController = rootVC
        if rootViewController == nil {
            rootViewController = UIApplication.shared.keyWindow?.rootViewController
        }
        
        if rootViewController?.presentedViewController == nil {
            return rootViewController
        }
        
        if let presented = rootViewController?.presentedViewController {
            if presented.isKind(of: UINavigationController.self) {
                let navigationController = presented as! UINavigationController
                return navigationController.viewControllers.last!
            }
            
            if presented.isKind(of: UITabBarController.self) {
                let tabBarController = presented as! UITabBarController
                return tabBarController.selectedViewController!
            }
            
            return getVisibleViewController(presented)
        }
        return nil
    }
}
