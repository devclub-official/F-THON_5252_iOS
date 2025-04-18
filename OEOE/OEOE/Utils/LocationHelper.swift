//
//  LocationHelper.swift
//  OEOE
//
//  Created by 송우진 on 4/19/25.
//

import Foundation
import CoreLocation

final class LocationHelper: NSObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    private var locationUpdateHandler: ((CLLocation) -> Void)?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func startUpdatingLocation(_ handler: @escaping (CLLocation) -> Void) {
        locationUpdateHandler = handler
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        locationUpdateHandler?(location)
    }

    func reverseGeocode(location: CLLocation, completion: @escaping (String?) -> Void) {
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            guard let placemark = placemarks?.first else {
                completion(nil)
                return
            }
            let address = [placemark.administrativeArea, placemark.locality, placemark.name]
                .compactMap { $0 }
                .joined(separator: " ")
            completion(address)
        }
    }
}
