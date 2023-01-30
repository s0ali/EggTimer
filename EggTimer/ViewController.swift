//
//  ViewController.swift
//  EggTimer
//
//  Created by Sayed Ali Husain on 29/01/2023.
//

import UIKit

class ViewController: UIViewController {
    
    let eggTimes = ["Soft": 5, "Medium": 7, "Hard": 12]
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        if timer.isValid {
            timer.invalidate()
        }
        
        let hardness = sender.currentTitle!
        print("\(eggTimes[hardness]!) minuts")
        timer = startTimer(time: eggTimes[hardness]!)
        
    }
    
    func startTimer(time: Int) -> Timer {
        var counter = time
        
        return Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
            if counter > 0 {
                print("\(counter) seconds left")
                counter -= 1
            } else {
                Timer.invalidate()
                print("DONE!!!")
            }
        }
    }
    
}
