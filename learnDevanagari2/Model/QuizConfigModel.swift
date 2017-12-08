//
//  MainModel.swift
//  learnDevanagari2
//
//  Created by Matthias Pochmann on 08.11.17.
//  Copyright © 2017 Matthias Pochmann. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result

enum SelectedSetting    {case Lektion, FreiesUeben}
class QuizConfigModel{
    var selectedSetting     = MutableProperty<SelectedSetting?>(nil)
    let gesamtZeichenSatz   = erstelleZeichensatz()
    let lektionen           = erstelleLektionen()
    var aktuelleLektion:MutableProperty<Lektion?>
    
    var gewaehltesQuizSetting:MutableProperty<QuizSetting?>     = MutableProperty(nil)
    var freiesUebenQuizSetting:MutableProperty<QuizSetting?>    = MutableProperty(QuizSetting())
    var lektionsQuizSetting:MutableProperty<QuizSetting?>       = MutableProperty(QuizSetting())
    
    var freiesUebenZeichenSatz:MutableProperty<[Zeichen]>       = MutableProperty([Zeichen]())
    var lektionsZeichenSatz:MutableProperty<[Zeichen]>          = MutableProperty([Zeichen]())
    var gewaehlterZeichensatz:MutableProperty<[Zeichen]>        = MutableProperty([Zeichen]())
    
    var canStartQuiz = MutableProperty(false)
    
    
    var configZeichensatzGrundauswahl                           = MutableProperty([Zeichen]())
    var configZeichensatzGewaehltausGrundauswahl                = MutableProperty([Zeichen]())
    var configZeichensatzGewaehlteLektionen                     = MutableProperty([Lektion]())
    
    var alleZeichenBisher:[Zeichen]     { return gesamtZeichenSatz.filter{$0.lektion ?? 1000 <= aktuelleLektion.value?.nummer ?? 0} }
    var alleLektionenBisher:[Lektion]   { return lektionen.filter{$0.nummer  ?? 1000  <= aktuelleLektion.value?.nummer ?? 0}}
    
    var quizZeichenSatzCount = MutableProperty(0)
    
    init(){
        aktuelleLektion = MutableProperty(lektionen[Int(MainSettings.get()?.angemeldeterUser?.aktuelleLektion ?? 0)])
        
        
        func useSetting(for selSetting:SelectedSetting?){
            guard let selSetting = selSetting else { return }
            switch selSetting {
            case .FreiesUeben:
                gewaehltesQuizSetting.value = freiesUebenQuizSetting.value
                gewaehlterZeichensatz.value = freiesUebenZeichenSatz.value
            case .Lektion:
                gewaehltesQuizSetting.value = aktuelleLektion.value?.quizSetting
                gewaehlterZeichensatz.value = alleZeichenBisher
            }
        }
        selectedSetting.producer.startWithValues { useSetting(for: $0) }
        gewaehlterZeichensatz           <~ freiesUebenZeichenSatz.producer.filter{[weak self] _ in self?.selectedSetting.value == .FreiesUeben}
        gewaehltesQuizSetting           <~ freiesUebenQuizSetting.producer.filter{[weak self] _ in self?.selectedSetting.value == .FreiesUeben}
        
        
        aktuelleLektion                 <~ quizZeichenSatzCount.signal.filter{$0 == 0}.filter{[weak self] _ in self?.selectedSetting.value == .Lektion}.map{[weak self] _ -> Lektion? in self?.lektionen[(self?.aktuelleLektion.value?.nummer ?? 0) + 1] }
        lektionsZeichenSatz             <~ aktuelleLektion.producer.map{ [weak self] lektion in self?.gesamtZeichenSatz.filter{$0.lektion ?? 1000 <= lektion?.nummer ?? 0} ?? [Zeichen]() }
        selectedSetting                 <~ quizZeichenSatzCount.producer.filter{$0 == 0}.map{_ in nil}
        lektionsQuizSetting             <~ aktuelleLektion.producer.map{$0?.quizSetting}
        
        freiesUebenZeichenSatz          <~ configZeichensatzGewaehltausGrundauswahl
        configZeichensatzGrundauswahl   <~ configZeichensatzGewaehlteLektionen.signal.map{[weak self] lektionen in self?.gesamtZeichenSatz.filter{lektionen.map{$0.nummer ?? 1000}.contains($0.lektion ?? -1000)} ?? [Zeichen]() }
        
        
        aktuelleLektion.producer.startWithValues { lektion in
            MainSettings.get()?.angemeldeterUser?.aktuelleLektion = Int16(lektion?.nummer ?? 0)
        }
        
        //setze canStartValue
        func _canStartQuiz() -> Bool{
            return !(selectedSetting.value == nil ||
                gewaehlterZeichensatz.value.count == 0 ||
                gewaehltesQuizSetting.value?.anzahlAbfragen == 0 && gewaehltesQuizSetting.value?.zeichenfeld != .Nachzeichnen ||
                gewaehltesQuizSetting.value == nil)
        }
        let canStartQuizProducerArray = [selectedSetting.producer.combinePrevious().filter{$0.0 != $0.1}.map{_ in ()},
                                         gewaehlterZeichensatz.producer.combinePrevious().filter{$0.0 != $0.1}.map{_ in ()},
                                         gewaehltesQuizSetting.producer.combinePrevious().filter{$0.0 != $0.1}.map{_ in ()} ]
        canStartQuiz <~ SignalProducer.merge(canStartQuizProducerArray).map{_canStartQuiz()}
    }
}





