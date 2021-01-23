//
//  Road.swift
//  TempleRunner-IOS
//
//  Created by m2sar on 14/01/2021.
//  Copyright © 2021 UPMC. All rights reserved.
//

import Foundation
import UIKit

/*
 Génération du chemin, le principe est le suivant :
    Au départ on crée le nombre d'obstacles que l'ont souhaite utiliser elles seront placées hors de l'écran, lorsqu'on les utilisera on les fera descendre
    Puis lorsque le jeu commence, on set la mainRoad.
    Dès qu'un bloc sort de la vue du jeu alors on le replace en haut en dehors de la vue de l'app
 */
class Road {
    var mainRoad = [Block]() // stock le road affiché
    var tabObstacles = [Block]() //Stocke tous les obstacles que l'on souhaite utiliser
    var obstacleInRoad = [Block]() //stock tous les obstacles qui sont sur le road
    var height = Int(UIScreen.main.bounds.height)
    var width = Int(UIScreen.main.bounds.width)
    // pour diviser l'ecran et road
    let hei_dvid = 10 //nombre de bloc
    var wid_dvid = 3
    var view : UIView
    private let blockSize: Int //hauteur du bloc
    
    var chosenValue = 5 //1 chance sur 5 d'avoir un obstacle, valeur choisie pour le random
    
    init(view : UIView){
        self.view = view
        blockSize = height/hei_dvid
        var n = 0
        mainRoad.append(SimpleRoad(x:width/3 ,y: -blockSize ,blockSize: blockSize))
        for _ in 0...1{
            tabObstacles.append(RoadRock(x:0 ,y: -blockSize,blockSize: blockSize))
        }
        while(n < height){
            mainRoad.append(SimpleRoad(x:width/3 ,y: n,blockSize: blockSize))
            n+=blockSize
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
        //Filtrage des block sortie du cadre et ajout des block par dessus
        for i in 0...mainRoad.count-1{
            if mainRoad[i].y > height{ //cas où block est sortie du cadre
                mainRoad[i].setPosY(y: -blockSize) //repositionne en haut
                let elem = mainRoad.remove(at: i)
                mainRoad.append(elem)
                generateObstacle(block: elem.baseView)
            }
            mainRoad[i].updatePosition(view : view)
        }
    }
    
    //permet de genérer des obstacles
    public func generateObstacle(block : UIImageView){
        let randomObstacle = Int.random(in: 0...8) // 1 chance sur 10 d'avoir un obstacle
        if randomObstacle == chosenValue { //peut générer l'obstacle
            if( tabObstacles.count > 0){//si il y a encore des obstacles dispo
                //on enleve l'obstacle
                let getObstacle = tabObstacles.remove(at: Int.random(in: 0...(tabObstacles.count-1)))
                obstacleInRoad.append(getObstacle) //indique que getObstacle a été généré sur le chemin
                getObstacle.setView(view: block)
            }
        }
    }
    
    //public func findBlock() -> Block {
        //TO DO
      
   // }
}
