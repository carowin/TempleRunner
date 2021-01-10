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
    let screenSize = UIScreen.main.bounds
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        chatView = ChatView(frame: screenSize)
        scoreView = ScoreView(frame: screenSize)
        gameView = GameView(frame: screenSize, scoreView!)
        firstView = FirstView(frame: screenSize, chatView!, scoreView!, gameView!)
        self.view = firstView!
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

}

