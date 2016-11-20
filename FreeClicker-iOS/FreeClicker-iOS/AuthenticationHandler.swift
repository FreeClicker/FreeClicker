//
//  AuthenticationHandler.swift
//  FreeClicker-iOS
//
//  Created by Andrew Arpasi on 11/19/16.
//  Copyright © 2016 Andrew Arpasi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class AuthenticationHandler {
    
    static func signIn(email: String, password: String, successCallback: @escaping (FIRUser) -> Void,errorCallback: @escaping (NSError) -> Void) {
        FIRAuth.auth()?.signIn(withEmail: email, password: password) { (user, error) in
            if(error != nil)
            {
                errorCallback(error! as NSError)
            }
            else if(user != nil)
            {
                print("user signed in!")
                successCallback(user!)
            }
        }
    }
    
    static func register(email: String, password: String,  successCallback: @escaping (FIRUser) -> Void,errorCallback: @escaping (NSError) -> Void) {
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user,error) in
            if(error != nil)
            {
                errorCallback((error! as NSError?)!)
            }
            else
            {
                successCallback(user!)
                print("user signed up!")
            }
        })
    }
    
    static func setName(user: FIRUser, name: String, successCallback: @escaping (FIRUser) -> Void,errorCallback: @escaping (NSError) -> Void) {
        let changeRequest = user.profileChangeRequest()
        changeRequest.displayName = name
        changeRequest.commitChanges(completion: {(error) in
            successCallback(user)
        })
    }
    
    static func signOutUser()
    {
        try! FIRAuth.auth()!.signOut()
    }
    
    static func userSignedIn() -> Bool
    {
        return (FIRAuth.auth()?.currentUser) != nil
    }

}
