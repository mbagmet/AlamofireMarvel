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
    
    enum CodingKeys: String, CodingKey {
        case path
        case format = "extension"
    }
    
    func getImage(size: ImageSize, queue: DispatchQueue = DispatchQueue.global(qos: .utility), completion: @escaping (Data?) -> ()) {
        var data: Data?
        
        let workItem = DispatchWorkItem {
            guard let imagePath = path,
                  let imageExtension = format,
                  let imageURL = URL(string: "\(imagePath)/\(size == .small ? "standard_medium" : "portrait_incredible").\(imageExtension)"),
                  let imageData = try? Data(contentsOf: imageURL)
            else { return }
            data = imageData
        }
        
        workItem.notify(queue: .main) {
            completion(data)
        }
        
        queue.async(execute: workItem)
    }
    
    enum ImageSize {
        case small
        case big
    }
}
