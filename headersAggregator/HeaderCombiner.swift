//
//  HeaderCombiner.swift
//  headersAggregator
//
//  Created by Oleksii on 17.03.22.
//

import Foundation

class HeaderCombiner {
  
  static func combine(in outputPath: String, file: String) {
    let fileManager = FileManager()
    var combinedList: String = ""
    do {
      let folderContent = try fileManager.contentsOfDirectory(atPath: outputPath)
      
      for headerFile in folderContent {
        guard
          headerFile.hasSuffix(".h"),
          headerFile != file
        else { continue }
        
        let declaration = String(format: "#include \"%@\"\n", headerFile)
        combinedList += declaration
      }
    } catch {
      print("   ERROR: can't scan output folder: \(error)")
      exit(1)
    }
    
    let umbrellaHeader = URL(fileURLWithPath: outputPath).appendingPathComponent(file)
    let fileData = combinedList.data(using: .utf8)
    
    do {
      try fileData?.write(to: umbrellaHeader)
    } catch {
      print("   ERROR: creation of \(file) failed: \(error)")
      exit(1)
    }
    
    
//    var check: ObjCBool = false
//    if fileManager.fileExists(atPath: umbrellaHeader.path, isDirectory: &check) {
//      print("   Existing \(file) found, will attach new headers.")
//      do {
//        let existingHeaders = try Data(contentsOf: umbrellaHeader)
//        if let existingString = String(data: existingHeaders, encoding: .utf8) {
//          print("   Current list \(combinedList.count) existing list \(existingString.count)")
//          combinedList += existingString
//          try fileManager.removeItem(at: umbrellaHeader)
//        } else {
//          print("   MINOR: can't decode content of existing \(file)")
//        }
//      } catch {
//        print("   MINOR: can't read existing \(file): \(error)")
//      }
//    }
//
    
    

  }
}
