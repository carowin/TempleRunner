//
//  SideRock.swift
//  TempleRunner-IOS
//
//  Created by m2sar on 28/01/2021.
//  Copyright © 2021 UPMC. All rights reserved.
//

import Foundation
import UIKit
class SideRock : Block {
    
    let rocherImage = UIImage(named: "sidebranch")
    let rockPlacement : RockPosition
    
    init(x : CGFloat ,y : CGFloat , blockSize : CGFloat , rockPosition : RockPosition) {
        rockPlacement = rockPosition
        super.init(x: x, y: y, blockSize: blockSize)
        if(rockPlacement == RockPosition.LEFT){
            // ajouter par dessu non ?
            
        }else {
            // ajouter par dessu non ?
            
        }
        super.baseView = UIImageView(image: rocherImage)
    }
    
    override public func setView(view : UIView){
        super.setView(view: view)
    }
    
    public override func detectCollision(player:Player) -> Bool{
        
        
         if(player.getCurrentDamageMode() == .NODAMAGE){
            return false
        }
        
        let pos = player.getPosition()
        //print(pos)
        //print(x)
        //print (y)
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
