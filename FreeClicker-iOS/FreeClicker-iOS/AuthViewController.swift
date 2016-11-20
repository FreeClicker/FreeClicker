//
//  AuthViewController.swift
//  FreeClicker-iOS
//
//  Created by Andrew Arpasi on 11/19/16.
//  Copyright © 2016 Andrew Arpasi. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logIn(_ sender: Any) {
        AuthenticationHandler.signIn(email: emailField.text!, password: passwordField.text!, successCallback: { user in
            self.dismiss(animated: true, completion: nil)
        }, errorCallback: { error in
            let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            
            let okAction: UIAlertAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true, completion: nil)
        })
    }
    
    @IBAction func signUp(_ sender: Any) {
        AuthenticationHandler.register(email: emailField.text!, password: passwordField.text!, successCallback: { user in
            let alertController = UIAlertController(title: "Set Name", message: "Please enter your full name.", preferredStyle: .alert)
            
            let setNameAction = UIAlertAction(title: "Set Name", style: .default) { (_) in
                let nameField = alertController.textFields![0] as UITextField
                AuthenticationHandler.setName(user: user, name: nameField.text!, successCallback: { user1 in
                    self.dismiss(animated: true, completion: nil)
                }, errorCallback: { error1 in
                    print("error" + error1.localizedDescription)
                })
            }
            
            setNameAction.isEnabled = false
            
            alertController.addTextField { (textField) in
                textField.placeholder = "Full Name"
                
                NotificationCenter.default.addObserver(forName: NSNotification.Name.UITextFieldTextDidChange, object: textField, queue: OperationQueue.main) { (notification) in
                    setNameAction.isEnabled = true
                }
            }
            
            alertController.addAction(setNameAction)
            
            self.present(alertController, animated: true, completion: nil)

        }, errorCallback: { error in
            let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            
            let okAction: UIAlertAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        })
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
