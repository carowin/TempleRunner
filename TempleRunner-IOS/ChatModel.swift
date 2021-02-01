//
//  ChatModel.swift
//  TempleRunner-IOS
//
//  Created by m2sar on 28/01/2021.
//  Copyright © 2021 UPMC. All rights reserved.
//

import UIKit

class ChatModel {
    let urlFetch = "http://templerunnerpmm.pythonanywhere.com/chat/fetch"
    let urlMessages = "http://templerunnerpmm.pythonanywhere.com/chat/fetchMessages"
    let urlMessagesSize = "http://templerunnerpmm.pythonanywhere.com/chat/fetchMessagesSize"
    var jsonVar : Response?
    struct Response: Codable {
        let value: String
    }
    
    init(){
        // Do nothing
    }
    
    func fetch(_ url : String) {
        let task = URLSession.shared.dataTask(with: URL(string:url)!, completionHandler: {data, response, error in
            
            if let error = error {
                print("Error accessing url: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,(200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(response)")
                return
            }
            
            var result: Response?
            
            do {
                result = try JSONDecoder().decode(Response.self, from: data!)
            }
            catch {
                print("enable to aprse data")
            }
            
            guard let json = result else {
                print("data is nil")
                return
            }
            self.jsonVar = json
            /*let hightScore = Int(json.value)!
            print(json.value)*/
        })
        
        task.resume()
    }

    func fetchScore() {
        fetch(urlFetch)
        if jsonVar != nil {
            print(jsonVar!.value)
        }
    }
    func fetchMessagesSize() -> Int {
        fetch(urlFetch)//urlMessagesSize
        if jsonVar != nil {
            return Int(jsonVar!.value)!
        }
        return -1
    }
    func fetchMessages() {
        fetch(urlMessages)
        if jsonVar != nil {
            print(jsonVar!.value)
        }
    }
    
    func storeMessage(sender: String, message:String) {
        print(message)
        print(sender)
        
        var url = "http://templerunnerpmm.pythonanywhere.com/chat/storeMessage/"
        url += sender
        url += "/"
        url += message
        print(url)
        let uurl = URL(string: url)
        if uurl != nil {
            let request = URLRequest(url: uurl!)
            let config = URLSessionConfiguration.default
            let session = URLSession(configuration: config)
            let task = session.dataTask(with: request) {data,resp,err in
                DispatchQueue.main.async {
                    if err != nil {
                        
                    }else if data != nil{
                        print("ok")
                    }
                }
            }
            task.resume()
        }
        fetch(url)
        if jsonVar != nil {
            print(jsonVar!.value)
        }
    }
}
