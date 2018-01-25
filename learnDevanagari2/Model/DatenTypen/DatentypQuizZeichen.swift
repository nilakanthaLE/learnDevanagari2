//
//  DatentypQuizZeichen.swift
//  learnDevanagari2
//
//  Created by Matthias Pochmann on 22.01.18.
//  Copyright © 2018 Matthias Pochmann. All rights reserved.
//

import Foundation
import ReactiveSwift

//MARK: QuizZeichen
// ein QuizZeichen beinhaltet alle Information für ein im Quiz abgefragtes Zeichen
// beinhaltet statische Methoden zur Erzeugung von QuizZeichenSätzen
class QuizZeichen:Equatable{
    //MARK: für "==" und Protokol Equatable benötigt
    static func ==(lhs: QuizZeichen, rhs: QuizZeichen) -> Bool { return lhs.zeichen == rhs.zeichen && lhs.quizSetting == rhs.quizSetting && lhs.status.value == rhs.status.value }
    
    //MARK: Basics
    //korrekte Antworten && Settings für Controls (QuizSetting)
    //scoreZeichen
    var zeichen:Zeichen
    var scoreZeichen:ScoreZeichen
    var nasalDesAnusvaraZeichen:NasalDesAnusvaraZeichen?
    var anusvaraVisargaViramaZeichen:AnusvaraVisargaViramaZeichen?
    var quizSetting:QuizSetting
    
    //MARK: init
    init(zeichen:Zeichen,quizSetting:QuizSetting) {
        self.zeichen                = zeichen
        self.quizSetting            = quizSetting
        self.scoreZeichen           = MainSettings.get()?.angemeldeterUser?.getScoreZeichen(for: zeichen.devanagari) ?? ScoreZeichen()
    }
    
    //MARK: Status der Abfrage
    //Ungesichtet, InUserAbfrage, Correct , FalschBeantwortet
    var status =   MutableProperty( QuizZeichenStatus.Ungesichtet )
    
    //MARK: helper
    var titleForZeichenfeldButton:String?{ return quizSetting.zeichenfeld == .InAbfrage ? "?" : nasalDesAnusvaraZeichen?.devanagari ?? anusvaraVisargaViramaZeichen?.devanagari ?? zeichen.devanagari }
    static func getSonderZeichenFuerTastaturBar(quizZeichensatz:[QuizZeichen]) -> [String]{
        if quizZeichensatz.first?.nasalDesAnusvaraZeichen != nil || quizZeichensatz.first?.anusvaraVisargaViramaZeichen != nil { return Array(Set(sonderZeichenFuerBar().map{$0.angezeigt}))}
        var ergebnis = Set<String>()
        for barZeichen in sonderZeichenFuerBar(){
            if (quizZeichensatz.map{$0.zeichen.devanagari ?? ""}.filter{$0.contains(barZeichen.suchString)}.count > 0) { ergebnis.insert(barZeichen.angezeigt)}
        }
        return Array(ergebnis)
    }
    
    //MARK: Methoden zur Erzeugung von QuizZeichensätzen
    static func createQuizZeichensatz(quizSetting:QuizSetting?,zeichensatz:[Zeichen]?) -> [QuizZeichen]             { return QuizZeichenSatz.createQuizZeichensatz(quizSetting:quizSetting, zeichensatz:zeichensatz) }
    static func createQuizZeichensatzForLektion(quizSetting:QuizSetting?,zeichensatz:[Zeichen]?) -> [QuizZeichen]   { return QuizZeichenSatz.createQuizZeichensatzForLektion(quizSetting:quizSetting, zeichensatz:zeichensatz) }
}

