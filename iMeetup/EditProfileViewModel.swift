//
//  EditProfileViewModel.swift
//  iMeetup
//
//  Created by ramsayleung on 2024-03-17.
//

import Foundation
import MapKit
import _MapKit_SwiftUI

extension EditProfileView {
    @Observable
    class ViewModel {
        var profile: Profile
        var name = ""
        var company = ""
        var addLocation = false
        let locationFetcher = LocationFetcher()
        
        func newProfile() -> Profile {
            var newProfile = profile
            newProfile.id = UUID()
            newProfile.name = name
            newProfile.company = company
            newProfile.addLocation = addLocation
            newProfile.geotappedAddress = geotappedAddress
            if addLocation {
                newProfile.latitude = locationFetcher.lastKnownLocation?.latitude
                newProfile.longitude = locationFetcher.lastKnownLocation?.longitude
            }
            return newProfile
        }
        
        var geotappedAddress: String {
            locationFetcher.address
        }
        
        var currentPosition: MapCameraPosition{
            MapCameraPosition.region(MKCoordinateRegion(center: currentCoordinate, span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)))
        }
        
        var currentCoordinate: CLLocationCoordinate2D {
            if let location = locationFetcher.lastKnownLocation {
            print("Your location is \(location)")
            } else {
                print("Your location is unknown")
            }
            return CLLocationCoordinate2D(latitude: locationFetcher.lastKnownLocation?.latitude ?? Profile.defaultLatitude, longitude: locationFetcher.lastKnownLocation?.longitude ?? Profile.defaultLongitude)
        }
        
        init(profile: Profile) {
            self.profile = profile
            self.name = profile.name
            self.company = profile.company
            locationFetcher.start()
        }
    }
}
