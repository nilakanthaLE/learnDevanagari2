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
        let correct     = quizZeichen.zeichen.getCorrectAnswer(for: controlTyp, quizZeichen: quizZeichen)
        return userEingabe != nil && userEingabe == correct
    }
    func isCorrect(for quizZeichen:QuizZeichen?) -> Bool{
        guard let quizZeichen = quizZeichen else {return false}
        
        return quizZeichen.quizSetting.filteredAbfragen(for: quizZeichen).map{isCorrect(for: $0, quizZeichen: quizZeichen)}.filter{$0 == false}.count == 0
    }
    func userAntworten(for quizZeichen:QuizZeichen?) ->[(controlTyp:ControlTyp,correct:Bool)]{
        guard let quizZeichen = quizZeichen else {return [(controlTyp:ControlTyp,correct:Bool)]()}
        return quizZeichen.quizSetting.filteredAbfragen(for: quizZeichen).map{(controlTyp:$0,correct:isCorrect(for: $0, quizZeichen: quizZeichen))}
    }
}

enum QuizZeichenStatus:Int{ case Ungesichtet = 1 , Correct = 0, FalschBeantwortet = 2, InUserAbfrage = 3}
class QuizZeichen:Equatable{
    static func ==(lhs: QuizZeichen, rhs: QuizZeichen) -> Bool {
        return lhs.zeichen == rhs.zeichen &&
        lhs.quizSetting == rhs.quizSetting &&
        lhs.status.value == rhs.status.value
    }
    
    var nasalDesAnusvaraZeichen:NasalDesAnusvaraZeichen?
    var anusvaraVisargaViramaZeichen:AnusvaraVisargaViramaZeichen?
    var status =   MutableProperty( QuizZeichenStatus.Ungesichtet )
    var zeichen:Zeichen
    var quizSetting:QuizSetting
    init(zeichen:Zeichen,quizSetting:QuizSetting) {
        self.zeichen                = zeichen
        self.quizSetting            = quizSetting
    }
    var titleForZeichenfeldButton:String?{
        return quizSetting.zeichenfeld == .InAbfrage ? "?" : nasalDesAnusvaraZeichen?.devanagari ?? anusvaraVisargaViramaZeichen?.devanagari ?? zeichen.devanagari
    }
    
    func setLetztesMalKorrektLektion(){
        guard status.value == .Correct else {return}
        scoreZeichen?.setLetztesMalKorrektLektion(quizZeichen: self)
    }
    
    static func getSonderZeichenFuerTastaturBar(quizZeichensatz:[QuizZeichen]) -> [String]{
        if quizZeichensatz.first?.nasalDesAnusvaraZeichen != nil || quizZeichensatz.first?.anusvaraVisargaViramaZeichen != nil { return Array(Set(sonderZeichenFuerBar().map{$0.angezeigt}))}
        var ergebnis = Set<String>()
        for barZeichen in sonderZeichenFuerBar(){
            if (quizZeichensatz.map{$0.zeichen.devanagari ?? ""}.filter{$0.contains(barZeichen.suchString)}.count > 0) { ergebnis.insert(barZeichen.angezeigt)}
        }
        return Array(ergebnis)
    }
    
    //helper
    static func createQuizZeichensatzForAnusvaraVisargaViramaLektion(quizSetting:QuizSetting?) -> [QuizZeichen]{
        let zeichensatz = erstelleZeichensatz()
        let anzahlProSonderzeichen  = 8
        guard let anusvara  = (zeichensatz.filter{$0.devanagari == "ं"}.first),
            let visarga     = (zeichensatz.filter{$0.devanagari == "ः"}.first),
            let virama      = (zeichensatz.filter{$0.devanagari == "्"}.first),
            let quizSetting = quizSetting else {return [QuizZeichen]()}
        var ergebnis        = [QuizZeichen]()
        
        var sonderZeichen = [anusvara,visarga,virama]
        
        let anusvaraViramaLektionNummer     = erstelleLektionen().filter{$0.quizSetting?.anusvaraVisargaViramaPruefe == true}.first?.nummer ?? 0
        var moeglichePraefixe               = Array(Set(zeichensatz.filter{$0.lektion ?? 1000 <= anusvaraViramaLektionNummer}).symmetricDifference(grundZeichen()))
        var moeglichePraefixeVirama         = grundZeichen().filter{$0.vokalOderKonsonant == VokalOderKonsonant.Konsonant.rawValue}
        
        for iSonderZeichen in sonderZeichen{
            for _ in 0 ..< anzahlProSonderzeichen{
                let praefix:Zeichen = {
                    if iSonderZeichen == virama{
                        var randomIndexPraefix:Int{ return Int(arc4random_uniform(UInt32(moeglichePraefixeVirama.count))) }
                        return moeglichePraefixeVirama.remove(at: randomIndexPraefix)
                    }
                    var randomIndexPraefix:Int{ return Int(arc4random_uniform(UInt32(moeglichePraefixe.count))) }
                    return moeglichePraefixe.remove(at: randomIndexPraefix)
                }()
                var suffix:String{
                    if iSonderZeichen == anusvara   { return "ṃ"}
                    if iSonderZeichen == visarga    { return "ḥ"}
                    return ""
                }
                
                let devanagari  = (praefix.devanagari ?? "") + (iSonderZeichen.devanagari ?? "")
                var umschrift:String{
                    if iSonderZeichen == virama{
                        var start = praefix.umschrift ?? ""
                        start.removeLast()
                        return start
                    }
                    return (praefix.umschrift ?? "") + suffix
                }
                
                let quizZeichen = QuizZeichen(zeichen: praefix, quizSetting: quizSetting)
                quizZeichen.anusvaraVisargaViramaZeichen = AnusvaraVisargaViramaZeichen(devanagari: devanagari, umschrift: umschrift, zeichenFuerScore: iSonderZeichen)
                ergebnis.append(quizZeichen)
            }
        }
        return ergebnis
    }
    
