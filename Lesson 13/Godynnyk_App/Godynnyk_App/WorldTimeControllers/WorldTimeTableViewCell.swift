//
//  WolrdTimeTableViewCell.swift
//  Godynnyk_App
//
//  Created by Максим Оліярник on 20.02.2023.
//

import UIKit

class WorldTimeTableViewCell: UITableViewCell {

   

    @IBOutlet weak var timeZoneName: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var currentTimeToOtherDifference: UILabel!
    var computedTimeZoneName : String!
    override func awakeFromNib( ) {
        super.awakeFromNib()
        // Initialization code
        
        
        let timerTime = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(setTime), userInfo: nil, repeats: true)
        
        RunLoop.current.add(timerTime, forMode: RunLoop.Mode.common)
    }
    
    
    
    @objc func setTime(){
        timeLabel.text = getTime()
        currentTimeToOtherDifference.text = getDifference()
    }
    
    
    func getTime()->String{
        
        var timeString = ""
        if computedTimeZoneName != ""{
            let formatter = DateFormatter()

            formatter.timeStyle = .short
            formatter.timeZone = TimeZone(identifier: computedTimeZoneName)
            let timeNow = Date()
            
            timeString  = formatter.string(from: timeNow)

            
            
        }
        return timeString
    }
    
    //MARK: Look at this later
    func getDifference()->String{
        var differenceTime = ""
        if computedTimeZoneName != ""{
            let calendar = Calendar(identifier: .gregorian)
            let currentDate = Date()
            let dateFormatter = DateFormatter()

            
            dateFormatter.timeZone = calendar.timeZone
            dateFormatter.dateFormat = "YY, MMM d, HH:mm"
            
            let otherFormatter = DateFormatter()
            otherFormatter.timeZone = TimeZone(identifier: computedTimeZoneName)
            otherFormatter.dateFormat = "YY, MMM d, HH:mm"
            let LocaleData = dateFormatter.string(from: currentDate)
            let OtherCountryData = otherFormatter.string(from: currentDate)
//            print("\(LocaleData) \(OtherCountryData)")
            let formatter2 = DateFormatter()
            formatter2.locale = Locale(identifier: "Europe/Kiev")
            formatter2.dateFormat = "YY, MMM d, HH:mm"
            let date2 = formatter2.date(from: LocaleData)!
            // Do any additional setup after loading the view.
            
            
            let formatter3 = DateFormatter()
            formatter3.locale = Locale(identifier: computedTimeZoneName)
            formatter3.dateFormat = "YY, MMM d, HH:mm"
            let date1 = formatter3.date(from: OtherCountryData)!
            // Do any additional setup after loading the view.
       

        
            var differenceHours = ""
            if date1.hours(from: date2) < 0{
                differenceHours = String(date1.hours(from: date2))
            }else if date1.hours(from: date2) >= 0 {
                differenceHours = "+" + String(date1.hours(from: date2))
            }
            if date2.get(.day) > date1.get(.day){
               differenceTime += "Учора "  + differenceHours + " " + "годин"
            }else if date2.get(.day) < date1.get(.day) {
                differenceTime += "Завтра "  + differenceHours + " " + "годин"
            }else if date2.get(.day) == date1.get(.day){
                differenceTime += "Сьогодні "  + differenceHours + " " + "годин"
            }

        }
            
        return differenceTime
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension Date {

    /// Returns the amount of hours from another date
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    /// Returns the amount of days from another date
        func days(from date: Date) -> Int {
            return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
        }
    
        func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
            return calendar.dateComponents(Set(components), from: self)
        }

        func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
            return calendar.component(component, from: self)
        }
    
//    func distance(from date: Date, only component: Calendar.Component, calendar: Calendar = .current) -> Int {
//            let days1 = calendar.component(component, from: self)
//            let days2 = calendar.component(component, from: date)
//            return days1 - days2
//        }
}
