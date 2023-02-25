//
//  TimerSingleTableController.swift
//  Godynnyk_App
//
//  Created by Максим Оліярник on 16.02.2023.
//

import UIKit


class TimerSingleTableController: UIViewController {
    
 
   
    @IBOutlet var viewTimer: UIView!
    @IBOutlet weak var pickerTimer: UIPickerView!
    var pickerData: [[String]] = [[String]]()
    @IBOutlet weak var singleTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        singleTable.dataSource = self
        singleTable.delegate = self
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
        pickerTimer.setPickerLabels(labels: [0:pickerLabel1,1:pickerLabel2,2:pickerLabel3], containedView: viewTimer)
       

    }
    
    

}


extension TimerSingleTableController : UITableViewDataSource, UITableViewDelegate, UIPickerViewDataSource , UIPickerViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        
        cell.textLabel?.text = "У кінці"
        cell.accessoryType = .disclosureIndicator
        cell.backgroundColor = .darkGray
        cell.layer.cornerRadius = cell.frame.height / 3
        cell.textLabel?.textColor = .white
        cell.selectionStyle = indexPath.row == 0 ? .default : .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
            guard indexPath.row == 0 else { return }
        guard let vc = storyboard?.instantiateViewController(identifier: "SoundsTimerViewController") else{ return}
        self.present(vc, animated: true)
    }
    
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
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
            return  NSAttributedString(string: pickerData[component][row], attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
    }

}

