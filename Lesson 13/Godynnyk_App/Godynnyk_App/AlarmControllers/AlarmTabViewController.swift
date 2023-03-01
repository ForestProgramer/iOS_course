//
//  AlarmTabViewController.swift
//  Godynnyk_App
//
//  Created by Максим Оліярник on 23.02.2023.
//

import UIKit
// клас для другого таб бару Будильник
class AlarmTabViewController: UIViewController , PassDataToRootController {
    // реалізована логіка делегату для передавання данних
    func passData(dataTuples: (hours: String, minutes: String, repeating: String, name: String, sound: String)) {
        timeAlarmToDisplay.append(dataTuples.hours + ":" + dataTuples.minutes)
        if dataTuples.repeating.isEmpty && !dataTuples.name.isEmpty {
            nameAndRepeatToDisplay.append(dataTuples.name)
        }else if dataTuples.repeating.isEmpty && dataTuples.name.isEmpty {
            nameAndRepeatToDisplay.append("Сигнал")
        }else if  !dataTuples.repeating.isEmpty && !dataTuples.name.isEmpty {
            nameAndRepeatToDisplay.append(dataTuples.name + ", " + dataTuples.repeating)
        }else if  !dataTuples.repeating.isEmpty && dataTuples.name.isEmpty{
            nameAndRepeatToDisplay.append("Сигнал" + ", " + dataTuples.repeating)
        }
        print(nameAndRepeatToDisplay)
        alarmTable.reloadData()
        // сетайєм значення локально
        setUserDefaults()
    }
    
    

 
    @IBOutlet weak var navigationAlarmBar: UINavigationItem!
    @IBOutlet weak var alarmTable: UITableView!
    // час будильника
    var timeAlarmToDisplay :[String] = []
    // ім'я і коли буде повторюватись будильник
    var nameAndRepeatToDisplay : [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // присвоїв деоегати таблиці
        alarmTable.dataSource = self
        alarmTable.delegate = self
        navigationAlarmBar.leftBarButtonItem = editButtonItem
        navigationAlarmBar.leftBarButtonItem?.tintColor = .systemOrange
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        // отримує значення з двох масивів
        timeAlarmToDisplay = getUserDefaultsOne()
        nameAndRepeatToDisplay = getUserDefaultsTwo()
    }


    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
            self.alarmTable.setEditing(editing, animated: animated)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("Not inside")
        if segue.identifier == "modelAlarmSegue"{
            print("Here we are!!!")
           if let destVC = segue.destination as? UINavigationController,
              let targetController = destVC.topViewController as? CreateNewAlarmViewController{
            
            targetController.delegateData = self
           }
                      
        }
    }
    // MARK: Use UserDefaults for store properities
    func setUserDefaults(){
        UserDefaults.standard.set(timeAlarmToDisplay, forKey: "YourAlarms")
        UserDefaults.standard.set(nameAndRepeatToDisplay,forKey: "NameAndRepeat")
        UserDefaults.standard.synchronize()
    }
// тут реалізував дві функції для отримання значень для двох масивів
    func getUserDefaultsOne()->[String]{
        if UserDefaults.standard.value(forKey: "YourAlarms") != nil{
            timeAlarmToDisplay = UserDefaults.standard.value(forKey: "YourAlarms") as! [String]
        }
        return timeAlarmToDisplay
    }
    func getUserDefaultsTwo()->[String]{
         if UserDefaults.standard.value(forKey: "NameAndRepeat") != nil{
            nameAndRepeatToDisplay = UserDefaults.standard.value(forKey: "NameAndRepeat") as! [String]
        }
        return nameAndRepeatToDisplay
    }
}
// розширення(тут майже все так само як і минулого класі для таб бару Час у світі) 
extension AlarmTabViewController : UITableViewDataSource , UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        timeAlarmToDisplay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "defaultcells",for: indexPath ) as! SingleAlarmTableViewCell
        cell.statusWhenRepeatLabel.text = nameAndRepeatToDisplay[indexPath.row]
        cell.estimatedAlarmTime.text = timeAlarmToDisplay[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            timeAlarmToDisplay.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            setUserDefaults()
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let temp1 = timeAlarmToDisplay[sourceIndexPath.row]
        let temp2 = timeAlarmToDisplay[destinationIndexPath.row]
        
        timeAlarmToDisplay[sourceIndexPath.row] = temp2
        timeAlarmToDisplay[destinationIndexPath.row] = temp1
        
        tableView.reloadData()
        setUserDefaults()
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
}
