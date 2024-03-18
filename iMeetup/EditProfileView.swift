//
//  EditContactView.swift
//  iMeetup
//
//  Created by ramsayleung on 2024-03-17.
//

import SwiftUI

struct EditProfileView: View {
    @Environment(\.dismiss) var dismiss
    var profile: Profile
    var onSave: (Profile) -> Void
    @State private var name = ""
    @State private var company = ""
    var body: some View {
        NavigationStack {
            VStack {
                Image(uiImage:profile.avatar)
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .clipShape(Circle())
                .overlay(Circle().stroke(lineWidth: 2).foregroundColor(.gray))
                
                TextField("Name", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 40)
                    .padding(.vertical, 10)
                
                TextField("Company", text: $company)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 40)
                
                Spacer()
            }
            .navigationTitle("Profile")
            .toolbar {
                Button("save"){
                    var newProfile = profile
                    newProfile.id = UUID()
                    newProfile.name = name
                    newProfile.company = company
                    onSave(newProfile)
                    dismiss()
                }
            }
        }
    }
    
    init(profile: Profile, onSave: @escaping (Profile) -> Void) {
        self.profile = profile
        self.onSave = onSave
        _name = State(initialValue: profile.name)
        _company = State(initialValue: profile.company)
    }
}

#Preview {
    EditProfileView(profile: Profile.example) { profile in
        
    }
}
