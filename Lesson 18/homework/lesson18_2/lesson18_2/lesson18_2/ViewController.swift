//
//  ViewController.swift
//  lesson18_2
//
//  Created by Максим Оліярник on 08.08.2023.
//
// створили проокол який буде вказувати точку на карті після того як ми вибрали певне місце знаходження з пошуку таблиці. Задали один метод який буде вказувати по плейсмарку точку на карті.
protocol HandleMapSearch {
    func dropPinZoomIn(placemark: MKPlacemark)
}
///!!! Для того щоб у нас все працювало нам потрібно додати новий рядок в info.plst з назвою "Privacy - Location When In Use Usage Description" в стрінзі вказати точну причну для чого користувачу потрібно надати локації, тобто що це йому має дати

// підключили фреймворк UIKIt для взаємодії з юай елементами
import UIKit
// підключили фреймворк MapKit для взаємодії з юай елементами мапи
import MapKit
// підключили фреймворк CoreLocation для визначення розташування нашого девайсу на карті
import CoreLocation
class ViewController: UIViewController {

    //створиили аутлет нашої юай мапи
    @IBOutlet weak var map: MKMapView!
    // стврили аутлет кнопки яка показує наше місце знаходження на карті
    @IBOutlet weak var urLocationButton: UIButton!
    // створити поле класу locationManager для початку або зупинки дії пошуку локації
    lazy var locationManager : CLLocationManager = {
        var manager = CLLocationManager()
        manager.distanceFilter = 10
        //задали найкращу точність відстеження локації
        manager.desiredAccuracy = kCLLocationAccuracyBest
        return manager
    }()
    //змінна яка зберігає UISearchController в пам'яті після того як він буде створений
    var resultSearchController : UISearchController? = nil
    // поле вибраного піну локації на карті після пошуку
    var selectedPin : MKPlacemark? = nil
    // метод який викликається нажиманні на іконку машини і передає картам apple данні про точку яку ми попередньо вибрили і задає опцію шляху для досягнення точки від нашої поточної локації
    @objc func getDirections(){
        if let selectedPin = selectedPin {
            let mapItem = MKMapItem(placemark: selectedPin)
            let launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
            mapItem.openInMaps(launchOptions: launchOptions)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // вказали що цей контроллер буде хенлдети івенти цього делегата
        locationManager.delegate = self
        // це метод викликається при загрузці нашого додатку і викликає поп-ап віконце на вибір опцій з вибором статусу дозвулу надання локації
        locationManager.requestWhenInUseAuthorization()
//        locationManager.requestLocation()
        
        // задали змінну таблиці (контроллера) через індетифікатор який ми попередньо задали в сторіборді
        let locationSearchTable = storyboard?.instantiateViewController(identifier: "LocationTableSearch") as! LocationTableSearch
        // присвоюєм змінній resultSearchController новий контроллер контроллер з ініціалізатором searchResultsController
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        // задали делегат для відображення результатів пошуку
        resultSearchController?.searchResultsUpdater = locationSearchTable
        // задали зміну серчбару
        let searchBar = resultSearchController!.searchBar
        // викликали на ньому метод який задає розміри серчбару , які будуть підходити до нашого контроллеру
        searchBar.sizeToFit()
        // плейсхолдер
        searchBar.placeholder = "Search for places"
        // задали заголовок navigationItem-у
        navigationItem.titleView = resultSearchController?.searchBar
        // це властивівсть визначає чи Navigation Bar зникає коли результати будуть показані
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        //властивість дозволяє розмивати задній фон серч бару при його виборі.
        resultSearchController?.obscuresBackgroundDuringPresentation = true
        // властивість щоб таблиця не перекривала серч бар
        definesPresentationContext = true
        // передаєм таблиці копію нашої карти
        locationSearchTable.mapView = map
        // підпорядковуєм протокол цьому контроллеру
        locationSearchTable.handleMapSearchDelegate = self
        
    }
    // метод , який викликається при оновленні локації . Він встановлює регіон показу локаціії на мапі.
    private func updateLocationOnMap(to location : CLLocation, with title : String?){
        
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 200, longitudinalMeters: 200)
        self.map.setRegion(region, animated: true)
    }
    //дія показу нашого поточного місця знаходження при нажиманні на кнопку
    @IBAction func didTouchLocationButton(_ sender: Any) {
        if let location = locationManager.location{
            location.lookUpLocationName { name in
                self.updateLocationOnMap(to: location, with: name)
            }
            
        }
        
    }
    

}
//реалізували делегат CLLocationManagerDelegate через розширення класу для реалізації подальших делегаційний методів
extension ViewController : CLLocationManagerDelegate{
    // виклик метода делегата який спрацьовує при зміні статусу дозволу локації
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        // всередині методи ми обробляємо кейси які можливі при використанні і коли у нас один з виппадків спрацьовує то ми викликаємо метод startUpdatingLocation для старту оновлення локації
        if manager.authorizationStatus == .authorizedWhenInUse || manager.authorizationStatus == .authorizedAlways {
                   locationManager.startUpdatingLocation()
               }
    }
    // метод який спрацьовує при оновленні локації телефону і повертає масив локацій в якому перший елемент містить всю потрібну інфу про нашу поточну локації
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        location.lookUpLocationName { name in
            self.updateLocationOnMap(to: location, with: name)
        }
    }
    // метод який спрацьовує при помилці в доступі до локації
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error: \(error)")
    }
}

