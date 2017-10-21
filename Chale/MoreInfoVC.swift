//
//  MoreInfoVC.swift
//  Chale
//
//  Created by Vishnu on 10/21/17.
//  Copyright © 2017 Vishnu. All rights reserved.
//

import Foundation
import UIKit

class MoreInfoVC: UIViewController {
    
    @IBOutlet weak var planNameLabel: UILabel!
    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    
    var eventInfo: EventModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
    
    func updateUI() {
        planNameLabel.text = eventInfo.eventName
        locationNameLabel.text = eventInfo.location
        dateTimeLabel.text = eventInfo.dateTime
    }
    
    @IBAction func backPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func chatPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "goToChat", sender: nil)
    }
}
