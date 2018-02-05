//
//  Helper.swift
//  learnDevanagari2
//
//  Created by Matthias Pochmann on 04.11.17.
//  Copyright © 2017 Matthias Pochmann. All rights reserved.
//

import Foundation
import UIKit

//globale Variable
var iPadOrientation = (UIApplication.shared.delegate as? AppDelegate)?.iPadOrientation


func berechneFarbe(score:Double) -> UIColor{
    guard score > 0 else    { return .clear}
    var rot:CGFloat         { return score < 0.5 ? CGFloat(1)  : CGFloat(-2 * score + 2) }
    var gruen:CGFloat       { return score < 0.5 ? CGFloat(score * 2) : CGFloat(1) }
    return UIColor.init(red: rot, green: gruen, blue: 0, alpha: 1)
}

func emoji(countryCode: String) -> Character {
    let base = UnicodeScalar("🇦").value - UnicodeScalar("A").value
    
    var string = ""
    countryCode.uppercased().unicodeScalars.forEach {
        if let scala = UnicodeScalar(base + $0.value) {
            string.append(String(describing: scala))
        }
    }
    
    return Character(string)
}

func rearrange<T>(array: Array<T>, fromIndex: Int, toIndex: Int) -> Array<T>{
    var arr = array
    let element = arr.remove(at: fromIndex)
    arr.insert(element, at: toIndex)
    
    return arr
}
func drawOnImage(startingImage: UIImage, start:CGPoint,end:CGPoint) -> UIImage? {
    
    let brush:CGFloat = 28.0;
    
    // Create a context of the starting image size and set it as the current one
    UIGraphicsBeginImageContext(startingImage.size)
    
    // Draw the starting image in the current context as background
    startingImage.draw(at: CGPoint.zero)
    
    // Get the current context
    let context = UIGraphicsGetCurrentContext()!
    
    // Draw a red line
    context.setLineWidth(brush)
    context.setStrokeColor(UIColor.white.cgColor)
    context.setLineCap(.round)
    context.move(to: start)
    context.addLine(to: end)
    context.strokePath()
    
    // Save the context as a new UIImage
    let myImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    // Return modified image
    return myImage
}

// Methode, die je nach Zustand aller Controls die Sichtbarkeit eines einzelnen Controls bestimmt
func controlIsHidden(controlCurrentModus:ControlCurrentModus ,usereingabe:UserAntwortZeichen?, controlTyp:ControlTyp, controlModus: PanelControlModus?, korrekteAntwort:Zeichen?, vokalOderKonsShowsAnswer: PanelControlModus?, isNasalDesAnusvaraLektion:Bool ) -> Bool{
    guard let usereingabe = usereingabe, controlCurrentModus != .Versteckt, controlCurrentModus != .Anzeige, controlModus != .Versteckt else {return true}
    
    let wirdGeprueft = controlCurrentModus == .ShowsPruefergebnis
    
    let showsAnswer             = vokalOderKonsShowsAnswer == .NurAnzeige && controlModus == .NurAnzeige // nur wenn showsAnswer / selected von vokal oder Konsonant
    let vokalForShowsAnswer     = showsAnswer ? korrekteAntwort?.vokalOderKonsonant == VokalOderKonsonant.Vokal.rawValue : false
    let konsonantForShowsAnswer = showsAnswer ? korrekteAntwort?.vokalOderKonsonant == VokalOderKonsonant.Konsonant.rawValue : false
    
    let vokalForKorrekt         = wirdGeprueft ? korrekteAntwort?.vokalOderKonsonant == VokalOderKonsonant.Vokal.rawValue : false
    let konsonantForKorrekt     = wirdGeprueft ? korrekteAntwort?.vokalOderKonsonant == VokalOderKonsonant.Konsonant.rawValue : false
    
    let vokalKonsNil            = usereingabe.vokalOderKonsonant.value   == nil && !wirdGeprueft && !showsAnswer
    let vokal                   = usereingabe.vokalOderKonsonant.value   == VokalOderKonsonant.Vokal.rawValue
    let konsonant               = usereingabe.vokalOderKonsonant.value   == VokalOderKonsonant.Konsonant.rawValue
    
    let vokalHalbVokalNil       = usereingabe.vokalOderHalbvokal.value   == nil && !wirdGeprueft && !showsAnswer
    let einfVokal               = usereingabe.vokalOderHalbvokal.value   == VokalOderHalbvokal.Vokal.rawValue
    
    
    switch controlTyp {
    case .VokalOderKonsonantTyp:    return false
    case .ZeichenfeldTyp:           return false
    case .TextfeldTyp:              return false
    case .VokalOderHalbvokalTyp:    return vokalKonsNil || konsonant || konsonantForKorrekt || konsonantForShowsAnswer //|| controlIsVersteckt
    case .ArtikulationTyp :         return (vokalKonsNil  || (vokal && (vokalHalbVokalNil || einfVokal)) || vokalForKorrekt || vokalForShowsAnswer) && !isNasalDesAnusvaraLektion
    case .AspirationTyp :           return vokalKonsNil || vokal || vokalForKorrekt || vokalForShowsAnswer //|| controlIsVersteckt
    case .StimmhaftigkeitTyp:       return vokalKonsNil || vokal || vokalForKorrekt || vokalForShowsAnswer //|| controlIsVersteckt
    case .KonsonantTyp :            return vokalKonsNil || vokal || vokalForKorrekt || vokalForShowsAnswer //|| controlIsVersteckt
        
    }
}


