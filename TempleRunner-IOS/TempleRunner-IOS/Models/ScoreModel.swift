//
//  FirstModel.swift
//  TempleRunner-IOS
//
//  Created by m2sar on 04/01/2021.
//  Copyright © 2021 UPMC. All rights reserved.
//

import UIKit

class ScoreModel {

    private var lastScore = 0
    private var hightScore  = 0
    private var currentScore = 0
    private var currentCoins = 0
    

    let urlFetch = "http://templerunnerppm.pythonanywhere.com/chat/storeScore/"
    struct Response: Codable {
        let value: String
    }

    init(){
        // Do nothing
    }

    init(lastScore: Int, hightScore: Int) {
        self.lastScore = lastScore
        self.hightScore = hightScore
    }

    init(currentScore: Int, currentCoins: Int) {
        self.currentScore = currentScore
        self.currentCoins = currentCoins
    }



    func storeHighScore() {
        print(urlFetch+Identifier.getId()+"/"+String(self.hightScore))
        let task = URLSession.shared.dataTask(with: URL( string:urlFetch+Identifier.getId()+"/"+String(self.hightScore) )!, completionHandler: {data, response, error in 
        
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
        
        })

        task.resume()
    }

    func getLastScore() -> Int {
        return lastScore
    }

    func getHightScore() -> Int {
        return hightScore
    }

    func getCurrentScore() -> Int {
        return currentScore
    }

    func getCurrentCoins() -> Int {
        return currentCoins
    }

    func setLastScore(val : Int)  {
        self.lastScore = val
    }

    func setHightScore(val : Int)  {
        self.hightScore = val
    }

    func setCurrentScore(val : Int)  {
        self.currentScore = val
    }

    func setCurrentCoins(val : Int)  {
        self.currentCoins = val
    }

    func updateScores() {
        if(currentScore != 0){
            lastScore = currentScore
        }
        if lastScore > hightScore {
            hightScore = lastScore
        } 
    }
    
    

}
