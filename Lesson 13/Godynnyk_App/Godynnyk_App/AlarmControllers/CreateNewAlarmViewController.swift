//
//  CreateNewAlarmViewController.swift
//  Godynnyk_App
//
//  Created by Максим Оліярник on 23.02.2023.
//

import UIKit
// реалізований проткол делегату
protocol PassDataToRootController {
    func passData(dataTuples : (hours : String , minutes : String , repeating : String , name : String, sound : String))
}
// клас в'ю де ми встановлюємо параметри будильника(три різні протоколи наслідується)
class CreateNewAlarmViewController: UIViewController , GetSound , NameOfNewAlarm , RepeatAlarm{
    // логіка протоколу для отримання параметру кол повторюється наш будильник
    func whenRepeat(days: [String]) {
        chosenTitlesAlarm[0] = ""
        
        for index in days{
            if days.count == 1 {
                chosenTitlesAlarm[0] += index
                break
            }
            switch index {
            case "Щопонеділка":
                chosenTitlesAlarm[0] += "Пн" + " "
            case "Щовівторка":
                chosenTitlesAlarm[0] += "Вт" + " "
            case "Щосереди":
                chosenTitlesAlarm[0] += "Ср" + " "
            case "Щочетверга":
                chosenTitlesAlarm[0] += "Чт" + " "
            case "Щоп'ятниці":
                chosenTitlesAlarm[0] += "Пт" + " "
            case "Щосуботи":
                chosenTitlesAlarm[0] += "Сб" + " "
            case "Щонеділі":
                chosenTitlesAlarm[0] += "Нд" + " "
            default:
                chosenTitlesAlarm[0] += " "
            }
    }
        alarmDataToDisplay.repeating = chosenTitlesAlarm[0]
        tableAlarmParametrs.reloadData()
}
    // логіка делеглату де ми додажмо нове ім'я будильнику
    func addNameAlarm(text: String) {
        chosenTitlesAlarm.remove(at: 1)
        chosenTitlesAlarm.insert(text, at: 1)
        alarmDataToDisplay.name = chosenTitlesAlarm[1]
        tableAlarmParametrs.reloadData()

    }
    // логіка делеглату де ми додажмо новий Сигнал будильника
    func addSound(sound: String) {
        chosenTitlesAlarm.remove(at: 2)
        chosenTitlesAlarm.insert(sound, at: 2)
        alarmDataToDisplay.sound = chosenTitlesAlarm[2]
        tableAlarmParametrs.reloadData()
        
    }
    
    // аутлети , дані пікера тобто години які ми виберемо , статичні дефолтні данні наших параметрів
    @IBOutlet weak var pickerAlarm: UIPickerView!
    var pickerData : [[String]] = [[String]]()
    @IBOutlet weak var tableAlarmParametrs: UITableView!
    let titlesParametrs : [String] = ["Повторювати", "Назва","Звук", "Відкласти"]
    var chosenTitlesAlarm : [String] = ["Ніколи","Сигнал","Радар"]
    // реалізована змінна делегату
    var delegateData : PassDataToRootController?
    // тюплз де ми будемо передавати всі наші данні через делегат
    var alarmDataToDisplay : (hours : String , minutes : String , repeating : String , name : String, sound : String) = (hours : "", minutes : "" , repeating : "" , name : "", sound : "")
    override func viewDidLoad() {
        super.viewDidLoad()
        // присвоєні делегати таблиці і пікеру
        tableAlarmParametrs.delegate = self
        tableAlarmParametrs.dataSource = self
        tableAlarmParametrs.layer.cornerRadius = tableAlarmParametrs.frame.height/10
        pickerAlarm.delegate = self
        pickerAlarm.dataSource = self
        pickerData = [["00", "01", "02", "03","04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22","23"],
                      ["00", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22","23","24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46","47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59"]
        ]
      
    }
    // екшн для кнопки зберігання
    @IBAction func didTapSaveButton(_ sender: Any) {
        // викликаєм змінну деоегату для передавання данних
        delegateData?.passData(dataTuples: alarmDataToDisplay)
        // і ховаєм наше в'ю
        self.dismiss(animated: true, completion: nil)
    }
}

// роширення класу
extension CreateNewAlarmViewController : UITableViewDelegate, UITableViewDataSource,  UIPickerViewDataSource , UIPickerViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        titlesParametrs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // через умову реалізував дві різні комріки хоча вони одного і того самого класу але мають різні ідентифікатори
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

// тут ми реалізовуєм кодом наші зв'язки з в'ю де є наші данні які ми можемо вибрати за домопомогою світч кейсу
        switch indexPath.row {
        case 0:
            guard let vc = storyboard?.instantiateViewController(identifier: "AlarmParametrsTable1") as? RepeatAlarmChoiceViewController else{ return}
            vc.delegateRepeat = self
            self.navigationController?.pushViewController(vc, animated: true)

        case 1:
            guard let vc = storyboard?.instantiateViewController(identifier: "AlarmParametrsTable2") as? NameForAlarmViewController else{ return}
            vc.delegateName = self
            self.navigationController?.pushViewController(vc, animated: true)

        case 2:
            guard let vc = storyboard?.instantiateViewController(identifier: "AlarmParametrsTable3") as? SoundForNewAlarmViewController else{ return}
            vc.delegateSound = self
            self.navigationController?.pushViewController(vc, animated: true)

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
        alarmDataToDisplay.hours = pickerData[0][pickerView.selectedRow(inComponent: 0)]
        alarmDataToDisplay.minutes = pickerData[1][pickerView.selectedRow(inComponent: 1)]
    }
    // взяв функцію зі стак оверфлоу для того щоб зробити колір тексту пікера білим
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
            return  NSAttributedString(string: pickerData[component][row], attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
    }
    
    

}

