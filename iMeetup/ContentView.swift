//
//  ContentView.swift
//  iMeetup
//
//  Created by ramsayleung on 2024-03-17.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    @State private var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.profiles) {contact in
                    NavigationLink {
                        ProfileView(profile: contact)
                    } label: {
                        HStack {
                            Image(uiImage: contact.avatar)
                                .resizable()
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                            VStack(alignment: .leading) {
                                Text(contact.name)
                                    .font(.headline)
                                    .foregroundStyle(.primary)
                                
                                Text(contact.company)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
                .onDelete(perform: viewModel.deleteProfile)
            }
            .navigationTitle("iMeetup")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
            }
            
            PhotosPicker(selection: $viewModel.selectedItem, matching: .images){
                Label("Import", systemImage: "photo")
            }
            .onChange(of: viewModel.selectedItem){
                Task {
                    await viewModel.loadImage()
                }
            }
            .sheet(item: $viewModel.selectedProfile) {profile in
                EditProfileView(profile: profile){
                    viewModel.updateProfiles(profile: $0)
                }
            }
        }
    }
    
}

#Preview {
    ContentView()
}
