//
//  Document.swift
//

import SwiftUI

class Document: ObservableObject
{
    @Published var model: Model
    @Published var selectedId: Int = 0
    @Published var selectedPalette:Palette = .rgb
    
    let bottomMargin = 150.0;
    
    var selectedItem: ItemModel? {
        model.item(id: selectedId)
    }
    
    init() {
        model = Model()
    }
    
    var items:[ItemModel] {
        model.items
    }
    
    func clearSelection() {
        selectedId = 0
        for index in  0..<model.items.count {
            model.items[index].selected = false;
        }
    }
    
    // Computed property to change the color of the selected item
    //  ColorPicker("Color", selection: $document.itemColor)
    var itemColor:Color {
        get {
            if let index = model.itemIndex(id: selectedId) {
                return model.items[index].color
            }
            else {
                return Color.red
            }
        }
        set {
            print("Document color set \(newValue)")
            if let index = model.itemIndex(id: selectedId) {
                let colorNum = colorNum_(color: newValue)
                model.items[index].colorNum = colorNum;
            }
        }
    }
    
    // Computed property to change the assetName of the selected item
    //  Picker("AssetName", selection: $document.itemAssetName) {
    var itemAssetName:String {
        get {
            if let index = model.itemIndex(id: selectedId) {
                return model.items[index].assetName
            }
            else {
                return ""
            }
        }
        set {
            print("Document itemAssetName set \(newValue)")
            if let index = model.itemIndex(id: selectedId) {
                model.items[index].assetName = newValue;
            }
        }
    }
    
    func select(id: Int, state:Bool) {
        for index in  0..<model.items.count {
            model.items[index].selected = false;
        }
        if let index = model.itemIndex(id: id) {
            print("ItemView selected index \(index)")
            model.items[index].selected = state;
            selectedId = id
            // move to front
            let item = model.items[index]
            model.items.remove(at: index)
            model.items.append(item)
        }
        else {
            print("Document select failed id \(id)")
        }
    }
    
    func sendToBack() {
        if let index = model.itemIndex(id: selectedId) {
            let item = model.items[index]
            model.items.remove(at: index)
            model.items.insert(item, at: 0)
        }
    }
    
    func update(id: Int, x: Int, y: Int) {
        //    print("Document update id \(id) x \(x) y \(y)")
        //    print("selectedID \(selectedID)")
        if let index = model.itemIndex(id: id) {
            model.items[index].x = x;
            model.items[index].y = y;
        }
    }
    
    func update(id: Int, sizeBy: Double) {
        if let index = model.itemIndex(id: id) {
            update(index: index, sizeBy: sizeBy)
        }
    }
    
    func update(index: Int, sizeBy: Double) {
        let w = Double(model.items[index].width)
        let h = Double(model.items[index].height)
        model.items[index].width = Int(w * sizeBy);
        model.items[index].height = Int(h * sizeBy);
    }
    
    func update(id: Int, rotationBy: Double) {
        if let index = model.itemIndex(id: id) {
            var rotation = model.items[index].rotation
            rotation = (rotation < 360 ? rotation + rotationBy : 0)
            model.items[index].rotation = rotation;
        }
    }
    
    func clear () {
        selectedId = 0
        model.reset()
    }

    func addItem(x: Int, y: Int) {
        print("addItems x y", x, y)
        let colorNum = randomColorNum()
        let assetName = randomAssetName();
        let item = ItemModel(colorNum: colorNum, x: x, y: y, assetName: assetName)
        model.addItem(item)
    }

    func addItem(rect: CGRect) {
        print("addItems rect", rect)
        let x = Int(rect.width / 2);
        let y = Int(rect.height / 2);
        addItem(x: x, y: y)
    }
        
    func addItems(rect: CGRect, count:Int) {
        print("addItems rect", rect, "count", count)
        let len = 50
        let bottom = Int(rect.height - bottomMargin)
        print("addItems bottom", bottom)
        var x = 0
        var y = 0
        if items.count > 0 {
            x = items[items.count-1].x
            y = items[items.count-1].y
            x += len;
            if x > Int(rect.width) {
                x = 0
                y += len;
                if y + len > bottom {
                    y = 0
                }
            }
        }
        for _ in 0..<count {
            addItem(x: x, y: y)
            x += len;
            if x > Int(rect.width) {
                x = 0
                y += len;
                if y > bottom {
                    y = 0
                }
            }
        }
    }
    
    func fillItems(rect: CGRect) {
        var x = 0
        var y = 0
        let len = 50
        let bottom = Int(rect.height - 250.0)
        while y < bottom {
            addItem(x: x, y: y)
            x += len;
            if x > Int(rect.width) {
                x = 0
                y += len;
            }
        }
    }
        
    func addInitalItem(rect: CGRect) {
        let x = rect.width / 2;
        let y = rect.height / 2;
        let item = ItemModel(x: Int(x), y: Int(y))
        model.addItem(item)
    }
    
    func shakeDemo(rect: CGRect) {
        let bottom = Int(rect.height - bottomMargin)
        for index in  0..<model.items.count {
            let a = 45.0;
            model.items[index].rotation = Double.random(in:-a...a)
            model.items[index].x = Int.random(in:0...Int(rect.width))
            model.items[index].y = Int.random(in:0...Int(bottom))
            update(index: index, sizeBy: Double.random(in:0.5...1.5))
        }
        model.items.shuffle()
    }
    
    func setRandomColor() {
        for index in  0..<model.items.count {
            model.items[index].colorNum = randomColorNum();
        }
    }
    
    func save(_ fileName: String) {
        model.saveAsJSON(fileName: fileName)
    }
    
    func restore(_ fileName: String) {
        model = Model(JSONfileName: fileName)
    }
}

enum Palette: String, CaseIterable, Identifiable {
    case fixed
    case rgb
    var id: String { self.rawValue }
}
