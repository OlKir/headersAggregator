//
//  FileManager+Directory.swift
//  headersAggregator
//
//  Created by Oleksii on 05.11.21.
//

import Foundation

extension FileManager {
    func isDirectory(atPath: String) -> Bool {
        var check: ObjCBool = false
        if fileExists(atPath: atPath, isDirectory: &check) {
            return check.boolValue
        } else {
            return false
        }
    }
}
