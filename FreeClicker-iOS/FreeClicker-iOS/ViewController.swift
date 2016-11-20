//
//  ViewController.swift
//  FreeClicker-iOS
//
//  Created by Andrew Arpasi on 11/19/16.
//  Copyright © 2016 Andrew Arpasi. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    @IBOutlet weak var welcomeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkAuth()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        checkAuth()
    }
    
    func checkAuth() {
        if(AuthenticationHandler.userSignedIn()) {
            let user = FIRAuth.auth()!.currentUser
            welcomeLabel.text = "Welcome, " + (user?.displayName)!
        } else {
            self.performSegue(withIdentifier: "authSegue", sender: self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func logOut(_ sender: Any) {
        AuthenticationHandler.signOutUser()
        self.performSegue(withIdentifier: "authSegue", sender: self)
    }

    @IBAction func scanQR(_ sender: Any) {
        
    }
}

