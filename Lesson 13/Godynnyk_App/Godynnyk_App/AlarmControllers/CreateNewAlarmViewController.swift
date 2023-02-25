//
//  CreateNewAlarmViewController.swift
//  Godynnyk_App
//
//  Created by Максим Оліярник on 23.02.2023.
//

import UIKit

class CreateNewAlarmViewController: UIViewController , GetSound , NameOfNewAlarm , RepeatAlarm{
    func whenRepeat(days: [String]) {
        days.forEach { chosenTitlesAlarm[0] += $0}
    }
    
    func addNameAlarm(text: String) {
        chosenTitlesAlarm.insert(text, at: 1)
    }
    
    func addSound(sound: String) {
        chosenTitlesAlarm.insert(sound, at: 2)
        tableAlarmParametrs.reloadData()
        print(chosenTitlesAlarm)
    }
    

    @IBOutlet weak var pickerAlarm: UIPickerView!
    var pickerData : [[String]] = [[String]]()
    @IBOutlet weak var tableAlarmParametrs: UITableView!
    let titlesParametrs : [String] = ["Повторювати", "Назва","Звук", "Відкласти"]
    var chosenTitlesAlarm : [String] = ["Ніколи","Сигнал","Радар"]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableAlarmParametrs.delegate = self
        tableAlarmParametrs.dataSource = self
        tableAlarmParametrs.layer.cornerRadius = tableAlarmParametrs.frame.height/10
        pickerAlarm.delegate = self
        pickerAlarm.dataSource = self
        pickerData = [["00", "01", "02", "03","04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22","23"],
                      ["00", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22","23","24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46","47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59"]
        ]
        print(chosenTitlesAlarm)
        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
            let destenation1 = segue.destination as! RepeatAlarmChoiceViewController
            destenation1.delegateRepeat = self
        
            let destenation2 = segue.destination as! NameForAlarmViewController
            destenation2.delegateName = self
        
            let destenation3 = segue.destination as! SoundForNewAlarmViewController
            destenation3.delegateSound = self
        
    }
}

extension CreateNewAlarmViewController : UITableViewDelegate, UITableViewDataSource,  UIPickerViewDataSource , UIPickerViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        titlesParametrs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row < 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "alarmParametrCells",for: indexPath ) as! SingleAlarmTableViewCell
            cell.titleParametrLabel.text = titlesParametrs[indexPath.row]
            cell.chosedAlarmParametrLabel.text = chosenTitlesAlarm[indexPath.row] 
            return cell
        }else{
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "alarmParametrCellsSwitch",for: indexPath ) as! SingleAlarmTableViewCell
            cell2.titleParametrLabel.text = titlesParametrs[indexPath.row]
            cell2.parametrSwitcher.isOn = false
            
            return cell2
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//            guard indexPath.row == 0 else { return }

        switch indexPath.row {
        case 0:
            guard let vc = storyboard?.instantiateViewController(identifier: "AlarmParametrsTable1") else{ return}
            self.navigationController?.pushViewController(vc, animated: true)
//            vc.performSegue(withIdentifier: "repeatingAlarmSegue", sender: self)
        case 1:
            guard let vc = storyboard?.instantiateViewController(identifier: "AlarmParametrsTable2") else{ return}
            self.navigationController?.pushViewController(vc, animated: true)
//            vc.performSegue(withIdentifier: "nameAlarmSegue", sender: self)
        case 2:
            guard let vc = storyboard?.instantiateViewController(identifier: "AlarmParametrsTable3") else{ return}
            self.navigationController?.pushViewController(vc, animated: true)
//            vc.performSegue(withIdentifier: "soundAlarmSegue", sender: self)
        default:
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
        
    }
    
    
    
    // Number of columns of data
        func numberOfComponents(in pickerView: UIPickerView)->Int {
            return 2
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

