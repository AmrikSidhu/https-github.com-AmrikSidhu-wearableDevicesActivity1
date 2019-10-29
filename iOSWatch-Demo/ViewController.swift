//
//  ViewController.swift
//  iOSWatch-Demo
//
//  Created by Z Angrazy Jatt on 2019-10-15.
//  Copyright © 2019 Z Angrazy Jatt. All rights reserved.
//

import UIKit
import WatchConnectivity

class ViewController: UIViewController, WCSessionDelegate {
    
    var i = 0
    @IBOutlet weak var mainLabel:UILabel!
    
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) { }
    
    func sessionDidBecomeInactive(_ session: WCSession) { }
    
    func sessionDidDeactivate(_ session: WCSession) { }
    
    
    func session(_ session: WCSession, didReceiveMessage message: [String :Any])
    {
        self.i = i + 1
        self.mainLabel.text = "Name:  \(i)\(message["Name"]!) , Age:  \(message["Age"] as! String)"
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("iPhone Loaded!")
        // MARK: does watch support communication with iPhone
        if(WCSession.isSupported() ==  true)
        {
            print("watch is Supporeting iphone")
            
            // create communication
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
        else
        {
            print("watch is NOT Supporeting iphone")
        }
    }
    
    // MARK: sending message
    @IBAction func messageSendButtonClicked(_ sender: Any) {
        
        // MARK:  sending message to watch
        if(WCSession.default.isReachable ==  true)
        {
            
            let message = ["Name": "Banana","Color" : "Yellow"]
                       WCSession.default.sendMessage( message, replyHandler: nil)
                       
                       print("message sent")
        }
        else
        {
          print("sending Failed, watch not connected")
        }
       
    }
    
    @IBAction func btnResetClicked(_ sender: UIButton) {
        mainLabel.text = " "
    }
    


}

