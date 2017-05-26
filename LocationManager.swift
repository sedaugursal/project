
import Foundation
import CoreLocation

class LocationManager : CLLocationManager {
    
    static let sharedInstance = LocationManager()
    var lon : Double = 0
    var lan : Double = 0
    
    override init() {
        super.init()
        self.delegate = self
        self.desiredAccuracy = kCLLocationAccuracyKilometer;
        self.requestWhenInUseAuthorization()
        self.startUpdatingLocation()

    }
    
    func getLongitude() -> Double{
        return lon
    }
    
    func getLatitude() -> Double{
        return lan
    }
    
    func request() {
        self.requestWhenInUseAuthorization()
        self.startUpdatingLocation()
    }
    
}

extension LocationManager : CLLocationManagerDelegate{
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location : CLLocation = locations.last!
        self.lon = location.coordinate.longitude
        self.lan = location.coordinate.latitude
        
        
        self.stopUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        //Logger.debug("location error : \(error.localizedDescription)")
        
    }
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            // If status has not yet been determied, ask for authorization
            manager.requestWhenInUseAuthorization()
            break
        case .authorizedWhenInUse:
            // If authorized when in use
            manager.startUpdatingLocation()
            break
        case .authorizedAlways:
            // If always authorized
            manager.startUpdatingLocation()
            break
        case .restricted:
            // If restricted by e.g. parental controls. User can't enable Location Services
            break
        case .denied:
            // If user denied your app access to Location Services, but can grant access from Settings.app
            break
        }
    }
}
