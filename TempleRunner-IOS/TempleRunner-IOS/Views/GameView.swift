//
//  GameView.swift
//  TempleRunner-IOS
//
//  Created by m2sar on 04/01/2021.
//  Copyright © 2021 UPMC. All rights reserved.
//

import UIKit
import CoreMotion


/* Vue sur le jeu */
class GameView: UIView, UIGestureRecognizerDelegate {
    var vc: ViewController?
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    
    private let seaGif = [UIImage(named: "gameView_bckg/water-0"),UIImage(named: "gameView_bckg/water-1"),UIImage(named: "gameView_bckg/water-2"),UIImage(named: "gameView_bckg/water-3"),UIImage(named: "gameView_bckg/water-4"),UIImage(named: "gameView_bckg/water-5")] //creation d'un tableau d'image(pour inserer un gif)
    var backgroundImage : UIImageView? //image de fond du jeu
    
    private var scoreLabel : UILabel? // affichage score du joueur
    private var coinsLabel : UILabel? // affichage nombre de pieces récupéré
    private var tempoLabel = UILabel() // affiche la temporisation

    private var progressView : UIProgressView? //barre de progression du nombre de pieces récupérés

    private var cptTemporisation = 3 // compteur servant à la temporisation 

    private let clawDeathScreen = UIImageView(image:UIImage(named: "claw"))
    
    
    private var myPlayer = Player() //ajout d'un player dans le jeu
    private var myMonster = Monster() //ajout d'un monster dans le jeu
    
    private let cmMngr = CMMotionManager() //gestion du motion device
    
    private var updateTimer : Timer? //timer pour updater le jeu
    private var actionTime : Timer? //timer pour remettre le player en position run
    private var tempoTimer : Timer? //timer pour laisser 3 secondes avant de reprendre le jeu
    private var deathTimer : Timer? //timer pour laisser 1 secondes avant de quitter le jeu

    var pauseButton = UIButton(type: .custom) //bouton score
    var blurEffectView : UIVisualEffectView? // blur effect when score view is shown
    
    private var  road : Road?

    private var life = 2
    
    //pour savoir si le jeux est perdu
    private var isLost = false
    
    private var bigFrame : CGFloat
    
    private var actualCoinCharge : Float
    
    
    
