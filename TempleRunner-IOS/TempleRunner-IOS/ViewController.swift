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
    @objc func displayGameViewFromFirstView(){
        firstView?.hideFirstView()
        gameView?.cleanGameView()
        gameView?.beginNewgame()
        gameView?.displayGameView()
    }

    
    /* Affichage du jeu lorsqu'on est sur la page de score ou de pause */
    @objc func displayGameViewFromScoreView(){
        if(firstView!.isHidden){
            var alert = UIAlertController( title:"End Game ?", message:"If you created a new game all your progress will be lost", preferredStyle: .alert)

            alert.addAction(UIAlertAction(title:"YES", style: .destructive, handler: {(action) in 
                self.removeScoreView()
                self.gameView?.cleanGameView()
                self.gameView?.beginNewgame()
            }))

            alert.addAction(UIAlertAction(title:"NO", style: .cancel, handler: {(action) in 
                // Do nothing
                return
            }))

            self.present(alert, animated:true, completion:nil)

        } else {
            self.removeScoreView()
            firstView?.hideFirstView()
            gameView?.cleanGameView()
            gameView?.beginNewgame()
            gameView?.displayGameView()
        }
    }
    
    /* Affichage la page des scores a partir de la first view  */
    @objc func displayScoreViewFromFirstView(){
        firstView?.displayFirstView()
        firstView?.blurFirstView()
        self.view.bringSubviewToFront(scoreView!)
        scoreModel?.updateScores()
        scoreView?.setLabelsOnFinishGame(lastScore : (scoreModel?.getCurrentScore())!, hightScore : (scoreModel?.getHightScore())!)
        scoreView?.displayScoreView()
        scoreView?.hideMainMenuButton()
        scoreView?.viewWillAppear()
        
    }

    /* Affichage la page des scores a partir de la game view  */
    @objc func displayScoreViewFromGameView() {
        gameView?.blurGameView()
        gameView?.beginPauseGame()
        self.view.bringSubviewToFront(scoreView!)
        scoreModel?.setCurrentScore(val:10000) // Mock, should set to gameModel.getCurrentScore()
        scoreModel?.setCurrentCoins(val:200) // Mock, should set to gameModel.getCurrentCoins()
        let currentScore = scoreModel?.getCurrentScore()
        let currentCoins = scoreModel?.getCurrentCoins()
        scoreView?.setLabelsOnPauseGame(currentScore : currentScore!, currentCoins : currentCoins!)
        scoreView?.displayScoreView()
        scoreView?.displayMainMenuButton()
        scoreView?.viewWillAppear()
    }

    /* Affichage la page principal  */
    @objc func displayFirstView(){
        removeScoreView()
        gameView?.hideGameView()
        firstView?.cleanFirstView()
        firstView?.displayFirstView()
    }

    /* Retire la page des scores  */
    @objc func removeScoreView(){
        if(firstView!.isHidden){
            gameView?.cleanGameView()
            gameView?.endPauseGame()
        } else {
            firstView?.cleanFirstView()
        }
        scoreView?.viewWillDisappear()
    }
    
    /* Sauvegarde le nouveau score dans la BDD */
    @objc func fetchScoreFromBDD(){
        scoreModel?.fetchScore()
        scoreView?.setLabelsOnFinishGame(lastScore : (scoreModel?.getCurrentScore())!, hightScore : (scoreModel?.getHightScore())!)
    }
    
    

}