//MARK: QuizZeichenSatz
// Methoden zur Erzeugung von QuizZeichensätzen
private class QuizZeichenSatz{
    //MARK: Standardmethoden zur Erzeugung von QuizZeichensätzen
    // Quizzeichensatz für freies Üben
    // Basis für StandardLektionen
    static func createQuizZeichensatz(quizSetting:QuizSetting?,zeichensatz:[Zeichen]?) -> [QuizZeichen]{
        guard let quizSetting = quizSetting, let zeichensatz = zeichensatz else {return [QuizZeichen]()}
        
        // Je nachdem, ob das Zeichenfeld in der Lektion angezeigt, nachgezeichnet oder abgefragt wird,
        // wird ein Quizzeichensatz erstellt
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
    //QuizZeichenSatz für Lektionen
    static func createQuizZeichensatzForLektion(quizSetting:QuizSetting?,zeichensatz:[Zeichen]?) -> [QuizZeichen]{
        //SonderLektion Nasal des Anusvara / AnusvaraVisargaVirama
        guard quizSetting?.nasalDesAnusvaraPruefe == false else         { return createQuizZeichensatzForNasalDesAnusvaraLektion(quizSetting:quizSetting) }
        guard quizSetting?.anusvaraVisargaViramaPruefe == false else    { return createQuizZeichensatzForAnusvaraVisargaViramaLektion(quizSetting:quizSetting) }
        
        let quizZeichenSatz = createQuizZeichensatz(quizSetting:quizSetting,zeichensatz:zeichensatz)
        for quizZeichen in quizZeichenSatz{
            //setzt QuizZeichen status auf Correct, wenn in ScoreZeichen letztesMalKorrektInLektion == aktuelleLektion
            let scoreZeichen    = MainSettings.get()?.angemeldeterUser?.getScoreZeichen(for: quizZeichen.zeichen.devanagari)
            let aktuelleLektion = MainSettings.get()?.angemeldeterUser?.aktuelleLektion
            if scoreZeichen?.getLetztesMalKorrektInLektion(quizZeichen: quizZeichen) == aktuelleLektion{ quizZeichen.status.value = .Correct }
        }
        return filterQuizZeichensatzForLektion(quizZeichenSatz: quizZeichenSatz,quizSetting: quizSetting)
    }
    
    //MARK: Filter für Lektionen QuizZeichenSatz
    //1 nur unbekannte Zeichen nachzeichnen
    //2 Zeichen mit neuer Abfrage nicht filtern
    //3 spezielle Filter
    static private func filterQuizZeichensatzForLektion(quizZeichenSatz:[QuizZeichen],quizSetting:QuizSetting?) -> [QuizZeichen]{
        let anzahlQZMax = 50
        var quizZeichenSatz = quizZeichenSatz
        
        //1 nur unbekannte Zeichen nachzeichnen
        func filterNochNichtNachgezeichnet(quizZeichen:QuizZeichen) -> Bool{
            if quizZeichen.quizSetting.zeichenfeld == .Nachzeichnen{
                return MainSettings.get()?.angemeldeterUser?.getScoreZeichen(for: quizZeichen.zeichen.devanagari)?.letztesMalKorrektLektionZFNachzeichnen == -1
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
            let scoreZeichen = user.getScoreZeichen(for: quizZeichen.zeichen.devanagari)
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
                return scoreZeichen.wurdeBereitsKomplettAbgefragt(fuer: quizZeichen.quizSetting, lektion:user.aktuelleLektion) == true
            }
            let mitNeuenAbfragen                = quizZeichenSatz.filter{!wurdeBereitsKomplettAbgefragt(quizZeichen: $0)}
            let bereitsKomplettAbgefragt        = quizZeichenSatz.filter{wurdeBereitsKomplettAbgefragt(quizZeichen: $0)}
            let sortedBereitsKomplettAbgefragt  = bereitsKomplettAbgefragt.sorted{$0.scoreZeichen.anzahlRichtigeMinusFalscheAbfragen(quizSetting:$0.quizSetting)
                < $1.scoreZeichen.anzahlRichtigeMinusFalscheAbfragen(quizSetting:$1.quizSetting)}
            let anzahlausBereitsKomlett         = anzahlQZMax - mitNeuenAbfragen.count > 0 ? anzahlQZMax - mitNeuenAbfragen.count : 0
            
            return mitNeuenAbfragen + sortedBereitsKomplettAbgefragt.prefix(anzahlausBereitsKomlett)
        }
        quizZeichenSatz = filterForStufeKleiner3(quizZeichenSatz: quizZeichenSatz)
        
        return quizZeichenSatz
    }
    
    
    //MARK: QuizZeichensätze für Sonderlektionen
    static let anusvara     = (Singleton.sharedInstance.zeichenSatz.filter{$0.devanagari == "ं"}.first)
    static let visarga      = (Singleton.sharedInstance.zeichenSatz.filter{$0.devanagari == "ः"}.first)
    static let virama       = (Singleton.sharedInstance.zeichenSatz.filter{$0.devanagari == "्"}.first)

    // AnusvaraVisargaVirama Lektion
    static private func createQuizZeichensatzForAnusvaraVisargaViramaLektion(quizSetting:QuizSetting?) -> [QuizZeichen]{
        let anzahlProSonderzeichen  = 8
        guard let anusvara  = anusvara, let visarga = visarga, let virama = virama, let quizSetting = quizSetting else {return [QuizZeichen]()}
        
        //Datenbasis - Zeichen, die als Praefixe in Frage kommen
        let anusvaraViramaLektionNummer     = Singleton.sharedInstance.lektionen.filter{$0.quizSetting?.anusvaraVisargaViramaPruefe == true}.first?.nummer ?? 0
        var moeglichePraefixe               = Array(Set(Singleton.sharedInstance.zeichenSatz.filter{$0.lektion ?? 1000 <= anusvaraViramaLektionNummer}).symmetricDifference(grundZeichen()))
        var moeglichePraefixeVirama         = grundZeichen().filter{$0.vokalOderKonsonant == VokalOderKonsonant.Konsonant.rawValue}
        
        // für jedes Sonderzeichen werden "anzahlProSonderzeichen" Quizzeichen erzeugt
        var ergebnis        = [QuizZeichen]()
        var sonderZeichen   = [anusvara,visarga,virama]
        for iSonderZeichen in sonderZeichen{
            for _ in 0 ..< anzahlProSonderzeichen{
                // Praefix per Zufall finden
                let praefix:Zeichen = {
                    var praefixe:[Zeichen] =    { return iSonderZeichen == virama ? moeglichePraefixeVirama : moeglichePraefixe }()
                    var randomIndexPraefix:Int  { return Int(arc4random_uniform(UInt32(praefixe.count))) }
                    return praefixe.remove(at: randomIndexPraefix)
                }()
                
                //Devanagari und Umschrift erzeugen
                let devanagari  = (praefix.devanagari ?? "") + (iSonderZeichen.devanagari ?? "")
                var umschrift:String{
                    if iSonderZeichen == virama         { return (praefix.umschrift ?? "").newRemoveLast() }
                    var suffix:String{
                        if iSonderZeichen.isAnusvara    { return "ṃ"}
                        if iSonderZeichen.isVisarga     { return "ḥ"}
                        return ""
                    }
                    return (praefix.umschrift ?? "") + suffix
                }
                
                //QuizZeichen erzeugen und dem ErgebnisArray hinzufügen
                let quizZeichen                             = QuizZeichen(zeichen: praefix, quizSetting: quizSetting)
                quizZeichen.anusvaraVisargaViramaZeichen    = AnusvaraVisargaViramaZeichen(devanagari: devanagari, umschrift: umschrift, zeichenFuerScore: iSonderZeichen)
                ergebnis.append(quizZeichen)
            }
        }
        return ergebnis
    }
    
    //NasalDesAnusvara Lektion
    static private func createQuizZeichensatzForNasalDesAnusvaraLektion(quizSetting:QuizSetting?) -> [QuizZeichen]{
        var anzahlProArtikulationsOrt   = 5
        guard let anusvara  = anusvara, let quizSetting = quizSetting else {return [QuizZeichen]()}
        
        //Datenbasis - Zeichen, die als Prae- und Suffixe in Frage kommen
        var moeglichePraefixe           = Singleton.sharedInstance.zeichenSatz.filter{$0.vokalOderKonsonant == VokalOderKonsonant.Konsonant.rawValue}
        var moeglicheSuffixe            = moeglichePraefixe.filter{ $0.konsonantTyp == KonsonantTyp.EinfacherKonsonant.rawValue }
        
        //Für jeden Artikulationsort werden "anzahlProArtikulationsOrt" QuizZeichen erzeugt
        var artikulationen              = [Artikulation.dental,Artikulation.labial,Artikulation.palatal,Artikulation.retroflex,Artikulation.velar]
        var ergebnis                    = [QuizZeichen]()
        for artikulation in artikulationen{
            var moeglicheSuffixeFuerArtikulation = moeglicheSuffixe.filter{$0.artikulation == artikulation.rawValue}
            for i in 0 ..< anzahlProArtikulationsOrt{
                //Praefixe und Suffixe per Zufall finden
                let praefix:Zeichen = {
                    var randomIndexPraefix:Int{ return Int(arc4random_uniform(UInt32(moeglichePraefixe.count))) }
                    return moeglichePraefixe.remove(at: randomIndexPraefix)
                }()
                let suffix:Zeichen = {
                    var randomIndexSuffix:Int{ return Int(arc4random_uniform(UInt32(moeglicheSuffixeFuerArtikulation.count))) }
                    return moeglicheSuffixeFuerArtikulation.remove(at: randomIndexSuffix)
                }()
                
                //Devanagari und Umschrift erzeugen
                let devanagari  = (praefix.devanagari ?? "")    + (anusvara.devanagari ?? "")           + (suffix.devanagari ?? "")
                let umschrift   = (praefix.umschrift ?? "")     + (artikulation.nasalUmschrift ?? "")   + (suffix.umschrift ?? "")
                
                //QuizZeichen erzeugen und dem ErgebnisArray hinzufügen
                let quizZeichen                     = QuizZeichen(zeichen: anusvara, quizSetting: quizSetting)
                quizZeichen.nasalDesAnusvaraZeichen = NasalDesAnusvaraZeichen(devanagari: devanagari, umschrift: umschrift, artikulation: artikulation)
                ergebnis.append(quizZeichen)
            }
        }
        return ergebnis
    }
}
