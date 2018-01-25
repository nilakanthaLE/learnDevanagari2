//
//  ScoreZeichen.swift
//  learnDevanagari2
//
//  Created by Matthias Pochmann on 30.11.17.
//  Copyright © 2017 Matthias Pochmann. All rights reserved.
//

import Foundation
import CoreData

extension ScoreZeichen{
    //MARK: Essentials
    static private func create(devaString:String?) -> ScoreZeichen?{
        guard let devaString = devaString else {return nil}
        let scoreZeichen            = NSEntityDescription.insertNewObject(forEntityName: "ScoreZeichen", into: managedContext) as? ScoreZeichen
        scoreZeichen?.devaString    = devaString
        return scoreZeichen
    }
    //erzeugt einen neuen ScoreZeichenSatz für den GesamtZeichensatz
    static func createScoreZeichenSatz() -> Set<ScoreZeichen>{ return Set(Singleton.sharedInstance.zeichenSatz.map{create(devaString: $0.devanagari)}.filter{$0 != nil} as! [ScoreZeichen]) }
    //das zum Scorezeichen gehörende Zeichen
    var zeichen:Zeichen?{ return Singleton.sharedInstance.zeichenSatz.filter{$0.devanagari == self.devaString}.first }
    
    
    //MARK: Zeichenauswahl
    //Parameter für die Auswahl der Zeichen im freien Üben (häufigFalsch oder seltenGeübt)
    private var alleAbfragen:[Abfrage]{
        return [convert(abfrageSet: artikulation) , convert(abfrageSet: aspiration) , convert(abfrageSet: konsonantTyp) , convert(abfrageSet: stimmhaftigkeit) , convert(abfrageSet: umschrift) , convert(abfrageSet: vokalOderHalbVokal) , convert(abfrageSet: vokalOderKonsonant) , convert(abfrageSet: devanagari)].flatMap{$0}
    }
    private var haeufigkeitFalsch:Int   { return alleAbfragen.filter{!$0.correct}.count }
    private var haeufigKeitGeuebt:Int   { return alleAbfragen.count }
    func setGeuebtCount()               { geuebtCount = Int16(haeufigkeitFalsch) }
    func setFalschBeantwortetCount()    { falschBeantwortetCount = Int16(haeufigkeitFalsch) }
    
    
    //MARK: Score berechnen und setzen
    //gesamtScore
    func setGesamtScore()               { gesamtScore = calcGesamtScore }
    private var calcGesamtScore:Double  { return ScoreZeichen.calcGesamtScore(scorezeichen: self) }
    static private func calcGesamtScore(scorezeichen:ScoreZeichen?) -> Double{
        guard let scorezeichen = scorezeichen, let anzahlMoeglich = scorezeichen.zeichen?.anzahlMoeglicheAbfragen, anzahlMoeglich > 0 else {return 0}
        var anzahlRichtigeAbfragen:Double{
            if scorezeichen.zeichen?.isVirama == true   { return Double(scorezeichen.richtigeLetzteNasalDesAnusvaraAbfragen.count) + (scorezeichen.wasLetzteAnusvaraVisargaAbfrageCorrect ? 1 : 0) }
            if scorezeichen.zeichen?.isVisarga == true || scorezeichen.zeichen?.isVirama == true    { return scorezeichen.wasLetzteAnusvaraVisargaAbfrageCorrect ? 1 : 0 }
            return Double(scorezeichen.richtigeLetzteAbfragen.count)
        }
        return  anzahlRichtigeAbfragen / Double(anzahlMoeglich)
    }
    //Grundzeichen (Zeichen ohne Vokalzeichenerweiterungen)
    var grundZeichen:[ScoreZeichen]{
        guard let abgeleiteteZeichen = zeichen?.vonGrundZeichenAbgeleitet, let user = MainSettings.get()?.angemeldeterUser, abgeleiteteZeichen.count > 0 else {return [ScoreZeichen]()}
        return (abgeleiteteZeichen.map{user.getScoreZeichen(for: $0.devanagari)}.filter{$0 != nil} as! [ScoreZeichen]).sorted{($0.devaString ?? "") < ($1.devaString ?? "")}
    }
    var grundZeichenScore:Double{
        let scoreSumme  = grundZeichen.map{$0.gesamtScore}.reduce(0){$0+$1}
        return scoreSumme / Double(grundZeichen.count)
    }
    
