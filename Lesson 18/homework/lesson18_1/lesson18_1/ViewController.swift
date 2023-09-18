//
//  ViewController.swift
//  lesson18_1
//
//  Created by Максим Оліярник on 15.07.2023.
//

import UIKit
import CoreLocation
import MapKit
class ViewController: UIViewController {
    
    // лейбл локації
    @IBOutlet private weak var labelLocation: UILabel!
    // аутлет нашої мапи
    @IBOutlet private weak var map: MKMapView!
    //менеджер локації
    let manager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        // присвоїли делегат до менеджера локації
        manager.delegate = self
        // параметр менеджеру який задає точність(певну площу в км або м) передачі данних локації і ми присвоїли йому найкращий рівень
        manager.desiredAccuracy = kCLLocationAccuracyBest
       
    }
    // екшн який дозволяє змінити вміст лейбла тобто показати назву нашої локальної локації
    @IBAction private func getLocationButtonPush(_ sender: Any) {
        // перевірка статусу який дозвоє отримати данні , тобто ми спочатку обробляємо чи є дозвіл до витягу локації для того щоб змінити вміст лейблу
        switch manager.authorizationStatus {
        // кейс коли ми вибираєм завжди використовувати локацію або використувати при користуванні додатком
        case .authorizedAlways, .authorizedWhenInUse:
            // викликаєм метод, який дозволяє нашому додатку використовувати локацію (з самого початку статус є невідомим)
            manager.startUpdatingLocation()
            // кейс який викликає поп ап з можливістю надання доступу до локації
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
            // кейс коли ми відмовляємо в доступі до геолокації
        case .denied, .restricted:
            // MARK: Доробити для того шоб перекидати користувача в настройки для зміни статусу
            print("denied")
            showLocationDeniedAlert()
            // передбачений дефолт при появі невідомого кейсу статусу в новій айос
        @unknown default:
            break
        }
    }
    // функція яка оновлює місце положення на мапі
    private func updateLocationOnMap(location : CLLocation, title : String?){
        // створюєм анотацію тобто позначку на карті
        let point = MKPointAnnotation()
        point.title = title
        // оновляєм координати новій точці
        point.coordinate = location.coordinate
        // видаляєм всі старі позначки для того щоб вони не зберігались на мапі
        map.removeAnnotations(map.annotations)
        // додали анотацію(точку) на карту
        map.addAnnotation(point)
        // створюєм константу регіонну і задаєм йому відповідний масштаб(в даному прикладі 500 на 500 метрів)
        let mapRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        // встановлюєм регіон на об'єкті мапи
        map.setRegion(mapRegion, animated: true)
    }
    // метод, який викликається при повторному виликку локації після її відмови. Контекстне менб запропонує вам перейти в налаштування там зміни параметр приватності цього додатку на повторний дозвіл надання геолокації
    private func showLocationDeniedAlert() {
        let alert = UIAlertController(title: "Доступ до локації відмовлено", message: "Для використання функції локації додаток потребує доступу до вашого місцезнаходження. Будь ласка, надайте дозвіл в налаштуваннях додатка.", preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: "Налаштування", style: .default) { _ in
            if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Відмінити", style: .cancel, handler: nil)
        
        alert.addAction(settingsAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
}
// розширення класу делегатом , який займається апдейтом лейбла
extension ViewController : CLLocationManagerDelegate{
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            manager.startUpdatingLocation()
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first{
            // берем перший елемент масиву(оскільки він тільки один)
            CLGeocoder().reverseGeocodeLocation(location) {[weak self] placemarks, error in
                // декодуєм довготу і широту в адресу локації
                if let error = error{
                    // тут обробляєм помилку якщо вона виникає
                    print(error.localizedDescription)
                }
                if let placemark = placemarks?.first{
                    // розпаковуєм перший елемент масива позначки на карті і витягуєм звідти данні локації і присвоюєм її лейблу
                    self?.labelLocation.text = [
                        placemark.name,
                        placemark.thoroughfare,
                        placemark.subThoroughfare,
                        placemark.country,
                        placemark.postalCode,
                        placemark.subAdministrativeArea
                    ].compactMap{$0}.joined(separator: ", ")
                    if let name = placemark.name, let street = placemark.thoroughfare{
                        let title = name + ", " + street
                        self?.updateLocationOnMap(location: location, title: title)
                    }
                    
                }
                
            }
        }
        
    }
    // функція для обробки помилки
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
