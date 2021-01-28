//
//  RoadBranch.swift
//  TempleRunner-IOS
//
//  Created by m2Sar on 22/01/2021.
//  Copyright © 2021 UPMC. All rights reserved.
//

import Foundation
import UIKit
class RoadBranch : Block {
    let rocherImage = UIImage(named: "branch")
    override init(x: CGFloat ,y: CGFloat ,blockSize: CGFloat){
        super.init(x: x, y: y, blockSize: blockSize)
        super.baseView = UIImageView(image: rocherImage)
    }
    
    override public func setView(view : UIView){
        super.setView(view: view)
    }
    
    public override func detectCollision(player:Player) -> Bool{
        if y+blockSize/10<player.getPosition().y && player.getPosition().y<y+blockSize{
            if player.getCurrentState() != .SLIDING{
                player.setState(state: .LOSE)
                return true
            }
        }
        return false    }
}