    //MARK: create Abfragen
    //neue Abfragen erstellen und ans ScoreZeichen "anhängen"
    func newAbfrage(userAntwort : (controlTyp:ControlTyp,correct:Bool)) -> Abfrage?{
        guard let abfrage = Abfrage.new( correct: userAntwort.correct) else {return nil}
        switch userAntwort.controlTyp {
        case .ArtikulationTyp:          addToArtikulation(abfrage)
        case .AspirationTyp:            addToAspiration(abfrage)
        case .KonsonantTyp:             addToKonsonantTyp(abfrage)
        case .StimmhaftigkeitTyp:       addToStimmhaftigkeit(abfrage)
        case .TextfeldTyp:              addToUmschrift(abfrage)
        case .VokalOderHalbvokalTyp:    addToVokalOderHalbVokal(abfrage)
        case .VokalOderKonsonantTyp:    addToVokalOderKonsonant(abfrage)
        case .ZeichenfeldTyp:           addToDevanagari(abfrage)
        }
        abfrage.lektion = user?.aktuelleLektion ?? -1
        return abfrage
    }
    func newAbfrageForNasalDesAnusvara(artikulation:Artikulation,correct:Bool) -> Abfrage?{
        guard let abfrage = Abfrage.new( correct: correct) else {return nil}
        switch artikulation {
        case .velar:        addToNasalDesAnusvaraVelar(abfrage)
        case .palatal:      addToNasalDesAnusvaraPalatal(abfrage)
        case .retroflex:    addToNasalDesAnusvaraRetroflex(abfrage)
        case .dental:       addToNasalDesAnusvaraDental(abfrage)
        case .labial:       addToNasalDesAnusvaraLabial(abfrage)
        }
        return abfrage
    }
    func setScoreForAnusvaraVisargaVirama(userAntwortZeichen:UserAntwortZeichen,quizZeichen:QuizZeichen?){
        func newAbfrageFuerAnusvaraVisargaVirama(correct:Bool) -> Abfrage?{
            guard let abfrage = Abfrage.new( correct: correct) else {return nil}
            addToAnusvaraVisargaVirama(abfrage)
            return abfrage
        }
        let userAntworten   = userAntwortZeichen.userAntworten(for: quizZeichen)
        let correct         = userAntworten.count == (userAntworten.filter{$0.correct}).count
        _ = newAbfrageFuerAnusvaraVisargaVirama(correct:correct)
        setGesamtScore()
    }
    
    //MARK: letztesMalKorrekt setzen
    //speichert in welcher Lektion ein Zeichen das letzte Mal vollständig korrekt beantwortet wurde
    func setLetztesMalKorrekt(userAntwortZeichen:UserAntwortZeichen,quizZeichen:QuizZeichen?)    {
        func setLetztesMalKorrektLektion(quizZeichen:QuizZeichen?){
            guard let quizZeichen = quizZeichen, let aktuelleLektion = MainSettings.get()?.angemeldeterUser?.aktuelleLektion else {return}
            switch quizZeichen.quizSetting.zeichenfeld {
            case .NurAnzeige: letztesMalKorrektLektionZFAnzeige = aktuelleLektion
            case .Nachzeichnen: letztesMalKorrektLektionZFNachzeichnen = aktuelleLektion
            case .InAbfrage: letztesMalKorrektLektionZFAbfrage = aktuelleLektion
            case .AbfrageUndNachzeichnen: break
            }
        }
        if userAntwortZeichen.isCorrect(for: quizZeichen){ setLetztesMalKorrektLektion(quizZeichen: quizZeichen) }
    }
    func getLetztesMalKorrektInLektion(quizZeichen:QuizZeichen?) -> Int16?{ return getLetztesMalKorrektInLektion(quizSetting: quizZeichen?.quizSetting) }
    func getLetztesMalKorrektInLektion(quizSetting:QuizSetting?) -> Int16?{
        guard let quizSetting = quizSetting, let aktuelleLektion = MainSettings.get()?.angemeldeterUser?.aktuelleLektion else {return nil}
        switch quizSetting.zeichenfeld{
        case .NurAnzeige:       return  letztesMalKorrektLektionZFAnzeige == aktuelleLektion ? aktuelleLektion :  nil
        case .Nachzeichnen:     return  letztesMalKorrektLektionZFNachzeichnen == aktuelleLektion ? aktuelleLektion :  nil
        case .InAbfrage:        return  letztesMalKorrektLektionZFAbfrage == aktuelleLektion ? aktuelleLektion :  nil
        case .AbfrageUndNachzeichnen: return nil
        }
    }
    
