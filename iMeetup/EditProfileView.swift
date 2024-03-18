//
//  EditContactView.swift
//  iMeetup
//
//  Created by ramsayleung on 2024-03-17.
//

import SwiftUI

struct EditProfileView: View {
    @Environment(\.dismiss) var dismiss
    var onSave: (Profile) -> Void
    @State private var viewModel: ViewModel

    var body: some View {
        NavigationStack {
            VStack {
                Image(uiImage: viewModel.profile.avatar)
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .clipShape(Circle())
                .overlay(Circle().stroke(lineWidth: 2).foregroundColor(.gray))
                
                TextField("Name", text: $viewModel.name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 40)
                    .padding(.vertical, 10)
                
                TextField("Company", text: $viewModel.company)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 40)
                
                Spacer()
            }
            .navigationTitle("Profile")
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
