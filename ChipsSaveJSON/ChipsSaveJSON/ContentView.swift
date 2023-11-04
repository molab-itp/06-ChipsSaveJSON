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
                // ChipsCanvasView(document: document, rect: rect)
                ChipsCanvasView(rect: rect)
                    .padding(20)
                    .onAppear() {
                        // document.addInitalItem(rect: rect)
                    }
            }
        }
    }
}

struct ChipsCanvasView: View {
    @EnvironmentObject var document: Document
    // @StateObject var document: Document
    var rect: CGRect
    var body: some View {
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
            if let item = document.selectedItem {
                ButSelectedView(item: item)
            }
            ButBottomView(rect: rect)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject( Document() )
    }
}
