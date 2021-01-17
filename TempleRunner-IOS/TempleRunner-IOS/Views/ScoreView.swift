//
//  ScoreView.swift
//  TempleRunner-IOS
//
//  Created by m2sar on 04/01/2021.
//  Copyright © 2021 UPMC. All rights reserved.
//

import UIKit

let FONT_NAME = "HanaleiFill-Regular"
let EMPTY_LABEL = "-----"

let topButtonColor = UIColor (red:239.0/255.0, green:205.0/255.0, blue:100.4/255.0, alpha:1)
let bottomButtonColor = UIColor (red:104.0/255.0, green:69.2/255.0, blue:32.6/255.0, alpha:1)

/* Vue : Table de score */
class ScoreView: UIView {
    var vc: ViewController?
    private var firstView : FirstView?

    let backgroundImage = UIImageView(image: UIImage(named: "scoreViewBackground"))
    var buttonSaveScore = UIButton(type: .custom) //bouton saveScore
    var buttonPlayAgain = UIButton(type: .custom) //bouton playAgain
    var buttonBack = UIButton() // bouton de sortie de score view
    var buttonMenu = UIButton() // bouton pour aller au menu principal

    /* This four labels are the only shown when the scoreView is invoke from the firstView */
    let topScoreLabel = UILabel()
    let lastScoreLabel = UILabel()
    var topScoreLabelValue = UILabel()
    var lastScoreLabelValue = UILabel()

