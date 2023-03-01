//
//  TimerSingleTableController.swift
//  Godynnyk_App
//
//  Created by Максим Оліярник on 16.02.2023.
//

import UIKit
// клас таб бару для таймера(декрементора часу)

class TimerSingleTableController: UIViewController , SoundForTimer {
    func getSoundTimer(name: String) {
        chosenLabel = name
        singleTable.reloadData()
    }
    
    
 
   // аутлети
    @IBOutlet var viewTimer: UIView!
    @IBOutlet weak var pickerTimer: UIPickerView!
    var pickerData: [[String]] = [[String]]()
    @IBOutlet weak var singleTable: UITableView!
    @IBOutlet weak var timerResetButton: UIButton!
    @IBOutlet weak var timerStartStopButton: UIButton!
    var upperLabel : UILabel = {
        // головний лейбл який буде показувати час після запуску таймера
        let label = UILabel()
        
        
        label.backgroundColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 70, weight:  .thin)
        label.textAlignment = .center
   
        
        return label
    }()
    // таймер об'єкт
    var timer : Timer = Timer()
    // каунтер для розуміння на паузі таймер чи ні
    var counter : Int = 0
    // бул змінна для стоп чи старт таймеру
    var timeCounting : Bool = false
    // години хвилини і секунди які отримали з пікера
    var hours : Int = 0
    var mins : Int = 0
    var secs : Int = 0
    // години хвилини і секунди які ми будемо виводити на лейбл(це зроблено для того щоб якшо після першого вибору пікера ми запустемо таймер і ресетним його і захочемо знову запустити його на тому самому часі що і до того , то ми зберігаємо ці данні тому що якщо цього не зробити то будуть нулі а так в нас є зереженні данні )
    var chosedHours : Int = 0
    var chosedMinutes : Int = 0
    var chosedSeconds : Int = 0
    // енум формат для стейтів наших кнопок
    enum StateForBuuton{
        case defaultState
        case continueState
        case pauseState
    }
    var chosenLabel : String = "Радар"
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
        // тут я задава лебйли і текст які мають бути біля цифр
        let pickerLabel1 = UILabel()
        pickerLabel1.text = "год"
        let pickerLabel2 = UILabel()
        pickerLabel2.text = "хв"
        let pickerLabel3 = UILabel()
        pickerLabel3.text = "с"
        // ЦЯ ФУНКЦІЯ ЦЕ РОЗШИРЕННЯ ПІКЕРА В ФАЙЛІ PICKERLABELS оскільки я не найшов можливості задати ім'я компонетам
        pickerTimer.setPickerLabels(labels: [0:pickerLabel1,1:pickerLabel2,2:pickerLabel3], containedView: viewTimer)
        timerResetButton.isUserInteractionEnabled = false
        timerResetButton.alpha = 0.5
       
    }
    func createNewConstrraints (){
        // констрейти для нашого мабутнього сабв'ю з лейблом
        upperLabel.leftAnchor.constraint(equalTo: pickerTimer.leftAnchor).isActive = true
        upperLabel.rightAnchor.constraint(equalTo: pickerTimer.rightAnchor).isActive = true
        upperLabel.topAnchor.constraint(equalTo: pickerTimer.topAnchor).isActive = true
        upperLabel.bottomAnchor.constraint(equalTo: pickerTimer.bottomAnchor).isActive = true
    }
    // екшн для кпонки рісет
    @IBAction func didTapResetButton(_ sender: Any) {
        self.timer.invalidate()
        // видаляємо в'ю з супер в'ю
        upperLabel.removeFromSuperview()
        pickerTimer.isHidden = false
        timeCounting = false
        // присвоюжмо наші попередньо вибранні данні
        hours = chosedHours
        mins = chosedMinutes
        secs = chosedSeconds
        // обнуляємо канутер
        counter = 0
        // обновляємо лебйбл
        updateLabelTimer()
        // функція яка задає вигляд кнопці від відповідного заданого стейту
        resetViewToDefault(buttonToDefaultState: .defaultState)
        timerResetButton.isUserInteractionEnabled = false
        timerResetButton.alpha = 0.5
    }
    // екшн для кнопки старт-пауза
    @IBAction func didTapStartStopButton(_ sender: Any) {
        counter += 1
        // ці функція нам потрібно виконати тільки коли мми вперше запускаємо наш таймер
        if counter == 1 {
            pickerTimer.isHidden = true
            self.view.addSubview(upperLabel)
            createNewConstrraints()
            timerResetButton.isUserInteractionEnabled = true
            timerResetButton.alpha = 1
            chosedHours = hours
            chosedMinutes = mins
            chosedSeconds = secs
        }
        timeCounting = !timeCounting
        if (timeCounting){
            // таймер працює
            updateLabelTimer()
            resetViewToDefault(buttonToDefaultState: .pauseState)
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerDecrementor), userInfo: nil, repeats: true)
            print("Working")
            
        }else{
            // таймер не працює
            timer.invalidate()
            resetViewToDefault(buttonToDefaultState: .continueState)
            print("Not working")
        }
        
    }
    // функція для логіки таймера обрахування секунд годин і хвилин
    @objc func timerDecrementor()->Void{
        self.updateLabelTimer()
        if self.secs > 0{
            self.secs = self.secs - 1
        }else if self.mins > 0 &&  self.secs == 0{
            self.mins = self.mins - 1
            self.secs = 59
        }else if self.hours > 0 &&  self.mins == 0 && self.secs == 0{
            self.hours = self.hours - 1
            self.mins = 59
            self.secs = 59
        }else if hours == 0 && mins == 0 && secs == 0{
            // якщо в нас все по нулям то сав'ю пропадає і кнопка рісет стає недоступна і напів прозора
            upperLabel.removeFromSuperview()
            pickerTimer.isHidden = false
            counter = 0
            resetViewToDefault(buttonToDefaultState: .defaultState)
            timerResetButton.isUserInteractionEnabled = false
            timerResetButton.alpha = 0.5
        }
        
    }
    
    // функція для обновлення лейблу таймера
    func updateLabelTimer(){
        upperLabel.text = "\(hours):\(mins):\(secs)"
    }
    
    // функція для обновлення вигляду кнопки
    func resetViewToDefault(buttonToDefaultState state : StateForBuuton ){
        if state == .continueState{
            timerStartStopButton.setTitle("Далі", for: .normal)
            timerStartStopButton.setTitleColor(UIColor.systemGreen, for: .normal)
            timerStartStopButton.tintColor = .init(red: 0.09, green: 0.37, blue: 0.09, alpha: 0.5)
        }else if state == .defaultState {
            timerStartStopButton.setTitle("Старт", for: .normal)
            timerStartStopButton.setTitleColor(UIColor.systemGreen, for: .normal)
            timerStartStopButton.tintColor = .init(red: 0.09, green: 0.37, blue: 0.09, alpha: 0.5)
            
        }else if state == .pauseState{
            timerStartStopButton.setTitle("Пауза", for: .normal)
            timerStartStopButton.setTitleColor(UIColor.systemOrange, for: .normal)
            timerStartStopButton.tintColor = .init(red: 0.76, green: 0.44, blue: 0.11, alpha: 0.5)
        }
    }
}
    

// розширення для таблиці і пікера делегатів

extension TimerSingleTableController : UITableViewDataSource, UITableViewDelegate, UIPickerViewDataSource , UIPickerViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ChosedSoundTableViewCell
        
        cell.generalLabelChoose.text = "У кінці"
        cell.choosedSoundLabel.text = chosenLabel
        cell.accessoryType = .disclosureIndicator
        cell.layer.cornerRadius = cell.frame.height / 3
        cell.textLabel?.textColor = .white
        cell.selectionStyle = indexPath.row == 0 ? .default : .none
        return cell
    }
    // налаштовуєм зв'язок з в'ю з параметрами
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
            guard indexPath.row == 0 else { return }
        guard let vc = storyboard?.instantiateViewController(identifier: "SoundsTimerViewController") as? SoundsTimerViewController else{ return}
        vc.delegateSoundTimer = self
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
        // присвоювання змінним данні які ми вибранили
        hours = Int(pickerData[0][pickerView.selectedRow(inComponent: 0)])!
        mins = Int(pickerData[1][pickerView.selectedRow(inComponent: 1)])!
        secs = Int(pickerData[2][pickerView.selectedRow(inComponent: 2)])!
    }
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
            return  NSAttributedString(string: pickerData[component][row], attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
    }

}

