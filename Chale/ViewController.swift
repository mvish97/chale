//
//  ViewController.swift
//  Chale
//
//  Created by Vishnu on 10/20/17.
//  Copyright © 2017 Vishnu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var enterButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func pressedEnter(_ sender: UIButton) {
        performSegue(withIdentifier: "goToHome", sender: nil)
    }
    

}

