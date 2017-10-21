//
//  HomeVC.swift
//  Chale
//
//  Created by Vishnu on 10/21/17.
//  Copyright © 2017 Vishnu. All rights reserved.
//

import Foundation
import UIKit

class HomeVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var homeArray: [EventModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        homeArray = [EventModel(eventName: "Boba Run", dateTime: "6 PM, Oct 21", location: "Cha for Tea")]
    }
    
    // TableView Functions
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as? HomeCell {
            cell.updateUI(homeCell: homeArray[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 175
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "getInfo", sender: homeArray[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? MoreInfoVC {
            if let item = sender as? EventModel {
                dest.eventInfo = item
            }
        }
    }
    ///
    
    @IBAction func addEvent(_ sender: UIBarButtonItem) {
    }
    
}


class HomeCell: UITableViewCell {
    
    @IBOutlet weak var planName: UILabel!
    @IBOutlet weak var dateTime: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var numPeople: UILabel!
    
    func updateUI(homeCell: EventModel) {
        planName.text = homeCell.eventName
        dateTime.text = homeCell.dateTime
        location.text = homeCell.location
    }
    
}
