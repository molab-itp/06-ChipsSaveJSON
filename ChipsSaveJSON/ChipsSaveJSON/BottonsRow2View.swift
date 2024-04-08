//
//  BottonsRow2View.swift
//  ChipsSaveJSON
//
//  Created by jht2 on 4/8/24.
//

import SwiftUI

struct BottonsRow2View: View {
    var rect:CGRect
    @EnvironmentObject var document: Document
    var body: some View {
        HStack {
            Picker("Palette", selection: $document.selectedPalette) {
                Text("rgb").tag(Palette.rgb)
                Text("fixed").tag(Palette.fixed)
            }
            Button("Move-Back") {
                withAnimation {
                    document.sendToBack();
                }
            }
            Button("Save") {
                document.save("chipItems.json");
            }
            Button("Restore") {
                document.restore("chipItems.json");
            }
        }
        .buttonStyle(.bordered)
        Text("frame \(format(rect))")
    }
}

#Preview {
    BottonsRow2View(rect: CGRect(x: 0, y: 0, width: 100, height: 100))
        .environmentObject(Document())


}
