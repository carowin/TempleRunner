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
    var backgroundImage : UIImageView? //image de fond du jeu
    
    private var scoreLabel : UILabel? // affichage score du joueur
    private var coinsLabel : UILabel? // affichage nombre de pieces récupéré
    private var progressView : UIProgressView? //barre de progression du nombre de pieces récupérés
    
    private var myScore = 0 //score du joueur (TEMPORAIRE, peut être faire une classe Joueur)
    private var scoreCoins = 0 //nb coins recolté (TEMPORAIRE, peut être faire une classe Joueur)
    
    var updateTimer : Timer? //timer pour updater le jeu
    
    init(frame : CGRect, viewc : ViewController){
        self.vc = viewc
        super.init(frame: frame)
    
        backgroundImage = UIImageView(image: UIImage(named: "image_game_background"))
        
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
        
        self.addSubview(backgroundImage!)
        self.addSubview(progressView!)
        self.addSubview(scoreLabel!)
        self.addSubview(coinsLabel!)
        
        self.drawInSize(frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /* fonction update appelé toute les 0.1sec, gère l'avancé du jeu */
    @objc func update(){
        myScore += 1 //incrémentation du score (1points/ms à changer peut être)
        scoreLabel?.text = String(myScore)
    }

    
    /* fonction appelé par le viewController pour afficher la vue du jeu */
    func displayGameView() {
        updateTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        backgroundImage!.isHidden = false
        progressView?.isHidden = false
        scoreLabel?.isHidden = false
        coinsLabel?.isHidden = false
    }
    
    /* fonction appelé par le viewController pour cacher la vue du jeu */
    func hideGameView() {
        updateTimer?.invalidate()
        backgroundImage!.isHidden = true
        progressView?.isHidden = true
        scoreLabel?.isHidden = true
        coinsLabel?.isHidden = true
    }
    
    /* fonction appelé pour dessiner la game view */
    func drawInSize(_ frame : CGRect){
        let width = frame.size.width
        let height = frame.size.height
        var top = 5
        
        //cas où c'est un iphone X ou supérieur
        if(UIDevice.current.userInterfaceIdiom == .phone && UIScreen.main.bounds.height >= 812) {
            top = 40
        }
        
        backgroundImage!.frame = CGRect(x: 0, y: 0, width: width, height: height)
        progressView?.frame = CGRect(x: 0, y: top+Int(width/4), width: Int(width/4), height: 10)
        progressView?.transform = .init(rotationAngle: .pi/2*(-1))
        scoreLabel?.frame = CGRect(x:Int(4*width/5), y:top, width: Int(width/4), height: 20)
        coinsLabel?.frame = CGRect(x:Int(4*width/5), y:top+30, width: Int(width/4), height: 20)
    }
}
