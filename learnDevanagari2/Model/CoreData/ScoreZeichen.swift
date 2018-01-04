//
//  ScoreZeichen.swift
//  learnDevanagari2
//
//  Created by Matthias Pochmann on 30.11.17.
//  Copyright © 2017 Matthias Pochmann. All rights reserved.
//

import Foundation
import CoreData
import ReactiveSwift
import Result

extension ScoreZeichen{
    static func getAll() -> [ScoreZeichen]{
        let request = NSFetchRequest<ScoreZeichen>.init(entityName: "ScoreZeichen")
        return (try? managedContext.fetch(request)) ?? [ScoreZeichen]()
    }
    static func create(devaString:String?) -> ScoreZeichen?{
        guard let devaString = devaString else {return nil}
        
        let scoreZeichen            = NSEntityDescription.insertNewObject(forEntityName: "ScoreZeichen", into: managedContext) as? ScoreZeichen
        scoreZeichen?.devaString    = devaString
        return scoreZeichen
    }
    
    
    var zeichen:Zeichen?{
        return erstelleZeichensatz().filter{$0.devanagari == self.devaString}.first
    }
    

    
    //helper
    var alleAbfragen:[Abfrage]{
        return [convert(abfrageSet: artikulation) , convert(abfrageSet: aspiration) , convert(abfrageSet: konsonantTyp) , convert(abfrageSet: stimmhaftigkeit) , convert(abfrageSet: umschrift) , convert(abfrageSet: vokalOderHalbVokal) , convert(abfrageSet: vokalOderKonsonant) , convert(abfrageSet: devanagari)].flatMap{$0}
    }
    var haeufigkeitFalsch:Int       {
        print("\(devaString) anzahlFalsch:  \(alleAbfragen.filter{!$0.correct}.count)")
        return alleAbfragen.filter{!$0.correct}.count }
    var haeufigKeitGeuebt:Int       { return alleAbfragen.count }
    var gesamtScore:Double          { return ScoreZeichen.calcGesamtScore(scorezeichen: self) }
    static func calcGesamtScore(scorezeichen:ScoreZeichen?) -> Double{
        guard let scorezeichen = scorezeichen, let anzahlMoeglich = Zeichen.get(forDeva: scorezeichen.devaString)?.anzahlMoeglicheAbfragen, anzahlMoeglich > 0 else {return 0}
        return Double(scorezeichen.richtigeLetzteAbfragen.count) / Double(anzahlMoeglich)
    }
    private var richtigeLetzteAbfragen:[(controlTyp:ControlTyp,abfrage:Abfrage)]{ return letzteAbfragen.filter{$0.abfrage.correct} }
    private var letzteAbfragen:[(controlTyp:ControlTyp,abfrage:Abfrage)]{
        return ControlTyp.alleTypen.map{ (controlTyp:$0,abfrage:getAbfragen(for: $0).sorted{$1.date!.isGreaterThanDate(dateToCompare: $0.date!)}.last)}.filter{$0.abfrage != nil} as! [(controlTyp:ControlTyp,abfrage:Abfrage)]
    }
    private func getAbfragen(for controlTyp:ControlTyp)->[Abfrage]{
        switch controlTyp {
        case .ArtikulationTyp:          return convert(abfrageSet: artikulation)
        case .AspirationTyp:            return convert(abfrageSet: aspiration)
        case .KonsonantTyp:             return convert(abfrageSet: konsonantTyp)
        case .StimmhaftigkeitTyp:       return convert(abfrageSet: stimmhaftigkeit)
        case .TextfeldTyp:              return convert(abfrageSet: umschrift)
        case .VokalOderHalbvokalTyp:    return convert(abfrageSet: vokalOderHalbVokal)
        case .VokalOderKonsonantTyp:    return convert(abfrageSet: vokalOderKonsonant)
        case .ZeichenfeldTyp:           return convert(abfrageSet: devanagari)
        }
    }
    func newAbfrage(userAntwort : (controlTyp:ControlTyp,correct:Bool)) -> Abfrage?{
        guard let abfrage = Abfrage.new( correct: userAntwort.correct) else {return nil}
        switch userAntwort.controlTyp {
        case .ArtikulationTyp: addToArtikulation(abfrage)
        case .AspirationTyp:addToAspiration(abfrage)
        case .KonsonantTyp:addToKonsonantTyp(abfrage)
        case .StimmhaftigkeitTyp:addToStimmhaftigkeit(abfrage)
        case .TextfeldTyp:addToUmschrift(abfrage)
        case .VokalOderHalbvokalTyp: addToVokalOderHalbVokal(abfrage)
        case .VokalOderKonsonantTyp: addToVokalOderKonsonant(abfrage)
        case .ZeichenfeldTyp: addToDevanagari(abfrage)
        }
        abfrage.lektion = user?.aktuelleLektion ?? -1
        return abfrage
    }
    private func convert(abfrageSet:NSSet?) -> [Abfrage]{
        guard let abfrageSet = abfrageSet else {return [Abfrage]()}
        return Array(abfrageSet) as! [Abfrage]
    }
    
