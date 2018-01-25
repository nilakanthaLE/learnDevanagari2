//
//  DatentypenZeichen.swift
//  learnDevanagari2
//
//  Created by Matthias Pochmann on 08.11.17.
//  Copyright © 2017 Matthias Pochmann. All rights reserved.
//

import Foundation
import ReactiveSwift

class Zeichen:NSObject{
    var devanagari:String?
    var umschrift:String?
    var vokalOderKonsonant:String?
    var vokalOderHalbvokal:String?
    var artikulation:String?
    var konsonantTyp:String?
    var aspiration:String?
    var stimmhaftigkeit:String?
    var grundZeichen:String?
    var lektion:Int?
    var isLigatur = false
    
    //MARK: für "==" und NSObject benötigt
    static func ==(lhs: Zeichen, rhs: Zeichen) -> Bool { return lhs.devanagari == rhs.devanagari }
    
    //MARK: calc Properties
    var scoreZeichen:ScoreZeichen?                      { return MainSettings.get()?.angemeldeterUser?.getScoreZeichen(for: devanagari)}
    var isAnusvara:Bool                                 { return devanagari == "ं" }
    var isVisarga:Bool                                  { return devanagari == "ः" }
    var isVirama:Bool                                   { return devanagari == "्" }
    var vonGrundZeichenAbgeleitet:[Zeichen]             { return Singleton.sharedInstance.zeichenSatz.filter{$0.grundZeichen == grundZeichen} }
    private var alleMoegelichenAbfragewerte:[String?]   { return  [devanagari,umschrift,vokalOderHalbvokal,vokalOderKonsonant,artikulation,konsonantTyp,aspiration,stimmhaftigkeit]}
    var anzahlMoeglicheAbfragen:Int{
        if isAnusvara               { return 5 }
        if isVirama || isVisarga    { return 1 }
        else                        { return alleMoegelichenAbfragewerte.filter{$0 != nil}.count }
    }
    
    //MARK: holt korrekte Antwort für ein UserControl
    // und QuizZeichen - falls Sonderlektion
    func getCorrectAnswer(for controlTyp:ControlTyp?,quizZeichen:QuizZeichen?) -> String?{
        guard let controlTyp = controlTyp else {return nil}
        var textFeldAnswer:String?      { return quizZeichen?.nasalDesAnusvaraZeichen?.umschrift ??  quizZeichen?.anusvaraVisargaViramaZeichen?.umschrift ?? umschrift }
        var artikulationsAnswer:String? { return quizZeichen?.nasalDesAnusvaraZeichen?.artikulation.rawValue ?? artikulation }
        
        switch controlTyp {
        case .ArtikulationTyp:          return artikulationsAnswer
        case .AspirationTyp:            return aspiration
        case .KonsonantTyp:             return konsonantTyp
        case .StimmhaftigkeitTyp:       return stimmhaftigkeit
        case .TextfeldTyp:              return textFeldAnswer
        case .VokalOderHalbvokalTyp:    return vokalOderHalbvokal
        case .VokalOderKonsonantTyp:    return vokalOderKonsonant
        case .ZeichenfeldTyp:           return devanagari
        }
    }
    
    //MARK: Sortierung für Freies Üben Zeichenauswahl
    //sortiert Zeichensatz ja nach Typ: Zufall, selten geübt, häufig falsch
    static func sortZeichenSatz(aus zeichenSatz:[Zeichen]?, user:User?,zeichenAuswahlTyp:ZeichenAuswahlTyp?) -> [Zeichen]{
        guard let zeichenSatz = zeichenSatz else {return [Zeichen]()}
        guard let zeichenAuswahlTyp = zeichenAuswahlTyp else {return zeichenSatz}
        switch zeichenAuswahlTyp {
        case .Zufall:
            var zSatz = zeichenSatz
            zSatz.shuffle()
            return zSatz
        case .SeltenGeuebt:
            var sortedSatz  = zeichenSatz.map{$0.scoreZeichen}.sorted{$1?.geuebtCount ?? 0 > $0?.geuebtCount ?? 0}.map{$0?.zeichen}
            sortedSatz      = sortedSatz.filter{$0 != nil}
            return sortedSatz as! [Zeichen]
        case .HauefigFalsch:    return zeichenSatz.sorted{$0.scoreZeichen?.falschBeantwortetCount ?? 0 > $1.scoreZeichen?.falschBeantwortetCount ?? 0}
        }
    }
}

// MARK: Sonderzeichen für Sonderlektion
// hängt an QuizZeichen, falls NasalDesAnusvara oder AnusvaraVisargaVirama Lektion
class NasalDesAnusvaraZeichen{
    var devanagari:String
    var umschrift:String
    var artikulation:Artikulation
    init (devanagari:String,umschrift:String,artikulation:Artikulation){
        self.devanagari         = devanagari
        self.umschrift          = umschrift
        self.artikulation       = artikulation
    }
}
class AnusvaraVisargaViramaZeichen{
    var devanagari:String
    var umschrift:String
    var zeichenFuerScore:Zeichen
    init (devanagari:String,umschrift:String,zeichenFuerScore:Zeichen){
        self.devanagari         = devanagari
        self.umschrift          = umschrift
        self.zeichenFuerScore   = zeichenFuerScore
    }
}
