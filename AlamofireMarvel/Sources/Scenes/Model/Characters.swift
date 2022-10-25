//
//  Characters.swift
//  AlamofireMarvel
//
//  Created by Михаил Багмет on 26.05.2022.
//

import Foundation

struct Characters: Decodable {
    let count: Int?
    let all: [Character]
    
    enum CodingKeys: String, CodingKey {
        case count
        case all = "results"
    }
}
