//
//  TimeZonesViewController.swift
//  Godynnyk_App
//
//  Created by Максим Оліярник on 20.02.2023.
//

import UIKit

protocol WorldTimeProtocol {
    func addTimeZone(timeZone : String)
}

class TimeZonesViewController: UIViewController {

    var timeZones : [String] = []
    
    @IBOutlet weak var reigionTimeTable: UITableView!
 
    @IBOutlet weak var searchReigionTime: UISearchBar!
    
    var delegate : WorldTimeProtocol?
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchReigionTime.delegate = self
        reigionTimeTable.dataSource = self
        reigionTimeTable.delegate = self
        self.searchReigionTime.backgroundColor = .clear
        self.searchReigionTime.barTintColor = .clear
        searchReigionTime.isTranslucent = true
        searchReigionTime.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        timeZones = NSTimeZone.knownTimeZoneNames
    }
    
    @IBAction func didActionForCancelButton(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedTimeZone : String = timeZones[indexPath.row]
        
        delegate?.addTimeZone(timeZone: selectedTimeZone)
        self.dismiss(animated: true, completion: nil)
        
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != ""{
            timeZones = NSTimeZone.knownTimeZoneNames.filter{$0.contains(searchText)}
            
        }else{
            timeZones = NSTimeZone.knownTimeZoneNames
            
        }
        reigionTimeTable.reloadData()
    }
}
