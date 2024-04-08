//
//  ButtonsRow1.swift
//  ChipsSaveJSON
//
//  Created by jht2 on 4/8/24.
//

import SwiftUI

struct ButtonsRow1View: View {
    var rect:CGRect
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
    }
}

#Preview {
    ButtonsRow1View(rect: CGRect(x: 0, y: 0, width: 100, height: 100))
        .environmentObject(Document())
}
