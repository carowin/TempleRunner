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
    var x: Int
    var y: Int
    let blockSize : Int
    let blockWidth = UIScreen.main.bounds.width
    let baseImage = UIImage(named: "pave")
    var baseView : UIImageView!
    static var cptID = 0
    let id : Int
    var speed = 10
    
    var obstaclePresent : Bool //signal la presence d'obstacle sur le block
    var coinPresent : Bool //signale la presence de pices sur le block
    
    var tagId : Int //indique le tag de la view
    
    init(x : Int ,y : Int , blockSize : Int ) {
        id  =  Block.cptID
        Block.cptID += 1
        self.x=x
        self.y=y
        self.blockSize = blockSize
        obstaclePresent = false
        coinPresent = false
        tagId = 0
    }
    
    public func setView(view : UIView) {
        if(baseView == nil ){
         baseView = UIImageView(image: baseImage)
        }
        //test view avec tag
        baseView.tag = tagId
        tagId += 1
        
        baseView.frame = CGRect(x: x, y: y, width:Int(blockWidth/3), height: blockSize)
        view.addSubview(baseView)
    }
    
    public func hideBlock(value : Bool){
        baseView.isHidden=value
    }
    
    public func updatePosition(view : UIView){
        if(baseView == nil){
            self.setView(view : view)
        }
        y = y + speed
        baseView.frame = CGRect(x: x, y: y, width: Int(blockWidth/3), height: blockSize)
    }
    
    public func setPosY(y: Int){
        self.y = y
    }
    
    
    public func changeObstaclePresent(bool : Bool){
        obstaclePresent = bool
    }
    
    public func changeCoinPresent(bool : Bool){
        coinPresent = bool
    }
    
    
    
}
