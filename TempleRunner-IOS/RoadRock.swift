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
    override init(x : Int ,y : Int , blockSize : Int ) {
        super.init(x: x, y: y, blockSize: blockSize)
    }
    
   override public func setView(view : UIView){
        super.baseView = UIImageView(image: rocherImage)
        super.setView(view: view)
    }
}