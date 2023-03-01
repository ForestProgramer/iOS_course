//
//  RepeatAlarmChoiceViewController.swift
//  Godynnyk_App
//
//  Created by Максим Оліярник on 24.02.2023.
//

import UIKit
// реалізований протокол для передавання параметру повторення
protocol RepeatAlarm {
    func whenRepeat(days : [String])
}

class RepeatAlarmChoiceViewController: UIViewController {
// аутлети таблиці з виборором парметрів
    @IBOutlet weak var tableRepeatAlarmChoice: UITableView!
    // статичні данні
    let choicesRepeat : [String] = ["Щопонеділка","Щовівторка","Щосереди","Щочетверга","Щоп'ятниці","Щосуботи","Щонеділі"]
    // массив для запису вибору парметра
    var daysToDisplay : [String] = []
    //змінна делегату
    var delegateRepeat : RepeatAlarm?
    override func viewDidLoad() {
        super.viewDidLoad()
        // присвоїв делегати таблиці
        tableRepeatAlarmChoice.delegate = self
        tableRepeatAlarmChoice.dataSource = self
        // Do any additional setup after loading the view.
    }
    

  
    

}
// роширення таблиці
extension RepeatAlarmChoiceViewController : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        choicesRepeat.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "AlarmRepeatCell", for: indexPath)
        cell.textLabel?.text = choicesRepeat[indexPath.row]
        
        return cell
    }
    // при виборі комірки  передаєм  данні через делегат
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            daysToDisplay.remove(at: indexPath.row)
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            daysToDisplay.append((tableView.cellForRow(at: indexPath)?.textLabel?.text)!)
            delegateRepeat?.whenRepeat(days: daysToDisplay)
        }
    }
    
}
