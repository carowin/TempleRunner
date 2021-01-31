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
    
    override public func setView(view : UIView){
        super.setView(view: view)
    }
    
    /* détecte si le joueur a dépassé l'intersection */
    public override func detectCollision(player:Player) -> Bool{
        if player.getPosition().y<y{
            player.setState(state: .LOSE)
            return true
        }
        return false
    }
}
