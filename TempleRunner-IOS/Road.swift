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
    
    var tabRoadCoin = [Block]() //stock les pièces
    var nbCoin = 0 //nombre de pièces sur le chemin
    var maxCoin = 5
    
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
        for _ in 0...maxCoin{
            tabRoadCoin.append(RoadCoin(x:0 ,y: -blockSize,blockSize: blockSize))
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
                //remove ou hide les pièces ?
                
                //elem.baseView.isHidden = true
                mainRoad.append(elem)
                //generateObstacle(block: elem.baseView)
                generateCoin(block: elem.baseView, i : i)
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
    
    
    
    public func generateCoin(block : UIImageView, i : Int){
        //s'il n'y a pas d'obstacle alors essayer de mettre des pièces

        /*
        //s'il n'y a pas de pièce que le block qui va apparaitre
        if !mainRoad[i].coinPresent && nbCoin < maxCoin {
            let randomCoin = Int.random(in: 0...3)
            if randomCoin == 3 {
                
                tabRoadCoin[0].setView(view: block)
                nbCoin += 1
                
            }
        }
        
        
        //si le block qui va apparaitre a une piece et qu'il faut encore en faire apparaitre
        if mainRoad[0].coinPresent && nbCoin < maxCoin {
            tabRoadCoin[0].setView(view: block)
            nbCoin += 1
        }
        */
        //print("nbCoin = " + String(nbCoin))//toujours à 5 mais toujours des pièces visible en boucle
        
        let randomObstacle = Int.random(in: 0...3)
        
        //NO : hide tout !!!
        if !mainRoad[i].baseView.isHidden {
            mainRoad[i].baseView.isHidden = true
        }
        
        
        if  nbCoin < maxCoin {
            let getCoin = tabRoadCoin.remove(at: 0)
            //CoinInRoad.append(getCoin)
            getCoin.setView(view: block)
            
            mainRoad[i].changeCoinPresent() //signaler qu'il y a une piece sur le block
            nbCoin += 1
            /*
            //réinitialiser
            if(nbCoin == 5 ){
                nbCoin = 0
            }*/
        }
        
        if mainRoad[i].coinPresent {
            
        }
        
        
        
        
    }
    
    
    //public func findBlock() -> Block {
        //TO DO
      
   // }
}
