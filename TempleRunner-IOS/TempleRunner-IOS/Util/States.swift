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
