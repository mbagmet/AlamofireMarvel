//
//  NetworkProvider.swift
//  AlamofireMarvel
//
//  Created by Михаил Багмет on 26.05.2022.
//

import Foundation
import Alamofire

class NetworkProvider {
    private var url: String { "\(marvelAPI.domain)\(marvelAPI.path)\(marvelSections.characters)" }
    
    private var parameters = ["apikey": marvelAPI.publicKey,
                              "ts": marvelAPI.ts,
                              "hash": marvelAPI.hash]

    func fetchData(characterName: String?, completion: @escaping ([Character]) -> ()) {
        if let name = characterName {
            parameters["name"] = name
        }
    
        AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default).response { response in
            //debugPrint(response)
            print(self.parameters)
        }
        .validate()
        .responseDecodable(of: MarvelAPI.self) { (response) in
            guard let characters = response.value?.data else { return }
            completion(characters.all)
       }
    }
}

extension NetworkProvider {
    enum marvelAPI {
        static let domain = "https://gateway.marvel.com"
        static let path = "/v1/public/"
        
        static let privateKey = "a55596761256d8716a4f7a235dfa46ac4c36f6b2"
        static let publicKey = "798ae286d11198894a08eb4b1dc8f8e1"
        
        static var ts: String {
            return String(Date().getCurrentTimestamp())
        }
        
        static var hash: String {
            return String(String(ts) + privateKey + publicKey).md5
        }
    }
    
    enum marvelSections {
        case characters
        case comics
        case creators
        case events
        case series
        case stories
    }
}

