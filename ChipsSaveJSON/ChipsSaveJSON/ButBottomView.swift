//
//  ButtonsView.swift
//  ChipsSaveJSON
//
//  Created by jht2 on 2/28/23.
//

import SwiftUI

struct ButBottomView: View {
    var rect: CGRect
    
    @EnvironmentObject var document: Document
    
    var body: some View {
        VStack {
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
                        document.clear();
                    }
                }
                Button("Shake") {
                    withAnimation {
                        document.shakeDemo();
                    }
                }
                Button("Color") {
                    withAnimation {
                        document.colorDemo();
                    }
                }
            }
            .buttonStyle(.bordered)
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
}

struct ButtonsView_Previews: PreviewProvider {
    
    static var previews: some View {
        let document = Document()
        ButBottomView(rect: CGRect(x:0,y:0,width:200,height:300))
            .environmentObject(document)
    }
}
