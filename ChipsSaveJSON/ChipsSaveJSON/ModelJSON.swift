//
//  ModelJSON.swift
//  Created by jht2 on 1/15/22.

import SwiftUI

extension Model {

  func saveAsJSON(fileName: String) {
    do {
      let directory =
        try FileManager.default.url(
          for: .documentDirectory,
          in: .userDomainMask,
          appropriateFor: nil,
          create: true)
      let fileUrl = directory.appendingPathComponent(fileName)
      print("saveAsJSON filePath \(fileUrl as Any)")

      let encoder = JSONEncoder()
      encoder.outputFormatting = .prettyPrinted

      let jsonData = try encoder.encode(self)
      // print("Model saveAsJSON jsonData \(String(describing: jsonData))")

      let str = String(data: jsonData, encoding: .utf8)!
      // print("Model saveAsJSON encode str \(str)")

      try str.write(to: fileUrl, atomically: true, encoding: .utf8)
      //
    } catch {
      fatalError("Model saveAsJSON error \(error)")
    }
  }

  init(JSONfileName fileName: String) {
    items = []
    do {
      let fileMan = FileManager.default
      let directory =
        try fileMan.url(
          for: .documentDirectory,
          in: .userDomainMask,
          appropriateFor: nil,
          create: true)
      let fileUrl = directory.appendingPathComponent(fileName)
      let filePathExists = fileMan.fileExists(atPath: fileUrl.path)
      if !filePathExists {
        print("Model init not filePath \(fileUrl as Any)")
        return
      }
      print("Model init filePath \(fileUrl as Any)")

      let jsonData = try String(contentsOfFile: fileUrl.path).data(
        using: .utf8)

      let decoder = JSONDecoder()
      self = try decoder.decode(Model.self, from: jsonData!)
      //
    } catch {
      fatalError("Model init error \(error)")
    }
  }
}
