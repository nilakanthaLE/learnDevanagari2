//
//  MainModel.swift
//  learnDevanagari2
//
//  Created by Matthias Pochmann on 08.11.17.
//  Copyright © 2017 Matthias Pochmann. All rights reserved.
//

import Foundation
import ReactiveSwift

enum SelectedSetting    {case Lektion, FreiesUeben}
class QuizConfigModel{
    let gesamtZeichenSatz           = erstelleZeichensatz()
    
    var selectedSetting             = MutableProperty<SelectedSetting?>(nil)
    
    //quizSetting
    private var gewaehltesQuizSetting:MutableProperty<QuizSetting?> = MutableProperty(nil)
    var freiesUebenQuizSetting:MutableProperty<QuizSetting?>        = MutableProperty(QuizSetting())
    var lektionsQuizSetting:MutableProperty<QuizSetting?>           = MutableProperty(QuizSetting())
    
    //einfache ZeichenSätze
    var freiesUebenZeichenSatz                                      = MutableProperty([Zeichen]())
    
    //QuizZeichenSätze
    var gewaehlterQuizZeichensatz                                   = MutableProperty([QuizZeichen]())
    var freiesUebenQuizZeichenSatz                                  = MutableProperty([QuizZeichen]())
    var lektionsQuizZeichenSatz                                             = MutableProperty([QuizZeichen]())

    //Zeichsatz für freies Üben
    var configZeichensatzGrundauswahl                                       = MutableProperty([Zeichen]())
    var configZeichensatzGewaehltausGrundauswahl                            = MutableProperty([Zeichen]())
    var configZeichensatzGewaehlteLektionen                                 = MutableProperty([Lektion]())
    
    var canStartQuiz                                                        = MutableProperty(false)
    var quizZeichenInAbfrageIstLeer                                         = MutableProperty(Void())
    
    var aktuellerLektionsTitle:MutableProperty<String?>                     = MutableProperty(nil)
    var aktuelleLektion                                                     = MutableProperty(0)
    
    var currentQuizZeichenStatusHasChanged:MutableProperty<QuizZeichen?>    = MutableProperty(nil)
    
