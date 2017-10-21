//
//  ViewController.swift
//  Chale
//
//  Created by Vishnu on 10/20/17.
//  Copyright © 2017 Vishnu. All rights reserved.
//

import UIKit

var userName = ""

class ViewController: UIViewController {

    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var userTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func pressedEnter(_ sender: UIButton) {
        userName = userTextField.text!
        performSegue(withIdentifier: "goToHome", sender: nil)
    }
    

}

