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
    
    init(x : CGFloat ,y : CGFloat , blockSize : CGFloat , rockPosition : RockPosition) {
        rockPlacement = rockPosition
        if(rockPlacement == RockPosition.LEFT){
            rocherImage = UIImage(named: "sidebranch")
        }else {
            rocherImage = UIImage(named: "branchdroite")
        }
        super.init(x: x, y: y, blockSize: blockSize)
      
        super.baseView = UIImageView(image: rocherImage)
    }
    
    override public func setView(view : UIView){
        super.setView(view: view)
    }
    
    public override func detectCollision(player:Player) -> Bool{
        let pos = player.getPosition()
        if y+blockSize/10<pos.y && pos.y<y+blockSize{
            if player.getCurrentState() == .JUMPING{
                return false
            }
            if(rockPlacement == RockPosition.LEFT){
                if(pos.x <= x+blockSize/3){
                    player.decrementLifePoints()
                }
            }else  if(pos.x >= x+blockSize/2) {
                player.decrementLifePoints()
            }
        }
        return false
    }
}