    static func createQuizZeichensatzForNasalDesAnusvaraLektion(quizSetting:QuizSetting?) -> [QuizZeichen]{
        let zeichensatz = erstelleZeichensatz()
        guard let anusvara  = (zeichensatz.filter{$0.devanagari == "ं"}.first), let quizSetting = quizSetting else {return [QuizZeichen]()}
        var ergebnis        = [QuizZeichen]()
        var anzahlProArtikulationsOrt   = 5
        var moeglichePraefixe           = zeichensatz.filter{$0.vokalOderKonsonant == VokalOderKonsonant.Konsonant.rawValue}
        var moeglicheSuffixe            = moeglichePraefixe.filter{ $0.konsonantTyp == KonsonantTyp.EinfacherKonsonant.rawValue }
        
        
        var artikulationen              = [Artikulation.dental,Artikulation.labial,Artikulation.palatal,Artikulation.retroflex,Artikulation.velar]
        for artikulation in artikulationen{
            var moeglicheSuffixeFuerArtikulation = moeglicheSuffixe.filter{$0.artikulation == artikulation.rawValue}
            for i in 0 ..< anzahlProArtikulationsOrt{
                let quizZeichen = QuizZeichen(zeichen: anusvara, quizSetting: quizSetting)
                var randomIndexPraefix:Int{ return Int(arc4random_uniform(UInt32(moeglichePraefixe.count))) }
                let praefix = moeglichePraefixe.remove(at: randomIndexPraefix)
                
                var randomIndexSuffix:Int{ return Int(arc4random_uniform(UInt32(moeglicheSuffixeFuerArtikulation.count))) }
                let suffix  = moeglicheSuffixeFuerArtikulation.remove(at: randomIndexSuffix)
                
                let devanagari  = (praefix.devanagari ?? "") + (anusvara.devanagari ?? "") + (suffix.devanagari ?? "")
                let umschrift   = (praefix.umschrift ?? "") + (artikulation.nasalUmschrift ?? "") + (suffix.umschrift ?? "")
                quizZeichen.nasalDesAnusvaraZeichen = NasalDesAnusvaraZeichen(devanagari: devanagari, umschrift: umschrift, artikulation: artikulation)
                ergebnis.append(quizZeichen)
            }
        }
        return ergebnis
    }
    
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
        //SonderLektion Nasal des Anusvara
        guard quizSetting?.nasalDesAnusvaraPruefe == false else { return createQuizZeichensatzForNasalDesAnusvaraLektion(quizSetting:quizSetting) }
        guard quizSetting?.anusvaraVisargaViramaPruefe == false else { return createQuizZeichensatzForAnusvaraVisargaViramaLektion(quizSetting:quizSetting) }

        
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
    
    var isLigatur = false
    
    var vonGrundZeichenAbgeleitet:[Zeichen]{
        let zeichenSatz = erstelleZeichensatz()
        return zeichenSatz.filter{$0.grundZeichen == grundZeichen}
    }
    
