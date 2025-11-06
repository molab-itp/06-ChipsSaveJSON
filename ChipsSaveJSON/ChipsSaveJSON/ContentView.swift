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
          ItemsCanvasView()
          SelectedItemControlsView()
          ActionButtonsView(rect: rect)
          PaletteControlsView()
          Text("frame \(format(rect))")
        }
        .padding(20)
        .onAppear {
          // document.addInitalItem(rect: rect)
        }
      }
    }
  }
}

// MARK: - Items Canvas View
struct ItemsCanvasView: View {
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

// MARK: - Selected Item Controls View
struct SelectedItemControlsView: View {
  @Environment(Document.self) var document

  var body: some View {
    if let item = document.selectedItem {
      @Bindable var document = document
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

// MARK: - Action Buttons View
struct ActionButtonsView: View {
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

// MARK: - Palette Controls View
struct PaletteControlsView: View {
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
