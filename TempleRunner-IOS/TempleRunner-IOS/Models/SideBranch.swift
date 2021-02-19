//
//  SideBranch.swift
//  TempleRunner-IOS
//
//  Created by m2sar on 01/02/2021.
//  Copyright © 2021 UPMC. All rights reserved.
//

import Foundation
import UIKit
class SideBranch : Block {
    
    let rocherImage : UIImage?
  
    let rockPlacement : RockPosition

    var alreadyHit : Bool
    
    init(x : CGFloat ,y : CGFloat , blockSize : CGFloat , rockPosition : RockPosition) {
        rockPlacement = rockPosition
        if(rockPlacement == RockPosition.LEFT){
            rocherImage = UIImage(named: "sidebranch")
        }else {
            rocherImage = UIImage(named: "branchdroite")
        }
        alreadyHit = false
        super.init(x: x, y: y, blockSize: blockSize)
      
        super.baseView = UIImageView(image: rocherImage)
    }
    
    override public func setView(view : UIView){
        super.setView(view: view)
    }
    
    public override func detectCollision(player:Player) -> Bool{
        
         if(player.getCurrentDamageMode() == .NODAMAGE){
            return false
        }
        
        let posY = (super.baseView.superview?.frame.origin.y)!
        let posX = (super.baseView.superview?.frame.origin.x)!
        if(posY<player.getPosition().y && player.getPosition().y<posY+blockSize/2 && alreadyHit==false){
            if(player.getCurrentState() == .JUMPING){
                return false
            }else{
                alreadyHit = true
                player.decrementLifePoints()
            }
        }
        return false
    }
}
