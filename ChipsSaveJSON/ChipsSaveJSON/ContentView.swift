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
          if document.items.isEmpty {
            Spacer()
          } else {
            ZStack {
              ForEach(document.items) { item in
                ItemDragView(item: item)
              }
            }
          }
          if let item = document.selectedItem {
            SelectedItemView(item: item);
          }
          ButtonsView(rect: rect);
        }
        .padding(20)
        .onAppear {
          // document.addInitalItem(rect: rect)
        }
      }
    }
  }
}

struct SelectedItemView: View {
  @Environment(Document.self) var document
  var item:ItemModel;
  var body: some View {
    @Bindable var document = document
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

#Preview {
  ContentView()
    .environment(Document())
}
