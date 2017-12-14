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
    let gesamtZeichenSatz           = erstelleZeichensatz()
    private let lektionen           = erstelleLektionen()
    private var alleZeichenBisher:[Zeichen]     { return gesamtZeichenSatz.filter{$0.lektion ?? 1000 <= aktuelleLektion.value?.nummer ?? 0} }
    var alleLektionenBisher:[Lektion]           { return lektionen.filter{$0.nummer  ?? 1000  <= aktuelleLektion.value?.nummer ?? 0}}
    
    var selectedSetting     = MutableProperty<SelectedSetting?>(nil)
    var aktuelleLektion:MutableProperty<Lektion?>
    
    private var gewaehltesQuizSetting:MutableProperty<QuizSetting?>     = MutableProperty(nil)
    var freiesUebenQuizSetting:MutableProperty<QuizSetting?>    = MutableProperty(QuizSetting())
    var lektionsQuizSetting:MutableProperty<QuizSetting?>       = MutableProperty(QuizSetting())
    
    //einfache ZeichenSätze
    var freiesUebenZeichenSatz:MutableProperty<[Zeichen]>       = MutableProperty([Zeichen]())
    
    //QuizZeichenSätze
    var gewaehlterQuizZeichensatz:MutableProperty<[QuizZeichen]>    = MutableProperty([QuizZeichen]())
    var freiesUebenQuizZeichenSatz:MutableProperty<[QuizZeichen]>   = MutableProperty([QuizZeichen]())
    var lektionsQuizZeichenSatz:MutableProperty<[QuizZeichen]>      = MutableProperty([QuizZeichen]())

    //Zeichsatz für freies Üben
    var configZeichensatzGrundauswahl                           = MutableProperty([Zeichen]())
    var configZeichensatzGewaehltausGrundauswahl                = MutableProperty([Zeichen]())
    var configZeichensatzGewaehlteLektionen                     = MutableProperty([Lektion]())
    
    var canStartQuiz = MutableProperty(false)
    
    var quizZeichenInAbfrageIstLeer = MutableProperty(Void())
    
    init(){
        //helper
        func nextLektion() -> Lektion{ return  lektionen[(aktuelleLektion.value?.nummer ?? 0) + 1] }
        func getLektionsZeichensatz(for lektion:Int?) -> [Zeichen]{
            guard let lektion = lektion else {return [Zeichen]()}
            return erstelleZeichensatz().filter{$0.lektion ?? 1000 <= lektion}
        }
        func useSetting(for selSetting:SelectedSetting?){
            guard let selSetting = selSetting else { return }
            switch selSetting {
            case .FreiesUeben:
                gewaehltesQuizSetting.value                 = freiesUebenQuizSetting.value
                gewaehlterQuizZeichensatz.value             = freiesUebenQuizZeichenSatz.value
            case .Lektion:
                gewaehltesQuizSetting.value                 = aktuelleLektion.value?.quizSetting
                gewaehlterQuizZeichensatz.value             = lektionsQuizZeichenSatz.value.sorted(by: { (qz1, qz2) -> Bool in return qz1.status.value == .Correct })
            }
        }
        func getZeichenSatz(fuer lektionen:[Lektion]) -> [Zeichen]{ return gesamtZeichenSatz.filter{lektionen.map{$0.nummer ?? 1000}.contains($0.lektion ?? -1000)} }
        
        
        //aktuelle Lektion setzen (angemeldeter User)
        aktuelleLektion = MutableProperty(lektionen[Int(MainSettings.get()?.angemeldeterUser?.aktuelleLektion ?? 0)])
        
        //Zeichensatz und QuizSetting wird gesetzt, wenn selectedSetting gesetzt wird (Usereingabe)
        selectedSetting.signal.observeValues { useSetting(for: $0) }
        
        //Anzahl der QuizZeichen in Abfrage observieren --> wenn  == 0:
        //--> falls selectedSeting == .Lektion: nächste Lektion
        //--> selectedSetting wieder auf nil setzen
        quizZeichenInAbfrageIstLeer.signal.observeValues{ [weak self] _ in
            if self?.selectedSetting.value == .Lektion { self?.aktuelleLektion.value = nextLektion() }
            self?.selectedSetting.value = nil
        }
        

        
        //aktuelle Lektion observieren --> Änderung:
        //angemeldeter User aktuelle Lektion setzen
        aktuelleLektion.producer.startWithValues { lektion in  MainSettings.get()?.angemeldeterUser?.aktuelleLektion       = Int16(lektion?.nummer ?? 0) }
        //LektionsSetting setzen
        lektionsQuizSetting <~ aktuelleLektion.producer.map{$0?.quizSetting}
        
        //UserConfig Freies Üben
        freiesUebenZeichenSatz          <~ configZeichensatzGewaehltausGrundauswahl
        configZeichensatzGrundauswahl   <~ configZeichensatzGewaehlteLektionen.signal.map{getZeichenSatz(fuer: $0)}
        
        
        //QuizZeichenSätze generieren
        //1) neue Lektion
        lektionsQuizZeichenSatz         <~ aktuelleLektion.producer.map{ QuizZeichen.createQuizZeichensatzForLektion(quizSetting: $0?.quizSetting, zeichensatz: getLektionsZeichensatz(for: $0?.nummer)) }
        //2) freies Ueben - QuizSetting oder ZeichenSatz ändert sich
        freiesUebenQuizZeichenSatz      <~ freiesUebenZeichenSatz.producer.map{[weak self] zeichenSatz in QuizZeichen.createQuizZeichensatz(quizSetting: self?.freiesUebenQuizSetting.value, zeichensatz: zeichenSatz)}
        freiesUebenQuizZeichenSatz      <~ freiesUebenQuizSetting.producer.map{[weak self] quizSetting in QuizZeichen.createQuizZeichensatz(quizSetting: quizSetting, zeichensatz: self?.freiesUebenZeichenSatz.value)}
        

        //setze canStartValue
        func _canStartQuiz() -> Bool{
            return !(selectedSetting.value == nil ||
                gewaehlterQuizZeichensatz.value.count == 0 ||
                gewaehltesQuizSetting.value?.anzahlAbfragen == 0 && gewaehltesQuizSetting.value?.zeichenfeld != .Nachzeichnen ||
                gewaehltesQuizSetting.value == nil)
        }
        let canStartQuizProducerArray = [selectedSetting.producer.combinePrevious().filter{$0.0 != $0.1}.map{_ in ()},
                                         gewaehlterQuizZeichensatz.producer.combinePrevious().filter{$0.0 != $0.1}.map{_ in ()},
                                         gewaehltesQuizSetting.producer.combinePrevious().filter{$0.0 != $0.1}.map{_ in ()} ]
        canStartQuiz <~ SignalProducer.merge(canStartQuizProducerArray).map{_canStartQuiz()}
    }
    
    func getQuizModel() -> QuizModel{ return QuizModel(quizZeichenSatz: gewaehlterQuizZeichensatz, quizZeichenInAbfrageIstLeer: quizZeichenInAbfrageIstLeer, isLektionsquiz: selectedSetting.value == .Lektion) }
}





