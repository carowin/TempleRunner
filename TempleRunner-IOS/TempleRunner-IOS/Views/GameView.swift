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
    
    let backgroundImage = UIView()
    private var labelEssay : UILabel?
    
    init(frame : CGRect, viewc : ViewController){
        self.vc = viewc
        super.init(frame: frame)
        self.backgroundImage.backgroundColor = .blue
        labelEssay = UILabel()
        labelEssay?.text = "GAME VIEW !"
        
        self.addSubview(backgroundImage)
        self.addSubview(labelEssay!)
        
        self.drawInSize(frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /* fonction appelé pour dessiner la game view */
    func drawInSize(_ frame : CGRect){
        backgroundImage.frame = CGRect(x: 0, y: 10, width: frame.size.width, height: frame.size.height - 10 + 50)
        labelEssay?.frame = CGRect(x: 20, y: 100, width: 100, height: 100)
    }
    
    /* fonction appelé par le viewController pour afficher la vue du jeu */
    func displayGameView() {
        backgroundImage.isHidden = false
        labelEssay?.isHidden = false
    }
    
    /* fonction appelé par le viewController pour cacher la vue du jeu */
    func hideGameView() {
        backgroundImage.isHidden = true
        labelEssay?.isHidden = true
    }
}
