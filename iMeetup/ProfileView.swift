//
//  ProfileView.swift
//  iMeetup
//
//  Created by ramsayleung on 2024-03-17.
//

import SwiftUI

struct ProfileView: View {
    let profile: Profile
    var body: some View {
        NavigationStack {
            VStack{
                Image(uiImage: profile.avatar)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(lineWidth: 2).foregroundColor(.gray))
                
                HStack {
                    Text(profile.name)
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding()
                }

                
                Text(profile.company)
                
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ProfileView(profile: Profile.example)
}
