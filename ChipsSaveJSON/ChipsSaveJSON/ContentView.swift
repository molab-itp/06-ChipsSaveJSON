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
        Rectangle()
          .fill(Color(white: 0.9))
          .onTapGesture {
            print("ContentView onTapGesture")
            document.clearSelection()
          }
        VStack {
          ItemsView(document: document)
          if let item = document.selectedItem {
            SelectedItemView(document: document)
          }
          ActionButtonsView(document: document, rect: rect)
          PaletteAndSaveView(document: document)
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

struct ItemsView: View {
  @Bindable var document: Document

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

struct SelectedItemView: View {
  @Bindable var document: Document

  var body: some View {
    VStack {
      Text("x \(document.selectedItem?.x ?? 0) y \(document.selectedItem?.y ?? 0) color \(document.selectedItem?.colorName ?? "")")
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

struct PaletteAndSaveView: View {
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

#Preview {
  ContentView()
    .environment(Document())
}
