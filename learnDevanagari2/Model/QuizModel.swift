//
//  QuizModel.swift
//  learnDevanagari2
//
//  Created by Matthias Pochmann on 31.10.17.
//  Copyright © 2017 Matthias Pochmann. All rights reserved.
//

import Foundation
import CoreGraphics
import ReactiveSwift



class QuizModel{
    var quizConfigModel:QuizConfigModel
    var zeichenSatz = MutableProperty([Zeichen]())
    init(quizConfigModel:QuizConfigModel ) {
        self.quizConfigModel        = quizConfigModel
        zeichenSatz                 <~ quizConfigModel.gewaehlterZeichensatz.producer
        
        quizZeichenSatz.value       = createQuizZeichensatz(quizSetting: quizConfigModel.gewaehltesQuizSetting.value  , zeichensatz: quizConfigModel.gewaehlterZeichensatz.value)
        setNextCurrentZeichen()
        
        

        
        nextZeichenPressed.signal.observe { [weak self] _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self?.setNextCurrentZeichen()
            }
        }
        pruefenPressed.signal.observe { [weak self] _ in
            self?.pruefeEingabe()
        }
    }
    
    
    var zeilenHoehe:MutableProperty<CGFloat>                = MutableProperty(30.0)
    
    var quizZeichenSatz                                     = MutableProperty([QuizZeichen]())
    var currentQuizZeichen:MutableProperty<QuizZeichen?>    = MutableProperty(nil)
    var userEingabe                                         = UserAntwortZeichen()
    var userEingabeDevaErkannteZeichen                      = MutableProperty([String()])
    var userEingabePrüfen                                   = MutableProperty(false)
    
    var isUserEingabeCorrect:Bool   { return userEingabe.isCorrect(for: currentQuizZeichen.value) }
    
    
    var nextZeichenPressed  = MutableProperty(Void())
    var pruefenPressed      = MutableProperty(Void())
    private func pruefeEingabe(){
        currentQuizZeichen.value?.status.value = isUserEingabeCorrect  ? .Correct  : .FalschBeantwortet
        userEingabePrüfen.value = true
        ScoreZeichen.update(for: userEingabe, quizZeichen: currentQuizZeichen.value)
    }
    private func setNextCurrentZeichen(){
        guard let next = getNaechstesQuizZeichen() else {return}
        if next.quizSetting.anzahlAbfragen == 0  { next.status.value = .Correct } //für Zeichenfeldmodus (kein Prüfen)
        currentQuizZeichen.value = next
    }
    
    
    private func getNaechstesQuizZeichen() -> QuizZeichen? {
        if currentQuizZeichen.value?.status.value == .Ungesichtet { currentQuizZeichen.value?.status.value = .Correct}  //falls ohe Prüfung (Nachzeichnen)
        quizConfigModel.quizZeichenSatzCount.value  = quizZeicheninAbfrage.count
        userEingabe.resetToNil()
        userEingabePrüfen.value = false
        let newRandomZeichen = getRandomQuizZeichen()
        newRandomZeichen?.status.value = .InUserAbfrage
        return newRandomZeichen
    }
    private func getRandomQuizZeichen() -> QuizZeichen?{
        // Keine Zeichenfeldabfrage für Zeichen, die noch nicht nachgezeichnet wurden
        guard quizZeicheninAbfrage.count > 0 else {return nil}
        let index = Int(arc4random_uniform(UInt32(quizZeicheninAbfrage.count)))
        return quizZeicheninAbfrage[index]
    }
    var quizZeicheninAbfrage:[QuizZeichen]{
        return quizZeichenSatz.value.filter{$0.status.value != QuizZeichenStatus.Correct}
    }
        
    //helper
    func createQuizZeichensatz(quizSetting:QuizSetting?,zeichensatz:[Zeichen]?) -> [QuizZeichen]{
        guard let quizSetting = quizSetting, let zeichensatz = zeichensatz else {return [QuizZeichen]()}
        
        var zeichensatzForZeichenfeldAbfrage:[QuizZeichen]{
            var quizSetting = quizSetting
            quizSetting.setPanelControlsToNurAnzeige()
            quizSetting.zeichenfeld = .InAbfrage
            return zeichensatz.map{QuizZeichen(zeichen: $0, quizSetting: quizSetting)}
        }
        var zeichensatzForZeichenfeldNachzeichnen:[QuizZeichen]{
            var quizSetting = quizSetting
            quizSetting.setPanelControlsToNurAnzeige()
            quizSetting.zeichenfeld = .Nachzeichnen
            return zeichensatz.map{QuizZeichen(zeichen: $0, quizSetting: quizSetting)}
        }
        var zeichensatzForZeichenfeldNurAnzeige:[QuizZeichen]{
            var quizSetting = quizSetting
            quizSetting.zeichenfeld = .NurAnzeige
            return quizSetting.anzahlAbfragen > 0 ? zeichensatz.map{QuizZeichen(zeichen: $0, quizSetting: quizSetting)} : [QuizZeichen]()
        }
        
        switch quizSetting.zeichenfeld {
        case .NurAnzeige:
            return zeichensatzForZeichenfeldNurAnzeige
        case .Nachzeichnen:
            return zeichensatzForZeichenfeldNachzeichnen + zeichensatzForZeichenfeldNurAnzeige
        case .InAbfrage:
            return zeichensatzForZeichenfeldAbfrage + zeichensatzForZeichenfeldNurAnzeige
        case .AbfrageUndNachzeichnen:
            return zeichensatzForZeichenfeldAbfrage + zeichensatzForZeichenfeldNurAnzeige + zeichensatzForZeichenfeldNachzeichnen
        }
    }
}













