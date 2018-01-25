//
//  PanelControlViewModel.swift
//  learnDevanagari2
//
//  Created by Matthias Pochmann on 04.11.17.
//  Copyright © 2017 Matthias Pochmann. All rights reserved.
//

import UIKit
import ReactiveSwift


enum ControlCurrentModus{ case Abfrage, Anzeige, ShowsPruefergebnis, Versteckt }

class PanelControlViewModel:PanelControlViewModelProtocol{
    var quizModel:QuizModel
    var controlTyp:ControlTyp
    
    var zeilenHoehe:MutableProperty<CGFloat> = MutableProperty(30.0)
    var correctAnswer: MutableProperty<String?> = MutableProperty(nil)
    var backGroundColor     = MutableProperty(colorForDefault) //nicht für MultiTouchButtons
    
    var controlCurrentModus = MutableProperty(ControlCurrentModus.Versteckt)
    
    
    //Model Interaktionen
    var isEnabled                           = MutableProperty(true)
    var isHidden                            = MutableProperty(false)
    var userEingabe                         = MutableProperty<String?>(nil)
    
    required init(controlSetting: PanelControlSetting,quizModel:QuizModel) {
        controlTyp         = controlSetting.controlTyp
        self.quizModel          = quizModel
        
        if controlTyp == .TextfeldTyp || controlTyp == .ArtikulationTyp { backGroundColor     <~ controlCurrentModus.producer.map{[weak self] _ in self?.getBackGroundColor() ?? colorForDefault} }
        
        //schreibt Usereingabe in das UsereingabeZeichen im Quizmodel
        userEingabe             = quizModel.userEingabe.getMutableProperty(for: controlTyp) ?? MutableProperty<String?>(nil)
        
        //neues QuizZeichen
        correctAnswer       <~ quizModel.currentQuizZeichen.producer.map{ [weak self] quizZeichen -> String? in
            return quizZeichen?.zeichen.getCorrectAnswer(for: self?.controlTyp, quizZeichen: quizZeichen)
        }
        
        
        controlCurrentModus <~ quizModel.currentQuizZeichen.producer.map                    { [weak self] quizZeichen in
            guard let panelControlSetting = quizZeichen?.quizSetting.getPanelControlSetting(for: self?.controlTyp) else {return .Versteckt}
            switch panelControlSetting.modus{
                case .InAbfrage     :  return .Abfrage
                case .NurAnzeige    :  return .Anzeige
                case .Versteckt     :  return .Versteckt
            }
        }
        //currentControlModus
        controlCurrentModus <~ quizModel.zeigePruefergebnisse.signal.map{ _ in .ShowsPruefergebnis }
        
        //isHidden
        
        isHidden <~ quizModel.userEingabe.vokalOderKonsonant.producer
            .filter{ [weak self] _ in self?.controlCurrentModus.value != .Versteckt}
            .map       { [weak self] _ -> Bool in getIsHidden()}
        isHidden <~ quizModel.userEingabe.vokalOderHalbvokal.producer
            .filter{ [weak self] _ in self?.controlCurrentModus.value != .Versteckt}
            .map       { [weak self] _ -> Bool in getIsHidden() }
        isHidden <~ controlCurrentModus.producer
            .filter{$0 == .Versteckt}
            .map{_ in return true}
        isHidden <~ controlCurrentModus.producer
            .filter{$0 != .Versteckt}
            .map        { [weak self] _ -> Bool in getIsHidden()}
    

        
        
        isEnabled           <~ controlCurrentModus.producer.map{  $0 == .Abfrage ? true : false }
        zeilenHoehe         <~ quizModel.zeilenHoehe.producer
    
        func getIsHidden()->Bool {
            let controlModus = quizModel.currentQuizZeichen.value?.quizSetting.getPanelControlSetting(for: controlTyp)?.modus
            return isHidden(controlCurrentModus:controlCurrentModus.value,
                            usereingabe:                quizModel.userEingabe,
                            controlTyp:                 controlTyp,
                            controlModus:               controlModus,
                            korrekteAntwort:            quizModel.currentQuizZeichen.value?.zeichen,
                            vokalOderKonsShowsAnswer:   quizModel.currentQuizZeichen.value?.quizSetting.vokalOderKonsonant.modus,
                            isNasalDesAnusvaraLektion:  quizModel.currentQuizZeichen.value?.nasalDesAnusvaraZeichen  != nil) }
    }
    
    //helper
    
    
    
    func getBackGroundColor() -> UIColor{
        var currentControlSetting:PanelControlSetting?{ return quizModel.currentQuizZeichen.value?.quizSetting.getPanelControlSetting(for: controlTyp) }
        if controlCurrentModus.value == .ShowsPruefergebnis && currentControlSetting?.modus != PanelControlModus.NurAnzeige {
            return correctAnswer.value == userEingabe.value ? colorForCorrect : colorForWrong
        }
        return colorForDefault
    }
}
