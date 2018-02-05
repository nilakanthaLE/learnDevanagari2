//
//  ZeichenAuswahlConfigView.swift
//  learnDevanagari2
//
//  Created by Matthias Pochmann on 02.01.18.
//  Copyright © 2018 Matthias Pochmann. All rights reserved.
//

import Foundation
import ReactiveSwift

//MARK: ZeichenAuswahlConfigViewModel
// ViewModel für ZeichenImQuadratView
// Model für die Darstellung von gewählten Zeichen (als Grundauswahl)
// und einer farblich hervorgehobenen (Hintergrund grau) Auswahl daraus , die im freien Üben Quiz abgefragt werden sollen
class ZeichenAuswahlConfigViewModel:ZeichenImQuadratViewModelProtocol{
    var zeichenUndFarbeArray        = MutableProperty([[(title:String,color:UIColor)]]())
    var editButtonIsHidden          = MutableProperty(true)

    //MARK: init
    init (grundauswahl:MutableProperty<[Zeichen]>,gewaehltausGrundauswahl:MutableProperty<[Zeichen]>){
        //zeichenUndFarbeArray erhält update, wenn:
        // 1) Grundauswahl ändert sich
        // 2) gewähltAusGrundauswahl ändert sich
        zeichenUndFarbeArray <~ grundauswahl.producer.map               { ZeichenAuswahlConfigViewModel.updateZeichenArray(grundauswahl: $0, gewaehltausGrundauswahl: gewaehltausGrundauswahl.value) }
        zeichenUndFarbeArray <~ gewaehltausGrundauswahl.producer.map    { ZeichenAuswahlConfigViewModel.updateZeichenArray(grundauswahl: grundauswahl.value, gewaehltausGrundauswahl:$0) }
    }
    
    //MARK: helper
    // erzeugt neues QuadratArray aus titleAndColor Tuples
    // immer wenn sich Grundauswahl oder gewähltAusGrundauswahl ändert
    static func updateZeichenArray(grundauswahl:[Zeichen],gewaehltausGrundauswahl:[Zeichen]) -> [[(title:String,color:UIColor)]]{
        var grundauswahl            = grundauswahl
        let array                   = createQuadratArray(menge: grundauswahl.count, repeating: String())
        return array.map {row in row.map{ _ in titleAndColor(from: getAndRemoveFirst(from: &grundauswahl), gewaehltAusGrundauswahl: gewaehltausGrundauswahl) }}
    }
    //liefert ein titleAndColor Tuple für ein Zeichen (und gewaehltAusGrundauswahl)
    // color: lightGray - in Grundauswahl enthalten
    // clear - nicht enthalten
    static func titleAndColor(from zeichen:Zeichen?, gewaehltAusGrundauswahl:[Zeichen]) -> (title:String,color:UIColor)  {
        guard let zeichen = zeichen else {return (title: String() , color : .clear)}
        let title   = zeichen.devanagari ?? String()
        let color   = gewaehltAusGrundauswahl.contains(zeichen) ? UIColor.lightGray : UIColor.clear
        return (title: title, color : color)
    }
}



