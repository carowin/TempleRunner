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
    let urlMessages = "http://templerunnerppm.pythonanywhere.com/chat/fetchMessages/"
    let urlMessagesSize = "http://templerunnerppm.pythonanywhere.com/chat/fetchMessagesSize"
    
    var jsonVar : Response?
    struct Response: Codable {
        let value: String
    }

    struct Welcome: Codable {
        let messages: [Message]
    }
    
    struct Message: Codable {
        let sender, message: String
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
    }
    func fetchMessagesSize() -> Int {
        fetch(urlMessagesSize)//urlMessagesSize
        if jsonVar != nil {
            return Int(jsonVar!.value)!
        }
        return -1
    }
    func fetchMessages(number : Int, view : ChatView) {
        var thisUrl = urlMessages
        thisUrl += String(number)
        thisUrl += "/"
        var result: Welcome?
        let task = URLSession.shared.dataTask(with: URL(string:thisUrl)!, completionHandler: {data, response, error in
            DispatchQueue.main.async {
            if let error = error {
                print("Error accessing url: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,(200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(response)")
                return
            }
            
            do {
                result = try JSONDecoder().decode(Welcome.self, from: data!)
            }
            catch {
                print("enable to aprse data")
            }
            
            guard let _ = result else {
                print("data is nil")
                return
            }
            view.addMessages(result!.messages)
            }
        })
        task.resume()
    }
    
    func storeMessage(sender: String, message:String) {
        print(message)
        print(sender)
        
        var url = "http://templerunnerppm.pythonanywhere.com/chat/storeMessage/"
        
        url += sender
        url += "/"
        url += message
        
        url = url.replacingOccurrences(of: " ", with: "%20")
        let uurl = URL(string: url)
        if uurl != nil {
            let task = URLSession.shared.dataTask(with: uurl!, completionHandler: {data, response, error in
                DispatchQueue.main.async {
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
                    
                    guard let _ = result else {
                        print("data is nil")
                        return
                    }
                }
            })
            task.resume()
        }
    }
}
