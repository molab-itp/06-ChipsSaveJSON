//
//  ChipsSaveJSONApp.swift
//  Created by jht2 on 1/12/22.
//

// Guesture04 save as local file json

import SwiftUI

@main
struct MySaveJSONApp: App {
  @State var document = Document()

  var body: some Scene {
    WindowGroup {
      ContentView()
        .environment(document)
    }
  }
}
