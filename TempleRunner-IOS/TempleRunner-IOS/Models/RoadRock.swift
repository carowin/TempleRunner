//
//  RoadRock.swift
//  TempleRunner-IOS
//
//  Created by m2sar on 14/01/2021.
//  Copyright © 2021 UPMC. All rights reserved.
//

import Foundation
import UIKit
class RoadRock : Block {
    let rocherImage = UIImage(named: "rocher")
    override init(x : CGFloat ,y : CGFloat , blockSize : CGFloat ) {
        super.init(x: x, y: y, blockSize: blockSize)
        super.baseView = UIImageView(image: rocherImage)
    }
    
   override public func setView(view : UIView){
        baseView.frame = CGRect(x: x, y: y, width:blockWidth/3, height: blockSize)
        view.addSubview(baseView)
    }
    
    public override func detectCollision(player:Player) -> Bool{
        var posY:CGFloat
        if super.baseView.superview != nil{
            posY = (super.baseView.superview?.frame.origin.y)!
            if posY<player.getPosition().y && player.getPosition().y<posY+blockSize{
                if player.getCurrentState() != .JUMPING{
                    //print(posY-blockSize," < ", player.getPosition().y," < ",posY)
                    player.setState(state: .LOSE)
                    return true
                }
            }
        }
        return false
    }
}
