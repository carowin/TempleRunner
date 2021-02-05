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
    var block : Block
    var position : String
    var coinView : UIImageView!
    
    init(block : Block, position : String) {
        self.coinView = UIImageView (image: coinImage)
        self.block = block
        
        if position == "gauche" {
            self.coinView.frame = CGRect(x: 0, y: 0, width: block.blockSize/3, height: block.blockSize/3)
        }
        if position == "milieu" {
            self.coinView.frame = CGRect(x: (block.blockWidth/3)/2 - (block.blockSize/3)/2, y: 0, width: block.blockSize/3, height: block.blockSize/3) //blockSize ?
        }
        if position == "droite" {
            //print("coin : blocksize = ", block.blockSize, "blockW = ", block.blockWidth)

            self.coinView.frame = CGRect(x: block.blockWidth/3 - block.blockSize/3, y: 0, width: block.blockSize/3, height: block.blockSize/3)
        }
        
        self.position = position
        block.baseView.addSubview(self.coinView)
        
    }
    
    public func removeCoin(){
        self.coinView.removeFromSuperview()
    }
    
    public func detectionCoin(player: Player, screenOriginX : CGFloat , gameView : GameView) -> Bool{
        var posY : CGFloat
        var posX : CGFloat

        if block.baseView.superview != nil{
            posY = block.y - block.blockSize/3 // détection trop tôt à corriger !
            posX = block.x
            
            let playerG = player.getPosition().x - player.getView().frame.width/2
            let playerD = player.getPosition().x + player.getView().frame.width/2
            
            if posY < player.getPosition().y && player.getPosition().y < posY+block.blockSize{

                //détection même quand pas possible à gauche 
                
                if self.position == "gauche" && playerG < posX + block.blockSize/3 {
                    print("COORD PIECE : ", posX,",",  posX + block.blockSize/3 )
                    print("cote gauche du joueur", playerG)
                    gameView.incrementCoinsScore()

                    print("detection piece gauche score =", player.getCurrentScore())
                    return true
                }
                
                
                if self.position == "milieu" && playerG < posX + (block.blockSize/2 + block.blockSize/3)  &&  posX + (block.blockSize/2) < playerD {
                    print("detection piece milieu score =", player.getCurrentScore())
                    gameView.incrementCoinsScore()

                    
                    return true
                }
                
                if self.position == "droite" && playerG < (block.blockWidth/3) && posX + ( block.blockWidth/3 - block.blockSize/3) <  playerD {
                    print("detection piece droite score =", player.getCurrentScore())
                    gameView.incrementCoinsScore()

                    return true
                }
            }
        }
        return false
    }
    
}
