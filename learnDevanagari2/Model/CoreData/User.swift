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
        user?.lektionsQuizSettings = QuizSetting().asDict as NSObject
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
    
    
    
    //MARK: ScoreZeichen
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
    
    var bereitsCorrectBeantworteteZeichenFuerAktuelleLektion:[Zeichen]{
        //zeichen in Abfrage (Lektion)
        //Abfragen fuer <zeichen in Abfrage (Lektion)> nach Lektionsstart zu lektion
        
        return [Zeichen]()
    }
    

    
    func updateScoreZeichen(for userAntwortZeichen:UserAntwortZeichen,quizZeichen:QuizZeichen?){
        
        
        guard let quizZeichen = quizZeichen else {return}
        let scoreZeichen = getScoreZeichen(for: quizZeichen.zeichen.devanagari)
        for userAntwort in userAntwortZeichen.userAntworten(for: quizZeichen){
            _ = scoreZeichen?.newAbfrage(userAntwort: userAntwort)
        }
        
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
