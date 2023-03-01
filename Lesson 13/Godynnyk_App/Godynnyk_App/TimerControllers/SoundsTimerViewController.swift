//
//  SoundsTimerViewController.swift
//  Godynnyk_App
//
//  Created by Максим Оліярник on 16.02.2023.
//

import UIKit
protocol SoundForTimer{
    func getSoundTimer (name : String)
}

class SoundsTimerViewController : UIViewController {
    
    @IBOutlet weak var tableSoundsForTimer: UITableView!
    let dataSoundsToDisplay : [String] = ["Радар(типовий)", "Апекс","Брижі","Відкриття","Вістка","Дозвілля","Збори","Космос","Кристали","Куранти","Мерехтіння","На пляжі","Опівнічник","Осяяння","Пагорб","Піднесення","Престо","Пробудження","Промені","Радіомаяк"]
    
    var delegateSoundTimer : SoundForTimer?
    
    var selectedSound : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        tableSoundsForTimer.delegate = self
        tableSoundsForTimer.dataSource = self
    }
    @IBAction func didTapCancelButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    @IBAction func didTapSaveButton(_ sender: Any) {
        delegateSoundTimer?.getSoundTimer(name: selectedSound)
        self.dismiss(animated: true)
    }
}

extension SoundsTimerViewController : UITableViewDataSource , UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSoundsToDisplay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = dataSoundsToDisplay[indexPath.row]
        cell.textLabel?.textColor = .white
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
         selectedSound = dataSoundsToDisplay[indexPath.row]
        
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
    
    
}
