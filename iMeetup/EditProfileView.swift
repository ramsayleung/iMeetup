//
//  EditContactView.swift
//  iMeetup
//
//  Created by ramsayleung on 2024-03-17.
//

import SwiftUI
import MapKit

struct EditProfileView: View {
    @Environment(\.dismiss) var dismiss
    var onSave: (Profile) -> Void
    @State private var viewModel: ViewModel

    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    
                Section {
                    Image(uiImage: viewModel.profile.avatar)
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .overlay(Circle().stroke(lineWidth: 2).foregroundColor(.gray))
                    
                    TextField("Name", text: $viewModel.name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    TextField("Company", text: $viewModel.company)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                Section("Location") {
                    Toggle("Add location", isOn: $viewModel.addLocation)
                    
                    if(viewModel.addLocation) {
                        Text(viewModel.geotappedAddress)
                            .font(.caption)
                        Map(initialPosition: viewModel.currentPosition) {
                            Annotation("",coordinate: viewModel.currentCoordinate) {
                                Image(uiImage: viewModel.profile.avatar)
                                    .resizable()
                                    .frame(width: 44, height: 44)
                            }
                        }
                        .scaledToFit()
                    }
                }
                    
                }
            }
            .onChange(of: viewModel.addLocation){
                if(viewModel.addLocation) {
                    viewModel.locationFetcher.start()
                }
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("save"){
                    onSave(viewModel.newProfile())
                    dismiss()
                }
            }
        }
    }
    
    init(profile: Profile, onSave: @escaping (Profile) -> Void) {
        let viewModel = ViewModel(profile: profile)
        self.onSave = onSave
        _viewModel = State(initialValue: viewModel)
    }
}

#Preview {
    EditProfileView(profile: Profile.example) { profile in
        
    }
}
