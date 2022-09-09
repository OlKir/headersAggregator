//
//  LocalizationsScanner.swift
//  headersAggregator
//
//  Created by Oleksii on 05.11.21.
//

import Foundation

class HeadersScanner {
    
  private var outputFolder: URL
  
  init(with outputFolderPath: String) {
    let fileManager = FileManager()
    
    self.outputFolder = URL(fileURLWithPath: outputFolderPath)
    
    guard fileManager.isDirectory(atPath: outputFolderPath) == false else {
      return
    }
    
    do {
      try fileManager.createDirectory(at: outputFolder, withIntermediateDirectories: true, attributes: nil)
    } catch {
      print("   ERROR: can't create output folder: \(error)")
      exit(1)
    }
  }
  
  func scanFolder(_ path: String) {
    let fileManager = FileManager()
    let pathURL = URL(fileURLWithPath: path)
    do {
      let folderContent = try fileManager.contentsOfDirectory(atPath: path)
      for contentObject in folderContent {
        let contentObjectPath = pathURL.appendingPathComponent(contentObject)
        if contentObject.hasSuffix(".h") {
          self.processHeaderFile(atPath: contentObjectPath.path, with: fileManager)
        } else {
          guard fileManager.isDirectory(atPath: contentObjectPath.path) else {
            continue
          }
          self.scanFolder(contentObjectPath.path)
        }
      }
    } catch {
      print("   ERROR: can't read folder content: \(path)")
      exit(1)
    }
  }
  
  func processHeaderFile(atPath path: String, with fileManager: FileManager) {
    do {
      let sourcePath = URL(fileURLWithPath: path)
      let targetPath = self.outputFolder.appendingPathComponent(sourcePath.lastPathComponent)
      var check: ObjCBool = false
      guard fileManager.fileExists(atPath: targetPath.path, isDirectory: &check) == false else {
        return
      }
      try fileManager.copyItem(at: sourcePath, to: targetPath)
    } catch {
      print("   ERROR: can't copy header: \(error)")
      exit(1)
    }
  }
  
}
