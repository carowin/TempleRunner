//
//  FirstView.swift
//  TempleRunner-IOS
//
//  Created by m2sar on 04/01/2021.
//  Copyright © 2021 UPMC. All rights reserved.
//

import UIKit

/* Vue sur la page d'accueil */
class FirstView: UIView {
    var vc: ViewController?
    
    let backgroundImage = UIImageView(image: UIImage(named: "firstViewBackground"))
    let playButtonBacklight = UIImageView(image: UIImage(named: "ray-sunlight"))
    var playButtonBacklightTimer : Timer?
    var buttonPlay = UIButton(type: .custom) //bouton play
    var buttonScore = UIButton(type: .custom) //bouton score
    var blurEffectView : UIVisualEffectView? // blur effect when score view is shown
    var identifierPlayer : UILabel?
    
    init(frame : CGRect, viewc : ViewController){
        self.vc = viewc
        playButtonBacklight.frame.size.width = frame.size.width/3
        playButtonBacklight.frame.size.height = frame.size.height/4
        
        super.init(frame: frame)

        buttonPlay.addTarget(self.superview, action:  #selector(vc!.displayGameViewFromFirstView), for: .touchUpInside)
        buttonPlay.alpha = 0.3
        buttonPlay.backgroundColor = .red
        
        buttonScore.createCustomButton(title:"SCORES", width: CGFloat(150))
        buttonScore.addTarget(self.superview, action: #selector(vc!.displayScoreViewFromFirstView), for: .touchUpInside)
        
        
       
        let blurEffect = UIBlurEffect(style: .dark)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView?.frame = self.bounds
        blurEffectView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView?.isHidden = true

        identifierPlayer = UILabel()
        identifierPlayer?.backgroundColor = .white
        identifierPlayer?.text = Identifier.getId()


        self.addSubview(backgroundImage)
        self.addSubview(playButtonBacklight)
        self.addSubview(buttonPlay)
        self.addSubview(buttonScore)
        self.addSubview(blurEffectView!)
        self.addSubview(identifierPlayer!)
        self.drawInSize(frame)
    }
    
    /* fonction appelé pour dessiner la vue */
    func drawInSize(_ frame : CGRect){
        var top : CGFloat = 0;
        if (UIDevice.current.userInterfaceIdiom == .phone && frame.size.height > 812){
            top = 30
        }
        backgroundImage.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height - top + 100)
        playButtonBacklight.center = CGPoint(x: frame.size.width/2, y: frame.size.height*2/3)
        buttonPlay.frame = CGRect(x: frame.size.width/3.5, y: frame.size.height*3.05/4, width: frame.size.width/2.5, height: frame.size.height/12)
        buttonScore.frame = CGRect(x: frame.size.width/2-75, y: frame.size.height*9/10, width: 150, height: 50)
        identifierPlayer?.frame = CGRect(x: frame.size.width/2-75, y: frame.size.height*3/10, width: 150, height: 50)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /* fonction pour faire clignoter le rayon de soleil */
    @objc func playButtonBlink(){
        if (playButtonBacklight.isHidden){
            playButtonBacklight.isHidden = false
        } else {
            playButtonBacklight.isHidden = true
        }
    }
    
    /* fonction appelé par le viewController pour afficher la page d'accueil */
    func displayFirstView() {
        playButtonBacklightTimer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(playButtonBlink), userInfo: nil, repeats: true)
        self.isHidden = false
        backgroundImage.isHidden = false
        playButtonBacklight.isHidden = false
        buttonPlay.isHidden = false
        buttonScore.isHidden = false
        }
    
    /* fonction appelé par le viewController pour cacher la vue de la table des scores */
    func hideFirstView() {
        playButtonBacklightTimer?.invalidate()
        playButtonBacklightTimer = nil
        self.isHidden = true
        backgroundImage.isHidden = true
        playButtonBacklight.isHidden = true
        buttonPlay.isHidden = true
        buttonScore.isHidden = true
      }

    func blurFirstView (){
        identifierPlayer?.text = Identifier.getId()
        self.blurEffectView?.isHidden = false
    }

    func cleanFirstView (){
        identifierPlayer?.text = Identifier.getId()
        self.blurEffectView?.isHidden = true
    }
}