    init(){
        let user = MainSettings.get()?.angemeldeterUser
        //Test!
        print("test für Sonderlektionen")
        user?.aktuelleLektion = 19
        
        //aktuelle Lektion setzen (angemeldeter User)
        func updateForLektion(_ lektion:Lektion?){
            lektionsQuizSetting.value       = filterLektionsQuizSetting(lektion: lektion)
            lektionsQuizZeichenSatz.value   = QuizZeichen.createQuizZeichensatzForLektion(quizSetting:filterLektionsQuizSetting(lektion:lektion), zeichensatz: lektion?.zeichenSatzBisAktuell)
            aktuellerLektionsTitle.value    = lektion?.title
            aktuelleLektion.value           = lektion?.nummer ?? 0
            user?.updateBereitsBekannteControls(quizSetting: lektionsQuizSetting.value)
            user?.updateBereitsbekannteLektion()
            //falls beim letzten Mal die App beendet wurde, ohne dass die nächste Lektion initialisiert wurde
            if (lektionsQuizZeichenSatz.value.filter{ $0.status.value != .Correct}).count == 0{
                updateForLektion(user?.nextLektion())
            }
            
        }
        updateForLektion(user?.currentLektion)
        
        //Zeichensatz und QuizSetting wird gesetzt, wenn selectedSetting gesetzt wird (Usereingabe)
        selectedSetting.signal.observeValues { useSetting(for: $0) }
        
        //quizZeichenInAbfrageIstLeer observieren
        //--> falls selectedSeting == .Lektion: nächste Lektion
        //--> selectedSetting wieder auf nil setzen
        quizZeichenInAbfrageIstLeer.signal.observeValues{ [weak self] _ in
            if self?.selectedSetting.value == .Lektion { updateForLektion(user?.nextLektion()) }
            else {
                self?.freiesUebenZeichenSatz.value = [Zeichen]()
            }
            self?.selectedSetting.value = nil
        }
        
        //UserConfig Freies Üben
        freiesUebenZeichenSatz          <~ configZeichensatzGewaehltausGrundauswahl
        configZeichensatzGrundauswahl   <~ configZeichensatzGewaehlteLektionen.signal.map{Lektion.zeichenSatz(fuer: $0)}
        
        //QuizZeichenSätze generieren
        //freies Ueben - QuizSetting oder ZeichenSatz ändert sich
        freiesUebenQuizZeichenSatz      <~ freiesUebenZeichenSatz.producer.map{[weak self] zeichenSatz in QuizZeichen.createQuizZeichensatz(quizSetting: self?.freiesUebenQuizSetting.value, zeichensatz: zeichenSatz)}
        freiesUebenQuizZeichenSatz      <~ freiesUebenQuizSetting.producer.map{[weak self] quizSetting in return QuizZeichen.createQuizZeichensatz(quizSetting: quizSetting, zeichensatz: self?.freiesUebenZeichenSatz.value)}
        
        //setze canStartValue
        let canStartQuizProducerArray   = [     selectedSetting.producer.combinePrevious().filter{$0.0 != $0.1}.map{_ in ()},
                                                gewaehlterQuizZeichensatz.producer.combinePrevious().filter{$0.0 != $0.1}.map{_ in ()},
                                                gewaehltesQuizSetting.producer.combinePrevious().filter{$0.0 != $0.1}.map{_ in ()} ]
        canStartQuiz                    <~ SignalProducer.merge(canStartQuizProducerArray).map{_canStartQuiz()}
        
        //MARK: helper
        func _canStartQuiz() -> Bool
            { return !(selectedSetting.value == nil ||
                gewaehlterQuizZeichensatz.value.count == 0 ||
                gewaehltesQuizSetting.value?.anzahlAbfragen == 0 &&
                gewaehltesQuizSetting.value?.zeichenfeld != .Nachzeichnen ||
                gewaehltesQuizSetting.value == nil) }
        func useSetting(for selSetting:SelectedSetting?){
            guard let selSetting = selSetting else { return }
            switch selSetting {
            case .FreiesUeben:
                gewaehltesQuizSetting.value                 = freiesUebenQuizSetting.value
                gewaehlterQuizZeichensatz.value             = freiesUebenQuizZeichenSatz.value
            case .Lektion:
                gewaehltesQuizSetting.value                 = lektionsQuizSetting.value
                gewaehlterQuizZeichensatz.value             = lektionsQuizZeichenSatz.value.sorted(by: { (qz1, qz2) -> Bool in return qz1.status.value == .Correct })
            }
        }
        func filterLektionsQuizSetting(lektion:Lektion?) -> QuizSetting?{
            
            print("muss überdacht werden")
            guard lektion?.quizSetting?.nasalDesAnusvaraPruefe == false  , lektion?.quizSetting?.anusvaraVisargaViramaPruefe  == false else {return lektion?.quizSetting}
            
            //user Einstellungen für Quiz berücksichtigen
            guard let mainSettings  = MainSettings.get()?.angemeldeterUser?.currentMainQuizSetting else { return QuizSetting()}
            return lektion?.quizSetting?.filterNotIn(quizSetting: mainSettings)
        }
    }
    func getQuizModel() -> QuizModel{ return QuizModel(quizZeichenSatz: gewaehlterQuizZeichensatz, quizZeichenInAbfrageIstLeer: quizZeichenInAbfrageIstLeer, isLektionsquiz: selectedSetting.value == .Lektion, currentQuizZeichenStatusHasChanged: currentQuizZeichenStatusHasChanged, konsonantenTypModus: gewaehltesQuizSetting.value?.konsonantTyp.konsonantTypModus) }
}





