//
//  InputViewController.swift
//  FreeClicker-iOS
//
//  Created by Andrew Arpasi on 11/20/16.
//  Copyright © 2016 Andrew Arpasi. All rights reserved.
//

import UIKit
import FirebaseAuth

class InputViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var responseLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = ResponseHandler.currentRoomName
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func answerPress(sender: UIButton) {
        print(sender.titleLabel?.text)
        if let user = FIRAuth.auth()?.currentUser {
            ResponseHandler.submitResponse(letter: (sender.titleLabel?.text)!, user: user, callback: { response in
                if(response != nil) {
                    print("res: " + response!)
                    if(response?.contains("success"))! == true {
                        DispatchQueue.main.async {
                            self.responseLabel.text = "Answer successfully submitted as " + (sender.titleLabel?.text)! + "."
                        }
                    } else if(response == "closed") {
                        DispatchQueue.main.async {
                            self.responseLabel.text = "Polling currently closed."
                        }
                    }
                }
            })
        }
        
    }

    @IBAction func leave(_ sender: Any) {
        ResponseHandler.leaveRoom()
        self.dismiss(animated: true, completion: nil)
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
