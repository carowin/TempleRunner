//
//  Block.swift
//  TempleRunner-IOS
//
//  Created by m2sar on 14/01/2021.
//  Copyright © 2021 UPMC. All rights reserved.
//

import Foundation
import UIKit

class Block {
    var x: CGFloat
    var y: CGFloat
    let blockSize : CGFloat
    let blockWidth = UIScreen.main.bounds.width
    let baseImage = UIImage(named: "pave")
    var baseView : UIImageView!
    static var cptID = 0
    let id : Int
    var speed = CGFloat(10)
    
    var obstaclePresent : Bool //signale la presence d'obstacle sur le block
    
    init(x : CGFloat ,y : CGFloat , blockSize : CGFloat ) {
        id  =  Block.cptID
        Block.cptID += 1
        self.x=x
        self.y=y
        self.blockSize = blockSize
        obstaclePresent = false
    }
    
    public func setView(view : UIView){
        if(baseView == nil ){
         baseView = UIImageView(image: baseImage)
        }
        baseView.frame = CGRect(x: x, y: y, width:blockWidth/3, height: blockSize)
        view.addSubview(baseView)
    }
    
    public func hideBlock(value : Bool){
        baseView.isHidden=value
    }
    
    public func updatePosition(view : UIView){
        if(baseView == nil){
            self.setView(view : view)
        }
        y = incrementSpeed(y: y)
        baseView.frame = CGRect(x: CGFloat(x), y: CGFloat(y), width: blockWidth/3, height: blockSize)
    }
    
    public func setPosY(y: CGFloat){
        self.y = y
        baseView.frame = CGRect(x: CGFloat(x), y: CGFloat(y), width: blockWidth/3, height: blockSize)
    }
    
    public func detectCollision(player:Player) -> Bool{
        return true
    }
    
    public func incrementSpeed(y : CGFloat) -> CGFloat {
        switch CurrentDifficulty.getDiff() {
        case .EASY:
            return y + 10
        case .MEDIUM:
            return y + 20
        case .HARD:
            return y + 30
        default:
            return y + 40
        }
        
    }
    
}
