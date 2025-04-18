//
//  AIViewModel.swift
//  OEOE
//
//  Created by 송우진 on 4/19/25.
//

import SwiftUI
import CoreLocation

final class AIViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var currentAddress: String = "현재 위치를 불러오는 중..."
    @Published var destinationAddress: String = ""

    private let locationManager = CLLocationManager()

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        guard let location = locations.last else { return }
        reverseGeocode(location: location) { [weak self] address in
            DispatchQueue.main.async {
                self?.currentAddress = address ?? "위치 확인 불가"
            }
        }
    }

    func reverseGeocode(
        location: CLLocation,
        completion: @escaping (String?) -> Void
    ) {
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            guard let placemark = placemarks?.first else {
                completion(nil)
                return
            }
            let address = [placemark.administrativeArea, placemark.locality, placemark.name].compactMap { $0 }.joined(separator: " ")
            completion(address)
        }
    }

    func setDestination(from coordinate: CLLocationCoordinate2D) {
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        reverseGeocode(location: location) { [weak self] address in
            DispatchQueue.main.async {
                self?.destinationAddress = address ?? "\(coordinate.latitude), \(coordinate.longitude)"
            }
        }
    }
}