func zeilenInQuadrat(menge:Int) -> Int{ return Int(ceil(sqrt(Double(menge)))) }

func createQuadratArray<T>(menge:Int,repeating:T) -> [[T]]{
    let anzahlReihen            = zeilenInQuadrat(menge: menge)
    return Array.init(repeating: Array.init(repeating: repeating, count: anzahlReihen), count: anzahlReihen)
}

func getAndRemoveFirst<T>( from array:inout [T]) -> T?{
    if array.count > 0  { return array.removeFirst() }
    return nil
}

//MARK: Array helper
func getIndex(for  string:String?,in array:[[String]])->(x:Int,y:Int)?{
    guard let string = string else {return nil}
    let selArray    = getArray(forTitle: string, inArray: array)
    return getIndex(forSelectedArray: selArray)
}

func getTitle(forTag tag:Int,inArray array:[[String]]) -> String?{
    let index               = getIndex(forTag: tag, inArray: array)
    return index == nil ? nil : array[index!.x][index!.y]
}
func getIndex(forTag tag:Int,inArray array:[[Any]])->(x:Int,y:Int)?{
    let array = getSelectedArray(forTag: tag, inArray: array)
    return getIndex(forSelectedArray: array)
}
func getIndex(forSelectedArray array:[[Any?]]) -> (x:Int,y:Int)?{
    guard array.count > 0  else {return nil}
    return array.enumerated().reduce((x:0,y:0)){ ergebnis, row in
        let x = row.offset
        return row.element.enumerated().reduce(ergebnis){ ergebnis, dataPoint in
            let y = dataPoint.offset
            return dataPoint.element != nil ? (x,y) : ergebnis
        }
    }
}
func getTag(forSelected selected:[[Any?]]?) -> Int{
    guard let selected = selected else {return -1}
    return selected.enumerated().reduce(-1){ ergebnis, row in
        let x = row.offset
        return row.element.enumerated().reduce(ergebnis){
            ergebnis, dataPoint in
            let y = dataPoint.offset
            return ergebnis  < 0 && dataPoint.element != nil ? getTag(for: (x: x, y: y), in: selected) ?? -1 : ergebnis
        }
    }
}
func getTag(for  string:String?,in array:[[String]])->Int?{
    guard let string            = string else {return nil}
    let selArray                = getArray(forTitle: string, inArray: array)
    guard let index             = getIndex(forSelectedArray: selArray) else {return nil}
    return getTag(for: index, in: array)
}
func getTag(for index:(x:Int,y:Int)?, in array:[[Any?]]) -> Int?{
    guard let index = index else {return nil}
    var outOfBounds = false
    let tag = array.enumerated().reduce(0){(ergebnis,row) in
        let rowID = row.offset
        return row.element.enumerated().reduce(ergebnis) { (ergebnis, dataPoint) in
            var toAdd:Int{ return row.offset < index.x ||  row.offset == index.x  && dataPoint.offset < index.y ? 1 : 0 }
            outOfBounds = outOfBounds == true ? true : index.x >= array.count || (row.offset == index.x  && index.y >= row.element.count)
            return ergebnis + toAdd
        }
    }
    return outOfBounds ? nil : tag
}
func getSelectedArray(forTag tag:Int,inArray array:[[Any]]) -> [[Any?]]{
    return array.enumerated().map{
        let x = $0.offset
        return $0.element.enumerated().map{
            let y       = $0.offset
            let iTag    = getTag(for: (x: x, y: y), in: array)
            return iTag == tag ? $0.element : nil
        }
    }
}
func getArray(forTitle title:String?,inArray array:[[String]]) -> [[String?]]{ return array.map{$0.map{$0  == title ? $0 : nil}} }
