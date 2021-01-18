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
    let x: Int
    var y: Int
    let blockSize : Int
    let baseImage = UIImage(named: "pave")
    var baseView : UIImageView!
    static var cptID = 0
    let id : Int
    var speed = 10
    
    init(x : Int ,y : Int , blockSize : Int ) {
        id  =  Block.cptID
        Block.cptID += 1
        self.x=x
        self.y=y
        self.blockSize = blockSize
    }
    
    public func setView(view : UIView){
        if(baseView == nil ){
         baseView = UIImageView(image: baseImage)
        }
       baseView.frame = CGRect(x: x, y: y, width: blockSize, height: blockSize)
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
        baseView.frame = CGRect(x: x, y: y, width: blockSize, height: blockSize)
    }
    
}
