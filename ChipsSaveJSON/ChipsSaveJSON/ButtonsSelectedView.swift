//
//  ButtonsSelectedView.swift
//  ChipsSaveJSON
//
//  Created by jht2 on 2/28/23.
//

import SwiftUI

struct ButtonsSelectedView: View {
    var item: ItemModel
    
    @EnvironmentObject var document: Document

    var body: some View {
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

struct ButtonsSelectedView_Previews: PreviewProvider {
    static var previews: some View {
        let document = Document()
        ButtonsSelectedView(item: ItemModel())
            .environmentObject(document)
    }
}
}
