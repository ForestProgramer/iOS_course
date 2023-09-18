//
//  ViewController.swift
//  lesson18
//
//  Created by Volodymyr Rykhva on 19.07.2021.
//

import UIKit
import CoreLocation
import MapKit

final class ViewController: UIViewController {

    @IBOutlet private weak var locationLabel: UILabel!
    @IBOutlet private weak var mapView: MKMapView!

    let manager = CLLocationManager()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
    }

    @IBAction private func getLocationDidTouch(_ sender: Any) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            manager.startUpdatingLocation()
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .denied, .restricted:
            print("denied")
        @unknown default:
            break
        }
    }

    // MARK: - Private

    private func updateLocationOnMap(location: CLLocation, title: String?) {
        let point = MKPointAnnotation()
        point.title = title
        point.coordinate = location.coordinate

        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotation(point)

        let viewRegion = MKCoordinateRegion(center: location.coordinate,
                                            latitudinalMeters: 100,
                                            longitudinalMeters: 100)
        mapView.setRegion(viewRegion, animated: true)
    }
}

// MARK: - CLLocationManagerDelegate

extension ViewController: CLLocationManagerDelegate {

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            manager.startUpdatingLocation()
        default: break
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            CLGeocoder().reverseGeocodeLocation(location) { [weak self] placemarks, errors in
                if let error = errors {
                    print(error.localizedDescription)
                }

                if let placemark = placemarks?.first {
                    self?.locationLabel.text =
                        [
                            placemark.name,
                            placemark.thoroughfare,
                            placemark.subThoroughfare,
                            placemark.country,
                            placemark.postalCode,
                            placemark.administrativeArea,
                            placemark.subAdministrativeArea
                        ]
                        .compactMap { $0 }
                        .joined(separator: ", ")

                    if let name = placemark.name, let street = placemark.thoroughfare {
                        let title = name + street
                        self?.updateLocationOnMap(location: location, title: title)
                    }
                }
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}

