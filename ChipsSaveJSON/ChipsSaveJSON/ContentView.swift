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
      // @Bindable needed for $ references
      ZStack {
        Rectangle()
          .fill(Color(white: 0.9))
          .onTapGesture {
            print("ContentView onTapGesture")
            document.clearSelection()
          }
        VStack {
          ItemsCanvasView(items: document.items)
          SelectedItemControlsView(document: document)
          ActionButtonsView(document: document, rect: rect)
          PaletteControlsView(document: document)
          FrameInfoView(rect: rect)
        }
        .padding(20)
        .onAppear {
          // document.addInitalItem(rect: rect)
        }
      }
    }
  }
}

// MARK: - Subviews

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

struct SelectedItemControlsView: View {
  @Bindable var document: Document
  
  var body: some View {
    if let item = document.selectedItem {
      VStack {
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
  }
}

struct PaletteControlsView: View {
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

struct FrameInfoView: View {
  let rect: CGRect
  
  var body: some View {
    Text("frame \(format(rect))")
  }
}

#Preview {
  ContentView()
    .environment(Document())
}
