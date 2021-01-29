//
//  Fish.swift
//  ACNHFishies
//
//  Created by River McCaine on 1/27/21.
//

import Foundation

//struct TopLevelArray {
//    let fish: [Fish]
//}

struct Fish: Codable {
    let name: Name
    let price: Int
    let catchPhrase: String
    let imageURL: URL
    let availability: Availability
    
    enum CodingKeys: String, CodingKey {
        case name
        case price
        case catchPhrase = "catch-phrase"
        case imageURL = "image_uri"
        case availability
    }
    
    struct Name: Codable {
        let nameUSEn: String
        
        enum CodingKeys: String, CodingKey {
            case nameUSEn = "name-USen"
        }
    }
    
    struct Availability: Codable {
        let location: String
        let rarity: String
        let monthArray: [Int]
        
        enum CodingKeys: String, CodingKey {
            case location
            case rarity
            case monthArray = "month-array-northern"
        }
    }
    
} // END OF STRUCT






