//
//  States.swift
//  TempleRunner-IOS
//
//  Created by m2Sar on 28/01/2021.
//  Copyright © 2021 UPMC. All rights reserved.
//

import Foundation

enum StatePlayer {
    case RUNNING
    case JUMPING
    case SLIDING
    case LEFT
    case RIGHT
    case PAUSE
    case LOSE
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
    public static func getDiff() -> Difficulty {
        return lvl
    }
}