    //MARK:helper
    //convertiert NSSet zu [Abfrage]
    private func convert(abfrageSet:NSSet?) -> [Abfrage]{
        guard let abfrageSet = abfrageSet else {return [Abfrage]()}
        return Array(abfrageSet) as! [Abfrage]
    }
    
    //MARK: helper - für createQuizZeichensatz (Filter)
    func wurdeBereitsKomplettAbgefragt(fuer quizSetting:QuizSetting,lektion:Int16?) -> Bool{
        if quizSetting.zeichenfeld == .InAbfrage    { return letztesMalKorrektLektionZFAbfrage != -1 }
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
    
    //MARK: helper - Berechnung des GesamtScores
    //letzte Abfragen (zeitlich) für alle ControlTypen
    private var letzteAbfragen:[(controlTyp:ControlTyp,abfrage:Abfrage)]{
        return ControlTyp.alleTypen.map{ (controlTyp:$0,abfrage:getAbfragen(for: $0).sorted{$1.date!.isGreaterThanDate(dateToCompare: $0.date!)}.last)}.filter{$0.abfrage != nil} as! [(controlTyp:ControlTyp,abfrage:Abfrage)]
    }
    //nur letzteAbfragen, die korrekt waren
    private var richtigeLetzteAbfragen:[(controlTyp:ControlTyp,abfrage:Abfrage)]{ return letzteAbfragen.filter{$0.abfrage.correct} }
    //letzte Abfragen (zeitlich) für die 5 NasalDesAnusvaras (nach Artikulationsort)
    private var richtigeLetzteNasalDesAnusvaraAbfragen:[(artikulation:Artikulation,abfrage:Abfrage)]{
        let letzteAbfragen = Artikulation.cases().map{ (artikulation:$0,abfrage:getNasalDesAnusvaraAbfragen(for: $0).sorted{$1.date!.isGreaterThanDate(dateToCompare: $0.date!)}.last) }
        return letzteAbfragen.filter{$0.abfrage?.correct == true} as! [(artikulation: Artikulation, abfrage: Abfrage)]
    }
    //war die letzte Abfrage des Anusvara,Visarga oder Virama korrekt (self ist Scorezeichen für eins der drei)
    private var wasLetzteAnusvaraVisargaAbfrageCorrect:Bool{
        let abfragen    = convert(abfrageSet: anusvaraVisargaVirama)
        let letzte      = abfragen.sorted{$1.date!.isGreaterThanDate(dateToCompare: $0.date!)}.last
        return letzte?.correct == true
    }
    //Abfragen holen für ein Control --> von NSSet zu [Abfragen] convertieren
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
    //NasalDesAnusvaraAbfragen holen für Artikulationsort  --> von NSSet zu [Abfragen] convertieren
    private func getNasalDesAnusvaraAbfragen(for artikulation:Artikulation) -> [Abfrage]{
        switch artikulation{
        case .velar:        return convert(abfrageSet: nasalDesAnusvaraVelar)
        case .palatal:      return convert(abfrageSet: nasalDesAnusvaraPalatal)
        case .retroflex:    return convert(abfrageSet: nasalDesAnusvaraRetroflex)
        case .dental:       return convert(abfrageSet: nasalDesAnusvaraDental)
        case .labial:       return convert(abfrageSet: nasalDesAnusvaraLabial)
        }
    }
}



