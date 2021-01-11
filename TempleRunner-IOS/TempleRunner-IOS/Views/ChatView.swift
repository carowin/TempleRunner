//
//  ChatView.swift
//  TempleRunner-IOS
//
//  Created by m2sar on 04/01/2021.
//  Copyright © 2021 UPMC. All rights reserved.
//

import UIKit

/* Vue sur la conversation entre les joueurs */
class ChatView: UIView {
    var vc: ViewController?
    
    private var firstView : FirstView?
    
    init(frame : CGRect, viewc : ViewController){
        self.vc = viewc
        super.init(frame: frame)
        backgroundColor = .gray
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /* fonction appelé pour dessiner le chat view */
    func drawInSize(_ frame : CGRect){
        //TO BE COMPLETED!!
    }
    
    /* fonction appelé par le viewController pour afficher la vue du chat */
    func displayChatView() {
        //TO BE COMPLETED!!
    }
    
    /* fonction appelé par le viewController pour cacher la vue du chat */
    func hideChatView() {
        //TO BE COMPLETED!!
    }
}
