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
    var currentQuizZeichenStatusHasChanged:MutableProperty<QuizZeichen?>
    init(quizZeichenSatz:MutableProperty<[QuizZeichen]>, quizZeichenInAbfrageIstLeer:MutableProperty<Void>, isLektionsquiz:Bool, currentQuizZeichenStatusHasChanged:MutableProperty<QuizZeichen?>) {
        self.quizZeichenSatz = quizZeichenSatz
        self.quizZeichenInAbfrageIstLeer = quizZeichenInAbfrageIstLeer
        self.currentQuizZeichenStatusHasChanged = currentQuizZeichenStatusHasChanged
        //setze alle QZ auf ungesichtet
        for quizZeichen in quizZeichenSatz.value.filter({$0.status.value == .InUserAbfrage}){ quizZeichen.status.value = .Ungesichtet }
        
        //observiert UserInteraktion für PrufenButton
        pruefenButtonHasAnAction.signal.observeValues {[weak self] () in  self?.pruefenButtonAction() }
        setNextQZ()
    }
    
    //Zeilenhöhe der Controls (ändert sich wenn sich Orientation ändert)
    //wird von PanelControlViewModel gesetzt
    var zeilenHoehe:MutableProperty<CGFloat>                = MutableProperty(30.0)
    
    //das aktuelle QuizZeichen
    var currentQuizZeichen:MutableProperty<QuizZeichen?>    = MutableProperty(nil)
    //aktuelle UserEingabe
    var userEingabe                                         = UserAntwortZeichen()
    
    //Erkannte Zeichen beim Zeichen schreiben (Tesseract)
    // wird von QuizZeichenFeld gesetzt
    var userEingabeDevaErkannteZeichen                      = MutableProperty([String()])
    
    
    //FortschrittsbalkenAnimationen
    var animateFortschrittsbalkenTo:MutableProperty<Bool?>          = MutableProperty(nil)
    var pruefenButtonZustand:MutableProperty<PruefenButtonZustand?> = MutableProperty(nil)
    
    //pruefenButton Aktionen
    var pruefenButtonHasAnAction    = MutableProperty(Void())
    
    //zeigt Pruefergebnisse
    var zeigePruefergebnisse        = MutableProperty(Void())
    
    
    //helper
    private func setNextQZ(){
        func naechstesQuizZeichen() -> QuizZeichen? {
            userEingabe.resetToNil()
            let newRandomZeichen            = getRandomQuizZeichen()
            newRandomZeichen?.status.value  = .InUserAbfrage
            return newRandomZeichen
        }
        if currentQuizZeichen.value?.quizSetting.isNachZeichnen == true{
            animateFortschrittsbalkenTo.value = true
        }
        currentQuizZeichen.value = naechstesQuizZeichen()
        //prüft Zeichen, falls Nachzeichnen (== correct)
        //sonst setzt PruefenButtonZustand auf Prüfen
        if currentQuizZeichen.value?.quizSetting.isNachZeichnen == true     { userEingabePruefen() }
        else                                                                { pruefenButtonZustand.value = PruefenButtonZustand.Pruefen }
    }
    private func userEingabePruefen(){
        currentQuizZeichen.value?.status.value      = isUserEingabeCorrect  ? .Correct  : .FalschBeantwortet
        currentQuizZeichenStatusHasChanged.value    = currentQuizZeichen.value
        currentQuizZeichen.value?.setLetztesMalKorrektLektion()
        MainSettings.get()?.angemeldeterUser?.updateScoreZeichen(for: userEingabe, quizZeichen: currentQuizZeichen.value)
        
        //zeigt PruefErgebnisse +
        //animiert die UserAntwort, wenn nicht nachzeichnen
        if currentQuizZeichen.value?.quizSetting.isNachZeichnen == false{
            zeigePruefergebnisse.value = Void()
            animateFortschrittsbalkenTo.value = isUserEingabeCorrect }
        //ist current letztes Zeichen? --> PruefenButton setzen
        switch quizZeicheninAbfrage.count == 0 {
        case true: pruefenButtonZustand.value = .QuizBeenden
        case false:pruefenButtonZustand.value = .NaechstesZeichen
        }
    }
    private func pruefenButtonAction(){
        guard let pruefenButtonZustand = pruefenButtonZustand.value else {return}
        switch pruefenButtonZustand {
        case .Pruefen:userEingabePruefen()
        case .NaechstesZeichen:setNextQZ()
        case .QuizBeenden: quizZeichenInAbfrageIstLeer.value = Void()
        }
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













