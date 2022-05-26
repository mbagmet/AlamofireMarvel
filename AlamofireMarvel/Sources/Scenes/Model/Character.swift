//
//  Character.swift
//  AlamofireMarvel
//
//  Created by Михаил Багмет on 26.05.2022.
//

import Foundation

struct Character: Decodable {
    let id: Int?
    let name: String?
    let description: String?
    let image: CharacterImage?
    let comics: ComicList?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case image = "thumbnail"
        case comics
    }
}

struct CharacterImage: Decodable {
    private let path: String?
    private let format: String?
    
    var imageUrl: String? {
        return "\(path ?? "")\(format ?? "")"
    }
    
    enum CodingKeys: String, CodingKey {
        case path
        case format = "extension"
    }
}
