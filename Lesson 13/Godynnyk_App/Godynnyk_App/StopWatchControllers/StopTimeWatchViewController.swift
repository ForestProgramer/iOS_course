//
//  ViewController.swift
//  Godynnyk_App
//
//  Created by Максим Оліярник on 12.02.2023.
//

import UIKit
// класс для таб бару Секундомір
class StopTimeWatchViewController: UIViewController {
// аутлети
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startStopButton: UIButton!
    @IBOutlet weak var resetAndCircleTimeButton: UIButton!
    // змінна яка приймає об'єкт Timer
    var time : Timer = Timer()
    // каунтер для кільксоті секунд
    var count : Int = 0
    // і булівська змінна шоб провіряти чи секундомір зупинено чи ні
    var timeCounting : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // задали властивості кнопкам
        startStopButton.setTitleColor(UIColor.systemGreen, for: .normal)
        resetAndCircleTimeButton.isUserInteractionEnabled = false
        resetAndCircleTimeButton.alpha = 0.5
    }
// екшн для кнопки старт
    @IBAction func startStopTapped(_ sender: Any) {
        resetAndCircleTimeButton.isUserInteractionEnabled = true
        resetAndCircleTimeButton.alpha = 1
        if(timeCounting){
            // коли таймер не працює
            timeCounting = false
            // зупиняє таймер
            time.invalidate()
            // змінна властивостей кнопки
            startStopButton.setTitle("Старт", for: .normal)
            startStopButton.setTitleColor(UIColor.systemGreen, for: .normal)
            startStopButton.tintColor = .init(red: 0.09, green: 0.37, blue: 0.09, alpha: 0.5)
        } else{
            // коли таймер працює
            timeCounting = true
            startStopButton.setTitle("Стоп", for: .normal)
            startStopButton.setTitleColor(UIColor.systemRed, for: .normal)
            startStopButton.tintColor = .init(red: 0.39, green: 0.14, blue: 0.12, alpha: 0.5)
            time = Timer.scheduledTimer(timeInterval: 0.017, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
        }
        
        
    }
    // екшн для кнопки ресет
    @IBAction func resetAndCircleTimeTapped(_ sender: Any) {
        // обнуляємо каунтер
        self.count = 0
        //зупиняємо таймер
        self.time.invalidate()
        // обновлємо лейбл
        self.timerLabel.text = makeTimeString(hours: 0, minutes: 0, seconds: 0)
        self.startStopButton.setTitle("Старт", for: .normal)
        self.startStopButton.setTitleColor(UIColor.systemGreen, for: .normal)
        self.startStopButton.tintColor = .init(red: 0.09, green: 0.37, blue: 0.09, alpha: 0.5)
        resetAndCircleTimeButton.isUserInteractionEnabled = false
        resetAndCircleTimeButton.alpha = 0.5
    }
    
    //objc функція для логіки роботи таймера і обновлення лейблу
    @objc func timerCounter()->Void{
         count += 1
        let time = secondsToHoursMinutesToSeconds(seconds: count)
        
        let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
        
        timerLabel.text = timeString
    }
    //
    func secondsToHoursMinutesToSeconds(seconds : Int)->(Int,Int,Int){
        
        
        
        return ((seconds / 3600) , ((seconds % 3600) / 60) , ((seconds % 3600) % 60))
    }
    // фкнція для обновлення тексту лейблу з часом
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
