//
//  ViewController.swift
//  Chale
//
//  Created by Vishnu on 10/20/17.
//  Copyright © 2017 Vishnu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, BackendDelegate {

    @IBOutlet weak var enterButton: UIButton!
    let backend = Backend()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backend.delegate = self
        let deviceId = UIDevice.current.identifierForVendor!.uuidString
        backend.getJSONData(from: "token/", withParams: ["device": deviceId])
    }
    
    func processDataOfType(JSON: Dictionary<String, Any>) {
        print(JSON)
    }
    
    @IBAction func pressedEnter(_ sender: UIButton) {
        performSegue(withIdentifier: "goToHome", sender: nil)
    }
    

}

