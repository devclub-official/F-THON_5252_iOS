//
//  AIViewModel.swift
//  OEOE
//
//  Created by 송우진 on 4/19/25.
//

import SwiftUI
import CoreLocation

final class AIViewModel: ObservableObject {
    private let locationHelper = LocationHelper()

    @Published var currentAddress: String = "현재 위치를 불러오는 중..."
    @Published var destinationAddress: String = ""

    init() {
        locationHelper.startUpdatingLocation { [weak self] location in
            self?.locationHelper.reverseGeocode(location: location) { address in
                DispatchQueue.main.async {
                    self?.currentAddress = address ?? "위치 확인 불가"
                }
            }
        }
    }

    func setDestination(from coordinate: CLLocationCoordinate2D) {
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        locationHelper.reverseGeocode(location: location) { [weak self] address in
            DispatchQueue.main.async {
                self?.destinationAddress = address ?? "\(coordinate.latitude), \(coordinate.longitude)"
            }
        }
    }
}
