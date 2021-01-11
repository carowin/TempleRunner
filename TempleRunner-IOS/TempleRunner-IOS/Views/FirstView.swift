//
//  FirstView.swift
//  TempleRunner-IOS
//
//  Created by m2sar on 04/01/2021.
//  Copyright © 2021 UPMC. All rights reserved.
//

import UIKit

class FirstView: UIView {
    var chatView : ChatView?
    var scoreView : ScoreView?
    var gameView : GameView?
    let backgroundImage = UIImageView(image: UIImage(named: "firstViewBackground"))
    let playButtonBacklight = UIImageView(image: UIImage(named: "ray-sunlight"))
    var playButtonBacklightTimer : Timer?
    init(frame: CGRect, _ chatView : ChatView, _ scoreView : ScoreView, _ gameView : GameView) {
        self.chatView = chatView
        self.scoreView = scoreView
        self.gameView = gameView
        //play button
        playButtonBacklight.frame.size.width = frame.size.width/3
        playButtonBacklight.frame.size.height = frame.size.height/4
        
        super.init(frame: frame)
        playButtonBacklightTimer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(playButtonBlink), userInfo: nil, repeats: true)
        backgroundColor = .black
        chatView.setFirstView(firstView: self)
        scoreView.setFirstView(firstView: self)
        self.addSubview(backgroundImage)
        addSubview(playButtonBacklight)
        drawInSize(frame)
    }
    
    func drawInSize(_ frame : CGRect){
        var top : CGFloat = 0;
        if (UIDevice.current.userInterfaceIdiom == .phone && frame.size.height > 812){
            top = 30
        }
        backgroundImage.frame = CGRect(x: 0, y: top, width: frame.size.width, height: frame.size.height - top + 50)
        playButtonBacklight.center = CGPoint(x: frame.size.width/2, y: frame.size.height*2/3)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func playButtonBlink(){
        if (playButtonBacklight.isHidden){
            playButtonBacklight.isHidden = false
        } else {
            playButtonBacklight.isHidden = true
        }
    }
    func display() {
        //TO BE COMPLETED!!
    }
    
    func hide() {
        //TO BE COMPLETED!!
    }
}
