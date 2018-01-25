//
//  DatentypUserAntwortZeichen.swift
//  learnDevanagari2
//
//  Created by Matthias Pochmann on 22.01.18.
//  Copyright © 2018 Matthias Pochmann. All rights reserved.
//

import Foundation
import ReactiveSwift

class UserAntwortZeichen{
    //MARK: Mögliche Antworten des Users
    var devanagari:             MutableProperty<String?> = MutableProperty<String?>(nil)
    var umschrift:              MutableProperty<String?> = MutableProperty<String?>(nil)
    var vokalOderKonsonant:     MutableProperty<String?> = MutableProperty<String?>(nil)
    var vokalOderHalbvokal:     MutableProperty<String?> = MutableProperty<String?>(nil)
    var artikulation:           MutableProperty<String?> = MutableProperty<String?>(nil)
    var konsonantTyp:           MutableProperty<String?> = MutableProperty<String?>(nil)
    var aspiration:             MutableProperty<String?> = MutableProperty<String?>(nil)
    var stimmhaftigkeit:        MutableProperty<String?> = MutableProperty<String?>(nil)
    //MARK:helper
    //liefert ein Array von Userantworten - für jedes Control mit Wert für correct
    func userAntworten(for quizZeichen:QuizZeichen?) ->[(controlTyp:ControlTyp,correct:Bool)]{
        guard let quizZeichen = quizZeichen else {return [(controlTyp:ControlTyp,correct:Bool)]()}
        return quizZeichen.quizSetting.fuerVokalOderKonsonantGefilterteAbfragen(for: quizZeichen).map{(controlTyp:$0,correct:isCorrect(for: $0, quizZeichen: quizZeichen))}
    }
    //war die Eingabe des Users korrekt?
    func isCorrect(for controlTyp:ControlTyp, quizZeichen:QuizZeichen) -> Bool{
        // für Nachzeichnen  = true (quizSetting.abfragen.count == 0)
        let userEingabe = getMutableProperty(for: controlTyp)?.value
        let correct     = quizZeichen.zeichen.getCorrectAnswer(for: controlTyp, quizZeichen: quizZeichen)
        return userEingabe != nil && userEingabe == correct
    }
    func isCorrect(for quizZeichen:QuizZeichen?) -> Bool{
        guard let quizZeichen = quizZeichen else {return false}
        return quizZeichen.quizSetting.fuerVokalOderKonsonantGefilterteAbfragen(for: quizZeichen).map{isCorrect(for: $0, quizZeichen: quizZeichen)}.filter{$0 == false}.count == 0
    }
    // setzt Usereingabe zurück
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
    // liefert die MutableProperty für ein Control
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
}
