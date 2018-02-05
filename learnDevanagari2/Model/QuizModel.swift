//
//  QuizModel.swift
//  learnDevanagari2
//
//  Created by Matthias Pochmann on 31.10.17.
//  Copyright © 2017 Matthias Pochmann. All rights reserved.
//

import Foundation
import ReactiveSwift


class QuizModel{
    var quizZeichenInAbfrageIstLeer:MutableProperty<Void>
    var quizZeichenSatz:MutableProperty<[QuizZeichen]>
    var currentQuizZeichenStatusHasChanged:MutableProperty<QuizZeichen?>
    var konsonantenTypModus:KonsonantTypModus?
    var sonderZeichenFuerTastaturBar = MutableProperty([String]())
    init(quizZeichenSatz:MutableProperty<[QuizZeichen]>, quizZeichenInAbfrageIstLeer:MutableProperty<Void>, isLektionsquiz:Bool, currentQuizZeichenStatusHasChanged:MutableProperty<QuizZeichen?>, konsonantenTypModus:KonsonantTypModus?) {
        self.konsonantenTypModus                = konsonantenTypModus
        self.quizZeichenSatz                    = quizZeichenSatz
        self.quizZeichenInAbfrageIstLeer        = quizZeichenInAbfrageIstLeer
        self.currentQuizZeichenStatusHasChanged = currentQuizZeichenStatusHasChanged
        
        //setze alle QZ auf ungesichtet
        for quizZeichen in quizZeichenSatz.value.filter({$0.status.value == .InUserAbfrage}){ quizZeichen.status.value = .Ungesichtet }
        
        //sonderZeichenFuerTastaturBar
        sonderZeichenFuerTastaturBar.value = QuizZeichen.getSonderZeichenFuerTastaturBar(quizZeichensatz: quizZeichenSatz.value)
        
        //observiert UserInteraktion für PrufenButton
        pruefenButtonHasAnAction.signal.observeValues {[weak self] () in  self?.pruefenButtonAction() }
        
        // start mit neuem QuizZeichen
        setNextQZ()
    }
    
    //Zeilenhöhe der Controls (ändert sich wenn sich Orientation ändert)
    //wird von PanelControlViewModel gesetzt
    var zeilenHoehe:MutableProperty<CGFloat>                = MutableProperty(30.0)
    
    //das aktuelle QuizZeichen
    var currentQuizZeichen:MutableProperty<QuizZeichen?>    = MutableProperty(nil)
    
    //aktuelle UserEingabe
    var userEingabe                                         = UserAntwortZeichen()
    
    //Erkannte Zeichen beim  "zeichnen" des DevanagariZeichens (Tesseract)
    // wird von QuizZeichenFeld gesetzt
    var userEingabeDevaErkannteZeichen                      = MutableProperty([String()])
    
    //FortschrittsbalkenAnimationen
    var animateFortschrittsbalkenTo:MutableProperty<QuizZeichenStatus?> = MutableProperty(nil)
    var pruefenButtonZustand:MutableProperty<PruefenButtonZustand?>     = MutableProperty(nil)
    
    //pruefenButton Aktionen
    // (immer wenn, pruefenButton gedrückt wird)
    var pruefenButtonHasAnAction    = MutableProperty(Void())
    
