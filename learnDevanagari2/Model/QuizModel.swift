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
    var quizZeichenInAbfrageIstLeer:MutableProperty<Void>
    var quizZeichenSatz:MutableProperty<[QuizZeichen]>
    init(quizZeichenSatz:MutableProperty<[QuizZeichen]>,quizZeichenInAbfrageIstLeer:MutableProperty<Void>, isLektionsquiz:Bool ) {
        self.quizZeichenSatz = quizZeichenSatz
        self.quizZeichenInAbfrageIstLeer = quizZeichenInAbfrageIstLeer
        
        for quizZeichen in quizZeichenSatz.value.filter({$0.status.value == .InUserAbfrage}){ quizZeichen.status.value = .Ungesichtet }
        
        nextZeichenPressed.signal.observe               { [weak self] _ in DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { self?.setNextCurrentZeichen() } }
        pruefenPressed.signal.observe                   { [weak self] _ in self?.pruefeEingabe() }

        setNextCurrentZeichen()
    }
    
    //Zeilenhöhe der Controls (ändert sich wenn sich Orientation ändert)
    var zeilenHoehe:MutableProperty<CGFloat>                = MutableProperty(30.0)
    
    
    var currentQuizZeichen:MutableProperty<QuizZeichen?>    = MutableProperty(nil)
    var userEingabe                                         = UserAntwortZeichen()
    var userEingabeDevaErkannteZeichen                      = MutableProperty([String()])
    var userEingabePrüfen                                   = MutableProperty(false)
    
    //PruefenButton Aktionen
    var nextZeichenPressed  = MutableProperty(Void())
    var pruefenPressed      = MutableProperty(Void())
    
    //helper
    private func setLetztesMalKorrektLektion(){
        guard currentQuizZeichen.value?.status.value == .Correct else{return}
        currentQuizZeichen.value?.scoreZeichen?.setLetztesMalKorrektLektion(quizZeichen: currentQuizZeichen.value)
    }
    private func pruefeEingabe(){
        currentQuizZeichen.value?.status.value = isUserEingabeCorrect  ? .Correct  : .FalschBeantwortet
        setLetztesMalKorrektLektion()
        MainSettings.get()?.angemeldeterUser?.updateScoreZeichen(for: userEingabe, quizZeichen: currentQuizZeichen.value)
        
        userEingabePrüfen.value = true
        
    }
    private func setNextCurrentZeichen(){
        guard let next = getNaechstesQuizZeichen() else {return}
        if next.quizSetting.isNachZeichnen  {
            setLetztesMalKorrektLektion()
            next.status.value = .Correct } //für Zeichenfeldmodus (kein Prüfen)
        currentQuizZeichen.value = next
    }
    private func getNaechstesQuizZeichen() -> QuizZeichen? {
        userEingabe.resetToNil()
        userEingabePrüfen.value = false
        let newRandomZeichen = getRandomQuizZeichen()
        newRandomZeichen?.status.value = .InUserAbfrage
        if newRandomZeichen == nil {
            //kein QuizZeichen mehr in Abfrage
            setLetztesMalKorrektLektion()
            quizZeichenInAbfrageIstLeer.value = Void() }
        return newRandomZeichen
    }
    private func getRandomQuizZeichen() -> QuizZeichen?{
        // Keine Zeichenfeldabfrage für Zeichen, die noch nicht nachgezeichnet wurden
        guard quizZeicheninAbfrage.count > 0 else {return nil}
        let index = Int(arc4random_uniform(UInt32(quizZeicheninAbfrage.count)))
        return quizZeicheninAbfrage[index]
    }
    
    //calc Properties
    //quizZeicheninAbfrage --> nicht correkt beantwortete QuizZeichen
    var quizZeicheninAbfrage:[QuizZeichen]{ return quizZeichenSatz.value.filter{$0.status.value != QuizZeichenStatus.Correct} }
    //prüft Usereingabe --> Bool
    var isUserEingabeCorrect:Bool   { return userEingabe.isCorrect(for: currentQuizZeichen.value) }
}













