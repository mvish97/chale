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
    var identity = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        textField.delegate = self
    }

    
}





// Twilio Chat Delegate
extension ChatVC: TwilioChatClientDelegate {
    
    func chatClient(_ client: TwilioChatClient, synchronizationStatusUpdated status: TCHClientSynchronizationStatus) {
        if status == .completed {
            // Join (or create) the general channel
            let defaultChannel = "general"
            client.channelsList()?.channel(withSidOrUniqueName: defaultChannel, completion: { (result, channel) in
                if let channel = channel {
                    self.generalChannel = channel
                    channel.join(completion: { result in
                        print("Channel joined with result \(result)")
                    })
                }
                // Have to create a channel if it hasn't been created yet
            })
        }
    }
    
    func chatClient(_ client: TwilioChatClient, channel: TCHChannel, messageAdded message: TCHMessage) {
        // Called whenever a new message is received
        self.messages.append(message)
        self.tableView.reloadData()
        DispatchQueue.main.async() {
            if self.messages.count > 0 {
                self.scrollToBottomMessage()
            }
        }
    }
    
    func scrollToBottomMessage() {
        // Scroll to the bottom of the table view
        // to view the new messages
        if self.messages.count == 0 {
            return
        }
        
        let bottomMessageIndex = IndexPath(row: messages.count - 1, section: 0)
        tableView.scrollToRow(at: bottomMessageIndex, at: .bottom, animated: true)
    }
    
}


extension ChatVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let messages = self.generalChannel?.messages {
            messages.sendMessage(with: TCHMessageOptions(), completion: nil)
            textField.text = ""
            textField.resignFirstResponder()
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
