//
//  GameView.swift
//  TempleRunner-IOS
//
//  Created by m2sar on 04/01/2021.
//  Copyright © 2021 UPMC. All rights reserved.
//

import UIKit


/* Vue sur le jeu */
class GameView: UIView {
    var vc: ViewController?
    
    let seaGif = [UIImage(named: "gameView_bckg/water-0"),UIImage(named: "gameView_bckg/water-1"),UIImage(named: "gameView_bckg/water-2"),UIImage(named: "gameView_bckg/water-3"),UIImage(named: "gameView_bckg/water-4"),UIImage(named: "gameView_bckg/water-5")] //creation d'un tableau d'image(pour inserer un gif)
    var backgroundImage : UIImageView? //image de fond du jeu
    
    private var scoreLabel : UILabel? // affichage score du joueur
    private var coinsLabel : UILabel? // affichage nombre de pieces récupéré
    private var progressView : UIProgressView? //barre de progression du nombre de pieces récupérés
    
    private var myScore = 0 //score du joueur (TEMPORAIRE, peut être faire une classe Joueur)
    private var scoreCoins = 0 //nb coins recolté (TEMPORAIRE, peut être faire une classe Joueur)
    
    
    let playerRunGif = [UIImage(named: "playerMouvement/playerRun1"),UIImage(named: "playerMouvement/playerRun2")]//gif du joueur en train de courir
    var playerRun : UIImage? //image joueur qui cours
    let playerJump = UIImage(named: "playerMouvement/playerJump")//image du joueur qui saute
    let playerSlide = UIImage(named: "playerMouvement/playerSlide")//image du joueur qui glisse
    let playerLeft = UIImage(named: "playerMouvement/playerLeft")//image du joueur tourne à gauche
    let playerRight = UIImage(named: "playerMouvement/playerRight")//image du joueur tourne à droite
    var playerImage : UIImageView? //icone du joueur
    
    
    var updateTimer : Timer? //timer pour updater le jeu
    var actionTime : Timer? //timer pour remettre le player en position run
    
    
    
    init(frame : CGRect, viewc : ViewController){
        self.vc = viewc
        super.init(frame: frame)
    
        backgroundImage = UIImageView(image: UIImage.animatedImage(with: seaGif as! [UIImage], duration: 2.0))
        
        progressView = UIProgressView(progressViewStyle: .bar)
        progressView!.progress = 0.1 //attention max progressView=1 (incrémentation: +0.1)
        progressView!.progressViewStyle = .bar
        progressView!.backgroundColor = .lightGray
        progressView!.progressTintColor = UIColor.yellow
        
        scoreLabel = UILabel()
        scoreLabel?.text = String(myScore)
        scoreLabel?.font = .boldSystemFont(ofSize: 25)
        scoreLabel?.textColor = .white
        
        coinsLabel = UILabel()
        coinsLabel?.text = String(scoreCoins)
        coinsLabel?.font = .boldSystemFont(ofSize: 25)
        coinsLabel?.textColor = .white
        
        //__________________ gestion des mouvements du joueur __________________
        playerRun = UIImage.animatedImage(with: playerRunGif as! [UIImage], duration: 0.5)
        playerImage = UIImageView(image: UIImage.animatedImage(with: playerRunGif as! [UIImage], duration: 0.4))
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(swipeHandler(sender:)))
        swipeDown.direction = .down
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(swipeHandler(sender:)))
        swipeUp.direction = .up
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeHandler(sender:)))
        swipeLeft.direction = .left
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeHandler(sender:)))
        swipeRight.direction = .right
        //__________________ fin gestion des mouvements du joueur __________________
        
        self.addSubview(backgroundImage!)
        self.addSubview(playerImage!)
        self.addSubview(progressView!)
        self.addSubview(scoreLabel!)
        self.addSubview(coinsLabel!)
        
        self.addGestureRecognizer(swipeDown)
        self.addGestureRecognizer(swipeUp)
        self.addGestureRecognizer(swipeLeft)
        self.addGestureRecognizer(swipeRight)
        
        self.drawInSize(frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //methode qui detecte le type de swipe qui a été effectué
    @objc func swipeHandler(sender : UISwipeGestureRecognizer){
        print("swipe detect")
        if sender.direction == .down { //down=joueur glisse
            actionTime = Timer.scheduledTimer(timeInterval: 0.8, target: self, selector: #selector(resetRunningMode), userInfo: nil, repeats: false)
            playerImage?.image = playerSlide
        }
        if sender.direction == .up { // up=joueur saute
            actionTime = Timer.scheduledTimer(timeInterval: 0.8, target: self, selector: #selector(resetRunningMode), userInfo: nil, repeats: false)
            playerImage?.image = playerJump
        }
        if sender.direction == .left { //left=tourne à gauche
            actionTime = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(resetRunningMode), userInfo: nil, repeats: false)
            playerImage?.image = playerLeft
        }
        if sender.direction == .right { //right=tourne à droite
            actionTime = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(resetRunningMode), userInfo: nil, repeats: false)
            playerImage?.image = playerRight
        }
    }
    
    /* appelé par le timer pour mettre le player en position running */
    @objc func resetRunningMode(){
        actionTime!.invalidate()
        playerImage?.image = playerRun
    }
    
    /* fonction update appelé toute les 0.1sec, gère l'avancé du jeu */
    @objc func update(){
        myScore += 1 //incrémentation du score (1points/ms à changer peut être)
        scoreLabel?.text = String(myScore)
    }

    
    /* fonction appelé par le viewController pour afficher la vue du jeu */
    func displayGameView() {
        updateTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        self.isHidden = false
        backgroundImage!.isHidden = false
        playerImage?.isHidden = false
        progressView?.isHidden = false
        scoreLabel?.isHidden = false
        coinsLabel?.isHidden = false
    }
    
    /* fonction appelé par le viewController pour cacher la vue du jeu */
    func hideGameView() {
        updateTimer?.invalidate()
        self.isHidden = true
        backgroundImage!.isHidden = true
        playerImage?.isHidden = true
        progressView?.isHidden = true
        scoreLabel?.isHidden = true
        coinsLabel?.isHidden = true
    }
    
    /* fonction appelé pour dessiner la game view */
    func drawInSize(_ frame : CGRect){
        let width = frame.size.width
        let height = frame.size.height
        var top = 25
        
        //cas où c'est un iphone X ou supérieur
        if(UIDevice.current.userInterfaceIdiom == .phone && UIScreen.main.bounds.height >= 812) {
            top = 40
        }
        backgroundImage!.frame = CGRect(x: 0, y: 0, width: width, height: height)
        playerImage?.center = CGPoint(x: width/2, y: 4*height/6)
        progressView?.frame = CGRect(x: 0, y: top+Int(width/4), width: Int(width/4), height: 10)
        progressView?.transform = .init(rotationAngle: .pi/2*(-1))
        scoreLabel?.frame = CGRect(x:Int(4*width/5), y:top, width: Int(width/4), height: 20)
        coinsLabel?.frame = CGRect(x:Int(4*width/5), y:top+30, width: Int(width/4), height: 20)
    }
}
