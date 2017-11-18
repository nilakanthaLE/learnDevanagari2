//
//  DatentypenZeichen.swift
//  learnDevanagari2
//
//  Created by Matthias Pochmann on 08.11.17.
//  Copyright © 2017 Matthias Pochmann. All rights reserved.
//

import Foundation
import ReactiveSwift

class UserAntwortZeichen{
    var devanagari:MutableProperty<String?>
    var umschrift:MutableProperty<String?>
    var vokalOderKonsonant:MutableProperty<String?>
    var vokalOderHalbvokal:MutableProperty<String?>
    var artikulation:MutableProperty<String?>
    var konsonantTyp:MutableProperty<String?>
    var aspiration:MutableProperty<String?>
    var stimmhaftigkeit:MutableProperty<String?>
    
    init(){
        self.devanagari                 = MutableProperty<String?>(nil)
        self.umschrift                  = MutableProperty<String?>(nil)
        self.vokalOderKonsonant         = MutableProperty<String?>(nil)
        self.vokalOderHalbvokal         = MutableProperty<String?>(nil)
        self.artikulation               = MutableProperty<String?>(nil)
        self.konsonantTyp               = MutableProperty<String?>(nil)
        self.aspiration                 = MutableProperty<String?>(nil)
        self.stimmhaftigkeit            = MutableProperty<String?>(nil)
    }
    func resetToNil(){
        self.devanagari.value                   = nil
        self.umschrift.value                    = nil
        self.vokalOderKonsonant.value           = nil
        self.vokalOderHalbvokal.value           = nil
        self.artikulation.value                 = nil
        self.konsonantTyp.value                 = nil
        self.aspiration.value                   = nil
        self.stimmhaftigkeit.value              = nil
    }
    func getMutableProperty(for controlTyp:ControlTyp?) -> MutableProperty<String?>?{
        guard let controlTyp = controlTyp else {return nil}
        switch controlTyp {
        case .ArtikulationTyp:          return artikulation
        case .AspirationTyp:            return aspiration
        case .KonsonantTyp:             return konsonantTyp
        case .StimmhaftigkeitTyp:       return stimmhaftigkeit
        case .TextfeldTyp:              return umschrift
        case .VokalOderHalbvokalTyp:    return vokalOderHalbvokal
        case .VokalOderKonsonantTyp:    return vokalOderKonsonant
        case .ZeichenfeldTyp:           return devanagari
        }
    }
    
    func isCorrect(for quizZeichen:QuizZeichen?) -> Bool{
        guard let quizZeichen = quizZeichen else {return false}
        
        func isCorrect(for controlTyp:ControlTyp, quizZeichen:QuizZeichen) -> Bool{
            let userEingabe = getMutableProperty(for: controlTyp)?.value
            let correct     = quizZeichen.zeichen.getValue(for: controlTyp)
            return userEingabe == correct
        }
        
        return quizZeichen.quizSetting.abfragen.map{isCorrect(for: $0, quizZeichen: quizZeichen)}.filter{$0 == false}.count == 0
    }
}

class QuizZeichen{
    var zeichen:Zeichen
    var quizSetting:QuizSetting
    init(zeichen:Zeichen,quizSetting:QuizSetting) {
        self.zeichen        = zeichen
        self.quizSetting    = quizSetting
    }
    var titleForZeichenfeldButton:String?{
        return quizSetting.zeichenfeld == .Abfrage ? "?" : zeichen.devanagari
    }
}

class Zeichen{
    var ID:Int?
    
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
    
    func getValue(for controlTyp:ControlTyp?) -> String?{
        guard let controlTyp = controlTyp else {return nil}
        switch controlTyp {
        case .ArtikulationTyp:         return artikulation
        case .AspirationTyp:           return aspiration
        case .KonsonantTyp:         return konsonantTyp
        case .StimmhaftigkeitTyp:      return stimmhaftigkeit
        case .TextfeldTyp:             return umschrift
        case .VokalOderHalbvokalTyp:   return vokalOderHalbvokal
        case .VokalOderKonsonantTyp:   return vokalOderKonsonant
        case .ZeichenfeldTyp:          return devanagari
        }
    }
}
enum VokalOderKonsonant:String  { case Vokal        = "Vokal", Konsonant  = "Konsonant" }
enum VokalOderHalbvokal:String  { case Vokal        = "einf. Vokal", Halbvokal  = "Halbvokal" }
enum KonsonantTyp:String        { case Nasal        = "Nasal",Sibilant = "Sibilant",Hauchlaut = "Hauchlaut",EinfacherKonsonant = "einf. Konsonant" }
enum Aspiration:String          { case Aspiriert    = "aspiriert", NichtAspiriert = "n. aspiriert" }
enum Stimmhaftigkeit:String     { case Stimmhaft    = "stimmhaft", NichtStimmhaft = "n. stimmhaft" }
enum Artikulation:String        { case velar        = "velar",palatal = "palatal",retroflex = "retroflex" ,dental = "dental",labial = "labial" }
