//
//  File.swift
//  ChipsSaveJSON
//
//  Created by jht2 on 11/6/25.
//

import SwiftUI

struct ButtonsView: View {
  var  rect :CGRect; 
  @Environment(Document.self) var document
  var body: some View {
    @Bindable var document = document
    HStack {
      Button("Add") {
        withAnimation {
          document.addItem(rect: rect)
        }
      }
      Button("+8") {
        withAnimation {
          //document.clear();
          document.addItems(rect: rect, count: 8)
        }
      }
      Button("Clear") {
        withAnimation {
          document.clear()
        }
      }
      Button("Shake") {
        withAnimation {
          document.shakeDemo()
        }
      }
      Button("Color") {
        withAnimation {
          document.colorDemo()
        }
      }
    }
    .buttonStyle(.bordered)
    HStack {
      Picker("Palette", selection: $document.selectedPalette) {
        Text("rgb").tag(Palette.rgb)
        Text("fixed").tag(Palette.fixed)
      }
      Button("Move-Back") {
        withAnimation {
          document.sendToBack()
        }
      }
      Button("Save") {
        document.save("chipItems.json")
      }
      Button("Restore") {
        document.restore("chipItems.json")
      }
    }
    .buttonStyle(.bordered)
    Text("frame \(format(rect))")
  }
}

#Preview {
  ButtonsView(rect: CGRect.zero)
    .environment(Document())
}
