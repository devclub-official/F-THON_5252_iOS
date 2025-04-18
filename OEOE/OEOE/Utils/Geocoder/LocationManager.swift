import Foundation
import CoreLocation
class LocationService : NSObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    var completionHandler: ((CLLocationCoordinate2D) -> (Void))?
    
    override init() {
        super.init()
        print("coordinate: LocationService")
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
    }
    
    func requestLocation(completion: @escaping ((CLLocationCoordinate2D) -> (Void))) {
        completionHandler = completion
        manager.requestLocation()
        
    }
    func stopUpdatingLocation() {
        manager.stopUpdatingHeading()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        if let completion = self.completionHandler {
            completion(location.coordinate)
        }
        manager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
