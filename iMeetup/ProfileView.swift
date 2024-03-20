//
//  ProfileView.swift
//  iMeetup
//
//  Created by ramsayleung on 2024-03-17.
//

import SwiftUI
import MapKit

struct ProfileView: View {
    let profile: Profile
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: profile.latitude ?? Profile.defaultLatitude, longitude: profile.longitude ?? Profile.defaultLongitude)
    }
    
    var startPosition: MapCameraPosition{
        MapCameraPosition.region(MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)))
    }
    
    var body: some View {
        NavigationStack {
            VStack{
                Form{
                    Section {
                        Image(uiImage: profile.avatar)
                            .resizable()
                            .scaledToFit()
                            .clipShape(Circle())
                            .overlay(Circle().stroke(lineWidth: 2).foregroundColor(.gray))
                    }
                    Section("Detail") {
                        Text(profile.name)
                            .fontWeight(.bold)
                        
                        Text(profile.company)
                    }

                    if profile.addLocation {
                        Section("Map") {
                            if(profile.geotappedAddress != nil){
                                Text(profile.geotappedAddress!)
                                    .font(.caption)
                            }
                            Map(initialPosition: startPosition) {
                                Annotation("",coordinate: coordinate) {
                                    Image(uiImage: profile.avatar)
                                        .resizable()
                                        .foregroundColor(.red)
                                        .frame(width: 44, height: 44)
                                        .background(.white)
                                        .clipShape(Circle())
                                }
                            }
                            .scaledToFit()

                        }
                    }
                }
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ProfileView(profile: Profile.example)
}
