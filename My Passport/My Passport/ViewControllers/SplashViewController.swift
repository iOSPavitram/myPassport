//
//  SplashViewController.swift
//  My Passport
//
//  Created by Pavi on 06/12/18.  https://lenczes.edumedia.ca/mad9137/final_api/passport/read/
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {
    
    var seconds = 3 //This variable will hold a starting value of seconds. It could be any amount above 0.
    var timer = Timer()
    var isTimerRunning = false //This will be used to make sure only one timer is created at a time.

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if !isTimerRunning
        {
            runTimer()
        }
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
        isTimerRunning = true
    }

    @objc func updateTimer() {
        seconds -= 1     //This will decrement(count down)the seconds.
        if seconds <= 0
        {
            if timer.isValid
            {
                timer.invalidate()
                isTimerRunning = false
            }
            performSegue(withIdentifier:"showPassport", sender:nil)
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
