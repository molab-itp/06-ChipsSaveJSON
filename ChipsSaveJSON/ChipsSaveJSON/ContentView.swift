//
//  ContentView.swift
//  Created by jht2 on 1/12/22.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var document: Document
    
    var body: some View {
        GeometryReader { geometry in
            let rect = geometry.frame(in: .local)
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
                    }
                    else {
                        ZStack {
                            ForEach(document.items) { item in
                                ItemDragView(item: item)
                            }
                        }
                    }
                    SelectItemView()
                    ButFirstRow(rect: rect)
                    ButSecondRow();
                    Text("frame \(format(rect))")
                }
                .padding(20)
                .onAppear() {
                    // document.addInitalItem(rect: rect)
                }
            }
        }
    }
}

struct SelectItemView: View {
    
    @EnvironmentObject var document: Document
    
    var body: some View {
        if let item = document.selectedItem {
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


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(Document())
    }
}

//PlaygroundPage.current.setLiveView(ExampleView())

