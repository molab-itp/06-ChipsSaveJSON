//
//  ButtonFirstRow.swift
//  ChipsSaveJSON
//
//  Created by drew on 11/9/23.
//

import SwiftUI

struct ButtonFirstRow: View {
    @EnvironmentObject var document: Document
    
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
    ButtonFirstRow(rect: CGRect(x: 0, y: 0, width: 10, height: 10))
        .environmentObject(Document())
}
