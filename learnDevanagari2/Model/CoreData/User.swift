//
//  User.swift
//  learnDevanagari2
//
//  Created by Matthias Pochmann on 08.12.17.
//  Copyright © 2017 Matthias Pochmann. All rights reserved.
//

import Foundation
import CoreData

extension User{
    class func neu() -> User?{
        let user = NSEntityDescription.insertNewObject(forEntityName: "User", into: managedContext) as? User
        for zeichen in erstelleZeichensatz(){
            if let scoreZeichen = ScoreZeichen.create(devaString: zeichen.devanagari){
                user?.addToScoreZeichen(scoreZeichen)
            }
        }
        user?.lektionsQuizSettings = QuizSetting.stufeEinsSetting.asDict as NSObject
        return user
    }
    static func getAll() -> [User]{
        let request = NSFetchRequest<User>.init(entityName: "User")
        return (try? managedContext.fetch(request)) ?? [User]()
    }
    func delete(){
        managedObjectContext?.delete(self)
        try? managedContext.save()
    }
    
    func getButtonData(title:String?)           -> ButtonData   { return (title ?? "" ,getScoreZeichen(for: title)?.grundZeichenScore ?? 0) }
    func getButtonData(for titles:[String?])    -> [ButtonData] { return titles.map{getButtonData(title: $0)} }
    
    var currentMainQuizSetting:QuizSetting?{ return QuizSetting(dict: lektionsQuizSettings as? Dictionary) }
    
    //Mark:Lektion
    var currentLektion:Lektion{ return erstelleLektionen()[Int(aktuelleLektion)] }
    func nextLektion()->Lektion{
        aktuelleLektion = erstelleLektionen().count < aktuelleLektion + 1 ?  aktuelleLektion + 1  : 0
        try? managedContext.save()
        return currentLektion
    }
    var alleLektionenBisher:[Lektion]           { return erstelleLektionen().filter{$0.nummer  ?? 1000  <= aktuelleLektion } }
    var bekannteControls:Set<ControlTyp>        { return Set((bereitsBekannteControls as? Set<String>)?.map{ControlTyp.getBy(name: $0)} ?? [ControlTyp]() )}
    func updateBereitsBekannteControls(quizSetting:QuizSetting?){
        guard let quizSetting = quizSetting else {return}
        let aktuelleAbfragen    = Set(quizSetting.abfragen.map{$0.controlName!})
        let bereitsBekannte     = (bereitsBekannteControls as? Set<String>) ??  Set<String>()
        bereitsBekannteControls = bereitsBekannte.union(aktuelleAbfragen) as NSObject
    }
    func updateBereitsbekannteLektion(){
        bereitsBekannteLektion  = aktuelleLektion > bereitsBekannteLektion ? aktuelleLektion : bereitsBekannteLektion
    }
    
    //MARK: ScoreZeichen
    var ligaturenScoreZeichen:[ScoreZeichen]{
        return erstelleZeichensatz().filter{$0.isLigatur}.map{self.getScoreZeichen(for: $0.devanagari)}.filter{$0 != nil} as! [ScoreZeichen]
    }
    func getScoreZeichen(for devaString:String?) -> ScoreZeichen?{
        return allScoreZeichen.filter{$0.devaString == devaString}.first
    }
    func scoreZeichen(for devaString:String?) -> ScoreZeichen?{
        guard let devaString = devaString else {return nil}
        return allScoreZeichen.filter{$0.devaString == devaString}.first
    }
    var allScoreZeichen:[ScoreZeichen]{
        return Array(scoreZeichen ?? NSSet()) as? [ScoreZeichen] ?? [ScoreZeichen]()
    }
    private var allScoreZeichenGreaterZero:[Zeichen]{
        return allScoreZeichen.filter{$0.gesamtScore > 0}.map{Zeichen.get(forDeva:$0.devaString)!}
    }
    func allScoreZeichenGreaterZero(fuerLektion lektion:Int) -> [Zeichen]{
        return allScoreZeichenGreaterZero.filter{$0.lektion == lektion}
    }
    func allScoreZeichenGreaterZero(bisLektion lektion:Int) -> [Zeichen]{
        return allScoreZeichenGreaterZero.filter{$0.lektion ?? 1000 <= lektion}
    }
    func updateScoreZeichen(for userAntwortZeichen:UserAntwortZeichen,quizZeichen:QuizZeichen?){
        guard let quizZeichen = quizZeichen else {return}
        let scoreZeichen = getScoreZeichen(for: quizZeichen.zeichen.devanagari)
        
        if let nasalDesAnusvaraZeichen = quizZeichen.nasalDesAnusvaraZeichen{
            let userAntworten   = userAntwortZeichen.userAntworten(for: quizZeichen)
            let correct         = userAntworten.count == (userAntworten.filter{$0.correct}).count
            _ = scoreZeichen?.newAbfrageForNasalDesAnusvara(artikulation: nasalDesAnusvaraZeichen.artikulation, correct: correct)
        }
        else{
            if let anusvaraVisargaViramaZeichen = quizZeichen.anusvaraVisargaViramaZeichen{
                let userAntworten   = userAntwortZeichen.userAntworten(for: quizZeichen)
                let correct         = userAntworten.count == (userAntworten.filter{$0.correct}).count
                let anusVisVirScoreZeichen  = getScoreZeichen(for:anusvaraVisargaViramaZeichen.zeichenFuerScore.devanagari)
                _ = anusVisVirScoreZeichen?.newAbfrageFuerAnusvaraVisargaVirama(correct:correct)
                anusVisVirScoreZeichen?.gesamtScore = anusVisVirScoreZeichen?.calcGesamtScore ?? 0
            }
            for userAntwort in userAntwortZeichen.userAntworten(for: quizZeichen){
                _ = scoreZeichen?.newAbfrage(userAntwort: userAntwort)
            }
        }
        //update GesamtScore
        scoreZeichen?.gesamtScore = scoreZeichen?.calcGesamtScore ?? 0
        
        //letzte Korrekte Antwort in Lektion speichern
        if userAntwortZeichen.isCorrect(for: quizZeichen){
            let lektion = MainSettings.get()?.angemeldeterUser?.aktuelleLektion ?? -1
            switch quizZeichen.quizSetting.zeichenfeld{
            case .NurAnzeige:               scoreZeichen?.letztesMalKorrektLektionZFAnzeige         = lektion
            case .Nachzeichnen:             scoreZeichen?.letztesMalKorrektLektionZFNachzeichnen    = lektion
            case .InAbfrage:                scoreZeichen?.letztesMalKorrektLektionZFAbfrage         = lektion
            case .AbfrageUndNachzeichnen:   break
            }
        }
        try? managedContext.save()
    }
}



extension MainSettings{
    class func get() -> MainSettings?{
        let request = NSFetchRequest<MainSettings>.init(entityName: "MainSettings")
        if let settings = (try? managedContext.fetch(request))?.first   { return settings }
        return NSEntityDescription.insertNewObject(forEntityName: "MainSettings", into: managedContext) as? MainSettings
    }
}
