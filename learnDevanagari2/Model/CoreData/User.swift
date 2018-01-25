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
    //MARK: essential
    class func neu() -> User?{
        //erstellt neuen User
        let user = NSEntityDescription.insertNewObject(forEntityName: "User", into: managedContext) as? User
        //erstellt ScoreZeichenSatz und "hängt" diesen an das UserObjekt
        user?.addToScoreZeichen(NSSet.init(set: ScoreZeichen.createScoreZeichenSatz()))
        //setzt LektionsQuizSetting auf Stufe1 (Nachzeichnen+Textfeld)
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
    
    
    //Mark:Lektion
    //user hat var aktuelleLektion:Int
    var currentLektion:Lektion                  { return Singleton.sharedInstance.lektionen[Int(aktuelleLektion)] }
    var alleLektionenBisher:[Lektion]           { return Singleton.sharedInstance.lektionen.filter{$0.nummer  ?? 1000  <= aktuelleLektion } }
    func nextLektion()->Lektion{
        // setzt aktuelleLektion auf nächste Lektion
        // falls aktuelleLektion == letzteLektion -> aktuelleLektion auf 0 setzen (Neustart)
        aktuelleLektion = Singleton.sharedInstance.lektionen.count < aktuelleLektion + 1 ?  aktuelleLektion + 1  : 0
        try? managedContext.save()
        return currentLektion
    }
    // bereitsBekannteLektion entspricht der letzten Lektionsnummer, die der User bereits kennengelernt hat (ab 2. Durchlauf -> letzteLektion)
    func updateBereitsbekannteLektion()         { bereitsBekannteLektion  = aktuelleLektion > bereitsBekannteLektion ? aktuelleLektion : bereitsBekannteLektion }
    
    
    //MARK: ScoreZeichen
    //alleScorezeichen am UserObjekt als Array (von NSSet)
    var allScoreZeichen:[ScoreZeichen]                                  { return (Array(scoreZeichen ?? NSSet()) as? [ScoreZeichen] ?? [ScoreZeichen]()).filter{$0.devaString != nil} }
    //liefert Scorezeichen für Zeichen (bzw. Devanagari String)
    func getScoreZeichen(for devaString:String?) -> ScoreZeichen?       { return allScoreZeichen.filter{$0.devaString == devaString}.first }
    //für MantraView (Zeichen, welche grün werden oder bereits sichtbar sind)
    private var allScoreZeichenGreaterZero:[Zeichen]                    { return allScoreZeichen.filter{$0.gesamtScore > 0}.map{$0.zeichen!} }
    func allScoreZeichenGreaterZero(fuerLektion lektion:Int)->[Zeichen] { return allScoreZeichenGreaterZero.filter{$0.lektion == lektion} }
    func allScoreZeichenGreaterZero(bisLektion lektion:Int)->[Zeichen]  { return allScoreZeichenGreaterZero.filter{$0.lektion ?? 1000 <= lektion} }
    //für Ligaturen Übersicht
    var ligaturenScoreZeichen:[ScoreZeichen]                            { return Singleton.sharedInstance.zeichenSatz.filter{$0.isLigatur}.map{self.getScoreZeichen(for: $0.devanagari)}.filter{$0 != nil} as! [ScoreZeichen] }
    //Scorezeichen update
    //erstellt Abfragen für UserEingabe und hängt diese an das ScoreZeichen
    func updateScoreZeichen(for userAntwortZeichen:UserAntwortZeichen,quizZeichen:QuizZeichen?){
        guard let quizZeichen = quizZeichen, let scoreZeichen = getScoreZeichen(for: quizZeichen.zeichen.devanagari) else {return}
        
        if let nasalDesAnusvaraZeichen = quizZeichen.nasalDesAnusvaraZeichen{
            //SonderLektionen NasalDesAnusvara
            let userAntworten   = userAntwortZeichen.userAntworten(for: quizZeichen)
            let correct         = userAntworten.count == (userAntworten.filter{$0.correct}).count
            _ = scoreZeichen.newAbfrageForNasalDesAnusvara(artikulation: nasalDesAnusvaraZeichen.artikulation, correct: correct)
        }
        else{
            //SonderLektionen AnusvaraVisargaVirama
            let anusVisVirScoreZeichen  = getScoreZeichen(for:quizZeichen.anusvaraVisargaViramaZeichen?.zeichenFuerScore.devanagari)
            anusVisVirScoreZeichen?.setScoreForAnusvaraVisargaVirama(userAntwortZeichen: userAntwortZeichen, quizZeichen: quizZeichen)
            
            //standardLektionen und AnusvaraVisargaVirama -> erzeugt für jede userAntwort eine Abfrage
            for userAntwort in userAntwortZeichen.userAntworten(for: quizZeichen){
                _ = scoreZeichen.newAbfrage(userAntwort: userAntwort)
            }
        }
        
        //update GesamtScore,haeufigkeitFalsch,haeufigkeitGeuebt
        scoreZeichen.setGesamtScore()
        scoreZeichen.setFalschBeantwortetCount()
        scoreZeichen.setGeuebtCount()
        
        //letzte korrekteAntwortInLektion speichern für ScoreZeichen
        scoreZeichen.setLetztesMalKorrekt(userAntwortZeichen: userAntwortZeichen, quizZeichen: quizZeichen)
        try? managedContext.save()
    }
    
    //Mark: bekannteControls
    // speichert, welche Controls der User bereits kennengelernt hat
    // nur bekannte Controls können für freies Üben gewählt werden
    var bekannteControls:Set<ControlTyp>        { return Set((bereitsBekannteControls as? Set<String>)?.map{ControlTyp.getBy(name: $0)} ?? [ControlTyp]() )}
    func updateBereitsBekannteControls(quizSetting:QuizSetting?){
        guard let quizSetting   = quizSetting else {return}
        let aktuelleAbfragen    = Set(quizSetting.abfragen.map{$0.controlName!})
        let bereitsBekannte     = (bereitsBekannteControls as? Set<String>) ??  Set<String>()
        bereitsBekannteControls = bereitsBekannte.union(aktuelleAbfragen) as NSObject
    }
    
    //MARK: MainQuizSetting
    // das aktuelle QuizSetting (Abfragensetting) (lektionsQuizSetting Dict -> QuizSetting)
    var currentMainQuizSetting:QuizSetting?     { return QuizSetting(dict: lektionsQuizSettings as? Dictionary) }
    
    
}


//in MainSetting wird der aktuell angemeldete User gespeichert
extension MainSettings{
    class func get() -> MainSettings?{
        let request = NSFetchRequest<MainSettings>.init(entityName: "MainSettings")
        if let settings = (try? managedContext.fetch(request))?.first   { return settings }
        return NSEntityDescription.insertNewObject(forEntityName: "MainSettings", into: managedContext) as? MainSettings
    }
}
