//
//  ChatVC.swift
//  Chale
//
//  Created by Vatsal Rustagi on 10/21/17.
//  Copyright © 2017 Vishnu. All rights reserved.
//

import UIKit
import TwilioChatClient

class ChatVC: UIViewController, BackendDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    
    var messages : [TCHMessage] = []
    var client : TwilioChatClient? = nil
    var generalChannel: TCHChannel? = nil
    var identity = ""
    let backend = Backend()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        textField.delegate = self
        backend.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        login()
    }
    
    func login() {
        let deviceId = UIDevice.current.identifierForVendor!.uuidString
        print(userName)
        backend.getJSONData(from: "token/", withParams: ["device": deviceId, "id": userName])
    }
    
    func processDataOfType(JSON: Dictionary<String, Any>) {
        if let id = JSON["identity"] as? String{
            identity = id
        }
        
        if let token = JSON["token"] as? String{
            TwilioChatClient.init()
            TwilioChatClient.chatClient(withToken: token, properties: nil, delegate: self){
                (result, chatClient) in
                print("\nchatCLient : \(chatClient), \n result : \(result)")
                self.client = chatClient
//                let options = [
//                    TCHChannelOptionFriendlyName: "General Channel",
//                    TCHChannelOptionType: TCHChannelType.public.rawValue
//                    ] as [String : Any]
//                self.client?.channelsList()?.createChannel(options: options, completion: {
//                    channelResult, channel in
//                    if (channelResult.isSuccessful()){
//                        print("Channel created")
//                    }
//                    else{
//                        print("Fuck ho gaya")
//                    }
//                })
                DispatchQueue.main.async() {
//                    self.navigationItem.prompt = "Logged in as \"\(self.identity)\""
                    
                    print("Logged in as \(self.identity)")
                }
            }
        }
    }
    
    func logout(){
        if let client = client {
            client.delegate = nil
            client.shutdown()
            self.client = nil
        }
    }
}

// Twilio Chat Delegate
extension ChatVC: TwilioChatClientDelegate {
    
    func chatClient(_ client: TwilioChatClient, synchronizationStatusUpdated status: TCHClientSynchronizationStatus) {
        print("\n\n ChatClient delegate called \n\n")
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
        print("Called and generalChannel is \(generalChannel)")
        if let messages = self.generalChannel?.messages {
            let options = TCHMessageOptions().withBody(textField.text!)
            messages.sendMessage(with: options){
                result, message in
                if result.isSuccessful(){
                    print("Message Sent")
                }
                else{
                    print("Tumhara app bakwas hai")
                }
            }
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
