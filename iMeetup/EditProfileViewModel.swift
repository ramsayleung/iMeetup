//
//  EditProfileViewModel.swift
//  iMeetup
//
//  Created by ramsayleung on 2024-03-17.
//

import Foundation

extension EditProfileView {
    @Observable
    class ViewModel {
        var profile: Profile
        var name = ""
        var company = ""
        
        func newProfile() -> Profile {
            var newProfile = profile
            newProfile.id = UUID()
            newProfile.name = name
            newProfile.company = company
            return newProfile
        }
        
        init(profile: Profile) {
            self.profile = profile
            self.name = profile.name
            self.company = profile.company
        }
    }
}
