//
//  ButtonFiles.swift
//  ChipsSaveJSON
//
//  Created by Kennon Cummings on 11/9/23.
//

import SwiftUI

struct ButtonFirstRow: View {
    
    @EnvironmentObject var document: Document
    
    var body: some View {
        let rect: CGRect
        
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

//struct ContentView_Previews: PreviewProvider {
  //  static var previews: some View {
    //    let document = Document()
      //  ContentView()
 //           .environmentObject(document)
//    }
//}


#Preview {
    ButtonFirstRow(CGRect(x: 10, y: 10, width: 200, height: 100))
        .environmentObject(Document())
}

