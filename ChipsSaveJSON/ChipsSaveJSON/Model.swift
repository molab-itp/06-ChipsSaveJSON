
import SwiftUI

struct Model: Codable {
    var items: [ItemModel] = []
    var uniqueId = 0
        
    mutating func reset () {
        uniqueId = 0
        items = []
    }
    
    mutating func addItem(_ item: ItemModel) {
        var nitem = item;
        uniqueId += 1
        nitem.id = uniqueId;
        items.append(nitem);
    }
    
    func itemIndex(id: Int) -> Int? {
        items.firstIndex { $0.id == id }
    }
    
    func item(id: Int) -> ItemModel? {
        items.first { $0.id == id }
    }
}

struct ItemModel: Identifiable, Hashable, Encodable, Decodable {
    var id: Int = 0
    var colorNum: Int = 0xFFFF0000
    var x: Int = 100
    var y: Int = 100
    var width: Int = 50
    var height: Int = 50
    var rotation: Double = 0.0
    var label: String = "red"   // Not used yet
    var selected: Bool = false
    var assetName: String = ""
    
    var colorName: String {
        String(format: "#%x", colorNum)
    }
    
    var color: Color {
        // !!@ Can't use color as func name due to var color property name
        color_(colorNum: colorNum)
    }
}

// Convert color to 32 bit argb integer
func colorNum_(color: Color) -> Int {
    if let cgColor = color.cgColor, 
        let cc = cgColor.components
    {
        let r = Int(cc[0] * 255.0)
        let g = Int(cc[1] * 255.0)
        let b = Int(cc[2] * 255.0)
        let a = Int(cc[3] * 255.0)
        print("colorNum cc \(String(describing: cc))")
        return ((a << 24) | (r << 16) | (g << 8) | b)
    }
    else {
        print("colorNum failed color \(color)")
        return 0
    }
}

// Covert from integer argb to Color
func color_(colorNum: Int) -> Color {
    let a = Double((colorNum >> 24) & 255)/255.0
    let r = Double((colorNum >> 16) & 255)/255.0
    let g = Double((colorNum >>  8) & 255)/255.0
    let b = Double((colorNum      ) & 255)/255.0
    return Color(.displayP3, red: r, green: g, blue: b, opacity: a)
}

// Pick a random color depending on the selectedPalette
func randomColorNum() -> Int {
//    return randomColorNum_freedomColors()
    return randomColorNum_rgb()
}

// Return a random argb color integer
func randomColorNum_rgb() -> Int {
    let r = Int.random(in:0...255)
    let g = Int.random(in:0...255)
    let b = Int.random(in:0...255)
    return (255 << 24) | (r << 16) | (g << 8) | b
}

// Freedom colors red, gold, green, black
let freedomColors = [0xFFFF0000, 0xFFF0F000, 0xFF00FF00, 0xFF000000]

// Return a random fixed color
func randomColorNum_freedomColors() -> Int {
    let index = Int.random(in:0..<freedomColors.count)
    return freedomColors[index]
}

// Return a random asset name
func randomAssetName() -> String {
    return ""
    // return ["", "fish", "lama"].randomElement()!;
}
