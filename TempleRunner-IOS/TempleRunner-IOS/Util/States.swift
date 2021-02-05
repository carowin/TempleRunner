//
//  States.swift
//  TempleRunner-IOS
//
//  Created by m2Sar on 28/01/2021.
//  Copyright © 2021 UPMC. All rights reserved.
//

import Foundation



enum Powers {
    case ACCELERATION
    case INVNCIBILITER
}

enum LatPosition {
    case GAUCHE
    case DROIT
    case MILIEU
}

enum ModeDamagePlayer {
    case NORMAL
    case NODAMAGE
} 



enum StatePlayer {
    case RUNNING
    case JUMPING
    case SLIDING
    case LEFT
    case RIGHT
    case PAUSE
    case LOSE
    case KILL
}

enum StateMonster {
    case RUNNING
    case PAUSE
}

enum RockPosition {
    case LEFT
    case RIGHT
}

enum Difficulty  {
    case EASY
    case MEDIUM
    case HARD
    case IMPOSSIBLE
}


struct CurrentDifficulty {
    private static var lvl  = Difficulty.EASY
    private static var currentPower = Powers.ACCELERATION
    public static func getNextLvl(){
        switch lvl {
        case .EASY:
            lvl = Difficulty.MEDIUM
        case .MEDIUM:
            lvl = Difficulty.HARD
        case .HARD:
            lvl = Difficulty.IMPOSSIBLE
        default:
            lvl = Difficulty.EASY
        }
    }
    
    public static func setDiff(dif : Difficulty){
        lvl = dif
    }
    public static func getDiff() -> Difficulty {
        return lvl
    }
    
    public static func setCurrentPower(p : Powers){
        currentPower = p
    }
    public static func getCurrentPower() -> Powers{
        return currentPower
    }
}
