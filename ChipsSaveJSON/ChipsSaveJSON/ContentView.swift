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
      @Bindable var document = document
      
      ZStack {
        BackgroundView(document: document)
        
        VStack {
          ItemsCanvasView(items: document.items)
          
          if let item = document.selectedItem {
            SelectedItemControlsView(
              item: item,
              document: document
            )
          }
          
          ActionButtonsView(document: document, rect: rect)
          
          PaletteAndSaveControlsView(document: document)
          
          Text("frame \(format(rect))")
        }
        .padding(20)
      }
    }
  }
}

// MARK: - Background View

struct BackgroundView: View {
  let document: Document
  
  var body: some View {
    Rectangle()
      .fill(Color(white: 0.9))
      .onTapGesture {
        print("ContentView onTapGesture")
        document.clearSelection()
      }
  }
}

// MARK: - Items Canvas View

struct ItemsCanvasView: View {
  let items: [ItemModel]
  
  var body: some View {
    if items.isEmpty {
      Spacer()
    } else {
      ZStack {
        ForEach(items) { item in
          ItemDragView(item: item)
        }
      }
    }
  }
}

// MARK: - Selected Item Controls View

struct SelectedItemControlsView: View {
  let item: ItemModel
  @Bindable var document: Document
  
  var body: some View {
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

// MARK: - Preview

#Preview {
  ContentView()
    .environment(Document())
}
