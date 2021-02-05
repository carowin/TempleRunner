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
    
    var mainRoad = [Block]() //stock le road principal(celle qu'on voit)
    var mainRoadLeft = [Block]()//road à gauche
    var mainRoadRight = [Block]()//road à droite
    var mainRoadDown = [Block]()//road en bas
    
    var tabObstacles = [Block]() //stock tous les obstacles dispo
    var obstacleInRoad = [Block]() //stock les obstacles qui sont utilisés pour le road
    var leftRoad : Block //pour le changement de direction gauche
    var rightRoad : Block //pour le changement de direction droite
    
    var height = UIScreen.main.bounds.height
    var width = UIScreen.main.bounds.width
    private let blockSize: CGFloat //hauteur du bloc
    let hei_dvid = 10 //nombre de bloc
    var wid_dvid = 3
    var screenOriginX : CGFloat?
    
    var view : GameView
    
    var chosenValue = 1 //1 chance sur 3 d'avoir un obstacle, valeur choisie pour le random
    var chosenValueIntersect = 1 //pour la génération de la rotation
    
    var intersectionPresent = false
    var intersectionBloc : Block
    
    var nbCoin = 0 //nombre de pièces sur le chemin
    var maxCoin = 5
    var coinEncCours = false //mettre une séquence de pièces
    var tabPos : [String]! // position de la première pièce d'une séquence
    
    
    init(view : UIView){
        self.view = view as! GameView
        blockSize = height/CGFloat(hei_dvid)
        screenOriginX = height-width

        /*------------------- Stockage et Créations des obstacles ---------------------*/

        for i in 0...2{
            tabObstacles.append(RoadRock(x:0 ,y:0 ,blockSize: blockSize))
            tabObstacles.append(RoadBranch(x:0 ,y:0 ,blockSize: blockSize))
            
            //ajout des sideRock
            if(i%2 == 0){
                tabObstacles.append(SideBranch(x:0 ,y: 0 ,blockSize: blockSize/3, rockPosition: RockPosition.LEFT))
            }else {
                tabObstacles.append(SideBranch(x:0 ,y: 0 ,blockSize: blockSize/3, rockPosition: RockPosition.RIGHT))
            }
        }
        
        /*------------------------ Initialisation du chemin ---------------------------*/
        var incrY = CGFloat(0)
        for _ in 0...hei_dvid{
            mainRoad.append(Block(x:width/3 ,y: (height-blockSize)-incrY,blockSize: blockSize))
            mainRoadLeft.append(IntersectionRoad(x:(screenOriginX!+width/3)-incrY ,y: height-2*width/3,blockSize: width/3))
            mainRoadRight.append(IntersectionRoad(x:screenOriginX!+2*width/3+incrY ,y: (height-2*width/3),blockSize: width/3))
            mainRoadDown.append(Block(x:screenOriginX!+width/3 ,y: (height-2*width/3)+incrY,blockSize: blockSize))
            incrY += blockSize
            
        }
        leftRoad = IntersectionRoad(x:-width/3,y:0 ,blockSize: width/3)
        rightRoad = IntersectionRoad(x:width/3 ,y:0 ,blockSize: width/3)
        intersectionBloc = leftRoad
    }
    
    
    /* ajout de chaques blocs du road dans la gameView */
    public func setRoad(){
        for i in 0...hei_dvid {
            mainRoad[i].setView(view:view)
            mainRoadLeft[i].setView(view:view.backgroundImage!)
            mainRoadRight[i].setView(view:view.backgroundImage!)
            mainRoadDown[i].setView(view:view.backgroundImage!)
        }
    }
    
    
    /* cache le road qui est passé en paramètre */
    public func hideRoad(road: [Block]){
        for bloc in road{
            bloc.baseView.isHidden = true
        }
    }
    
    
    /* cache le road qui est passé en paramètre */
    public func displayRoad(road: [Block]){
        for bloc in road{
            bloc.baseView.isHidden = false
        }
    }
    
    
    /* dans le cas d'une nouvelle partie on reset le road de départ ==>
            on retire tous les obstacles present sur le road */
    public func resetRoad(){
        self.removeObstacles()
        var incrY = CGFloat(height-blockSize)
        for bloc in mainRoad{
            bloc.obstaclePresent = false
            bloc.setPosY(y: incrY)
            incrY -= blockSize
            if bloc.coinPresent {
                bloc.coin?.removeCoin()
                bloc.changeCoinPresent(bool: false)
                nbCoin = 0
                coinEncCours = false
            }
        }
        intersectionPresent = false
        self.rightRoad.baseView.removeFromSuperview()
        self.leftRoad.baseView.removeFromSuperview()
        self.hideRoad(road: mainRoadLeft)
        self.hideRoad(road: mainRoadRight)
        self.hideRoad(road: mainRoadDown)
        isHidden(value: false)
    }
    
    
    /* Supprime tous les obstacles présents sur le road */
    public func removeObstacles(){
        if obstacleInRoad.count>0{
            for i in 0...obstacleInRoad.count-1{
                tabObstacles.append(obstacleInRoad[i])
                obstacleInRoad[i].baseView.removeFromSuperview()
            }
            obstacleInRoad.removeAll()
        }
    }

    
    /* cache le road principal */
    public func isHidden(value : Bool){
        for b in mainRoad {
            b.hideBlock(value : value)
        }
    }
    
    

    /* Fonction appelée dans GameView pour update le road affiché :
        On filtre les blocks sortis du cadre et on ajoute les obstacles.. par dessus */
    public func updateRoad(){
        if mainRoad.first!.y > height{ //sortis du cadre?
            mainRoad.first!.setPosY(y: -blockSize) //repositionne en haut
            let precedent = mainRoad.last //block qui précède le block courant
            let elem = mainRoad.removeFirst()
            mainRoad.append(elem)
            removeObstacleFromBloc(bloc: elem)
            if generateObstacle(bloc: elem) == false{
                self.generateIntersection(bloc: mainRoad.last!)
            }
            
            
            if elem.coinPresent { //si il y a une pièce sur le block qui va sortir le retirer
                elem.coin?.removeCoin()
                elem.changeCoinPresent(bool: false)
            }
            
            //vérifier s'il faut finir une séquence de Coin
            if coinEncCours {
                generateCoins(block: elem, pos : precedent!.position!)
            }
            
            //si il n'y a pas de séquence en cours et s'assurer que le block précédent n'a pas de pièce
            if !coinEncCours && !precedent!.coinPresent{
                
                let randomCoin = Int.random(in: 1...3) //commencer ou pas une séquence
                if randomCoin == 1{
                    nbCoin = 0
                    
                    //position de la pièce aléatoire
                    let randomPosition = Int.random(in: 1...3)
                    var pos = ""
                    if randomPosition == 1 {
                        pos = "gauche"
                    }
                    if randomPosition == 2 {
                        pos = "milieu"
                    }
                    if randomPosition == 3 {
                        pos = "droite"
                    }
                    
                    generateCoins(block: elem, pos : pos)
                    coinEncCours = true
                }
            }
        }
        
        for i in 0...(mainRoad.count-1){//pour chq elem de la road
            mainRoad[i].updatePosition(view : view)
        }
        if intersectionPresent == true{//cas où une intersection apparait
            hideBack(y: intersectionBloc.y)
        }
    }
    
    
    /* Génération des obstacles ==>
     On genere une valeur aléatoire, si cette valeur généré correspond à la valeur attendue alors:
            -on tire aléatoirement un obstacle dans notre tableau d'obstacle
            -on ajoute cet obstacle dans le tableau des obstacles utilisés */
    public func generateObstacle(bloc : Block) -> Bool{
        let randomObstacle = Int.random(in: 0...1)
        if randomObstacle==chosenValue && tabObstacles.count>0 {
            if mainRoad[mainRoad.count-2].obstaclePresent==false{//evite de placer 2 obstacles cote à cote
                let obst = tabObstacles.remove(at: Int.random(in: 0...(tabObstacles.count-1)))
                obstacleInRoad.append(obst)
                obst.setView(view: bloc.baseView)
                bloc.obstaclePresent = true
                return true
            }
        }
        return false
    }
    
    

    /* Génération de l'intersection ==>
        On genere aléatoirement les intersections ssi il n'y a pas d'obstacle present */
    public func generateIntersection(bloc : Block){
        let randomIntersection = Int.random(in: 0...6)
        if randomIntersection == chosenValue{
            if intersectionPresent == false{
                intersectionPresent = true
                self.leftRoad.setView(view: bloc.baseView)
                self.rightRoad.setView(view: bloc.baseView)
                intersectionBloc = bloc
            }
        }
    }
    

    public func generateCoins(block : Block, pos: String){
        block.position = pos // position de la pièce
        
        if  nbCoin < maxCoin {
            block.setCoin(position: pos)
            block.changeCoinPresent(bool : true)
            nbCoin += 1
        }
        
        if nbCoin == maxCoin {
            coinEncCours = false
        }
        
    }
    
  
    /* détecte une collision entre les obstacles et le joueur (appelée dans gameview) */
    public func detectCollision(player: Player){
        var res = false

        for obst in obstacleInRoad{//pour chaque obstacle présent
            res = obst.detectCollision(player: player)
            if res == true{//cas où collision
                player.setState(state: .LOSE)
            }
        }
        if leftRoad.detectCollision(player: player) || rightRoad.detectCollision(player: player){
            player.setState(state: .LOSE)
        }
    }
    
    
    public func detectionCoin(player : Player){
        for elem in mainRoad {
            if elem.coinPresent {
                //print("detection piece")
                if elem.coin!.detectionCoin(player: player, screenOriginX : screenOriginX!) {
                    elem.coin?.removeCoin()
                    elem.changeCoinPresent(bool: false)
                    MusicPlayer.shared.activateCollectCoinSound()
                }
            }
        }
    }

    
    /* retire l'obstable du bloc */
    public func removeObstacleFromBloc(bloc:Block){
        if bloc.obstaclePresent == true{//cas où le bloc contient un obstacle
            let obstF = obstacleInRoad.first
            obstF?.baseView.removeFromSuperview()
            obstacleInRoad.removeFirst()//on le retire du tableau
            tabObstacles.append(obstF!)//rajoute dans le tab de tous les obst
            bloc.obstaclePresent = false
        }
    }
    
    
    /* Effet de rotation de chemin */
    public func rotateRoad(player: Player){
        //le player peut rotate ssi sa position y se trouve dans le bloc d'intersection
        if intersectionBloc.y<player.getPosition().y && player.getPosition().y<intersectionBloc.y+width/3{
        var state = StatePlayer.RUNNING //sauvegarde de la derniere action du player
            self.displayRoad(road: mainRoadDown)
            self.displayRoad(road: mainRoadLeft)
            self.displayRoad(road: mainRoadRight)
            
            if player.getCurrentState() == .LEFT{ //cas où le joueur veut tourner à gauche
                state = .LEFT
                player.setIsTurning(value: true)
                UIView.animate(withDuration: 0.6, animations: {
                    self.hideRoad(road: self.mainRoad)
                    self.rightRoad.baseView.removeFromSuperview()
                    self.view.backgroundImage?.transform = (self.view.backgroundImage?.transform.rotated(by: .pi/2))!
                })
            }
            
            if player.getCurrentState() == .RIGHT{ //cas où le joueur veut tourner à droite
                state = .RIGHT
                player.setIsTurning(value: true)
                UIView.animate(withDuration: 0.6, animations: {
                    self.hideRoad(road: self.mainRoad)
                    self.leftRoad.baseView.removeFromSuperview()
                    self.view.backgroundImage?.transform = (self.view.backgroundImage?.transform.rotated(by: -.pi/2))!
                })
            }
            
            //timer appelé une fois que la rotation est terminée
            Timer.scheduledTimer(withTimeInterval: 0.6, repeats: false, block: {_ in
                self.resetRoad()
                player.setIsTurning(value: false)
                if state == .LEFT{
                    self.view.backgroundImage?.transform = (self.view.backgroundImage?.transform.rotated(by: -.pi/2))!
                }else{
                    self.view.backgroundImage?.transform = (self.view.backgroundImage?.transform.rotated(by: .pi/2))!
                }
            })
        }
    }

    
    /* appelée lorsqu'une intersection est generée, on cache les bloc se trouvant derriere cette intersection */
    private func hideBack( y : CGFloat){
        for b in mainRoad {
            if(b.y < y ){
                b.hideBlock(value: true)
            }
        }
    }

}
