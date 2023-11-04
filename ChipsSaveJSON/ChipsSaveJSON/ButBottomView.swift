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
            RowOne(rect: rect)
            RowTwo(rect: rect)
            Text("frame \(format(rect))")
        }
    }
}

struct RowOne: View {
    var rect: CGRect
    @EnvironmentObject var document: Document
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
            Button("Shake") {
                withAnimation {
                    document.shakeDemo(rect: rect);
                }
            }
            Button("Color") {
                withAnimation {
                    document.setRandomColor();
                }
            }
            Button("Back") {
                withAnimation {
                    document.sendToBack();
                }
            }
        }
        .buttonStyle(.bordered)
    }
}

struct RowTwo: View {
    var rect: CGRect
    @EnvironmentObject var document: Document
    var body: some View {
        HStack {
//            Picker("Palette", selection: $document.selectedPalette) {
//                Text("rgb").tag(Palette.rgb)
//                Text("fixed").tag(Palette.fixed)
//            }
            Button("Clear") {
                withAnimation {
                    document.clear();
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

struct ButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        ButBottomView(rect: CGRect(x:0,y:0,width:200,height:300))
            .environmentObject( Document() )
    }
}
