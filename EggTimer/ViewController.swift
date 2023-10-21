//
//  ViewController.swift
//  EggTimer
//
//  
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    let eggTimes = ["Soft": 5,"Medium": 7,"Hard": 12]
    
    var secondsRemaining = 60
    
    var player: AVAudioPlayer?
    
    var time = Timer()
    func playSound() {
        guard let path = Bundle.main.path(forResource: "alarm_sound", ofType:"mp3") else {
            return }
        let url = URL(fileURLWithPath: path)

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    @IBOutlet weak var eggStatus: UILabel!
    
    
    @IBOutlet weak var progress: UIProgressView!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        time.invalidate()
        progress.setProgress(1, animated: true)
        let hardness = sender.currentTitle
        if(hardness != nil){
            secondsRemaining = eggTimes[hardness!] ?? 0
        }
        
        time  = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
            if self.secondsRemaining > 0 {
                print ("\(self.secondsRemaining) seconds")
                self.secondsRemaining -= 1
                let percent = (Float(self.secondsRemaining)/Float(self.eggTimes[hardness!]!))
                print(percent)
                self.progress.setProgress(Float(percent), animated: true)
        
            } else {
                Timer.invalidate()
                self.eggStatus.text="Done!"
                self.playSound()
                
            }
        }
        
        
    }
    
    
    
    

}
