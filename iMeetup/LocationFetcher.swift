//
//  LocationFetcher.swift
//  iMeetup
//
//  Created by ramsayleung on 2024-03-19.
//

import CoreLocation

class LocationFetcher: NSObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    var lastKnownLocation: CLLocationCoordinate2D?
    var address = ""
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
    func start() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastKnownLocation = locations.first?.coordinate
        
        if let location = locations.first {
            // Reverse geocode the location
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                } else if let placemark = placemarks?.first {
                    // Extract the address components
                    if let street = placemark.thoroughfare {
                        self.address += street + ", "
                    }
                    if let city = placemark.locality {
                        self.address += city + ", "
                    }
                    if let country = placemark.country {
                        self.address += country
                    }
                    
                }
            }
        }
    }
}
