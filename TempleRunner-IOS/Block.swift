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
    let pos: Int
    let blockSize : Int
    let screenY : Int
    let baseImage = UIImage(named: "pave")
    var baseView : UIImageView!
    init(pos : Int , blockSize : Int , screenY : Int  ) {
        self.pos=pos
        self.blockSize = blockSize
        self.screenY = screenY
    }
    
    public func setView(view : UIView){
        baseView = UIImageView(image: baseImage)
        baseView.frame = CGRect(x: pos, y: 50, width: blockSize, height: blockSize)
        view.addSubview(baseView)
    }
    
}
