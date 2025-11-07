//
//  ContentView.swift
//  Created by jht2 on 1/12/22.
//

import SwiftUI

struct ContentView: View {
  @Environment(Document.self) var document

  var body: some View {
    GeometryReader { geometry in
      let rect = geometry.frame(in: .local)
      
      ZStack {
        backgroundView
        mainContent(rect: rect)
      }
    }
  }
  
  private var backgroundView: some View {
    Rectangle()
      .fill(Color(white: 0.9))
      .onTapGesture {
        print("ContentView onTapGesture")
        document.clearSelection()
      }
  }
  
  private func mainContent(rect: CGRect) -> some View {
    VStack {
      ItemDisplayView()
      SelectionControlsView()
      ActionButtonsView(rect: rect)
      SaveRestoreView()
      Text("frame \(format(rect))")
    }
    .padding(20)
  }
}

// MARK: - Subviews

private struct ItemDisplayView: View {
  @Environment(Document.self) var document
  
  var body: some View {
    if document.items.isEmpty {
      Spacer()
    } else {
      ZStack {
        ForEach(document.items) { item in
          ItemDragView(item: item)
        }
      }
    }
  }
}

private struct SelectionControlsView: View {
  @Environment(Document.self) var document
  
  var body: some View {
    if let item = document.selectedItem {
      @Bindable var document = document
      
      VStack(spacing: 8) {
        Text("x \(item.x) y \(item.y) color \(item.colorName)")
        
        HStack {
          ColorPicker("Color", selection: $document.itemColor)
          Button("Rotate") {
            document.update(id: document.selectedId, rotationBy: 45.0)
          }
          Button("+Size") {
            document.update(id: document.selectedId, sizeBy: 1.1)
          }
          Button("-Size") {
            document.update(id: document.selectedId, sizeBy: 0.9)
          }
        }
        .buttonStyle(.bordered)
        
        HStack {
          Text("AssetName:")
          Picker("AssetName", selection: $document.itemAssetName) {
            Text("").tag("")
            Text("cat").tag("cat")
            Text("lama").tag("lama")
          }
        }
        .padding(5)
        .background(Color.gray)
      }
    }
  }
}

private struct ActionButtonsView: View {
  @Environment(Document.self) var document
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

private struct SaveRestoreView: View {
  @Environment(Document.self) var document
  
  var body: some View {
    @Bindable var document = document
    
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

#Preview {
  ContentView()
    .environment(Document())
}
