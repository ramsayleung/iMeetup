//
//  Contact.swift
//  iMeetup
//
//  Created by ramsayleung on 2024-03-17.
//

import Foundation
import SwiftUI

struct Profile: Identifiable, Codable, Comparable {
    static func < (lhs: Profile, rhs: Profile) -> Bool {
        return lhs.name < rhs.name
    }
    
    var id = UUID()
    var avatar: UIImage
    var name: String
    var company: String
    init(avatar: UIImage, name: String, company: String){
        self.avatar = avatar
        self.name = name
        self.company = company
    }
    
    // Custom initializer for decoding
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let imageData = try container.decode(Data.self, forKey: .avatar)
        avatar = UIImage(data: imageData) ?? UIImage()
        name = try container.decode(String.self, forKey: .name)
        company = try container.decode(String.self, forKey: .company)
    }
    
    // Custom method for encoding
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(company, forKey: .company)
        if let jpegData = avatar.jpegData(compressionQuality: 1) {
            try container.encode(jpegData, forKey: .avatar)
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case avatar
        case name
        case company
    }
    
#if DEBUG
     static var example = Profile(avatar: UIImage(systemName: "swift") ?? UIImage(), name: "Swift Talor", company: "This is a description")
#endif
}
