//
//  ChatVC.swift
//  Chale
//
//  Created by Vatsal Rustagi on 10/21/17.
//  Copyright © 2017 Vishnu. All rights reserved.
//

import UIKit
import TwilioChatClient

class ChatVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    
    var messages : [TCHMessage] = []
    var client : TwilioChatClient? = nil
    var generalChannel: TCHChannel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }

}

extension ChatVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let messages = self.generalChannel?.messages {
            let msg = messages.sendMessage(with: TCHMessageOptions.withBody(textField.text!), completion: nil) //messages.createMessage(withBody: textField.text!)
            messages.send(msg) { result in
                textField.text = ""
                textField.resignFirstResponder()
            }
        }
        
        return true
    }
}


// MARK: UITableViewDataSource Delegate
extension ChatVC: UITableViewDataSource, UITableViewDelegate {
    
    // Return number of rows in the table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messages.count
    }
    
    // Create table view rows
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath)
            let message = self.messages[indexPath.row]
            
            // Set table cell values
            cell.detailTextLabel?.text = message.author
            cell.textLabel?.text = message.body
            cell.selectionStyle = .none
            return cell
    }
}
