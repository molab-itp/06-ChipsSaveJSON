//
//  ControlButtonsView.swift
//

import SwiftUI

// MARK: - Action Buttons View

struct ActionButtonsView: View {
  @Bindable var document: Document
  let rect: CGRect
  
  var body: some View {
    HStack {
      Button("Add") {
        withAnimation {
          document.addItem(rect: rect)
        }
      }
      Button("+8") {
        withAnimation {
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
  }
}

// MARK: - Palette and Save Controls View

struct PaletteAndSaveControlsView: View {
  @Bindable var document: Document
  
  var body: some View {
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
  }
}

