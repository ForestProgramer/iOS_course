//
//  AlarmTabViewController.swift
//  Godynnyk_App
//
//  Created by Максим Оліярник on 23.02.2023.
//

import UIKit

class AlarmTabViewController: UIViewController {

 
    @IBOutlet weak var navigationAlarmBar: UINavigationItem!
    @IBOutlet weak var alarmTable: UITableView!
    var timeAlarmToDisplay :[String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        alarmTable.dataSource = self
        alarmTable.delegate = self
        navigationAlarmBar.leftBarButtonItem = editButtonItem
        navigationAlarmBar.leftBarButtonItem?.tintColor = .systemOrange
        // Do any additional setup after loading the view.
    }
    

    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
            self.alarmTable.setEditing(editing, animated: animated)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension AlarmTabViewController : UITableViewDataSource , UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        timeAlarmToDisplay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "defaultcells",for: indexPath ) as! SingleAlarmTableViewCell
        
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
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let temp1 = timeAlarmToDisplay[sourceIndexPath.row]
        let temp2 = timeAlarmToDisplay[destinationIndexPath.row]
        
        timeAlarmToDisplay[sourceIndexPath.row] = temp2
        timeAlarmToDisplay[destinationIndexPath.row] = temp1
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
}
