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
        zeichenSatz            <~ quizConfigModel.gewaehlterZeichensatz.producer
        
        quizZeichenSatz.value       = createQuizZeichensatz(quizSetting: quizConfigModel.gewaehltesQuizSetting.value  , zeichensatz: quizConfigModel.gewaehlterZeichensatz.value)
        setNextCurrentZeichen()
        quizConfigModel.quizZeichenSatzCount <~ quizZeichenSatz.producer.map{[weak self] _ in self?.quizZeichenSatz.value.count ?? 0}
        
    }
    
    
    var zeilenHoehe:MutableProperty<CGFloat>                = MutableProperty(30.0)
    
    var quizZeichenSatz                                     = MutableProperty([QuizZeichen]())
    var currentQuizZeichen:MutableProperty<QuizZeichen?>    = MutableProperty(nil)
    var userEingabe                                         = UserAntwortZeichen()
    var userEingabeDevaErkannteZeichen                      = MutableProperty([String()])
    var userEingabePrüfen                                   = MutableProperty(false)
    
    var isUserEingabeCorrect:Bool   { return userEingabe.isCorrect(for: currentQuizZeichen.value) }
    
    
    func setNextCurrentZeichen(){
        currentQuizZeichen.value = getNaechstesQuizZeichen()
    }
    private func getNaechstesQuizZeichen() -> QuizZeichen? {
        if isUserEingabeCorrect && !(quizZeichenSatz.value.count == 0) { quizZeichenSatz.value.removeFirst() }
        userEingabe.resetToNil()
        userEingabePrüfen.value = false
        return getRandomQuizZeichen()
    }
    private func getRandomQuizZeichen() -> QuizZeichen?{
        return quizZeichenSatz.value.first
    }

    //helper
    func createQuizZeichensatz(quizSetting:QuizSetting?,zeichensatz:[Zeichen]?) -> [QuizZeichen]{
        guard let quizSetting = quizSetting, let zeichensatz = zeichensatz else {return [QuizZeichen]()}
        print(zeichensatz)
        
        var zeichensatzForZeichenfeldAbfrage:[QuizZeichen]{
            var quizSetting = quizSetting
            quizSetting.setPanelControlsToNurAnzeige()
            quizSetting.zeichenfeld = .Abfrage
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
        case .Abfrage:
            return zeichensatzForZeichenfeldAbfrage + zeichensatzForZeichenfeldNurAnzeige
        case .AbfrageUndNachzeichnen:
            return zeichensatzForZeichenfeldAbfrage + zeichensatzForZeichenfeldNurAnzeige + zeichensatzForZeichenfeldNachzeichnen
        }
    }
}













