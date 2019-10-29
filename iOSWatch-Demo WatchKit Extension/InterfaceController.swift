//
//  InterfaceController.swift
//  iOSWatch-Demo WatchKit Extension
//
//  Created by Z Angrazy Jatt on 2019-10-15.
//  Copyright © 2019 Z Angrazy Jatt. All rights reserved.
//

import WatchKit
import Foundation
import  WatchConnectivity


class InterfaceController: WKInterfaceController, WCSessionDelegate{
    @IBOutlet weak var msgFromPhone: WKInterfaceLabel!
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        // MARK: code to get data from mobile
    }

    
   
    
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        self.msgFromPhone.setText("Name:  \(message["Name"]  as! String)  , Color:  \(message["Color"] as! String)")
    }
    
    override func awake(withContext context: Any?) { super.awake(withContext: context)// Configure interface objects here.
        
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        print("watch Loaded!")
        
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
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
        
        
    }
    @IBAction func watchButtonClicked() {
        print("button Clicked!")
       // MARK:  sending message to watch
        if(WCSession.default.isReachable ==  true)
        {
            let message = ["Name": "Pritesh","Age" : "20"]
            WCSession.default.sendMessage( message, replyHandler: nil)
              print("message sent")        }
        else
        {
            print("Sending failed, Phone not connected")
        }
    }
    
    @IBAction func btnResetClicked() {
        
        
        msgFromPhone.setText(" ")
        
    }
    

}
