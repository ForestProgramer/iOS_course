//
//  TimeZonesViewController.swift
//  Godynnyk_App
//
//  Created by Максим Оліярник on 20.02.2023.
//

import UIKit
// протокол для реалізації делегату
protocol WorldTimeProtocol {
    func addTimeZone(timeZone : String)
}
//клас в'ю де ми можемо вибрати регіон і додати в таблицю
class TimeZonesViewController: UIViewController {
//масив який показує ім'я таймзони
    var timeZones : [String] = []
    // аутлети таблиці яка виводить імена таймзони
    @IBOutlet weak var reigionTimeTable: UITableView!
 // аутлет серчбара
    @IBOutlet weak var searchReigionTime: UISearchBar!
    // змінна делегату
    var delegate : WorldTimeProtocol?
    //сховали статус бар
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //присвоїні делегати і датасорс для таблиці і серчбара
        searchReigionTime.delegate = self
        reigionTimeTable.dataSource = self
        reigionTimeTable.delegate = self
        //задали кольора для серчбара
        self.searchReigionTime.backgroundColor = .clear
        self.searchReigionTime.barTintColor = .clear
        searchReigionTime.isTranslucent = true
        searchReigionTime.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        //присвоювання масиву всіх доступних зон через клас NSTimeZone і функцію knownTimeZoneNames
        timeZones = NSTimeZone.knownTimeZoneNames
    }
    // екшн для кнопки скасування
    @IBAction func didActionForCancelButton(_ sender: Any) {
        // закриваєтсья в'ю коли ми нажимаєм кнопку
        self.dismiss(animated: true, completion: nil)
    }

}
// розширення класу
extension TimeZonesViewController : UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timeZones.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = timeZones[indexPath.row]
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    // функція виликається коли ми вибираєм комірку і тут ми передаєм данні через делегат і закриваєм в'ю
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedTimeZone : String = timeZones[indexPath.row]
        
        delegate?.addTimeZone(timeZone: selectedTimeZone)
        self.dismiss(animated: true, completion: nil)
        
    }
// функція яка викливається коли текст в серчбарі був змінений і тут реалізована логіка пошуку
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != ""{
            timeZones = NSTimeZone.knownTimeZoneNames.filter{$0.contains(searchText)}
            
        }else{
            timeZones = NSTimeZone.knownTimeZoneNames
            
        }
        reigionTimeTable.reloadData()
    }
}