    func getCorrectAnswer(for controlTyp:ControlTyp?,quizZeichen:QuizZeichen?) -> String?{
        guard let controlTyp = controlTyp else {return nil}
        if let nasalDesAnusvaraZeichen = quizZeichen?.nasalDesAnusvaraZeichen{
            switch controlTyp{
            case .TextfeldTyp:      return nasalDesAnusvaraZeichen.umschrift
            case .ArtikulationTyp:  return nasalDesAnusvaraZeichen.artikulation.rawValue
            default: return nil
            }
        }
        
        
        var anusvaraVisargaViramaZeichenUmschrift:String?{
            guard controlTyp == .TextfeldTyp else {return nil}
            return quizZeichen?.anusvaraVisargaViramaZeichen?.umschrift
        }
        
        
        switch controlTyp {
        case .ArtikulationTyp:          return artikulation
        case .AspirationTyp:            return aspiration
        case .KonsonantTyp:             return konsonantTyp
        case .StimmhaftigkeitTyp:       return stimmhaftigkeit
        case .TextfeldTyp:              return anusvaraVisargaViramaZeichenUmschrift ?? umschrift
        case .VokalOderHalbvokalTyp:    return vokalOderHalbvokal
        case .VokalOderKonsonantTyp:    return vokalOderKonsonant
        case .ZeichenfeldTyp:           return devanagari
        }
    }
    
    static func get(forDeva devaString:String?) -> Zeichen?{
        guard let devaString = devaString else {return nil}
        return erstelleZeichensatz().filter{$0.devanagari == devaString}.first
    }
    
    // filtert Zeichensatz für Auswahl: Zufall, selten geübt, häufig falsch
    static func filterZeichenSatz(anzahl:Int,aus zeichenSatz:[Zeichen]?, user:User?,zeichenAuswahlTyp:ZeichenAuswahlTyp?) -> [Zeichen]{
        guard let zeichenSatz = zeichenSatz else {return [Zeichen]()}
        guard let zeichenAuswahlTyp = zeichenAuswahlTyp else {return zeichenSatz}
        switch zeichenAuswahlTyp {
        case .Zufall: return zeichenSatz.pickRandom(anzahl: anzahl)
        case .SeltenGeuebt:
            let sortedSatz = zeichenSatz.sorted{$1.scoreZeichen?.haeufigKeitGeuebt ?? 0 > $0.scoreZeichen?.haeufigKeitGeuebt ?? 0}
            return Array(sortedSatz.prefix(anzahl))
        case .HauefigFalsch:
            let sortedSatz = zeichenSatz.sorted{$0.scoreZeichen?.haeufigkeitFalsch ?? 0 > $1.scoreZeichen?.haeufigkeitFalsch ?? 0}
            return Array(sortedSatz.prefix(anzahl))
        }
    }
    
    private var alleMoegelichenAbfragewerte:[String?] {return  [devanagari,umschrift,vokalOderHalbvokal,vokalOderKonsonant,artikulation,konsonantTyp,aspiration,stimmhaftigkeit]}
    var anzahlMoeglicheAbfragen:Int{
        if devanagari == "ं" { return 5 }
        if devanagari == "्" || devanagari == "ः"{ return 1}
        else{
            return alleMoegelichenAbfragewerte.filter{$0 != nil}.count }
    }
}

extension Array{
    func pickRandom(anzahl:Int) -> Array{
        var workArray = self
        let numberToMove = count - anzahl >= 0 ? count - anzahl : 0
        for _ in 0 ..< numberToMove{
            let randomIndex = Int(arc4random_uniform(UInt32(workArray.count)))
            workArray.remove(at: randomIndex)
        }
        return workArray
    }
}

enum VokalOderKonsonant:String  { case Vokal        = "Vokal", Konsonant  = "Konsonant" }
enum VokalOderHalbvokal:String  { case Vokal        = "einf. Vokal", Halbvokal  = "Halbvokal" }
enum KonsonantTyp:String        { case Nasal        = "Nasal",Sibilant = "Sibilant",Hauchlaut = "Hauchlaut",EinfacherKonsonant = "einf. Konsonant" }
enum Aspiration:String          { case Aspiriert    = "aspiriert", NichtAspiriert = "n. aspiriert" }
enum Stimmhaftigkeit:String     { case Stimmhaft    = "stimmhaft", NichtStimmhaft = "n. stimmhaft" }
enum Artikulation:String {
    case velar        = "velar",palatal = "palatal",retroflex = "retroflex" ,dental = "dental",labial = "labial"
    
    var nasalUmschrift:String?{
        switch self {
        case .velar:return "ṅ"
        case .palatal:return "ñ"
        case .retroflex:return "ṇ"
        case .dental:return "n"
        case .labial:return "m"
        }
    }
    static func cases() -> [Artikulation]{ return [.velar,.palatal,.retroflex,.dental,.labial] }
}