    func setLetztesMalKorrektLektion(quizZeichen:QuizZeichen?){
        guard let quizZeichen = quizZeichen, let aktuelleLektion = MainSettings.get()?.angemeldeterUser?.aktuelleLektion else {return}
        switch quizZeichen.quizSetting.zeichenfeld {
        case .NurAnzeige: letztesMalKorrektLektionZFAnzeige = aktuelleLektion
        case .Nachzeichnen: letztesMalKorrektLektionZFNachzeichnen = aktuelleLektion
        case .InAbfrage: letztesMalKorrektLektionZFAbfrage = aktuelleLektion
        case .AbfrageUndNachzeichnen: break
        }
    }
    func getLetztesMalKorrektInLektion(quizZeichen:QuizZeichen?) -> Int16?{
        guard let quizZeichen = quizZeichen else {return nil}
        return getLetztesMalKorrektInLektion(quizSetting: quizZeichen.quizSetting)
    }
    func getLetztesMalKorrektInLektion(quizSetting:QuizSetting) -> Int16?{
        guard let aktuelleLektion = MainSettings.get()?.angemeldeterUser?.aktuelleLektion else {return nil}
        
        switch quizSetting.zeichenfeld{
        case .NurAnzeige:       return  letztesMalKorrektLektionZFAnzeige == aktuelleLektion ? aktuelleLektion :  nil
        case .Nachzeichnen:     return  letztesMalKorrektLektionZFNachzeichnen == aktuelleLektion ? aktuelleLektion :  nil
        case .InAbfrage:        return  letztesMalKorrektLektionZFAbfrage == aktuelleLektion ? aktuelleLektion :  nil
        case .AbfrageUndNachzeichnen: return nil
        }
    }
    
    func wurdeBereitsKomplettAbgefragt(fuer quizSetting:QuizSetting,lektion:Int16?) -> Bool{
        if quizSetting.zeichenfeld == .InAbfrage{
            return letztesMalKorrektLektionZFAbfrage != -1
        }
        if quizSetting.zeichenfeld == .NurAnzeige{
            let allesAbgefragt = quizSetting.abfragen.filter{!richtigeLetzteAbfragen.map{$0.controlTyp}.contains($0)}.count == 0
            let inAktuellerLektionCorrect = getLetztesMalKorrektInLektion(quizSetting:quizSetting) == lektion
            return allesAbgefragt && !inAktuellerLektionCorrect
        }
        return true
    }
    func anzahlRichtigeMinusFalscheAbfragen(quizSetting:QuizSetting) -> Int{
        //richtige - falsche
        let relevanteLetzteAbfragen = letzteAbfragen.filter{quizSetting.abfragen.contains($0.controlTyp)}
        let korrekte    = relevanteLetzteAbfragen.filter{$0.abfrage.correct}.count
        let falsche     = relevanteLetzteAbfragen.filter{!$0.abfrage.correct}.count
        return korrekte - falsche
    }
    //eventuell nicht mehr gebraucht
    func gesamtScoreIsMax(for quizSetting:QuizSetting) -> Bool{
        return gesamtScore == maxGesamtScore(for: quizSetting)
    }
    private func maxGesamtScore(for quizSetting:QuizSetting) -> Double{
        guard let anzahlMoeglich = Zeichen.get(forDeva: devaString)?.anzahlMoeglicheAbfragen, anzahlMoeglich > 0 else {return 1}
        return Double(quizSetting.abfragen.count) / Double(anzahlMoeglich)
    }
    
    
}

extension Date{
    func isGreaterThanDate(dateToCompare:Date) -> Bool { return self.compare(dateToCompare) == .orderedDescending }
}
