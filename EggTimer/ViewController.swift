//
//  ViewController.swift
//  EggTimer
//
//  Created by Sayed Ali Husain on 29/01/2023.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var timeLable: UILabel!
    
    let eggTimes = ["Soft": 5, "Medium": 7, "Hard": 12]
    
    var timer = Timer()
    var player: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        progressView.progress = 0
        timeLable.text = ""
    }
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        if timer.isValid {
            timer.invalidate()
        }
        
        let hardness = sender.currentTitle!
        print("\(eggTimes[hardness]!) minuts")
        titleLable.text = hardness
        timer = startTimer(time: eggTimes[hardness]!)
        
    }
    
    func startTimer(time: Int) -> Timer {
        var counter = time * 100
        progressView.progress = 1
        
        return Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { (Timer) in
            if counter > 0 {
                counter -= 1
                
                print("\(counter/100) seconds left")
                self.timeLable.text = "\((counter/100) + 1) Seconds"
                
                self.progressView.progress = Float(counter) / Float(time * 100)
                print(self.progressView.progress)
            } else {
                Timer.invalidate()
                print("DONE!!!")
                self.timeLable.text = ""
                self.progressView.progress = 0
                self.titleLable.text = "DONE!"
                self.playSound()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                    self.titleLable.text = "How do you like your eggs?"
                }
            }
        }
    }
    
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
    
}
