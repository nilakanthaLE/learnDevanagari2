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
    
    func isCorrect(for controlTyp:ControlTyp, quizZeichen:QuizZeichen) -> Bool{
        // für Nachzeichnen  = true (quizSetting.abfragen.count == 0)
        let userEingabe = getMutableProperty(for: controlTyp)?.value
        let correct     = quizZeichen.zeichen.getValue(for: controlTyp)
        return userEingabe == correct
    }
    func isCorrect(for quizZeichen:QuizZeichen?) -> Bool{
        guard let quizZeichen = quizZeichen else {return false}
        return quizZeichen.quizSetting.abfragen.map{isCorrect(for: $0, quizZeichen: quizZeichen)}.filter{$0 == false}.count == 0
    }
    func userAntworten(for quizZeichen:QuizZeichen?) ->[(controlTyp:ControlTyp,correct:Bool)]{
        guard let quizZeichen = quizZeichen else {return [(controlTyp:ControlTyp,correct:Bool)]()}
        return quizZeichen.quizSetting.abfragen.map{(controlTyp:$0,correct:isCorrect(for: $0, quizZeichen: quizZeichen))}
    }
}

enum QuizZeichenStatus:Int{ case Ungesichtet = 1 , Correct = 0, FalschBeantwortet = 2, InUserAbfrage = 3}
class QuizZeichen:Equatable{
    static func ==(lhs: QuizZeichen, rhs: QuizZeichen) -> Bool {
        return lhs.zeichen == rhs.zeichen &&
        lhs.quizSetting == rhs.quizSetting &&
        lhs.status.value == rhs.status.value
    }
    
    
    var status =   MutableProperty( QuizZeichenStatus.Ungesichtet )
    var zeichen:Zeichen
    var quizSetting:QuizSetting
    init(zeichen:Zeichen,quizSetting:QuizSetting) {
        self.zeichen        = zeichen
        self.quizSetting    = quizSetting
        
        
    }
    var titleForZeichenfeldButton:String?{
        return quizSetting.zeichenfeld == .InAbfrage ? "?" : zeichen.devanagari
    }
    
    func setLetztesMalKorrektLektion(){
        guard status.value == .Correct else {return}
        scoreZeichen?.setLetztesMalKorrektLektion(quizZeichen: self)
    }
    
