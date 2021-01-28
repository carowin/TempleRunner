//
//  RoadCoin.swift
//  TempleRunner-IOS
//
//  Created by m2sar on 21/01/2021.
//  Copyright © 2021 UPMC. All rights reserved.
//

import Foundation
import UIKit

class Coin {
    
    let coinImage = UIImage(named: "coin")
    
    var position : String
    var coinView : UIImageView!
    
    init(block : Block, position : String) {
        self.coinView = UIImageView (image: coinImage)
        
        if position == "gauche" {
            self.coinView.frame = CGRect(x: 0, y: 0, width: block.blockSize/3, height: block.blockSize/3)
        }
        if position == "milieu" {
            self.coinView.frame = CGRect(x: block.blockSize * 1/3, y: 0, width: block.blockSize/3, height: block.blockSize/3)
        }
        if position == "droite" {
            self.coinView.frame = CGRect(x: block.blockSize * 2/3, y: 0, width: block.blockSize/3, height: block.blockSize/3)
        }
        self.position = position
        block.baseView.addSubview(self.coinView)
    }

    public func removeCoin(){
        self.coinView.removeFromSuperview()
    }
    
}
