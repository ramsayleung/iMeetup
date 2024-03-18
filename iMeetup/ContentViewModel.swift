//
//  ContentViewModel.swift
//  iMeetup
//
//  Created by ramsayleung on 2024-03-17.
//

import Foundation
import PhotosUI
import SwiftUI

extension ContentView {
    @Observable
    class ViewModel {
        var selectedItem: PhotosPickerItem?
        var profiles = [Profile]()
        var selectedProfile: Profile?
        
        let savePath = URL.documentsDirectory.appending(path: "savedProfiles")
        
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                profiles = try JSONDecoder().decode([Profile].self, from: data)
            } catch {
                profiles = []
            }
        }
        
        func save() {
            do {
                let data = try JSONEncoder().encode(profiles)
                try data.write(to: savePath)
            }catch {
                print("Unable to save data.")
            }
        }
        
        func loadImage() async{
            do {
                guard let imageData = try await selectedItem?.loadTransferable(type: Data.self) else {
                    return }
                guard let uiImage = UIImage(data: imageData) else {return }
                selectedProfile = Profile(avatar: uiImage, name: "", company: "")
            }catch {
                print("Failed to loadImage")
            }
        }
        
        func addProfiles(profile: Profile) {
            profiles.append(profile)
            save()
        }
        
        func deleteProfile(of offsets: IndexSet){
            profiles.remove(atOffsets: offsets)
            save()
        }
    }
}
