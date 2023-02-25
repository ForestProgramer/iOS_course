//
//  ViewController.swift
//  Godynnyk_App
//
//  Created by Максим Оліярник on 12.02.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startStopButton: UIButton!
    @IBOutlet weak var resetAndCircleTimeButton: UIButton!
    
    var time : Timer = Timer()
    var count : Int = 0
    var timeCounting : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startStopButton.setTitleColor(UIColor.systemGreen, for: .normal)
        
    }

    @IBAction func startStopTapped(_ sender: Any) {
        if(timeCounting){
            timeCounting = false
            time.invalidate()
            startStopButton.setTitle("Старт", for: .normal)
            startStopButton.setTitleColor(UIColor.systemGreen, for: .normal)
        }else{
            timeCounting = true
            startStopButton.setTitle("Стоп", for: .normal)
            startStopButton.setTitleColor(UIColor.systemRed, for: .normal)
            time = Timer.scheduledTimer(timeInterval: 0.017, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
        }
        
        
    }
    
    @IBAction func resetAndCircleTimeTapped(_ sender: Any) {
        
        self.count = 0
        self.time.invalidate()
        self.timerLabel.text = makeTimeString(hours: 0, minutes: 0, seconds: 0)
        self.startStopButton.setTitle("Старт", for: .normal)
        self.startStopButton.setTitleColor(UIColor.systemGreen, for: .normal)
    }
    
    
    @objc func timerCounter()->Void{
         count += 1
        let time = secondsToHoursMinutesToSeconds(seconds: count)
        
        let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
        
        timerLabel.text = timeString
    }
    
    func secondsToHoursMinutesToSeconds(seconds : Int)->(Int,Int,Int){
        
        
        
        return ((seconds / 3600) , ((seconds % 3600) / 60) , ((seconds % 3600) % 60))
    }
    
    func makeTimeString(hours : Int , minutes : Int , seconds : Int)->String{
        var timeString = ""
        timeString += String(format: "%02d", hours)
        timeString += ":"
        timeString += String(format: "%02d", minutes)
        timeString += ","
        timeString += String(format: "%02d", seconds)
        return timeString
    }
}

