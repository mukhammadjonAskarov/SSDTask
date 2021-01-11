//
//  Objects.swift
//  Task1_SSD
//
//  Created by Mukhammadjon Askarov on 09/01/21.
//

import Foundation


// MARK: - Objects
struct Object: Codable {
    let zone: [Zone]
    let adMob: Bool

    enum CodingKeys: String, CodingKey {
        case zone
        case adMob = "ad_mob"
    }
    
}

struct Zone: Codable {
    let name: String
    let files: [File]
}

// MARK: - File
struct File: Codable {
    let url: String
   
}

