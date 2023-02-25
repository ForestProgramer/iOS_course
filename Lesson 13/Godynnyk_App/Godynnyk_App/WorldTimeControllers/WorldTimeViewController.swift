//
//  WorldTimeViewController.swift
//  Godynnyk_App
//
//  Created by Максим Оліярник on 20.02.2023.
//

import UIKit



class WorldTimeViewController: UIViewController , WorldTimeProtocol {
    
    

    
    @IBOutlet weak var worldTimeNavItem: UINavigationItem!
    @IBOutlet weak var timeTableView: UITableView!
    var timeZoneToDisplay :[String] = []
    
    func addTimeZone(timeZone: String) {

        timeZoneToDisplay.append(timeZone)
        timeTableView.reloadData()
        setUserDefaults()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        timeTableView.dataSource = self
        timeTableView.delegate = self
        worldTimeNavItem.leftBarButtonItem = editButtonItem
        worldTimeNavItem.leftBarButtonItem?.tintColor = .systemOrange
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        timeZoneToDisplay = getUserDefaults()
    }
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
            self.timeTableView.setEditing(editing, animated: animated)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "modelViewSeq"{
            let destenation = segue.destination as!TimeZonesViewController
            destenation.delegate = self
        }
        
        // MARK: Use UserDefaults for store properities
    }
    func setUserDefaults(){
        UserDefaults.standard.set(timeZoneToDisplay, forKey: "WorldTimes")
        UserDefaults.standard.synchronize()
    }
    
    func getUserDefaults()->[String]{
        if UserDefaults.standard.value(forKey: "WorldTimes") != nil{
            timeZoneToDisplay = UserDefaults.standard.value(forKey: "WorldTimes") as! [String]
        }
        
        return timeZoneToDisplay
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

extension WorldTimeViewController : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timeZoneToDisplay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath ) as! WorldTimeTableViewCell
        let firstSlash = timeZoneToDisplay[indexPath.row].index(timeZoneToDisplay[indexPath.row].firstIndex(of: "/")!, offsetBy: +1)
        let result = String(timeZoneToDisplay[indexPath.row][firstSlash...])
        cell.timeZoneName.text = result
        cell.timeZoneName.textColor = .white
       
        cell.computedTimeZoneName = timeZoneToDisplay[indexPath.row]
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            timeZoneToDisplay.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            setUserDefaults()
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let temp1 = timeZoneToDisplay[sourceIndexPath.row]
        let temp2 = timeZoneToDisplay[destinationIndexPath.row]
        
        timeZoneToDisplay[sourceIndexPath.row] = temp2
        timeZoneToDisplay[destinationIndexPath.row] = temp1
        
        tableView.reloadData()
        setUserDefaults()
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
}



