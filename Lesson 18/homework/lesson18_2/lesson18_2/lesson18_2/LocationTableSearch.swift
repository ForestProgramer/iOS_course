//
//  LocationTableSearch.swift
//  lesson18_2
//
//  Created by Максим Оліярник on 10.09.2023.
//
// Файл який відповідає за роботу контроллера типу UITableViewController, який буде показувати при пошуку локації відповідні результати
import MapKit
import UIKit
class LocationTableSearch : UITableViewController {

    // масив для видачі пошуку локації
    var matchItems : [MKMapItem] = []
    // зміна для маніпуляцій з головною мапою в ViewController
    var mapView : MKMapView? = nil
    // створюєм змінну протоколу для передачі данних з таблиці
    var handleMapSearchDelegate:HandleMapSearch? = nil
    //Цей метод перетворює позначку місця на спеціальний  формат адреси, наприклад: «4 Melrose Place, Washington DC».
    //В основному він додає коми та пробіли, навіть якщо деякі властивості повертаються як nil . Наприклад, немає сенсу розділяти рядок комою, якщо інформація про вулицю відсутня.
    func parseAddress(selectedItem : MKPlacemark)->String{
        // put a space between "4" and "Melrose Place"
        let firstSpace = (selectedItem.subThoroughfare != nil && selectedItem.thoroughfare != nil) ? " " : ""
        // put a comma between street and city/state
        let comma = (selectedItem.subThoroughfare != nil || selectedItem.thoroughfare != nil) && (selectedItem.subAdministrativeArea != nil || selectedItem.administrativeArea != nil) ? ", " : ""
        // put a space between "Washington" and "DC"
        let secondSpace = (selectedItem.subAdministrativeArea != nil && selectedItem.administrativeArea != nil) ? " " : ""
        let addressLine = String(
            format:"%@%@%@%@%@%@%@",
            // street number
            selectedItem.subThoroughfare ?? "",
            firstSpace,
            // street name
            selectedItem.thoroughfare ?? "",
            comma,
            // city
            selectedItem.locality ?? "",
            secondSpace,
            // state
            selectedItem.administrativeArea ?? ""
        )
        return addressLine
    }
}
// розширили даний клас для підтримки делегату
extension LocationTableSearch : UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        //Інструкція guard розгортає необов’язкові значення для mapView та текст панелі пошуку.
        guard let mapView = mapView,
              let searchBarText = searchController.searchBar.text else{
            return
        }
        //MKLocalSearchRequest : пошуковий запит складається з пошукового рядка та області карти, яка надає контекст розташування. Пошуковий рядок походить із тексту панелі пошуку, а область карти – з mapView.
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchBarText
        request.region = mapView.region
        //MKLocalSearch  виконує фактичний пошук об’єкта запиту. startWithCompletionHandler()  виконує пошуковий запит і повертає об’єкт MKLocalSearchResponse  , який містить масив mapItems . Ви зберігаєте ці mapItems у  matchingItems , а потім перезавантажуєте таблицю .
        let search = MKLocalSearch(request: request)
        search.start { response, _ in
            guard let response = response else{
                return
            }
            // передаєм вихідні данні в наш масив
            self.matchItems = response.mapItems
            // перезагружаєм табоицю для оновлення данних
            self.tableView.reloadData()
        }
    }
    
    
}
// розширили класс методами делегатів для фіксування кількості рядків таблиці , і налаштування кожного рядка таблиці
extension  LocationTableSearch {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        let selectedItem = matchItems[indexPath.row].placemark
        cell.textLabel?.text = selectedItem.name
        cell.detailTextLabel?.text = parseAddress(selectedItem: selectedItem)
        return cell
    }
}
// тут обробляєм події при нажиманні на рядок
extension LocationTableSearch {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = matchItems[indexPath.row].placemark
        handleMapSearchDelegate?.dropPinZoomIn(placemark: selectedItem)
        tableView.deselectRow(at: indexPath, animated: true)
        dismiss(animated: true, completion: nil)
    }
}