    //helper
    static func createQuizZeichensatz(quizSetting:QuizSetting?,zeichensatz:[Zeichen]?) -> [QuizZeichen]{
        guard let quizSetting = quizSetting, let zeichensatz = zeichensatz else {return [QuizZeichen]()}
        
        var zeichensatzForZeichenfeldAbfrage:[QuizZeichen]{
            guard var quizSetting = quizSetting.copy() else {return [QuizZeichen]()}
            quizSetting.setPanelControlsToNurAnzeige()
            quizSetting.zeichenfeld = .InAbfrage
            return zeichensatz.map{QuizZeichen(zeichen: $0, quizSetting: quizSetting)}
        }
        var zeichensatzForZeichenfeldNachzeichnen:[QuizZeichen]{
            guard var quizSetting = quizSetting.copy() else {return [QuizZeichen]()}
            quizSetting.setPanelControlsToNurAnzeige()
            quizSetting.zeichenfeld = .Nachzeichnen
            return zeichensatz.map{QuizZeichen(zeichen: $0, quizSetting: quizSetting)}
        }
        var zeichensatzForZeichenfeldNurAnzeige:[QuizZeichen]{
            guard var quizSetting = quizSetting.copy() else {return [QuizZeichen]()}
            quizSetting.zeichenfeld = .NurAnzeige
            return quizSetting.anzahlAbfragen > 0 ? zeichensatz.map{QuizZeichen(zeichen: $0, quizSetting: quizSetting)} : [QuizZeichen]()
        }
        
        switch quizSetting.zeichenfeld {
        case .NurAnzeige:               return zeichensatzForZeichenfeldNurAnzeige
        case .Nachzeichnen:             return zeichensatzForZeichenfeldNachzeichnen + zeichensatzForZeichenfeldNurAnzeige
        case .InAbfrage:                return zeichensatzForZeichenfeldAbfrage + zeichensatzForZeichenfeldNurAnzeige
        case .AbfrageUndNachzeichnen:   return zeichensatzForZeichenfeldAbfrage + zeichensatzForZeichenfeldNurAnzeige + zeichensatzForZeichenfeldNachzeichnen
        }
    }
    static func createQuizZeichensatzForLektion(quizSetting:QuizSetting?,zeichensatz:[Zeichen]?) -> [QuizZeichen]{
        let quizZeichenSatz = createQuizZeichensatz(quizSetting:quizSetting,zeichensatz:zeichensatz)
        for quizZeichen in quizZeichenSatz{
            //setzt QuizZeichen status auf Correct, wenn in ScoreZeichen letztesMalKorrektInLektion == aktuelleLektion
            let scoreZeichen    = MainSettings.get()?.angemeldeterUser?.scoreZeichen(for: quizZeichen.zeichen.devanagari)
            let aktuelleLektion = MainSettings.get()?.angemeldeterUser?.aktuelleLektion
            if scoreZeichen?.getLetztesMalKorrektInLektion(quizZeichen: quizZeichen) == aktuelleLektion{
                quizZeichen.status.value = .Correct
            }
        }
        return filterQuizZeichensatzForLektion(quizZeichenSatz: quizZeichenSatz,quizSetting: quizSetting)
    }
    static func filterQuizZeichensatzForLektion(quizZeichenSatz:[QuizZeichen],quizSetting:QuizSetting?) -> [QuizZeichen]{
        let anzahlQZMax = 50
        var quizZeichenSatz = quizZeichenSatz
        
        //1 nur unbekannte Zeichen nachzeichnen
        func filterNochNichtNachgezeichnet(quizZeichen:QuizZeichen) -> Bool{
            if quizZeichen.quizSetting.zeichenfeld == .Nachzeichnen{
                return MainSettings.get()?.angemeldeterUser?.scoreZeichen(for: quizZeichen.zeichen.devanagari)?.letztesMalKorrektLektionZFNachzeichnen == -1
            }
            return true
        }
        quizZeichenSatz = quizZeichenSatz.filter{filterNochNichtNachgezeichnet(quizZeichen: $0)}
        //2 Zeichen mit neuer Abfrage nicht filtern
        
        
        //3 identische Abfragen eines Zeichens
        // bei LektionsQuizSchwierigkeitsstufe 3 (voll)
        // <identische Abfrage eines Zeichens> herausfiltern
        func filterForStufe3(quizZeichen:QuizZeichen) -> Bool{
            guard let user = MainSettings.get()?.angemeldeterUser, user.currentMainQuizSetting?.isStufe3 == true else { return true}
            let scoreZeichen = user.scoreZeichen(for: quizZeichen.zeichen.devanagari)
            return scoreZeichen?.wurdeBereitsKomplettAbgefragt(fuer: quizZeichen.quizSetting, lektion:user.aktuelleLektion) == false
        }
        if let user = MainSettings.get()?.angemeldeterUser, user.currentMainQuizSetting?.isStufe3 == true{
            quizZeichenSatz = quizZeichenSatz.filter{filterForStufe3(quizZeichen: $0)}
        }
        
        // bei LektionsQuizSchwierigkeitsstufe kleiner 3
        // <identische Abfrage eines Zeichens> nach Häufigkeit richtiger Abfragen sortieren (umgekehrt)
        // Auswahl aus diesem Set (x Zeichen)
        func filterForStufeKleiner3(quizZeichenSatz:[QuizZeichen])->[QuizZeichen]{
            guard let user = MainSettings.get()?.angemeldeterUser ,user.currentMainQuizSetting?.isStufe3 != true else {return quizZeichenSatz}
            func wurdeBereitsKomplettAbgefragt(quizZeichen:QuizZeichen) -> Bool{
                let scoreZeichen = quizZeichen.scoreZeichen
                return scoreZeichen?.wurdeBereitsKomplettAbgefragt(fuer: quizZeichen.quizSetting, lektion:user.aktuelleLektion) == true
            }
            let mitNeuenAbfragen                = quizZeichenSatz.filter{!wurdeBereitsKomplettAbgefragt(quizZeichen: $0)}
            let bereitsKomplettAbgefragt        = quizZeichenSatz.filter{wurdeBereitsKomplettAbgefragt(quizZeichen: $0)}
            let sortedBereitsKomplettAbgefragt  = bereitsKomplettAbgefragt.sorted{$0.scoreZeichen?.anzahlRichtigeMinusFalscheAbfragen(quizSetting:$0.quizSetting) ?? 0
                < $1.scoreZeichen?.anzahlRichtigeMinusFalscheAbfragen(quizSetting:$1.quizSetting) ?? 0}
            let anzahlausBereitsKomlett         = anzahlQZMax - mitNeuenAbfragen.count > 0 ? anzahlQZMax - mitNeuenAbfragen.count : 0
            
            return mitNeuenAbfragen + sortedBereitsKomplettAbgefragt.prefix(anzahlausBereitsKomlett)
        }
        quizZeichenSatz = filterForStufeKleiner3(quizZeichenSatz: quizZeichenSatz)
        
        return quizZeichenSatz
    }
    var scoreZeichen:ScoreZeichen?{
        let user = MainSettings.get()?.angemeldeterUser
        let scoreZeichen = user?.scoreZeichen(for: zeichen.devanagari)
        return scoreZeichen
    }
}

