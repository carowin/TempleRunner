//
//  RoadCoin.swift
//  TempleRunner-IOS
//
//  Created by m2sar on 21/01/2021.
//  Copyright © 2021 UPMC. All rights reserved.
//

import Foundation
import UIKit

class RoadCoin : Block {
    
    let coinImage = UIImage(named: "coin")
    
    override init(x : Int ,y : Int , blockSize : Int ) {
        super.init(x: x, y: y, blockSize: blockSize)
        //super.baseView.frame = CGRect(x: x, y: y, width: Int(super.blockWidth), height: blockSize)
        super.baseView = UIImageView(image: coinImage)
        
    }
    
    override public func setView(view : UIView){
        super.setView(view: view)
    }
    
}