    //zeigt Pruefergebnisse
    var zeigePruefergebnisse        = MutableProperty(Void())
    
    
    //MARK: helper
    // ein neues QuizZeichen wird gesetzt
    private func setNextQZ(){
        // Für den fall, dass das gegenwärtige QuizZeichen nur nachgezeichnet wird
        // -> Animation des Fortschrittsbalkens
        if currentQuizZeichen.value?.quizSetting.isNachZeichnen == true     { animateFortschrittsbalkenTo.value = QuizZeichenStatus.Correct }
        //Usereingabe zurück setzen
        userEingabe.resetToNil()
        // currenQuizzeichen erhält neues QuizZeichen
        currentQuizZeichen.value = naechstesQuizZeichen()
        //prüft Zeichen, falls Nachzeichnen --> PrüfenProzess autmatisch starten
        // Nachzeichnen =
        // sonst setzt PruefenButtonZustand auf Prüfen
        if currentQuizZeichen.value?.quizSetting.isNachZeichnen == true     { userEingabePruefen() }
        else                                                                { pruefenButtonZustand.value = PruefenButtonZustand.Pruefen }
    }
    //das nächste QuizZeichen ermitteln
    private func naechstesQuizZeichen() -> QuizZeichen? {
        func getRandomQuizZeichen() -> QuizZeichen?{
            guard quizZeicheninAbfrage.count > 0 else {return nil}
            return quizZeicheninAbfrage[Int(arc4random_uniform(UInt32(quizZeicheninAbfrage.count)))]
        }
        let newRandomZeichen            = getRandomQuizZeichen()
        newRandomZeichen?.status.value  = .InUserAbfrage
        return newRandomZeichen
    }
    // Die Eingabe des Users prüfen ...
    private func userEingabePruefen(){
        //1 den Status des aktuellen QZ setzen (correct/falsch)
        //2 MutableProperty currentStatusHasChanged wird gesetzt -> führt dazu, dass auf der Startseite das Zeichen rot,gelb oder grün wird
        //3 falls korrekt, wird im ScoreZeichen gespeichert, wann dieses Zeichen das letze Mal korrekt beantwortet wurde
        currentQuizZeichen.value?.status.value      = isUserEingabeCorrect  ? .Correct  : .FalschBeantwortet
        currentQuizZeichenStatusHasChanged.value    = currentQuizZeichen.value
        currentQuizZeichen.value?.scoreZeichen.setLetztesMalKorrekt(userAntwortZeichen: userEingabe, quizZeichen: currentQuizZeichen.value)
        
        // das ScoreZeichen wird aktualisiert - alle Abfragen und ihre Ergebnisse werden gespeichert
        MainSettings.get()?.angemeldeterUser?.updateScoreZeichen(for: userEingabe, quizZeichen: currentQuizZeichen.value)
        
        //wenn nicht nachzeichnen:
        //zeigt PruefErgebnisse + animiert  Fortschrittsbalken
        if currentQuizZeichen.value?.quizSetting.isNachZeichnen == false{
            zeigePruefergebnisse.value = Void()
            animateFortschrittsbalkenTo.value = isUserEingabeCorrect ? QuizZeichenStatus.Correct : QuizZeichenStatus.FalschBeantwortet}
        //wenn current letztes Zeichen? --> PruefenButton auf QuizBeenden setzen, sonst auf nächstesZeichen setzen
        switch quizZeicheninAbfrage.count == 0 {
        case true: pruefenButtonZustand.value = .QuizBeenden
        case false:pruefenButtonZustand.value = .NaechstesZeichen
        }
    }
    //pruefenButtonAction() wird ausgeführt, wenn der User auf den PruefenKnopf drückt
    // 3 Zustände: Pruefen / NaechstesZeichen / QuizBeenden
    private func pruefenButtonAction(){
        guard let pruefenButtonZustand = pruefenButtonZustand.value else {return}
        switch pruefenButtonZustand {
        case .Pruefen:              userEingabePruefen()
        case .NaechstesZeichen:     setNextQZ()
        case .QuizBeenden:          quizZeichenInAbfrageIstLeer.value = Void()
        }
    }
    
    //MARK: calc Properties
    //quizZeicheninAbfrage = Array aller noch nicht richtig beantworteten QuizZeichen
    var quizZeicheninAbfrage:[QuizZeichen]{ return quizZeichenSatz.value.filter{$0.status.value != QuizZeichenStatus.Correct} }
    //prüft ob die Usereingabe vollständig richtig war
    var isUserEingabeCorrect:Bool   { return userEingabe.isCorrect(for: currentQuizZeichen.value) }
}