class Zeichen:NSObject{
    static func ==(lhs: Zeichen, rhs: Zeichen) -> Bool {
        return lhs.devanagari == rhs.devanagari
    }
    
    var ID:Int?
    
    var scoreZeichen:ScoreZeichen?  {return MainSettings.get()?.angemeldeterUser?.getScoreZeichen(for: devanagari)}
    //mögliche AbfrageWerte
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
        case .KonsonantTyp:             return konsonantTyp
        case .StimmhaftigkeitTyp:      return stimmhaftigkeit
        case .TextfeldTyp:             return umschrift
        case .VokalOderHalbvokalTyp:   return vokalOderHalbvokal
        case .VokalOderKonsonantTyp:   return vokalOderKonsonant
        case .ZeichenfeldTyp:          return devanagari
        }
    }
    
    static func get(forDeva devaString:String?) -> Zeichen?{
        guard let devaString = devaString else {return nil}
        return erstelleZeichensatz().filter{$0.devanagari == devaString}.first
    }
    
    private var alleMoegelichenAbfragewerte:[String?] {return  [devanagari,umschrift,vokalOderHalbvokal,vokalOderKonsonant,artikulation,konsonantTyp,aspiration,stimmhaftigkeit,]}
    var anzahlMoeglicheAbfragen:Int{ return alleMoegelichenAbfragewerte.filter{$0 != nil}.count }
}
enum VokalOderKonsonant:String  { case Vokal        = "Vokal", Konsonant  = "Konsonant" }
enum VokalOderHalbvokal:String  { case Vokal        = "einf. Vokal", Halbvokal  = "Halbvokal" }
enum KonsonantTyp:String        { case Nasal        = "Nasal",Sibilant = "Sibilant",Hauchlaut = "Hauchlaut",EinfacherKonsonant = "einf. Konsonant" }
enum Aspiration:String          { case Aspiriert    = "aspiriert", NichtAspiriert = "n. aspiriert" }
enum Stimmhaftigkeit:String     { case Stimmhaft    = "stimmhaft", NichtStimmhaft = "n. stimmhaft" }
enum Artikulation:String        { case velar        = "velar",palatal = "palatal",retroflex = "retroflex" ,dental = "dental",labial = "labial" }
