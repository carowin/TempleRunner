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
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    
    private var player : UIImageView?
    private var posX : CGFloat? //position X du player
    private var posY : CGFloat? //position Y du player
    //état courant du joueur ["RUNNING","JUMPING","SLIDING","LEFT","RIGHT","PAUSE","LOSE"]
    private var state : StatePlayer?

    //état courant des domages du joueur ["NORMAL","NODAMAGE"]
    private var modeDamage : ModeDamagePlayer?

    private var score = 0 //score actuel du joueur
    private var lifePoints = 2 // niveau de vie du joueur
    
    private var isTurning = false
    
    //----------------------- gestion des images du player -----------------------
    private let playerRunGif = [UIImage(named: "playerMouvement/playerRun1"),UIImage(named: "playerMouvement/playerRun2")]//gif du joueur en train de courir
    private let playerRun : UIImage? ///image du joueur qui court
    private let playerJump = UIImage(named: "playerMouvement/playerJump")//image du joueur qui saute
    private let playerSlide = UIImage(named: "playerMouvement/playerSlide")//image du joueur qui glisse
    private let playerLeft = UIImage(named: "playerMouvement/playerLeft")//image du joueur tourne à gauche
    private let playerRight = UIImage(named: "playerMouvement/playerRight")//image du joueur tourne à droite
    private let playerPaused = UIImage(named: "playerMouvement/playerRun1")//image du joueur en pause
    private let playerLose = UIImage(named: "playerMouvement/playerLose")//image du joueur en paus
    
    // ----------------- creation d'un identifiant unique pour chaque mobile --------

    let urlFetch = "http://templerunnerppm.pythonanywhere.com/chat/fetchNewUsersID"
    struct Response: Codable {
        let value: String
    }


    private let rep = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)


    init() {
        self.state = .RUNNING
        playerRun = UIImage.animatedImage(with: playerRunGif as! [UIImage], duration: 0.5)
        
        
        player = UIImageView(image: UIImage.animatedImage(with: playerRunGif as! [UIImage], duration: 0.4))
        posX = width/2
        posY = height - width/2
        player!.center = CGPoint(x: posX!, y: posY!)

        self.tryToFindIdentifier()

        if (Identifier.getId() == ""){
            print("Fetch id")
            self.fetchIdentifier()
        } else {
            print("Already there")
        }


    }

    func tryToFindIdentifier() {
        let thePath = rep[0] + "/backup"
        if FileManager.default.fileExists(atPath: thePath) {
            print("File exist")
            let data = FileManager.default.contents(atPath: thePath)
            if data != nil {
                print("Not null")
                do {
                    print(data)
                    let decoder = try NSKeyedUnarchiver(forReadingFrom: data!)
                    decoder.requiresSecureCoding = false
                    let d = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data!) as? Identifier
                    print("value d : %s", d?.aString)
                    Identifier.setId(s:d!.aString)
                } catch {
                    print("error could not read file in directory !!")
                }
                
            }
        }
    }

    func saveIdentifier(){
        let d = Identifier(s: Identifier.getId())
        let thePath = rep[0] + "/backup"
        let coder = NSKeyedArchiver(requiringSecureCoding: false)
        coder.encode(d, forKey: NSKeyedArchiveRootObjectKey)
        FileManager.default.createFile(atPath: thePath, contents: coder.encodedData, attributes: [:])
    }

    func fetchIdentifier() {
        let task = URLSession.shared.dataTask(with: URL(string:urlFetch)!, completionHandler: {data, response, error in 
            if let error = error {
                print("Error accessing url: \(error)")
                return
            }     

            guard let httpResponse = response as? HTTPURLResponse,(200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(response)")
                return
            }  

            var result: Response?

            do {
                result = try JSONDecoder().decode(Response.self, from: data!)
            }
            catch {
                print("enable to parse data")
            }

            guard let json = result else {
                print("data is nil")
                return 
            }
            print(json.value)
            Identifier.setId(s:json.value)
            self.saveIdentifier()
        })

        task.resume()
    }
    
    
    //----------------------- GETTER -----------------------
    func getCurrentScore() -> Int {
        return score
    }

    
    func getCurrentState() -> StatePlayer {
        return state!
    }

    func getCurrentDamageMode() ->  ModeDamagePlayer {
        return modeDamage!
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
    
    func playerTurning() -> Bool {
        return isTurning
    }
    
    
    //----------------------- SETTER -----------------------
    func incrementScore() {
        score = score + 1
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

    func setDamageMode(mode: ModeDamagePlayer){
        self.modeDamage = mode
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
        case .KILL:
            player!.image! = playerLose!
        default:
            player!.image! = playerRun!
        }
    }
    
    func setIsTurning(value: Bool){
        isTurning = value
    }
    
    func resetScore(){
        self.score = 0
    }
    
    func resetLifePoints(){
        self.lifePoints = 2
    }
    
    func resetPosition(){
        self.posX = width/2
        self.posY = height - width/2
        player!.center.x = posX!
        player!.center.y = posY!
    }
    
    
    /* cache le player  */
    func hidePlayer(){
        player!.isHidden = true
    }
    
    /* affiche le player */
    func displayPlayer(){
        player!.isHidden = false
    }

    /* sert à faire clignoter le player */
    @objc func blinkPlayer(){
        player!.isHidden =  !(player!.isHidden) 
    }
    
    /* ajout du player dans la game view et positionne le player */
    func addToView(view : UIView){
        view.addSubview(player!)
    }
}
