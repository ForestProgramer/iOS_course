//
//  WorldTimeViewController.swift
//  Godynnyk_App
//
//  Created by Максим Оліярник on 20.02.2023.
//

import UIKit


//класс який відповідає за перший таб бар Час у світі
class WorldTimeViewController: UIViewController , WorldTimeProtocol {
    
    

    //аутлети перший navigation bar
    @IBOutlet weak var worldTimeNavItem: UINavigationItem!
    // другий аутлет головної таблиці в якій добавлються наші часи
    @IBOutlet weak var timeTableView: UITableView!
    // масив яккий зберігає назви міст яких ми вибрали
    var timeZoneToDisplay :[String] = []
    // реалізована логіка функція делегату для передаванні вибранних данних з масиву
    func addTimeZone(timeZone: String) {

        timeZoneToDisplay.append(timeZone)
        timeTableView.reloadData()
        //функція зберігання локально данних на пристрої наших вибраних міст тут ми призначаєм значення
        setUserDefaults()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //встановленні делегати для таблиці
        timeTableView.dataSource = self
        timeTableView.delegate = self
        //реалізована кодом додавання правої кпонки нав бару і його колір
        worldTimeNavItem.leftBarButtonItem = editButtonItem
        worldTimeNavItem.leftBarButtonItem?.tintColor = .systemOrange
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        // функція в якій дістаються наші значення таблиці щоб після того їх засетати
        //виконується вона коли в'. появляється на екрані
        timeZoneToDisplay = getUserDefaults()
    }
    override func setEditing(_ editing: Bool, animated: Bool) {
        //перевизначена функція редагування таблиці що дозволяє видаляти елементи
        super.setEditing(editing, animated: animated)
            self.timeTableView.setEditing(editing, animated: animated)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // функція яка виликлається перед викликом в'ю на яке ми хочемо перейти
        if segue.identifier == "modelViewSeq"{
            // і тут після перевірки ідентифікатора ми по дестінейшену задаємо делегат нашій в'ю звідки будуть передаватись значення сюди
            let destenation = segue.destination as!TimeZonesViewController
            destenation.delegate = self
        }
        
       
    }
    
    // MARK: Use UserDefaults for store properities
    // визначенні функції і логіка в них для зберігання локальних данних через об'єкт UserDefaults()
    //тут в нас встановлються значення
    func setUserDefaults(){
        UserDefaults.standard.set(timeZoneToDisplay, forKey: "WorldTimes")
        UserDefaults.standard.synchronize()
    }
    // тут ми витягуєм значення
    func getUserDefaults()->[String]{
        if UserDefaults.standard.value(forKey: "WorldTimes") != nil{
            timeZoneToDisplay = UserDefaults.standard.value(forKey: "WorldTimes") as! [String]
        }
        
        return timeZoneToDisplay
    }
}

// реалізовано розширення для делегатів таблиці датасоурс і делегейт
extension WorldTimeViewController : UITableViewDataSource,UITableViewDelegate{
    //кількість рядків у секції
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timeZoneToDisplay.count
    }
    // функція де ми створюємо кастомну комірку таблиці
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath ) as! WorldTimeTableViewCell
        // фірстСлеш це змінна для обрізання повного ім'я таймозни для коректного виводу ім'я зони в таблицю
        let firstSlash = timeZoneToDisplay[indexPath.row].index(timeZoneToDisplay[indexPath.row].firstIndex(of: "/")!, offsetBy: +1)
        // результат присвоєм лейблу з класу WorldTimeTableViewCell
        let result = String(timeZoneToDisplay[indexPath.row][firstSlash...])
        cell.timeZoneName.text = result
        cell.timeZoneName.textColor = .white
       
        cell.computedTimeZoneName = timeZoneToDisplay[indexPath.row]
        
        return cell
    }
    // кількість секцій
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    // функція яка надає можливість редагувати комірки
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    // функція яка позволяє видаляти комірки з таблиці
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            timeZoneToDisplay.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            setUserDefaults()
        }
    }
    // функція яка реалізує переміщення таблиці в режимі редагування
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let temp1 = timeZoneToDisplay[sourceIndexPath.row]
        let temp2 = timeZoneToDisplay[destinationIndexPath.row]
        
        timeZoneToDisplay[sourceIndexPath.row] = temp2
        timeZoneToDisplay[destinationIndexPath.row] = temp1
        
        tableView.reloadData()
        setUserDefaults()
    }
    // і функція яка також дозволяє переміщати комірки
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
}



