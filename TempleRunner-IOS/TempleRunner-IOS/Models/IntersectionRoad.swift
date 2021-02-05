//
//  IntersectionRoad.swift
//  TempleRunner-IOS
//
//  Created by m2Sar on 28/01/2021.
//  Copyright © 2021 UPMC. All rights reserved.
//

import Foundation
import UIKit


class IntersectionRoad : Block {
    let rocherImage = UIImage(named: "sidePave")
    override init(x : CGFloat ,y : CGFloat , blockSize : CGFloat ) {
        super.init(x: x, y: y, blockSize: blockSize)
        super.baseView = UIImageView(image: rocherImage)
    }
    
    public override func setView(view : UIView){
        super.setView(view: view)
    }
    
    
    /* détecte si le joueur a dépassé l'intersection (2 cas):
        si le joueur depasse l'intersection alors il a perdu.
        s'il dépasse un petit peu mais qu'il est en train de changer de road alors la collision n'est pas détectée
     */
    public override func detectCollision(player:Player) -> Bool{
        
        if super.baseView.superview != nil{
            let posY = (super.baseView.superview?.frame.origin.y)!
            
            if player.getPosition().y<posY{
                if player.playerTurning() == true{
                    return false
                }
                player.setState(state: .LOSE)
                return true
            }
        }
        return false
    }
}
