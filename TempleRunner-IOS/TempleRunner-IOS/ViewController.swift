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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        gameView = GameView()
        chatView = ChatView()
        scoreView = ScoreView()
        firstView = FirstView()
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

}

