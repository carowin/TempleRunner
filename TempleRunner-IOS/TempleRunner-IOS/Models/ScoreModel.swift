//
//  FirstModel.swift
//  TempleRunner-IOS
//
//  Created by m2sar on 04/01/2021.
//  Copyright © 2021 UPMC. All rights reserved.
//

import UIKit

class ScoreModel {

    var lastScore = 0
    var hightScore  = 0

    init(){
        // Do nothing
    }

    init(lastScore: Int, hightScore: Int) {
        self.lastScore = lastScore
        self.hightScore = hightScore
    }

    func getLastScore() -> Int {
        return lastScore
    }

    func getHightScore() -> Int {
        return hightScore
    }

    func setLastScore(val : Int)  {
        self.lastScore = val
    }

    func setHightScore(val : Int)  {
        self.hightScore = val
    }

    func updateScores() {
        if lastScore > hightScore {
            hightScore = lastScore
        } 
    }

}