//
//  main.swift
//  localizationsCommentsChecker
//
//  Created by Oleksii on 05.11.21.
//

import Foundation

var inputPath: String?
var outputPath: String?
var umbrellaHeaderName: String = "umbrella_header.h"

for i in 0..<CommandLine.arguments.count {
  if i == 1 {
    inputPath = CommandLine.arguments[i]
  }
  if i == 2 {
    outputPath = CommandLine.arguments[i]
  }
  if i == 3 {
    umbrellaHeaderName = CommandLine.arguments[i]
  }
}

guard
  CommandLine.arguments.count > 0,
  let scanPath = inputPath,
  let outPath = outputPath
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
  print("Aggregation of headers files started...")

  let headerScanner = HeadersScanner(with: outPath)
  headerScanner.scanFolder(scanPath)
  
  HeaderCombiner.combine(in: outPath, file: umbrellaHeaderName)

  print("Aggregation of headers files finished in \(Date().timeIntervalSince(startTime)) seconds.")
} else {
  print("   ERROR: please provide a valid path to folder")
  exit(1)
}



