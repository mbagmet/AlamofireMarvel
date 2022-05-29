//
//  String+Ext.swift
//  AlamofireMarvel
//
//  Created by Михаил Багмет on 26.05.2022.
//

import Foundation
import CryptoKit

// MARK: - String to MD5
extension String {
    var md5: String {
        let digest = Insecure.MD5.hash(data: self.data(using: .utf8) ?? Data())

        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
}
