//
//  ButtonSecondRow.swift
//  ChipsSaveJSON
//
//  Created by drew on 11/9/23.
//

import SwiftUI

struct ButtonSecondRow: View {
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
    }
}

#Preview {
    ButtonSecondRow()
        .environmentObject(Document())
}
