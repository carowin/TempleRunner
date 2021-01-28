//
//  Player.swift
//  TempleRunner-IOS
//
//  Created by m2sar on 20/01/2021.
//  Copyright © 2021 UPMC. All rights reserved.
//

import Foundation
import UIKit

/* classe donnant des informations sur le joueur */
class Player {
    private var player : UIImageView?
    private var posX : CGFloat? //position X du player
    private var posY : CGFloat? //position Y du player
    //état courant du joueur ["RUNNING","JUMPING","SLIDING","LEFT","RIGHT","PAUSE","LOSE"]
    private var state : StatePlayer?
    private var score = 0 //score actuel du joueur
    private var coinsScore = 0 //nombre de pièces récupérés
    private var lifePoints = 2 // niveau de vie du joueur

    
    //----------------------- gestion des images du player -----------------------
    private let playerRunGif = [UIImage(named: "playerMouvement/playerRun1"),UIImage(named: "playerMouvement/playerRun2")]//gif du joueur en train de courir
    private let playerRun : UIImage? ///image du joueur qui court
    private let playerJump = UIImage(named: "playerMouvement/playerJump")//image du joueur qui saute
    private let playerSlide = UIImage(named: "playerMouvement/playerSlide")//image du joueur qui glisse
    private let playerLeft = UIImage(named: "playerMouvement/playerLeft")//image du joueur tourne à gauche
    private let playerRight = UIImage(named: "playerMouvement/playerRight")//image du joueur tourne à droite
    private let playerPaused = UIImage(named: "playerMouvement/playerRun1")//image du joueur en pause
    private let playerLose = UIImage(named: "playerMouvement/playerLose")//image du joueur en paus
    
    
    init() {
        self.state = .RUNNING
        playerRun = UIImage.animatedImage(with: playerRunGif as! [UIImage], duration: 0.5)
        
        player = UIImageView(image: UIImage.animatedImage(with: playerRunGif as! [UIImage], duration: 0.4))
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        posX = width/2
        posY = height - width/3
        player!.center = CGPoint(x: posX!, y: posY!)
    }
    
    
    //----------------------- GETTER -----------------------
    func getCurrentScore() -> Int {
        return score
    }
    
    func getCurrentCoinsScore() -> Int {
        return coinsScore
    }
    
    func getCurrentState() -> StatePlayer {
        return state!
    }

    func getImage() -> UIImage {
        return player!.image!
    }

    func getLifePoints() -> Int {
        return lifePoints
    }
    
    /* retourne un tuple (x,y) representant la position du player(centre)*/
    func getPosition() -> (x:CGFloat, y:CGFloat) {
        return (posX!,posY!)
    }
    
    func getView() -> UIImageView {
        return player!
    }
    
    
    //----------------------- SETTER -----------------------
    func incrementScore() {
        score = score + 1
    }
    
    func incrementCoinsScore() {
        coinsScore = coinsScore + 1
    }

     func decrementLifePoints() {
        if(lifePoints != 0){
            lifePoints = lifePoints - 1
        }
    }
    
    func setPosX(val:CGFloat){
        self.posX = val
        player!.center.x = posX!
    }

    
    
    /*appelée pour changer l'etat du joueur, et l'image associée */
    func setState(state:StatePlayer){
        self.state = state
        switch state{
        case .RUNNING:
            player!.image! = playerRun!
        case .JUMPING:
            player!.image! = playerJump!
        case .SLIDING:
            player!.image! = playerSlide!
        case .LEFT:
            player!.image! = playerLeft!
        case .RIGHT:
            player!.image! = playerRight!
        case .PAUSE:
            player!.image! = playerPaused!
        case .LOSE:
            player!.image! = playerLose!
        default:
            player!.image! = playerRun!
        }
    }
    
    func resetScore(){
        self.score = 0
    }
    
    func resetCoinsScore(){
        self.coinsScore = 0
    }

    func resetLifePoints(){
        self.lifePoints = 2
    }
    
    
    /* cache le player  */
    func hidePlayer(){
        player!.isHidden = true
    }
    
    /* affiche le player */
    func displayPlayer(){
        player!.isHidden = false
    }
    
    /* ajout du player dans la game view et positionne le player */
    func addToView(view : UIView){
        view.addSubview(player!)
    }
}
