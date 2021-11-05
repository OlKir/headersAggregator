//
//  main.swift
//  localizationsCommentsChecker
//
//  Created by Oleksii on 05.11.21.
//

import Foundation

var inputPath: String?

for i in 0..<CommandLine.arguments.count {
  if i == 1 {
    inputPath = CommandLine.arguments[i]
  }
}

guard
  CommandLine.arguments.count > 0,
  let scanPath = inputPath
else {
  print("   ERROR: provide folder path for recursive scan")
  exit(1)
}

let fileManager = FileManager()
var isDirectory: ObjCBool = false
if fileManager.fileExists(atPath: scanPath, isDirectory: &isDirectory) {
  guard isDirectory.boolValue else {
    print("   ERROR: please provide path to folder")
    exit(1)
  }
  let startTime = Date()
  print("Scan localization comments in interface files started...")

  LocalizationsScanner.scanFolder(scanPath)

  print("Scan localization comments finished in \(Date().timeIntervalSince(startTime)) seconds.")
} else {
  print("   ERROR: please provide a valid path to folder")
  exit(1)
}



