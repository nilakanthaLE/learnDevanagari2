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
    static func getOrCreate(devaString:String?) -> ScoreZeichen?{
        guard let devaString = devaString else {return nil}
        let request = NSFetchRequest<ScoreZeichen>.init(entityName: "ScoreZeichen")
        request.predicate = NSPredicate(format: "devaString == %@",devaString)
        if let scoreZeichen = (try? managedContext.fetch(request))?.first   { return scoreZeichen }
        let scoreZeichen            = NSEntityDescription.insertNewObject(forEntityName: "ScoreZeichen", into: managedContext) as? ScoreZeichen
        scoreZeichen?.devaString    = devaString
        return scoreZeichen
    }
    static func update(for userAntwortZeichen:UserAntwortZeichen,quizZeichen:QuizZeichen?){
        guard let quizZeichen = quizZeichen else {return}
        let scoreZeichen = getOrCreate(devaString: quizZeichen.zeichen.devanagari)
        for userAntwort in userAntwortZeichen.userAntworten(for: quizZeichen){
            _ = scoreZeichen?.newAbfrage(userAntwort: userAntwort)
        }
        try? managedContext.save()
    }
    

    static func getAllScoreGreaterZero() -> [Zeichen]{
        return getAll().filter{$0.gesamtScore > 0}.map{Zeichen.get(forDeva:$0.devaString)!}
    }
    static func getAllScoreGreaterZero(fuerLektion lektion:Int) -> [Zeichen]{
        return getAllScoreGreaterZero().filter{$0.lektion == lektion}
    }
    static func getAllScoreGreaterZero(bisLektion lektion:Int) -> [Zeichen]{
        return getAllScoreGreaterZero().filter{$0.lektion ?? 1000 <= lektion}
    }
    
    var scoreProducer:SignalProducer<Double, NoError>{
        let producers = SignalProducer.merge([
            reactive.producer(forKeyPath: "artikulation").filter{$0 != nil}.map{_ in Void()},
            reactive.producer(forKeyPath: "aspiration").filter{$0 != nil}.map{_ in Void()},
            reactive.producer(forKeyPath: "konsonantTyp").filter{$0 != nil}.map{_ in Void()},
            reactive.producer(forKeyPath: "stimmhaftigkeit").filter{$0 != nil}.map{_ in Void()},
            reactive.producer(forKeyPath: "umschrift").filter{$0 != nil}.map{_ in Void()},
            reactive.producer(forKeyPath: "vokalOderHalbVokal").filter{$0 != nil}.map{_ in Void()},
            reactive.producer(forKeyPath: "vokalOderKonsonant").filter{$0 != nil}.map{_ in Void()},
            reactive.producer(forKeyPath: "devanagari").filter{$0 != nil}.map{_ in Void()}
            ]).map{[weak self] _ in ScoreZeichen.calcGesamtScore(scorezeichen: self)}
        return producers
    }
    
    //helper
    var gesamtScore:Double{
        return ScoreZeichen.calcGesamtScore(scorezeichen: self)
    }
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
    private func newAbfrage(userAntwort : (controlTyp:ControlTyp,correct:Bool)) -> Abfrage?{
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
        return abfrage
    }
    private func convert(abfrageSet:NSSet?) -> [Abfrage]{
        guard let abfrageSet = abfrageSet else {return [Abfrage]()}
        return Array(abfrageSet) as! [Abfrage]
    }
}

extension Date{
    func isGreaterThanDate(dateToCompare:Date) -> Bool { return self.compare(dateToCompare) == .orderedDescending }
}
