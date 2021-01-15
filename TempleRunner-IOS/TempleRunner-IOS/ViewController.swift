//
//  ViewController.swift
//  TempleRunner-IOS
//
//  Created by m2sar on 04/01/2021.
//  Copyright © 2021 UPMC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var gameView: GameView?
    var chatView: ChatView?
    var scoreView: ScoreView?
    var firstView: FirstView?

    var scoreModel : ScoreModel?
    
    
    let screenSize = UIScreen.main.bounds
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chatView = ChatView(frame: screenSize, viewc: self)
        scoreView = ScoreView(frame: screenSize, viewc: self)
        gameView = GameView(frame: screenSize, viewc: self)
        firstView = FirstView(frame: screenSize, viewc: self)

        scoreModel = ScoreModel()
        
        self.view.addSubview(chatView!)
        self.view.addSubview(scoreView!)
        self.view.addSubview(gameView!)
        self.view.addSubview(firstView!)
        
        chatView?.hideChatView()
        scoreView?.hideScoreView()
        gameView?.hideGameView()
        firstView?.displayFirstView()
    }
    
    /* Affichage du jeu lorsqu'on est sur la page d'accueil */
    @objc func displayGameView(){
        firstView?.hideFirstView()
        scoreView?.hideScoreView()
        gameView?.displayGameView()
    }
    
    /* Affichage la page des scores  */
    @objc func displayScoreView(){
        firstView?.blurFirstView()
        self.view.bringSubviewToFront(scoreView!)
        scoreView?.displayScoreView()
        scoreView?.viewWillAppear()
        
    }

    /* Retire la page des scores  */
    @objc func removeScoreView(){
        firstView?.cleanFirstView()
        scoreView?.viewWillDisappear()
        scoreView?.hideScoreView()
        self.view.sendSubviewToBack(scoreView!)
    }
    
    /* Sauvegarde le nouveau score dans la BDD */
    @objc func saveScoreToBDD(){
        // TO DO
    }
    
    

}