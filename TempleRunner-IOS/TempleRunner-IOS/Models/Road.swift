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
    
    var mainRoad = [Block]() //stock le road pavé de base
    var tabObstacles = [Block]() //stock tous les obstacles dispo
    var obstacleInRoad = [Block]() //stock les obstacles qui sont utilisés pour le road
    var height = UIScreen.main.bounds.height
    var width = UIScreen.main.bounds.width
    // pour diviser l'ecran et road
    let hei_dvid = 10 //nombre de bloc
    var wid_dvid = 3
    var view : UIView
    private let blockSize: CGFloat //hauteur du bloc
    
    var chosenValue = 3 //1 chance sur 5 d'avoir un obstacle, valeur choisie pour le random

    
    var tabRoadCoin = [Coin]() //stock les pièces
    var nbCoin = 0 //nombre de pièces sur le chemin
    var maxCoin = 5
    var coinEncCours = true //mettre une séquence de pièces
    
    private var timerCoin : Timer? // quand rappeler les pièces 
    
    init(view : UIView){
        self.view = view
        blockSize = height/CGFloat(hei_dvid)
        var incrY = CGFloat(0)
        /*------------------- Stockage et Créations des obstacles ---------------------*/
        for _ in 0...2{
            //tabObstacles.append(RoadRock(x:CGFloat(0) ,y: -blockSize ,blockSize: blockSize))
            tabObstacles.append(RoadRock(x:width/3 ,y: -blockSize ,blockSize: blockSize))
        }
        for _ in 0...2{
            //tabObstacles.append(RoadBranch(x:CGFloat(0) ,y: -blockSize ,blockSize: blockSize))
            tabObstacles.append(RoadBranch(x:width/3 ,y: -blockSize ,blockSize: blockSize))
        }
        
        /*------------------------ Initialisation du chemin ---------------------------*/
        for _ in 0...hei_dvid{
            mainRoad.append(SimpleRoad(x:width/3 ,y: CGFloat(incrY),blockSize: blockSize))
            incrY += blockSize
        }
    }
    
    
    /* ajout de chaques blocs du road dans la gameView */
    public func setRoad(){
        for b in mainRoad {
            b.setView(view: view)
        }
    }
    
    /* ajout des obstacles dans la gameView */
    public func setObstacles(){
        for obst in tabObstacles{
            obst.setView(view: view)
        }
    }
    
    /* dans le cas d'une nouvelle partie on reset le road de départ ==>
            on retire tous les obstacles present sur le road et on les replace en dehors de l'écran*/
    public func resetRoad(){
        if obstacleInRoad.count>0{
            for i in 0...obstacleInRoad.count-1{
                obstacleInRoad[i].setPosY(y: -blockSize)
                tabObstacles.append(obstacleInRoad[i])
            }
            obstacleInRoad.removeAll()
        }
    }
    
    /* cache le road */
    public func isHidden(value : Bool){
        for b in mainRoad {
            b.hideBlock(value : value)
        }
    }
    
    
    //eventuelement ajouter une vitesse par la suite
    /* Fonction appelée dans GameView pour update le road affiché */
    public func updateRoad(){
        //Filtrage des block sortie du cadre et ajout des block par dessus
        for i in 0...mainRoad.count-1{//pour chq elem de la road
            if mainRoad[i].y > height{ //sortis du cadre?
                mainRoad[i].setPosY(y: -blockSize) //repositionne en haut
                let elem = mainRoad.remove(at: i)
                mainRoad.append(elem)
                generateObstacle()
                
                if elem.coinPresent { //si il y a une pièce sur le block qui va sortir nettoyer
                    elem.coin?.removeCoin()
                    elem.changeCoinPresent(bool: false)
                }
                
                if coinEncCours { //vérifier si il faut finir une séquence de Coin
                    generateCoins(block: elem)
                }
                
                var tmp = i - 1
                if tmp == -1 {
                    tmp = mainRoad.count - 1
                }
                
                //si il n'y a pas de séquence et s'assurer qu'il y a bien un écart entre 2 séquences de coins
                if !coinEncCours && !mainRoad[tmp].coinPresent {
                    
                    let randomCoin = Int.random(in: 0...10)
                    print("random" + String(randomCoin))
                    
                    if randomCoin == 1{
                        nbCoin = 0
                        generateCoins(block: elem)
                        coinEncCours = true
                        
                    }
                }
                
            }
            mainRoad[i].updatePosition(view : view)
        }
        if obstacleInRoad.count>0{
            let obstF = obstacleInRoad.first
            if(obstF!.y > height){//sortis du cadre?
                obstF?.setPosY(y: -blockSize)//repositionne en haut
                obstacleInRoad.remove(at: 0)//on le retire du tableau
                tabObstacles.append(obstF!)//rajoute dans le tab de tous les obst
            }
            for obst in obstacleInRoad{
                obst.updatePosition(view: view)
            }
        }
    }
    
    
    /* Génération des obstacles ==>
     On genere une valeur aléatoire, si cette valeur généré correspond à la valeur attendue alors:
            -on tire aléatoirement un obstacle dans notre tableau d'obstacle
            -on ajoute cet obstacle dans le tableau des obstacles utilisés */
    public func generateObstacle(){
        let randomObstacle = Int.random(in: 0...5)
        if randomObstacle==chosenValue && tabObstacles.count>0 {
            if (obstacleInRoad.count>0 && obstacleInRoad.last!.y>blockSize) || (obstacleInRoad.count==0){
                let obst = tabObstacles.remove(at: Int.random(in: 0...(tabObstacles.count-1)))
                obstacleInRoad.append(obst)
            }
        }
    }
    
    public func generateCoins(block : Block){
            if  nbCoin < maxCoin && nbCoin != -1{
                let randomPosition = Int.random(in: 0...2)
                if randomPosition == 0 {
                    block.setCoin(position: "gauche")
                }
                if randomPosition == 1 {
                    block.setCoin(position: "milieu")
                }
                if randomPosition == 2 {
                    block.setCoin(position: "droite")
                }
                
            
                block.changeCoinPresent(bool : true)
                nbCoin += 1
            }
        
            if nbCoin == maxCoin {
                nbCoin = -1
                coinEncCours = false
            }
        
    }
    
    /* détecte une collision entre les obstacles et le joueur (appelée dans gameview) */
    public func detectCollision(player: Player){
        var res = false
        for obst in obstacleInRoad{//pour chaque obstacle présent
            if ((obst as? RoadRock) != nil) {//c'est un rock
                res = obst.detectCollision(player: player, state: "JUMPING")
            } else if ((obst as? RoadBranch) != nil) {//c'est une branche
                res = obst.detectCollision(player: player, state: "SLIDING")
            }
            /*
            if res == true{//cas où collision
                let v = view as! GameView
                v.stopGame()
            }*/
        }
    }
    
    //public func findBlock() -> Block {
        //TO DO
      
   // }
}
