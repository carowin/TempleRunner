//
//  GameView.swift
//  TempleRunner-IOS
//
//  Created by m2sar on 04/01/2021.
//  Copyright © 2021 UPMC. All rights reserved.
//

import UIKit

class GameView: UIView {
    
    private var scoreView : ScoreView?
    
    init(frame: CGRect, _ scoreView : ScoreView) {
        self.scoreView = scoreView
        super.init(frame: frame)
        backgroundColor = .blue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func display() {
        //TO BE COMPLETED!!
    }
    
    func hide() {
        //TO BE COMPLETED!!
    }
}
