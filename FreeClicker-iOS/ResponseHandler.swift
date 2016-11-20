//
//  ResponseHandler.swift
//  FreeClicker-iOS
//
//  Created by Andrew Arpasi on 11/20/16.
//  Copyright © 2016 Andrew Arpasi. All rights reserved.
//

import UIKit

class ResponseHandler {
    
    private static var serverURL = ""
    
    static func getServerURL() -> String {
        return serverURL
    }
    
    static func setServerURL(host: String, port: Int) {
        serverURL = host + ":" + String(port)
    }

}
