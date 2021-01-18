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
        if lastScore > hightScore {
            hightScore = lastScore
        } 
    }

}