    /* This four labels are the only shown when the scoreView is invoke from the gameView */
    let currentScoreLabel = UILabel()
    let currentCoinsLabel = UILabel()
    var currentScoreLabelValue = UILabel()
    var currentCoinsLabelValue = UILabel()
    
    
    init(frame: CGRect, viewc: ViewController) {
        self.vc = viewc

        super.init(frame: frame)

        var sizeFontAlpha : CGFloat = 24.0;
        var sizeFontNumeric : CGFloat = 30.0;
        if (UIDevice.current.userInterfaceIdiom == .phone && UIScreen.main.bounds.width > 412){
            sizeFontAlpha = 28.0
            sizeFontNumeric = 32.0
        }else if (UIDevice.current.userInterfaceIdiom == .pad ){
            sizeFontAlpha = 42.0
            sizeFontNumeric = 46.0
        }
        

        topScoreLabel.createCustomLabel(text:"Your high score :", sizeFont: sizeFontAlpha)
        topScoreLabelValue.createCustomLabel(text:EMPTY_LABEL, sizeFont: sizeFontNumeric)
        lastScoreLabel.createCustomLabel(text:"Your last score :", sizeFont: sizeFontAlpha)
        lastScoreLabelValue.createCustomLabel(text:EMPTY_LABEL, sizeFont: sizeFontNumeric)

        currentScoreLabel.createCustomLabel(text:"Your current score :", sizeFont: sizeFontAlpha)
        currentScoreLabelValue.createCustomLabel(text:EMPTY_LABEL, sizeFont: sizeFontNumeric)
        currentCoinsLabel.createCustomLabel(text:"Your current coins :", sizeFont: sizeFontAlpha)
        currentCoinsLabelValue.createCustomLabel(text:EMPTY_LABEL, sizeFont: sizeFontNumeric)

        let sizeButton = frame.size.width - (frame.size.width/2.2)
        
        buttonPlayAgain.createCustomButton(title:"NEW GAME", width: sizeButton)
        buttonPlayAgain.addTarget(self.superview, action:  #selector(vc!.displayGameViewFromScoreView), for: .touchUpInside)

        buttonSaveScore.createCustomButton(title:"SAVE SCORE", width: sizeButton)
        buttonSaveScore.addTarget(self.superview, action: #selector(vc!.saveScoreToBDD), for: .touchUpInside)
        
        buttonBack.createCustomButton(title:"BACK", width: sizeButton)
        buttonBack.addTarget(self.superview, action: #selector(vc!.removeScoreView), for: .touchUpInside)

        buttonMenu.createCustomButton(title:"MAIN MENU", width: sizeButton)
        buttonMenu.addTarget(self.superview, action: #selector(vc!.displayFirstView), for: .touchUpInside)

        
        self.addSubview(backgroundImage)
        self.addSubview(buttonPlayAgain)
        self.addSubview(buttonSaveScore)
        self.addSubview(buttonBack)
        self.addSubview(buttonMenu)
        self.addSubview(topScoreLabel)
        self.addSubview(topScoreLabelValue)
        self.addSubview(lastScoreLabel)
        self.addSubview(lastScoreLabelValue)
        self.addSubview(currentScoreLabel)
        self.addSubview(currentScoreLabelValue)
        self.addSubview(currentCoinsLabel)
        self.addSubview(currentCoinsLabelValue)
        self.drawInSize(frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    func viewWillAppear() {
        let screenRect = UIScreen.main.bounds
        let screenWidth = screenRect.size.width
        let screenHeight = screenRect.size.height
        let translate = CABasicAnimation(keyPath: "position")
        translate.fromValue = [screenWidth/2,-screenHeight]
        translate.toValue = [screenWidth/2,0]
        self.layer.add(translate, forKey:nil)
    }

    func viewWillDisappear() {
        let screenRect = UIScreen.main.bounds
        let screenWidth = screenRect.size.width
        let screenHeight = screenRect.size.height
        let translate = CABasicAnimation(keyPath: "position")
        translate.fromValue = [screenWidth/2,0]
        translate.toValue =  [screenWidth/2,-screenHeight]
        self.layer.add(translate, forKey:nil)
    }
    
    
    func drawInSize(_ frame : CGRect){
        var top : CGFloat = 0;
        if (UIDevice.current.userInterfaceIdiom == .phone && frame.size.height > 812){
            top = 30
        }

        let padding = (frame.size.width/8)
        let reduceFrameWidth = frame.size.width - padding
        let sizeLabels = reduceFrameWidth - padding
        let paddingButton = (frame.size.width/10)
        
        topScoreLabel.frame = CGRect(x: padding, y: frame.size.height*1/10, width: sizeLabels, height: 50)
        topScoreLabelValue.frame = CGRect(x: padding, y: frame.size.height*2/10+10, width: sizeLabels, height: 50)
        lastScoreLabel.frame = CGRect(x: padding, y: frame.size.height*3/10, width: sizeLabels, height: 50)
        lastScoreLabelValue.frame = CGRect(x: padding, y: frame.size.height*4/10+10, width: sizeLabels, height: 50)
        currentScoreLabel.frame = CGRect(x: padding, y: frame.size.height*1/10, width: sizeLabels, height: 50)
        currentScoreLabelValue.frame = CGRect(x: padding, y: frame.size.height*2/10+10, width: sizeLabels, height: 50)
        currentCoinsLabel.frame = CGRect(x: padding, y: frame.size.height*3/10, width: sizeLabels, height: 50)
        currentCoinsLabelValue.frame = CGRect(x: padding, y: frame.size.height*4/10+10, width: sizeLabels, height: 50)
        backgroundImage.frame = CGRect(x: padding, y: 0, width: reduceFrameWidth - padding, height: frame.size.height - top + 50)
        buttonPlayAgain.frame = CGRect(x: padding + paddingButton, y: frame.size.height * 7/10, width: sizeLabels - 2*paddingButton, height: 50)
        buttonBack.frame = CGRect(x:padding + paddingButton, y: frame.size.height * 8/10, width: sizeLabels  -  2*paddingButton, height: 50)
        buttonSaveScore.frame =  CGRect(x:padding + paddingButton, y: frame.size.height * 6/10, width: sizeLabels  -  2*paddingButton, height: 50)
        buttonMenu.frame = CGRect(x:padding + paddingButton, y: frame.size.height * 6/10, width: sizeLabels  -  2*paddingButton, height: 50)
           
    }
    
    /* fonction appelé par le viewController pour afficher la vue de la table des scores */
    func displayScoreView() {
        self.isHidden = false
        backgroundImage.isHidden = false
        buttonPlayAgain.isHidden = false
        buttonBack.isHidden = false
    }
    
    /* fonction appelé par le viewController pour cacher la vue de la table des scores */
    func hideScoreView() {
        self.isHidden = true
        backgroundImage.isHidden = true
        buttonPlayAgain.isHidden = true
        buttonBack.isHidden = true
    }


    // Change Last Scores Label and Top Score Label
    func setLabelsOnFinishGame (lastScore : Int, hightScore : Int){
        lastScoreLabelValue.text = String(lastScore)
        topScoreLabelValue.text = String(hightScore)
    }

     // Change Current Scores Label and Current Coins Label
    func setLabelsOnPauseGame (currentScore : Int, currentCoins : Int){
        currentScoreLabelValue.text = String(currentScore)
        currentCoinsLabelValue.text = String(currentCoins)
    }

    func displayMainMenuButton() {
        buttonSaveScore.isHidden = true
        topScoreLabel.isHidden = true
        topScoreLabelValue.isHidden = true
        lastScoreLabel.isHidden = true
        lastScoreLabelValue.isHidden = true
        buttonMenu.isHidden = false
        currentScoreLabel.isHidden = false
        currentScoreLabelValue.isHidden = false
        currentCoinsLabel.isHidden = false
        currentCoinsLabelValue.isHidden = false
    }

    func hideMainMenuButton() {
        buttonSaveScore.isHidden = false
        topScoreLabel.isHidden = false
        topScoreLabelValue.isHidden = false
        lastScoreLabel.isHidden = false
        lastScoreLabelValue.isHidden = false
        buttonMenu.isHidden = true
        currentScoreLabel.isHidden = true
        currentScoreLabelValue.isHidden = true
        currentCoinsLabel.isHidden = true
        currentCoinsLabelValue.isHidden = true
        
    }

}

// Créer un button custom avec gradian peut etre utiliser dans tous les views
extension UIButton {

    func createCustomButton(title : String, width : CGFloat) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topButtonColor.cgColor, bottomButtonColor.cgColor]
        gradientLayer.frame = CGRect(x: 0, y: 0, width: width, height: 50)
        gradientLayer.cornerRadius = 10
        self.layer.insertSublayer(gradientLayer, at: 0)
        self.layer.cornerRadius = 10
        self.setTitle(title, for: .normal)
        self.setTitleColor(.darkGray, for: .normal)
        var sizeFont : CGFloat = 24.0;
        if (UIDevice.current.userInterfaceIdiom == .phone && UIScreen.main.bounds.width > 412){
            sizeFont = 28.0
        }else if (UIDevice.current.userInterfaceIdiom == .pad ){
            sizeFont = 42.0
        }
        self.titleLabel?.font = UIFont(name: FONT_NAME, size: sizeFont)
    }
}

// Créer un label custom avec la bonne font
extension UILabel {

    func createCustomLabel(text : String, sizeFont: CGFloat) {
        self.text = text
        self.textAlignment = .center
        self.font = UIFont(name: FONT_NAME, size: sizeFont)
    }
}
