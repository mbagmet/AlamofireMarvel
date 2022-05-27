//
//  NetworkProviderErrorHandler.swift
//  AlamofireMarvel
//
//  Created by Михаил Багмет on 27.05.2022.
//

import Foundation

protocol NetworkProviderErrorHandler {
    var delegate: NetworkProviderDelegate? { get set }
}
