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
    var mainRoad = [Block]()
    var height : Int
    var width : Int
    // pour diviser l'ecran et road
    let hei_dvid = 10
    var wid_dvid = 3
    var view : UIView
    private let blockSize: Int
    
    init(view : UIView){
        height = Int(view.frame.height)
        width = Int(view.frame.width)
        let part = (height/hei_dvid)
        blockSize = part
        self.view = view
        var n = 0
        var b = true
        mainRoad.append(SimpleRoad(x:width/3 ,y: -blockSize ,blockSize: part))
        while(n < height){
            print(mainRoad.count)
            if(!b){
                mainRoad.append(SimpleRoad(x:width/3 ,y: n,blockSize: part))
            }else{
                mainRoad.append(RoadRock(x:width/3 ,y: n,blockSize: part))
               b = false
            }
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
        let sizeBeffore = mainRoad.count
        
        mainRoad = mainRoad.filter{$0.y < height+$0.blockSize}
        
        let nb_add = sizeBeffore - mainRoad.count
        
       // print("nb-add " )
       // print(nb_add)
       // print("taille de la liste")
       // print(mainRoad.count)
        //print(mainRoad.capacity)
        if(sizeBeffore != mainRoad.count){
            for n in 0...nb_add{
                mainRoad.append(SimpleRoad(x:width/3 ,y: -blockSize, blockSize: blockSize))
            }
        }
        
        // scp -r -p TempleRunner.zip numet@ssh.ufr-info-p6.jussieu.fr:/users/Etu9/3524869/AAAA
        //update position
        print("dqsqd")
        for b in mainRoad {
            print(b.id,b.x,b.y)
            b.updatePosition(view : view)
        }
    }
    
    //public func findBlock() -> Block {
        //TO DO
      
   // }
}
