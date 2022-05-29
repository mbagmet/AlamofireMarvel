//
//  Date+Ext.swift
//  AlamofireMarvel
//
//  Created by Михаил Багмет on 26.05.2022.
//

import Foundation

// MARK: - Timestamp
extension Date {
    func getCurrentTimestamp() -> Int64 {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}
