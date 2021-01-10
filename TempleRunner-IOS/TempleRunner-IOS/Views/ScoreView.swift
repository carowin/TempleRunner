//
//  ScoreView.swift
//  TempleRunner-IOS
//
//  Created by m2sar on 04/01/2021.
//  Copyright © 2021 UPMC. All rights reserved.
//

import UIKit

class ScoreView: UIView {
    
    private var firstView : FirstView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setFirstView (firstView : FirstView){
        self.firstView = firstView
    }
    
    func display() {
        //TO BE COMPLETED!!
    }
    
    func hide() {
        //TO BE COMPLETED!!
    }
}
