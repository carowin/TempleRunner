//
//  Road.swift
//  TempleRunner-IOS
//
//  Created by m2sar on 14/01/2021.
//  Copyright © 2021 UPMC. All rights reserved.
//

import Foundation
import UIKit

class Road {
    var mainRoad = [Block]() // stock les simpleroad
    var tabRoadRock = [Block]() // nombre de bloc dans le road
    var height : Int
    var width : Int
    // pour diviser l'ecran et road
    let hei_dvid = 10
    var wid_dvid = 3
    var view : UIView
    private let blockSize: Int //hauteur du bloc
    
    init(view : UIView){
        height = Int(view.frame.height)
        width = Int(view.frame.width)
        let part = (height/hei_dvid)
        blockSize = part
        self.view = view
        var n = 0
        mainRoad.append(SimpleRoad(x:width/3 ,y: -blockSize ,blockSize: part))
        for _ in 0...2{
            tabRoadRock.append(RoadRock(x:width/3 ,y: -blockSize,blockSize: part))
        }
        while(n < height){
            mainRoad.append(SimpleRoad(x:width/3 ,y: n,blockSize: part))
            n+=part
        }
    }
    
    public func setRoad(){
        for b in mainRoad {
            b.setView(view: view)
        }
    }
    
    public func isHidden(value : Bool){
        for b in mainRoad {
            b.hideBlock(value : value)
        }
    }
    
    //eventuelement ajouter une vitesse par la suite
    public func updateRoad(){
        //Filtrage des block sortie du cadre et ajout des block par dessu
        // la condition est inversé dans les filter swift , Think diffrent
        for i in 0...mainRoad.count-1{
           if mainRoad[i].y > height{
                mainRoad[i].setPosY(y: -blockSize)
                var elem = mainRoad.remove(at: i)
            
            // generation obstacle en fonction d'une valeur random
                let randomRock = Int.random(in: 0...4)
                if randomRock == 3 {
                    
                }
                mainRoad.append(elem)
            }
            mainRoad[i].updatePosition(view : view)
        }
    }
    
    //public func findBlock() -> Block {
        //TO DO
      
   // }
}
