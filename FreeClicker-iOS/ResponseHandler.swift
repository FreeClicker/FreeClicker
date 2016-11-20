//
//  ResponseHandler.swift
//  FreeClicker-iOS
//
//  Created by Andrew Arpasi on 11/20/16.
//  Copyright © 2016 Andrew Arpasi. All rights reserved.
//

import UIKit
import FirebaseAuth
import SwiftyJSON

class ResponseHandler {
    
    private static var serverURL = "http://192.168.43.179:6969"
    static var currentRoomName = ""
    
    static func getServerURL() -> String {
        return serverURL
    }
    
    static func setServerURL(host: String, port: Int) {
        serverURL = "http://" + host + ":" + String(port)
    }
    
    static func leaveRoom() {
        currentRoomName = ""
        serverURL = ""
    }
    
    static func submitResponse(letter: String, user: FIRUser, callback: @escaping (String?) -> Void) {
        let json = JSON([user.displayName,letter])
        let representation = json.rawString()
        print("json raw string: " + representation!)
        Utilities.performTextBasedRequestToServer(route: "/answer/", method: "POST", body: representation!, callback: { data, response, error in
            let responseString = String(data: data!, encoding: String.Encoding.utf8)
            if(responseString != nil) {
                print("rs: " + responseString!)
                callback(responseString)
            } else {
                callback(nil)
            }
        })
    }

}