extension CLLocation{
    
    // розширили класс CLLocation методом який за дпомогою геокодера допамає витягати всі потрбні данні з точки дислокації
    func lookUpPlaceMark(_ handler : @escaping (CLPlacemark?)-> Void)  {
        // створили об'єкт типу CLGeocoder для перетворення між географічними координатами та назвами місць
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(self) { (placemarks, error) in
                    if error == nil {
                        let firstLocation = placemarks?.first
                        handler(firstLocation)
                    }
                    else {
                        handler(nil)
                    }
        }
    }
    // метод який повертає властивість name в нашій локації
    func lookUpLocationName(_ handler: @escaping (String?) -> Void){
        lookUpPlaceMark { placemark in
            handler(placemark?.country)
        }
    }
}
// розширеюєм наш клас реалізацією методу протоколу
extension ViewController : HandleMapSearch{
    func dropPinZoomIn(placemark: MKPlacemark) {
        // кешуєм наш пін
                selectedPin = placemark
                // очищаємо всі попередні піни(анотації)
                map.removeAnnotations(map.annotations)
                let annotation = MKPointAnnotation()
                annotation.coordinate = placemark.coordinate
                annotation.title = placemark.name
                if let city = placemark.locality,
                let state = placemark.administrativeArea {
                    // задаєм текст вибраної анотації
                    annotation.subtitle = "\(city) \(state)"
                }
        // додаєм анотацію на мапі
                map.addAnnotation(annotation)
        // задаєм радіус показу точки локації
                let span = MKCoordinateSpan(latitudeDelta: 500, longitudeDelta: 500)
        // створили рігеон показу
        let region = MKCoordinateRegion(center: placemark.coordinate, latitudinalMeters: span.latitudeDelta, longitudinalMeters: span.longitudeDelta)
        // задали регіон на карті
                map.setRegion(region, animated: true)
    }
    
    
}
// розширяєм клас делегатом мапи
extension ViewController : MKMapViewDelegate {
    // метод в якому можна редагувати вигляд анотації
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
        if annotation is MKUserLocation {
            // поверне ніл, то буде показуватись синя крапка для звичайної локації юзера
            return nil
        }
        // створюєм та задаєм налаштування для анотації та вигляд його колауту тобто меню яке появиться при нажиманні на анотацію
        let reuseId = "pin"
        var pinView = map.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
        pinView?.pinTintColor = UIColor.orange
        pinView?.canShowCallout = true
        let smallSquare = CGSize(width: 30, height: 30)
        let button = UIButton(frame: CGRect(origin: CGPoint.zero, size: smallSquare))
        button.setBackgroundImage(UIImage(systemName: "car.fill"), for: .normal)
        button.addTarget(self, action: #selector(getDirections), for: .touchUpInside)
        pinView?.leftCalloutAccessoryView = button
        return pinView
    }
}
