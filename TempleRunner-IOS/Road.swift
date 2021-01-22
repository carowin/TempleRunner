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
    
    var chosenValue = 0 //1 chance sur 5 d'avoir un obstacle, valeur choisie pour le random
    
    init(view : UIView){
        self.view = view
        blockSize = height/hei_dvid
        var n = 0
        //mainRoad.append(SimpleRoad(x:width/3 ,y: -blockSize ,blockSize: blockSize))
        for _ in 0...2{
            tabObstacles.append(RoadRock(x:0 ,y: -blockSize,blockSize: blockSize))
        }
        for _ in 0...2{
            tabObstacles.append(RoadBranch(x:0 ,y: -blockSize,blockSize: blockSize))
        }
        for _ in 0...hei_dvid+1{
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
        print(tabObstacles.count)
        print(obstacleInRoad.count)
        for i in 0...mainRoad.count-1{
            if mainRoad[i].y > height{ //cas où block est sortie du cadre
                if(mainRoad[i].baseView.subviews.count != 0){
                    let obstacle = obstacleInRoad.remove(at: 0)
                    tabObstacles.append(obstacle)
                    obstacle.baseView.removeFromSuperview()
                }
                mainRoad[i].setPosY(y: -blockSize) //repositionne en haut
                let elem = mainRoad.remove(at: i)
                
                mainRoad.append(elem)
                if (mainRoad[mainRoad.count-2].baseView.subviews.count == 0){ //si le bloc d'avant n'a pas d'obstacle
                    generateObstacle(block: elem.baseView)
                }
            }
            mainRoad[i].updatePosition(view : view)
        }
    }
    
    
    /*
     Génération des obstacles ==>
     On genere une valeur aléatoire, si cette valeur généré correspond à la valeur attendue alors:
            -on tire aléatoirement un obstacle dans notre tableau d'obstacle
            -on ajoute cet obstacle dans le tableau indiquant l'ensemble des obstacles présents dans la road
            -on ajoute cette obstacle dans la vue du bloc et on la draw
     */
    public func generateObstacle(block: UIImageView){
        let randomObstacle = Int.random(in: 0...3)
        if randomObstacle == chosenValue {
            if( tabObstacles.count > 0){
                let getObstacle = tabObstacles.remove(at: Int.random(in: 0...(tabObstacles.count-1)))
                obstacleInRoad.append(getObstacle)
                getObstacle.setView(view: block)
            }
        }
    }
    
    //public func findBlock() -> Block {
        //TO DO
      
   // }
}
