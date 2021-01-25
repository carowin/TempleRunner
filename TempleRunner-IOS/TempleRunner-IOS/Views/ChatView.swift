//
//  ChatView.swift
//  TempleRunner-IOS
//
//  Created by m2sar on 04/01/2021.
//  Copyright © 2021 UPMC. All rights reserved.
//

import UIKit

/* Vue sur la conversation entre les joueurs */
class ChatView: UIView , UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource{
    var vc: ViewController?
    private var messages = [CellInfos]()
    
    
    let stackView = UIStackView()
    let sendButton = UIButton()
    let textField = UITextField()
    var tableView : UITableView?
    var keyBoardShown = false
    private var firstView : FirstView?
    
    init(frame : CGRect, viewc : ViewController){
        self.vc = viewc
        //get messages from ower DataBase
        for i in 0...20 {
            if i%2 == 0 {
                messages.append(CellInfos(name: "Me", message: String(format: "Zoubir radi says that this message is very very very very very very long message %d", arguments: [i])))
            } else {
                messages.append(CellInfos(name: "Other", message: String(format: "Other says that this message is very very very very very very long message %d %d", arguments: [i])))
            }
        }
        
        //self.title = "Group Chat"
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height - 80), style: .plain)
        tableView?.separatorStyle = .none
        //tableView?.estimatedRowHeight = 100
        tableView?.rowHeight = UITableView.automaticDimension
        tableView?.allowsSelection = false
        
        
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .asciiCapable
        textField.returnKeyType = .send
        stackView.distribution = .fill
        
        stackView.axis = .horizontal
        sendButton.titleLabel?.text = "Send"
        sendButton.backgroundColor = .green
        sendButton.layer.cornerRadius = 50
        
        textField.backgroundColor = UIColor(red: 135/225.0, green: 206/255.0, blue: 235/255.0, alpha: 0.4)
        textField.placeholder = "Enter you message..."
        textField.layer.cornerRadius = 30
        //textField.frame.size.width = 100
        stackView.addArrangedSubview(textField)
        stackView.addArrangedSubview(sendButton)
        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(equalToConstant: frame.size.width),
            sendButton.widthAnchor.constraint(equalToConstant: 60)
            ])
        stackView.frame = CGRect(x: 0, y: frame.height - 80, width: frame.size.width
            , height: 60)
        super.init(frame: frame)
        self.backgroundColor = .white
        sendButton.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.backgroundColor = .white
        textField.delegate = self
        
        addSubview(tableView!)
        addSubview(stackView)
        
        
        //keyboar handling
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardAppers), name: UIWindow.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardDisappers), name: UIWindow.keyboardWillHideNotification, object: nil)
    }
    
    /* fonction qui repositionne la stackView et la tableView quand le keybeard apparu */
    @objc func keyBoardAppers (notif : Notification) {
        print("keyboard handler :", notif.name)
        if !keyBoardShown {
            keyBoardShown = true
            if let userinfo = notif.userInfo {
                let keyboardFrame = userinfo[UIWindow.keyboardFrameEndUserInfoKey]! as! CGRect
                print(keyboardFrame)
                stackView.frame = CGRect(x: 0, y: stackView.frame.minY - keyboardFrame.height, width: stackView.frame.width, height: stackView.frame.height)
                tableView!.frame = CGRect(x: 0, y: tableView!.frame.minY - keyboardFrame.height, width: tableView!.frame.width, height: tableView!.frame.height)
                tableView?.scrollToRow(at: IndexPath(row: messages.count - 1, section: 0), at: .bottom, animated: true)
            }
        }
        
    }
    
    /* fonction qui repositionne la stackView et la tableView quand le keybeard dispparu */
    @objc func keyBoardDisappers (notif : Notification) {
        if keyBoardShown {
            keyBoardShown = false
            if let userinfo = notif.userInfo {
                let keyboardFrame = userinfo[UIWindow.keyboardFrameBeginUserInfoKey]! as! CGRect
                print(keyboardFrame)
                stackView.frame = CGRect(x: 0, y: stackView.frame.minY + keyboardFrame.height, width: stackView.frame.width, height: stackView.frame.height)
                tableView!.frame = CGRect(x: 0, y: tableView!.frame.minY + keyboardFrame.height, width: tableView!.frame.width, height: tableView!.frame.height)
                tableView?.scrollToRow(at: IndexPath(row: messages.count - 1, section: 0), at: .bottom, animated: true)
            }
        }
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /* fonction appelé pour dessiner le chat view */
    func drawInSize(_ frame : CGRect){
        //TO BE COMPLETED!!
    }
    
    /* fonction appelé par le viewController pour afficher la vue du chat */
    func displayChatView() {
        self.isHidden = false
    }
    
    /* fonction appelé par le viewController pour cacher la vue du chat */
    func hideChatView() {
        self.isHidden = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = messages[indexPath.row].name
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId) as? ChatCell
        if cell == nil {
            cell = ChatCell(style: .subtitle, reuseIdentifier: cellId)
            if cellId == "Me" {
                cell?.message.backgroundColor = UIColor.init(red: 74/255.0, green: 201/255.0, blue: 89/255.0, alpha: 1)
                cell?.message.textColor = .white
                cell?.stackView.alignment = .trailing
            } else {
                cell?.message.backgroundColor = UIColor.init(red: 69/255.0, green: 90/255.0, blue: 100/255.0, alpha: 0.5)
            }
        }
        cell?.message.text = messages[indexPath.row].message
        cell?.name.text = messages[indexPath.row].name
        //cell!.sizeThatFits(CGSize(width: UIScreen.main.bounds.width, height: messages[indexPath.row].size))
        messages[indexPath.row].size = cell!.reSize()
        print("mysize", messages[indexPath.row].size)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        /*if indexPath.row % 2 == 0{
         return 100
         }else {
         return 60
         }*/
        print("forrow ", messages[indexPath.row].size)
        return messages[indexPath.row].size
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //Notification.use
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        sendMessage()
    }
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == "\n" {
            textField.resignFirstResponder()
            return false
        } else {
            return true
        }
    }
    
    @objc func sendMessage() {
        textField.resignFirstResponder()
        if textField.text != "" {
            // send web
            messages.append(CellInfos(name: "Me", message: textField.text!))
        }
        
        textField.text = ""
        tableView?.reloadData()
        tableView?.scrollToRow(at: IndexPath(row: messages.count - 1, section: 0), at: .bottom, animated: true)
    }
}
