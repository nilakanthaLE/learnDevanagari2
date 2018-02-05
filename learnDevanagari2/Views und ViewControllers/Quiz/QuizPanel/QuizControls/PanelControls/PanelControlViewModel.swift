//
//  PanelControlViewModel.swift
//  learnDevanagari2
//
//  Created by Matthias Pochmann on 04.11.17.
//  Copyright © 2017 Matthias Pochmann. All rights reserved.
//

import UIKit
import ReactiveSwift


//MARK: PanelControlViewModel
// Basisklasse für ViewModels aller PanelControls
class PanelControlViewModel:PanelControlViewModelProtocol{
    var quizModel:QuizModel
    var controlTyp:ControlTyp
    var zeilenHoehe:MutableProperty<CGFloat>
    
    var correctAnswer       = MutableProperty<String?>(nil)
    var controlCurrentModus = MutableProperty(ControlCurrentModus.Versteckt)
    var isEnabled           = MutableProperty(true)
    var isHidden            = MutableProperty(false)
    var userEingabe         = MutableProperty<String?>(nil)
    
    required init(controlSetting: PanelControlSetting,quizModel:QuizModel) {
        controlTyp          = controlSetting.controlTyp
        self.quizModel      = quizModel
        zeilenHoehe         = quizModel.zeilenHoehe
        userEingabe         = quizModel.userEingabe.getMutableProperty(for: controlTyp) ?? MutableProperty<String?>(nil)
        
        //richtige Antwort mit jedem neuen QuizZeichen initialisieren
        correctAnswer           <~ quizModel.currentQuizZeichen.producer.map{ $0?.zeichen.getCorrectAnswer(for: controlSetting.controlTyp, quizZeichen: $0) }
        
        //currentControlModus
        controlCurrentModus     <~ quizModel.currentQuizZeichen.producer.map { $0?.quizSetting.getPanelControlSetting(for: controlSetting.controlTyp)?.modus.asControlCurrentModus ?? .Versteckt }
        controlCurrentModus     <~ quizModel.zeigePruefergebnisse.signal.map { _ in .ShowsPruefergebnis }
        
        //isHidden
        isHidden                <~ quizModel.userEingabe.vokalOderKonsonant.producer.map        { [weak self] _ in self?.getIsHidden() ?? true }
        isHidden                <~ quizModel.userEingabe.vokalOderHalbvokal.producer.map        { [weak self] _ in self?.getIsHidden() ?? true }
        isHidden                <~ controlCurrentModus.producer.map                             { [weak self] _ in self?.getIsHidden() ?? true }
    
        //isEnabled
        isEnabled               <~ controlCurrentModus.producer.map                             { $0 == .Abfrage }
    }
    
    //MARK: helper
    // die Sichtbarkeit eines PanelControls ist von verschiedenen Parametern abhängig
    // wird ein Parameter verändert, wird diese Methode aufgerufen
    // sie gibt den Zustand der Sichtbarkeit des Controls zurück
    func getIsHidden() -> Bool {
        let controlModus = quizModel.currentQuizZeichen.value?.quizSetting.getPanelControlSetting(for: controlTyp)?.modus
        return controlIsHidden(controlCurrentModus:controlCurrentModus.value,
                               usereingabe:                quizModel.userEingabe,
                               controlTyp:                 controlTyp,
                               controlModus:               controlModus,
                               korrekteAntwort:            quizModel.currentQuizZeichen.value?.zeichen,
                               vokalOderKonsShowsAnswer:   quizModel.currentQuizZeichen.value?.quizSetting.vokalOderKonsonant.modus,
                               isNasalDesAnusvaraLektion:  quizModel.currentQuizZeichen.value?.nasalDesAnusvaraZeichen  != nil)
    }
    
    //Methode zur Ermittlung der Hintergrundfarbe
    // für Textfeld und Artikulation
    // nicht für Multitouchbuttons
    func getBackGroundColor() -> UIColor{
        let currentControlSetting = quizModel.currentQuizZeichen.value?.quizSetting.getPanelControlSetting(for: controlTyp)
        if controlCurrentModus.value == .ShowsPruefergebnis && currentControlSetting?.modus != PanelControlModus.NurAnzeige {
            return correctAnswer.value == userEingabe.value ? colorForCorrect : colorForWrong
        }
        return colorForDefault
    }
}
