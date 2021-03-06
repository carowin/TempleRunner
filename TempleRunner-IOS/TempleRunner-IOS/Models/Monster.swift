//
//  Monster.swift
//  TempleRunner-IOS
//
//  Created by m2sar on 20/01/2021.
//  Copyright © 2021 UPMC. All rights reserved.
//

import Foundation
import UIKit

/* classe donnant des informations sur le monstre */
class Monster {
    private var monster : UIImageView?
    private var posX : CGFloat? //position X du monstre
    private var posY : CGFloat? //position Y du monstre
    //état courant du joueur ["RUNNING","PAUSE"]
    private var state :  StateMonster?

    
    //----------------------- gestion des images du monstre -----------------------
    private let monsterRunGif = [UIImage(named: "monsterLeft"),UIImage(named: "monsterCenter"),UIImage(named: "monsterRight")]//gif du monstre en train de courir
    private let monsterRun : UIImage? ///image du monstre qui court
    private let monsterPaused = UIImage(named: "monsterCenter")

    
    init() {
        monsterRun = UIImage.animatedImage(with: monsterRunGif as! [UIImage], duration: 0.4)
        self.state = .RUNNING
        monster = UIImageView(image: UIImage.animatedImage(with: monsterRunGif as! [UIImage], duration: 0.4))
        monster?.isHidden = false
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        let imageWidth = width/2.5
        let imageHeight = height/4.5
        posX = width/2 - imageWidth/2
        posY = height-(100+imageHeight)  //17*height/18
        monster!.frame =  CGRect(x:posX!, y: posY!, width : imageWidth, height: imageHeight)
    }
    
    
    //----------------------- GETTER -----------------------
    
    func getCurrentState() -> StateMonster {
        return state!
    }

    func getImage() -> UIImage {
        return monster!.image!
    }
    
    /* retourne un tuple (x,y) representant la position du monstre(centre)*/
    func getPosition() -> (x:CGFloat, y:CGFloat) {
        return (posX!,posY!)
    }
    
    func getView() -> UIImageView {
        return monster!
    }
    
    
    //----------------------- SETTER -----------------------
    
    func setPosY(val:CGFloat){
        self.posY = val
        monster!.center.y = posY!
    }

    func translateImage(val:CGFloat){
        monster?.transform = CGAffineTransform(translationX:0, y: val)
    }

    func resetTransform(){
        monster?.transform = .identity
    }

    
    
    /*appelée pour changer l'etat du joueur, et l'image associée */
    func setState(state:StateMonster){
        self.state = state
        switch state{
        case .RUNNING:
            monster!.image! = monsterRun!
        case .PAUSE:
            monster!.image! = monsterPaused!
        default:
            monster!.image! = monsterRun!
        }
    }
    
    
    /* cache le monstre  */
    func hideMonster(){
        monster!.isHidden = true
    }
    
    /* affiche le monstre */
    func displayMonster(){
        monster!.isHidden = false
    }
    
    /* ajout du monstre dans la game view et positionne le monstre */
    func addToView(view : UIView){
        view.addSubview(monster!)
    }
}