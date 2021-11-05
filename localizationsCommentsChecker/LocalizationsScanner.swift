//
//  LocalizationsScanner.swift
//  localizationsCommentsChecker
//
//  Created by Oleksii on 05.11.21.
//

import Foundation

class LocalizationsScanner {
  
  static func scanFolder(_ path: String) {
    let fileManager = FileManager()
    let pathURL = URL(fileURLWithPath: path)
    do {
      let folderContent = try fileManager.contentsOfDirectory(atPath: path)
      for contentObject in folderContent {
        let contentObjectPath = pathURL.appendingPathComponent(contentObject)
        guard fileManager.isDirectory(atPath: contentObjectPath.path) else {
          continue
        }
        if contentObject.hasSuffix("en.lproj") {
          LocalizationsScanner.checkENLocalizations(atPath: contentObjectPath.path)
        } else {
          LocalizationsScanner.scanFolder(contentObjectPath.path)
        }
      }
    } catch {
      print("   ERROR: can't read folder content: \(path)")
      exit(1)
    }
  }
  
  static func checkENLocalizations(atPath path: String) {
    let pathURL = URL(fileURLWithPath: path)
    do {
      let folderContent = try fileManager.contentsOfDirectory(atPath: path)
      for contentObject in folderContent {
        let fileURL = pathURL.appendingPathComponent(contentObject)
        // We ignore code localizations for now
        if fileURL.lastPathComponent == "Localizable.strings" {
          continue
        }
        guard fileURL.pathExtension == "strings" else {
          continue
        }
        LocalizationsScanner.checkLocalizationFile(fileURL)
      }
    } catch {
      print("   ERROR: can't read EN localizations folder: \(path)")
      exit(1)
    }
  }
  
  static func checkLocalizationFile(_ fileURL: URL) {
    do {
      let data = try String(contentsOfFile: fileURL.path, encoding: .utf8)
      let localizationsStrings = data.components(separatedBy: .newlines)
      var missingComments: [String] = []
      for i in 0..<localizationsStrings.count {
        let textLine = localizationsStrings[i]
        let nextLine = i + 1 < localizationsStrings.count ? localizationsStrings[i + 1] : ""
        guard
          textLine.hasPrefix("/* "),
          textLine.hasSuffix(" */")
        else {
          continue
        }
        if textLine.contains("; Note = ") {
          // TODO: We can check comment format here
          continue
        } else {
          missingComments.append("No comment for: \(nextLine)")
        }
      }
      guard missingComments.count > 0 else {
        return
      }
      print("")
      print("\(fileURL.lastPathComponent)")
      missingComments.forEach { print($0) }
    } catch {
      print("   ERROR: can't read localisation file: \(fileURL.absoluteString)")
      exit(1)
    }
  }
  
}
