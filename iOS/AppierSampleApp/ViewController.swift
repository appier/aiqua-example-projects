//
//  ViewController.swift
//  AppierSampleApp
//
//  Created by Appier on 2020/2/18.
//  Copyright © 2020 appier. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func sendLogEvent(sender: UIButton) {
        
        //---- Sample Logging Event with Parameters -----//
        QGSdk.getSharedInstance().logEvent("Hi Aiqua", withParameters: ["key01": NSNumber(value:Float(1000)), "key02": "string"])
    }
}
