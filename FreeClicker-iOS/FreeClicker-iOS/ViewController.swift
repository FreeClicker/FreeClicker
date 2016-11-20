//
//  ViewController.swift
//  FreeClicker-iOS
//
//  Created by Andrew Arpasi on 11/19/16.
//  Copyright © 2016 Andrew Arpasi. All rights reserved.
//

import UIKit
import FirebaseAuth
import QRCodeReader
import AVFoundation
import SwiftyJSON

class ViewController: UIViewController, QRCodeReaderViewControllerDelegate {

    @IBOutlet weak var welcomeLabel: UILabel!
    
    lazy var readerVC = QRCodeReaderViewController(builder: QRCodeReaderViewControllerBuilder {
        $0.reader = QRCodeReader(metadataObjectTypes: [AVMetadataObjectTypeQRCode], captureDevicePosition: .back)
    })
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkAuth()
        let data = ["1":2, "2":"two", "3": nil] as [String: Any?]
        let json = JSON(data)
        let representation = json.rawString()
        print("json raw string: " + representation!)
        Utilities.performTextBasedRequestToServer(route: "/answer/", method: "POST", body: representation!, callback: { data, response, error in
            let responseString = String(data: data!, encoding: String.Encoding.utf8)
            if(responseString != nil) {
                print("rs: " + responseString!)
            }
        })
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
        readerVC.delegate = self
        self.present(readerVC, animated: true, completion: nil)
    }
    
    // MARK: - QRCodeReaderViewController Delegate Methods
    
    func reader(_ reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
        reader.stopScanning()
        print(result.value)
        let jsonDict = Utilities.convertStringToDictionary(text: result.value)
        print("==json result==")
        print(jsonDict)
        print("==end json result==")
        if(jsonDict != nil) {
            let room = jsonDict?["room"]
            let ip = jsonDict?["ip"]
            let port = jsonDict?["port"]
            ResponseHandler.setServerURL(host: ip as! String, port: port as! Int)
            print("serverURL: " + ResponseHandler.getServerURL())
            dismiss(animated: true, completion: nil)
        }
    }
    
    func readerDidCancel(_ reader: QRCodeReaderViewController) {
        reader.stopScanning()
        dismiss(animated: true, completion: nil)
    }
    
    /**
     Tells the delegate that the camera was switched by the user
     
     - parameter reader: A code reader object informing the delegate about the scan result.
     - parameter newCaptureDevice: The capture device that was switched to
     */
    public func reader(_ reader: QRCodeReaderViewController, didSwitchCamera newCaptureDevice: AVCaptureDeviceInput) {
        
    }
}

