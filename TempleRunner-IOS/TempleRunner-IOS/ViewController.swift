//
//  ViewController.swift
//  TempleRunner-IOS
//
//  Created by m2sar on 04/01/2021.
//  Copyright © 2021 UPMC. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController  {
    var gameView: GameView?
    var chatView: ChatView?
    var scoreView: ScoreView?
    var firstView: FirstView?

    var scoreModel : ScoreModel?

    let urlFetch = "http://templerunnerppm.pythonanywhere.com/chat/fetchScore/"
    struct Response: Codable {
        let value: [Int]
    }
    
    
    let screenSize = UIScreen.main.bounds
    
    private var notifyScoreTimer : Timer? //timer pour les notifications des scores
    
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

        notifyScoreTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(getNotificationForScore), userInfo: nil, repeats: true)
        MusicPlayer.shared.startBackgroundMusic()
    }

    @objc func getNotificationForScore(){
        print(urlFetch+Identifier.getId())
        let task = URLSession.shared.dataTask(with: URL(string:urlFetch+Identifier.getId())!, completionHandler: {data, response, error in 
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
                print("enable to aprse data")
            }

            guard let json = result else {
                print("data is nil")
                return 
            }

            for score in (result?.value)! {
                let center = UNUserNotificationCenter.current()
                let n = UNMutableNotificationContent()
                n.title = "New HighScore !"
                n.body = "There a new hight score from a another player: " + String(score)
                n.categoryIdentifier = "TempleRunnerScore"
                n.sound = UNNotificationSound.default
                n.badge = NSNumber(value: UIApplication.shared.applicationIconBadgeNumber + 1)
                let nr = UNNotificationRequest(identifier: UUID().uuidString, content: n, trigger: UNTimeIntervalNotificationTrigger(timeInterval: 0.1, repeats: false))
                center.add(nr, withCompletionHandler: nil)

            }
        

            
        
        })

        task.resume()
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
        scoreModel?.setCurrentScore(val:(gameView?.getPlayer().getCurrentScore())!) // Mock, should set to gameModel.getCurrentScore()
        scoreModel?.updateScores()
        scoreView?.setLabelsOnFinishGame(lastScore : (scoreModel?.getCurrentScore())!, hightScore : (scoreModel?.getHightScore())!)
        scoreView?.displayScoreView()
        scoreView?.hideMainMenuButton()
        scoreView?.viewWillAppear()
        
    }
    
    /* Affichage la page des chats a partir de la first view  */
    @objc func displayChatViewFromFirstView(){
        firstView?.displayFirstView()
        firstView?.blurFirstView()
        self.view.bringSubviewToFront(chatView!)
        
        chatView?.displayChatView()
        
    }
    
    @objc func changePower(sender : UIButton){
        if(sender.currentTitle == "Acceleration"){
            sender.setTitle("Invincibiliter", for : .normal )
            CurrentDifficulty.setCurrentPower(p: Powers.INVNCIBILITER)
        }else {
            sender.setTitle("Acceleration", for : .normal )
            CurrentDifficulty.setCurrentPower(p: Powers.ACCELERATION)
        }
        
    }

    /* Affichage la page des scores a partir de la game view  */
    @objc func displayScoreViewFromGameView() {
        gameView?.blurGameView()
        gameView?.beginPauseGame()
        self.view.bringSubviewToFront(scoreView!)
        scoreModel?.setCurrentScore(val:(gameView?.getPlayer().getCurrentScore())!) // Mock, should set to gameModel.getCurrentScore()
        scoreModel?.setCurrentCoins(val:(gameView?.getCurrentCoinsScore())!) // Mock, should set to gameModel.getCurrentCoins()
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
    @objc func storeScoreOnBDD(){
        scoreModel?.storeHighScore()
        //scoreView?.setLabelsOnFinishGame(lastScore : (scoreModel?.getCurrentScore())!, hightScore : (scoreModel?.getHightScore())!)
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }


  
    
}
