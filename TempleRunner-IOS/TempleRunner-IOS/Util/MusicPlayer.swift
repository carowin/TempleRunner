import UIKit
import Foundation
import AVFoundation

class MusicPlayer {
    static let shared = MusicPlayer()
    var audioPlayer: AVAudioPlayer?
    
    var jumpSound : AVAudioPlayer?
    var slideSound : AVAudioPlayer?
    var turnSound : AVAudioPlayer?
    var lostSound : AVAudioPlayer?
    var coinSound : AVAudioPlayer?

    func startBackgroundMusic() {
        if let bundle = Bundle.main.path(forResource: "backgroundMusic", ofType: "mp3") {
            let backgroundMusic = NSURL(fileURLWithPath: bundle)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf:backgroundMusic as URL)
                guard let audioPlayer = audioPlayer else { return }
                audioPlayer.numberOfLoops = -1
                audioPlayer.prepareToPlay()
                audioPlayer.play()
            } catch {
                print(error)
            }
        }
    }

    func stopBackgroundMusic() {
        guard let audioPlayer = audioPlayer else { return }
        audioPlayer.stop()
    }

    func playSoundEffect(soundEffect: String) {
    if let bundle = Bundle.main.path(forResource: soundEffect, ofType: "mp3") {
        let soundEffectUrl = NSURL(fileURLWithPath: bundle)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf:soundEffectUrl as URL)
            guard let audioPlayer = audioPlayer else { return }
            audioPlayer.play()
        } catch {
            print(error)
        }
    }
    }
    
//_______________ Ajout de sons pour les actions _______________
    
    func activateCollectCoinSound(){
        let url = Bundle.main.url(forResource:"coinSound", withExtension:"mp3")
        if url != nil {
            do{
                coinSound = try AVAudioPlayer(contentsOf: url!)
                coinSound?.play()
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    
    
    func activateLostSound(){
        let url = Bundle.main.url(forResource:"punchSound", withExtension:"mp3")
        if url != nil {
            do{
                lostSound = try AVAudioPlayer(contentsOf: url!)
                lostSound?.play()
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    
    
    func activateMouvementSound(myPlayer: Player){
        if myPlayer.getCurrentState() == .JUMPING{
            let url = Bundle.main.url(forResource:"jumpSound", withExtension:"mp3")
            if url != nil {
                do{
                    jumpSound = try AVAudioPlayer(contentsOf: url!)
                    jumpSound?.play()
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        }
        if myPlayer.getCurrentState() == .SLIDING{
            let url = Bundle.main.url(forResource:"slipSound", withExtension:"mp3")
            if url != nil {
                do{
                    slideSound = try AVAudioPlayer(contentsOf: url!)
                    slideSound?.play()
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        }
        if myPlayer.getCurrentState() == .LEFT || myPlayer.getCurrentState() == .RIGHT{
            let url = Bundle.main.url(forResource:"turnSound", withExtension:"mp3")
            if url != nil {
                do{
                    turnSound = try AVAudioPlayer(contentsOf: url!)
                    turnSound?.play()
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
