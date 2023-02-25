//
//  ViewController.swift
//  testssss
//
//  Created by Максим Оліярник on 14.02.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var viewTimer: UIView!
    @IBOutlet weak var pickerTimer: UIPickerView!
    var pickerData: [[String]] = [[String]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerTimer.delegate = self
        pickerTimer.dataSource = self
        pickerData = [["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22","23"],
                      ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22","23","24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46","47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59"],
                      ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22","23","24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46","47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59"]
        ]
        let pickerLabel1 = UILabel()
        pickerLabel1.text = "год"
        let pickerLabel2 = UILabel()
        pickerLabel2.text = "хв"
        let pickerLabel3 = UILabel()
        pickerLabel3.text = "с"
        pickerTimer.setPickerLabels(labels: [0:pickerLabel1,1:pickerLabel2,2: pickerLabel3], containedView: viewTimer)
        
        
        let calendar = Calendar(identifier: .gregorian)
        let currentDate = Date()
        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "MMM d, yyyy"
        dateFormatter.timeZone = calendar.timeZone
        
        
        let otherFormatter = DateFormatter()
       
        otherFormatter.timeZone = TimeZone(identifier: "America/New_York")
        otherFormatter.dateFormat = "MMM d, yyyy"
        let KievData = dateFormatter.string(from: currentDate)
        let NewYorkData = otherFormatter.string(from: currentDate)
        
        let formatter2 = DateFormatter()
        formatter2.locale = Locale(identifier: "Europe/Kiev")
        formatter2.dateFormat = "MMM d, yyyy"
        let kiev = formatter2.date(from: KievData)!
        // Do any additional setup after loading the view.
        
        print(kiev)
        
        let formatter3 = DateFormatter()
        formatter3.locale = Locale(identifier: "America/New_York")
        formatter3.dateFormat = "MMM d, yyyy"
        let newYork = formatter3.date(from: NewYorkData)!
        // Do any additional setup after loading the view.
        
        print(newYork)
        
        var differenceTime = ""
        
        if kiev > newYork{
           differenceTime += "Учора "  + " " + "годин"
        }else if kiev < newYork {
            differenceTime += "Завтра "  + " " + "годин"
        }else if kiev == newYork{
            differenceTime += "Сьогодні "  + " " + "годин"
        }
    
        
        print(differenceTime)
    }
    
    @IBAction func greenButtonTaped(_ sender: UIButton) {
        if sender.title(for: .normal) == "X" {
            sender.setTitle("A very long title for this button", for: .normal)
          } else {
            sender.setTitle("X", for: .normal)
          }
    }
    
    @IBAction func yellowButtonTaped(_ sender: UIButton) {
        if sender.title(for: .normal) == "X" {
            sender.setTitle("A very long title for this button", for: .normal)
          } else {
            sender.setTitle("X", for: .normal)
          }
    }
    
}

extension ViewController : UIPickerViewDataSource , UIPickerViewDelegate{
  
    // Number of columns of data
        func numberOfComponents(in pickerView: UIPickerView)->Int {
            return 3
        }
        
        // The number of rows of data
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) ->Int {
            
            return pickerData[component].count
        }
        
        // The data to return fopr the row and component (column) that's being passed in
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    
            return pickerData[component][row]
        }
    // Capture the picker view selection
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
   
                // This method is triggered whenever the user makes a change to the picker selection.
                // The parameter named row and component represents what was selected.
    }
//    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
//
//            return  NSAttributedString(string: pickerData[component][row], attributes: [NSAttributedString.Key.foregroundColor : UIColor.black])
//    }

}
