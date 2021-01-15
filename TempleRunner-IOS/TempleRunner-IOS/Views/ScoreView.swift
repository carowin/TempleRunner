//
//  ScoreView.swift
//  TempleRunner-IOS
//
//  Created by m2sar on 04/01/2021.
//  Copyright © 2021 UPMC. All rights reserved.
//

import UIKit

let FONT_NAME = "HanaleiFill-Regular"
let NUMERIC_LABEL_SIZE : CGFloat = 32.0
let ALPHA_LABEL_SIZE : CGFloat = 28.0
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
    var buttonBack = UIButton() // bouton de sortie de menu

    let topScoreLabel = UILabel()
    let lastScoreLabel = UILabel()
    var topScoreLabelValue = UILabel()
    var lastScoreLabelValue = UILabel()
    
    
    init(frame: CGRect, viewc: ViewController) {
        self.vc = viewc

        super.init(frame: frame)
        
        topScoreLabel.text = "Your high score :"
        topScoreLabel.textAlignment = .center
        topScoreLabel.font = UIFont(name: FONT_NAME, size: ALPHA_LABEL_SIZE)
        
        topScoreLabelValue.text = EMPTY_LABEL
        topScoreLabelValue.textAlignment = .center
        topScoreLabelValue.font = UIFont(name: FONT_NAME, size: NUMERIC_LABEL_SIZE)
        
        lastScoreLabel.text = "Your last score :"
        lastScoreLabel.textAlignment = .center
        lastScoreLabel.font = UIFont(name: FONT_NAME, size: ALPHA_LABEL_SIZE)
        
        lastScoreLabelValue.text = EMPTY_LABEL
        lastScoreLabelValue.textAlignment = .center
        lastScoreLabelValue.font = UIFont(name: FONT_NAME, size: NUMERIC_LABEL_SIZE)

        let sizeButton = frame.size.width - (frame.size.width/2.5)
        
        buttonPlayAgain.createCustomButton(title:"PLAY AGAIN", width: sizeButton)
        buttonPlayAgain.addTarget(self.superview, action:  #selector(vc!.displayGameView), for: .touchUpInside)

        buttonSaveScore.createCustomButton(title:"SAVE SCORE", width: sizeButton)
        buttonSaveScore.addTarget(self.superview, action: #selector(vc!.saveScoreToBDD), for: .touchUpInside)
        
        buttonBack.createCustomButton(title:"BACK", width: sizeButton)
        buttonBack.addTarget(self.superview, action: #selector(vc!.removeScoreView), for: .touchUpInside)

        self.addSubview(backgroundImage)
        self.addSubview(buttonPlayAgain)
        self.addSubview(buttonSaveScore)
        self.addSubview(buttonBack)
        self.addSubview(topScoreLabel)
        self.addSubview(topScoreLabelValue)
        self.addSubview(lastScoreLabel)
        self.addSubview(lastScoreLabelValue)
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

        let reduceFrameWidth = frame.size.width - (frame.size.width/10)
        let begingReduceFrame = (frame.size.width/10)
        let sizeLabels = reduceFrameWidth-begingReduceFrame
        let paddingButton = (frame.size.width/10)
        
        topScoreLabel.frame = CGRect(x: begingReduceFrame, y: frame.size.height*1/10, width: sizeLabels, height: 50)
        topScoreLabelValue.frame = CGRect(x: begingReduceFrame, y: frame.size.height*2/10+10, width: sizeLabels, height: 50)
        lastScoreLabel.frame = CGRect(x: begingReduceFrame, y: frame.size.height*3/10, width: sizeLabels, height: 50)
        lastScoreLabelValue.frame = CGRect(x: begingReduceFrame, y: frame.size.height*4/10+10, width: sizeLabels, height: 50)
        backgroundImage.frame = CGRect(x: reduceFrameWidth/20, y: 0, width: reduceFrameWidth, height: frame.size.height - top + 50)
        buttonSaveScore.frame = CGRect(x: begingReduceFrame + paddingButton, y: frame.size.height*6/10, width: sizeLabels - 2*paddingButton, height: 50)
        buttonPlayAgain.frame = CGRect(x: begingReduceFrame + paddingButton, y: frame.size.height*7/10, width: sizeLabels - 2*paddingButton, height: 50)
        buttonBack.frame = CGRect(x: begingReduceFrame + paddingButton, y: frame.size.height*8/10, width: sizeLabels - 2*paddingButton, height: 50)
    }
    
    /* fonction appelé par le viewController pour afficher la vue de la table des scores */
    func displayScoreView() {
        self.isHidden = false
        backgroundImage.isHidden = false
        buttonSaveScore.isHidden = false
        buttonPlayAgain.isHidden = false
        buttonBack.isHidden = false
        topScoreLabel.isHidden = false
        topScoreLabelValue.isHidden = false
        lastScoreLabel.isHidden = false
        lastScoreLabelValue.isHidden = false
    }
    
    /* fonction appelé par le viewController pour cacher la vue de la table des scores */
    func hideScoreView() {
        self.isHidden = true
        backgroundImage.isHidden = true
        buttonSaveScore.isHidden = true
        buttonPlayAgain.isHidden = true
        buttonBack.isHidden = true
        topScoreLabel.isHidden = true
        topScoreLabelValue.isHidden = true
        lastScoreLabel.isHidden = true
        lastScoreLabelValue.isHidden = true
    }


    // Change Last Scores Label and Top Score Label
    func setLabelsScores (lastScore : Int, hightScore : Int){
        lastScoreLabelValue.text = String(lastScore)
        topScoreLabelValue.text = String(hightScore)
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
        self.titleLabel?.font = UIFont(name: FONT_NAME, size: ALPHA_LABEL_SIZE)
    }
}
