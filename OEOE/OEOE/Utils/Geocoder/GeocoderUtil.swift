//
//  GeocoderUtil.swift
//  OEOE
//
//  Created by zeze on 4/19/25.
//

import CoreLocation
// 좌표로 받은 데이터를 한글명으로 변환
func getKoreanCityName(lat: Double, lon: Double, completion: @escaping (String?) -> Void) {
    let location = CLLocation(latitude: lat, longitude: lon)
    let geocoder = CLGeocoder()

    geocoder.reverseGeocodeLocation(location, preferredLocale: Locale(identifier: "ko_KR")) { placemarks, error in
        if let placemark = placemarks?.first {
        
            let city = placemark.locality ?? placemark.administrativeArea
            completion(city)
        } else {
            completion(nil)
        }
    }
}
