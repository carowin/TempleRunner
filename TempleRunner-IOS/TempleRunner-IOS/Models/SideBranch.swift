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
    
    var playerHit : Bool
    
    init(x : CGFloat ,y : CGFloat , blockSize : CGFloat , rockPosition : RockPosition) {
        rockPlacement = rockPosition
        if(rockPlacement == RockPosition.LEFT){
            rocherImage = UIImage(named: "sidebranch")
        }else {
            rocherImage = UIImage(named: "branchdroite")
        }
        playerHit = false
        super.init(x: x, y: y, blockSize: blockSize)
      
        super.baseView = UIImageView(image: rocherImage)
    }
    
    override public func setView(view : UIView){
        super.setView(view: view)
    }
    
    public func setHitPlayer(val: Bool){
        playerHit = val
    }
    
    public override func detectCollision(player:Player) -> Bool{
        let pos = player.getPosition()
        if player.getCurrentState() == .JUMPING{
            return false
        }
        if(rockPlacement == RockPosition.LEFT && playerHit != true){
            if(pos.x <= x+blockSize/3){
                print("DANS DETECT COLL +++++++++++++++++++++++++++++++++++")
                playerHit = true
                player.decrementLifePoints()
            }
        }else  if(pos.x >= x+blockSize/2 &&  playerHit != true) {
            print("DANS DETECT COLL +++++++++++++++++++++++++++++++++++")
            playerHit = true
            player.decrementLifePoints()
        }
        return false
    }
}