    init(frame: CGRect, viewc: ViewController){
        self.vc = viewc
        bigFrame = 2*(height-width)+width
        actualCoinCharge=0
        super.init(frame: frame)
        
        backgroundImage = UIImageView(image: UIImage.animatedImage(with: seaGif as! [UIImage], duration: 2.0))
        
        progressView = UIProgressView(progressViewStyle: .bar)
        progressView!.progress = 0.1 //attention max progressView=1 (incrémentation: +0.1)
        progressView!.progressViewStyle = .bar
        progressView!.backgroundColor = .lightGray
        progressView!.progressTintColor = UIColor.yellow

        var sizeFontNumeric : CGFloat = 30.0;
        if (UIDevice.current.userInterfaceIdiom == .phone && UIScreen.main.bounds.width > 412){
            sizeFontNumeric = 40.0
        }else if (UIDevice.current.userInterfaceIdiom == .pad ){
            sizeFontNumeric = 50.0
        }
        
        scoreLabel = UILabel()
        scoreLabel?.createCustomLabel(text:String(myPlayer.getCurrentScore()), sizeFont:sizeFontNumeric)
        scoreLabel?.textColor = .white
        
        coinsLabel = UILabel()
        coinsLabel?.createCustomLabel(text:String(myPlayer.getCurrentCoinsScore()), sizeFont:sizeFontNumeric)
        coinsLabel?.textColor = .white

        tempoLabel.createCustomLabel(text:String(cptTemporisation), sizeFont: sizeFontNumeric*1.5)
        tempoLabel.layer.borderColor = UIColor.black.cgColor
        tempoLabel.layer.borderWidth = 5.0
        tempoLabel.layer.cornerRadius = 10
        tempoLabel.layer.backgroundColor = UIColor.darkGray.cgColor
        tempoLabel.alpha = 0.8
        tempoLabel.isHidden = true
        
        //__________________ gestion des mouvements du joueur __________________
        myPlayer.hidePlayer()
        myMonster.hideMonster()
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(swipeHandler(sender:)))
        swipeDown.direction = .down
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(swipeHandler(sender:)))
        swipeUp.direction = .up
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeHandler(sender:)))
        swipeLeft.direction = .left
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeHandler(sender:)))
        swipeRight.direction = .right
        swipeDown.delegate = self
        swipeUp.delegate = self
        swipeLeft.delegate = self
        swipeRight.delegate = self
        self.addGestureRecognizer(swipeDown)
        self.addGestureRecognizer(swipeUp)
        self.addGestureRecognizer(swipeLeft)
        self.addGestureRecognizer(swipeRight)
        
        cmMngr.startAccelerometerUpdates()
        cmMngr.startDeviceMotionUpdates()
        road = Road(view: self)
        //__________________ fin gestion des mouvements du joueur __________________


        pauseButton.createCustomButton(title:"PAUSE", width: (width/3.5))
        pauseButton.addTarget(self.superview, action: #selector(vc!.displayScoreViewFromGameView), for: .touchUpInside)

        let blurEffect = UIBlurEffect(style: .dark)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView?.frame = self.bounds
        blurEffectView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView?.isHidden = true
        clawDeathScreen.isHidden = true
        
        self.addSubview(backgroundImage!)
        road?.setRoad()
        self.addSubview(myPlayer.getView())
        self.addSubview(myMonster.getView())
        self.addSubview(progressView!)
        self.addSubview(scoreLabel!)
        self.addSubview(coinsLabel!)
        self.addSubview(tempoLabel)
        self.addSubview(pauseButton)
        self.addSubview(blurEffectView!)
        self.addSubview(clawDeathScreen)
        
        //gestion de la double tape
        let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        tap.numberOfTapsRequired = 2
        self.addGestureRecognizer(tap)
        
        
        
        self.drawInSize(frame)
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //methode qui detecte le type de swipe qui a été effectué
    @objc func swipeHandler(sender : UISwipeGestureRecognizer){
        if sender.direction == .down { //down=joueur glisse
            actionTime = Timer.scheduledTimer(timeInterval: 1.2, target: self, selector: #selector(resetRunningMode), userInfo: nil, repeats: false)
            myPlayer.setState(state: .SLIDING)
        }
        if sender.direction == .up { // up=joueur saute
            actionTime = Timer.scheduledTimer(timeInterval: 1.2, target: self, selector: #selector(resetRunningMode), userInfo: nil, repeats: false)
            myPlayer.setState(state: .JUMPING)
        }
        if sender.direction == .left { //left=tourne à gauche
            actionTime = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(resetRunningMode), userInfo: nil, repeats: false)
            myPlayer.setState(state: .LEFT)
            road?.rotateRoad(player: myPlayer)
        }
        if sender.direction == .right { //right=tourne à droite
            actionTime = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(resetRunningMode), userInfo: nil, repeats: false)
            myPlayer.setState(state: .RIGHT)
            road?.rotateRoad(player: myPlayer)
        }
    }
    
    /* appelé par le timer pour mettre le player et le monster en position running */
    @objc func resetRunningMode(){
        actionTime!.invalidate()
        myPlayer.setState(state: .RUNNING)
        myMonster.setState(state: .RUNNING)
    }

    
    /* fonction update appelé toute les 0.1sec, gère l'avancé du jeu */
    @objc func update(){

        myPlayer.incrementScore() //incrémentation du score (1points/ms à changer peut être)
        scoreLabel!.text = String(myPlayer.getCurrentScore())
        coinsLabel!.text = String(myPlayer.getCurrentCoinsScore())
         setProgressBar(amount : 1)


        self.updatePosMonster()
       
        if cmMngr.deviceMotion !== nil {
            let newX = myPlayer.getPosition().x + CGFloat(12*(cmMngr.deviceMotion?.gravity.x)!)
            //A changer avec la limite de la route
            if width/3<newX && newX<2*width/3 {
                myPlayer.setPosX(val: newX)
            }
        }
        // update roade
        road?.updateRoad()
        road?.detectCollision(player: myPlayer)
        road?.detectionCoin(player: myPlayer)

        if(myPlayer.getCurrentState() == .LOSE){
            //clawDeathScreen.isHidden = false
            updateTimer?.invalidate()
            myMonster.hideMonster()
            Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.stopGame), userInfo: nil, repeats: false)    
        } else if (myPlayer.getCurrentState() == .KILL){
            clawDeathScreen.isHidden = false
            updateTimer?.invalidate()
            myMonster.hideMonster()
            Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.stopGame), userInfo: nil, repeats: false)    
        }

        //mise en place du joueur au dessu si nul ça fait boum

        self.bringSubviewToFront(myPlayer.getView())
        self.bringSubviewToFront(myMonster.getView())

        self.bringSubviewToFront(tempoLabel)
        self.bringSubviewToFront(blurEffectView!)
        self.bringSubviewToFront(clawDeathScreen)
    }

    /* fionction qui démarre le jeu */
    func beginNewgame() {
        updateTimer?.invalidate()
        tempoTimer?.invalidate()
        myPlayer.resetScore()
        myPlayer.resetCoinsScore()
        myPlayer.resetLifePoints()
        scoreLabel?.text = String(myPlayer.getCurrentScore())
        coinsLabel?.text = String(myPlayer.getCurrentCoinsScore())
        myMonster.setPosY(val:17*height/18)
        myMonster.resetTransform()
        clawDeathScreen.isHidden = true
        road?.resetRoad()
        myPlayer.displayPlayer()
        myMonster.displayMonster()
        myPlayer.setState(state: .PAUSE)
        myMonster.setState(state: .PAUSE)
        cptTemporisation = 3
        tempoLabel.text = String(cptTemporisation)
        tempoTimer =  Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(temporisation), userInfo: nil, repeats: true)
        tempoLabel.isHidden = false
    }
    
    /* fonction appelé pour stopper le jeu*/
    @objc func stopGame(){
        //TO BE COMPLETED
        cmMngr.stopAccelerometerUpdates()
        cmMngr.stopDeviceMotionUpdates()
        self.hideGameView()
        vc?.displayScoreViewFromFirstView()
    }

    /* fonction applé pour pauser le jeu */
    func beginPauseGame (){
        updateTimer?.invalidate()
        tempoTimer?.invalidate()
        myPlayer.setState(state: .PAUSE)
        myMonster.setState(state: .PAUSE)
    }

    /* fonction applé pour pauser le jeu */
    func endPauseGame (){
        tempoTimer?.invalidate()
        cptTemporisation = 3
        tempoLabel.text = String(cptTemporisation)
        tempoTimer =  Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(temporisation), userInfo: nil, repeats: true)
        tempoLabel.isHidden = false
    }

    /* fonction de temporisation avant de reprendre le jeu aprés pause */
    @objc func temporisation() {
        if(cptTemporisation == 0) {
            tempoTimer!.invalidate()
            tempoLabel.isHidden = true
            cptTemporisation = 3
            tempoLabel.text = String(cptTemporisation)  
            myPlayer.setState(state: .RUNNING)
            myMonster.setState(state: .RUNNING)
            self.vc?.scoreView?.hideScoreView()
            updateTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        } else {
            cptTemporisation-=1
            tempoLabel.text = String(cptTemporisation)
        }
    }

    
    /* fonction appelé par le viewController pour afficher la vue du jeu */
    func displayGameView() {
        self.isHidden = false
        backgroundImage!.isHidden = false
        progressView?.isHidden = false
        scoreLabel?.isHidden = false
        coinsLabel?.isHidden = false
        pauseButton.isHidden = false
        road?.isHidden(value : false)

    }
    
    /* fonction appelé par le viewController pour cacher la vue du jeu */
    func hideGameView() {
        updateTimer?.invalidate()
        tempoTimer?.invalidate()
        self.isHidden = true
        backgroundImage!.isHidden = true
        myPlayer.hidePlayer()
        myMonster.hideMonster()
        progressView?.isHidden = true
        scoreLabel?.isHidden = true
        coinsLabel?.isHidden = true
        pauseButton.isHidden = true
        road?.isHidden(value : true)
    }

    func blurGameView (){
        self.blurEffectView?.isHidden = false
    }

    func cleanGameView (){
        self.blurEffectView?.isHidden = true
    }

     func updatePosMonster(){
        if(myPlayer.getLifePoints() == 2){

            myMonster.setPosY(val:height)

        } else if(myPlayer.getLifePoints() == 1){
            UIView.animate(withDuration: 1, animations: {
                self.myMonster.translateImage(val:-1*self.height/18)
            }) { _ in
                self.myMonster.setPosY(val:17*self.height/18)
            }

        } else {
            UIView.animate(withDuration: 1, animations: {
                self.myMonster.translateImage(val:-3*self.height/18)
            }) { _ in
                
                self.myPlayer.setState(state: .KILL)
                self.myMonster.resetTransform()
            }
        }
    }
    
    func getPlayer() -> Player {
        return myPlayer
    }
    
    
    /* fonction appelé pour dessiner la game view */
    func drawInSize(_ frame : CGRect){
        var top = 25
        
        //cas où c'est un iphone X ou supérieur
        if(UIDevice.current.userInterfaceIdiom == .phone && UIScreen.main.bounds.height >= 812) {
            top = 32
        }else if (UIDevice.current.userInterfaceIdiom == .pad ){
            top = 75
        }

        self.updatePosMonster()

        backgroundImage!.frame = CGRect(x:-(height-width), y:0, width:bigFrame, height:bigFrame)
        progressView?.frame = CGRect(x: 0, y: top+Int(width/4), width: Int(width/4), height: 10)
        progressView?.transform = .init(rotationAngle: .pi/2*(-1))
        scoreLabel?.frame = CGRect(x:Int(4*width/5), y:top, width: Int(width/4), height: top)
        coinsLabel?.frame = CGRect(x:Int(4*width/5), y:2*top+10, width: Int(width/4), height: top)
        tempoLabel.frame = CGRect(x:Int(width/2-width/6), y:Int(height/2-width/6), width: Int(width/3), height: Int(width/3))
        pauseButton.frame = CGRect(x:Int(3.5*width/5), y: Int(9*height/10), width : Int(width/3.5), height: 50)
        clawDeathScreen.frame =  CGRect(x:0, y: 0, width : width, height: height)
    }
    
    //__________________ GestureRecognizer DELEGATE __________________
    
    //permet de désactiver les swipes lorsqu'on ne joue pas encore
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if myPlayer.getCurrentState() == .PAUSE || myPlayer.getCurrentState() == .LOSE{
            return false
        }
        return true
    }
    
    // gestionDoubleTape
    @objc func doubleTapped() {
        //print(actualCoinCharge)
        if(actualCoinCharge >= 100.0){
            actualCoinCharge = 0
            progressView?.progress=0
        }
    }
    
    //------------------ Gestion de l'activation du super pouvoir -----------------------------------
    /** a la division car ont doit ajouter a chaque ajout d'une piece il
*/
    public func setProgressBar(amount :Float){
        actualCoinCharge = actualCoinCharge + amount
        progressView?.setProgress( actualCoinCharge/100, animated: true)
    }
}
