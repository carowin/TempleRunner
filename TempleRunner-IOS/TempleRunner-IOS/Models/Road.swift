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
    var screenOriginX : CGFloat
    
    var view : GameView
    
    var chosenValue = 1 //1 chance sur 5 d'avoir un obstacle, valeur choisie pour le random
    var chosenValueIntersect = 1 //pour la génération de la rotation
    
    var isIntersecting = false
    
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
            mainRoad.append(Block(x:screenOriginX+width/3 ,y: (height-blockSize)-incrY,blockSize: blockSize))
            incrY += blockSize
            
        }
 
        leftRoad = IntersectionRoad(x:screenOriginX,y: -width/3,blockSize: width/3)
        rightRoad = IntersectionRoad(x:screenOriginX+2*width/3 ,y: -width/3,blockSize: width/3)
    }
    
    
    /* ajout de chaques blocs du road dans la gameView */
    public func setRoad(){
        for i in 0...hei_dvid {
            mainRoad[i].setView(view:view.backgroundImage!)
        }
    }
    
    public func hideRoad(road: [Block]){
        for bloc in road{
            bloc.baseView.isHidden = true
        }
    }
    
    public func displayRoad(road: [Block]){
        for bloc in road{
            bloc.baseView.isHidden = false
        }
    }

    
    public func setSideRoad(){
        leftRoad.setView(view: view.backgroundImage!)
        rightRoad.setView(view: view.backgroundImage!)
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
        }
        leftRoad.setPosY(y: -width/3)
        rightRoad.setPosY(y: -width/3)
        isHidden(value: false)
    }
    
    
    /* Supprime tous les obstacles présent sur le road */
    public func removeObstacles(){
        if obstacleInRoad.count>0{
            for i in 0...obstacleInRoad.count-1{
                tabObstacles.append(obstacleInRoad[i])
                obstacleInRoad[i].baseView.removeFromSuperview()
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
    
    

    /* Fonction appelée dans GameView pour update le road affiché */
    public func updateRoad(){
        //Filtrage des block sortie du cadre et ajout des block par dessus
        if mainRoad.first!.y > height{ //sortis du cadre?
            mainRoad.first!.setPosY(y: -blockSize) //repositionne en haut
            let elem = mainRoad.removeFirst()
            mainRoad.append(elem)
            removeObstacleFromBloc(bloc: elem)
            if generateObstacle(bloc: elem) == false{
                isIntersecting = true
            }
        }
        for i in 0...(mainRoad.count-1){//pour chq elem de la road
            mainRoad[i].updatePosition(view : view)
        }
        
       /* if isIntersecting == true{
            leftRoad.updatePosition(view: view.backgroundImage!)
            rightRoad.updatePosition(view: view.backgroundImage!)
            hideBack(y: leftRoad.y)
        }*/
 
    }
    
    
    /* Génération des obstacles ==>
     On genere une valeur aléatoire, si cette valeur généré correspond à la valeur attendue alors:
            -on tire aléatoirement un obstacle dans notre tableau d'obstacle
            -on ajoute cet obstacle dans le tableau des obstacles utilisés */
    public func generateObstacle(bloc : Block) -> Bool{
        let randomObstacle = Int.random(in: 0...5)
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
    
    public func removeObstacleFromBloc(bloc:Block){
        if bloc.obstaclePresent == true{//cas où le bloc contient un obstacle
            let obstF = obstacleInRoad.first
            obstF?.baseView.removeFromSuperview()
            obstacleInRoad.removeFirst()//on le retire du tableau
            tabObstacles.append(obstF!)//rajoute dans le tab de tous les obst
            bloc.obstaclePresent = false
        }
    }

    
    private func hideBack( y : CGFloat){
        for b in mainRoad {
            if(b.y < y ){
                b.hideBlock(value: true)
            }
        }
    }

}
