//
//  ScoreView.swift
//  TempleRunner-IOS
//
//  Created by m2sar on 04/01/2021.
//  Copyright © 2021 UPMC. All rights reserved.
//

import UIKit

/* Vue : Table de score */
class ScoreView: UIView {
    var vc: ViewController?
    private var firstView : FirstView?
    
    init(frame: CGRect, viewc: ViewController) {
        self.vc = viewc
        super.init(frame: frame)
        backgroundColor = .red
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func drawInSize(_ frame : CGRect){
        //TO BE COMPLETED!!
    }
    
    /* fonction appelé par le viewController pour afficher la vue de la table des scores */
    func displayScoreView() {
        //TO BE COMPLETED!!
    }
    
    /* fonction appelé par le viewController pour cacher la vue de la table des scores */
    func hideScoreView() {
        //TO BE COMPLETED!!
    }
}
