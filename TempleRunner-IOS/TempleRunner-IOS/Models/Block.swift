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
    
    var coinPresent : Bool //signale la presence de pices sur le block
    var coin : Coin?
    
    init(x : CGFloat ,y : CGFloat , blockSize : CGFloat ) {
        id  =  Block.cptID
        Block.cptID += 1
        self.x=x
        self.y=y
        self.blockSize = blockSize
        coinPresent = false

        
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
        y = y + speed
        baseView.frame = CGRect(x: CGFloat(x), y: CGFloat(y), width: blockWidth/3, height: blockSize)
    }
    
    public func setPosY(y: CGFloat){
        self.y = y
        baseView.frame = CGRect(x: CGFloat(x), y: CGFloat(y), width: blockWidth/3, height: blockSize)
    }
    
    /* detection de collisions entre joueur et obstacle. On passe en parametre l'etat attendu selon
     l'obstacle détecté. On verifie si le joueur se trouve bien dans cet etat lorsqu'il rencontre cet obstacle*/
    public func detectCollision(player:Player, state: String) -> Bool{
        if y+blockSize/10<player.getPosition().y && player.getPosition().y<y+blockSize{
            if player.getCurrentState() != state{
                player.setState(state: "LOSE")
                return true
            }
        }
        return false
    }
    
    
    public func changeCoinPresent(bool : Bool){
        coinPresent = bool
    }
    
    
    public func  setCoin(position: String){
        coin = Coin(block: self, position: position)
    }
}
