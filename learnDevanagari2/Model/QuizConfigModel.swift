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

class QuizConfigModel{
    let gesamtZeichenSatz                                                   = Singleton.sharedInstance.zeichenSatz
    let user                                                                = (MainSettings.get()?.angemeldeterUser)!
    
    // die aktuelle Lektion des angemeldeten Users
    var aktuelleLektion                                                     = MutableProperty(0)
    
    // welche Art von Quiz soll gestartet werden? (freies Üben / lektionsQuiz)
    var selectedSetting                                                     = MutableProperty<SelectedSetting?>(nil)
    
    //quizSetting
    private var gewaehltesQuizSetting:MutableProperty<QuizSetting?>         = MutableProperty(nil)
    var freiesUebenQuizSetting:MutableProperty<QuizSetting?>                = MutableProperty(QuizSetting())
    var lektionsQuizSetting:MutableProperty<QuizSetting?>                   = MutableProperty(QuizSetting())
    
    //QuizZeichenSätze
    var gewaehlterQuizZeichensatz                                           = MutableProperty([QuizZeichen]())
    var freiesUebenQuizZeichenSatz                                          = MutableProperty([QuizZeichen]())
    var lektionsQuizZeichenSatz                                             = MutableProperty([QuizZeichen]())

    //Zeichssätze für freies Üben
    var freiesUebenZeichenSatz                                              = MutableProperty([Zeichen]())
    var configZeichensatzGrundauswahl                                       = MutableProperty([Zeichen]())
    var configZeichensatzGewaehltausGrundauswahl                            = MutableProperty([Zeichen]())
    var configZeichensatzGewaehlteLektionen                                 = MutableProperty([Lektion]())
    
    // wird gesetzt, wenn alle QuizZeichen richtig beantwortet wurden
    var quizZeichenInAbfrageIstLeer                                         = MutableProperty(Void())
    
    // trägt Information, ob das Quiz gestartet werden kann
    var canStartQuiz                                                        = MutableProperty(false)
    
    //das aktuelle QuizZeichen hat Veränderungen
    // wird benötigt, um z.B. in der Überblicksanzeige farblich anzuzeigen, dass ein Zeichen richtig beantwortet wurde (= grün)
    var currentQuizZeichenStatusHasChanged:MutableProperty<QuizZeichen?>    = MutableProperty(nil)
    
    init(){
        //Test!
        print("test für Sonderlektionen")
        user.aktuelleLektion = 19
        
        //Einstellungen für die aktuelle Lektion des Users setzen
        setCurrentLektion(user.currentLektion)
        
        // selectedSetting hält die information, welche Art Quiz gestartet werden soll (freies Üben / Lektionsquiz)
        // wenn selectedSetting gesetzt wird, wird der betreffende Zeichensatz und QuizSetting gesetzt
        selectedSetting.signal.observeValues                    {[weak self] selSetting in self?.useSetting(for: selSetting)}
        
        // quizZeichenInAbfrageIstLeer observieren
        // wird gesetzt, wenn alle QuizZeichen richtig beantwortet wurden
        quizZeichenInAbfrageIstLeer.signal.observeValues        { [weak self] _ in self?.quizWurdeAbgeschlossen() }
        
        //UserConfig Freies Üben
        freiesUebenZeichenSatz          <~ configZeichensatzGewaehltausGrundauswahl
        configZeichensatzGrundauswahl   <~ configZeichensatzGewaehlteLektionen.signal.map{Lektion.zeichenSatz(fuer: $0)}
        
        //QuizZeichenSätze generieren
        //freies Ueben - QuizSetting oder ZeichenSatz ändert sich
        freiesUebenQuizZeichenSatz      <~ freiesUebenZeichenSatz.producer.map{[weak self] zeichenSatz in QuizZeichen.createQuizZeichensatz(quizSetting: self?.freiesUebenQuizSetting.value, zeichensatz: zeichenSatz)}
        freiesUebenQuizZeichenSatz      <~ freiesUebenQuizSetting.producer.map{[weak self] quizSetting in return QuizZeichen.createQuizZeichensatz(quizSetting: quizSetting, zeichensatz: self?.freiesUebenZeichenSatz.value)}
        
        //setze canStartValue
        canStartQuiz                    <~ SignalProducer.merge(canStartQuizProducerArray).map{[weak self] _ in self?.pruefeCanStartQuiz() ?? false}
    }
    
    
    //MARK: helper
    // Array von SignalProducer
    // die Veränderung eines jeden Parameters kann dazu führen, dass das Quiz gestartet werden kann
    var canStartQuizProducerArray:[SignalProducer<(), NoError>] {
        return [selectedSetting.producer.combinePrevious().filter{$0.0 != $0.1}.map{_ in ()},
                gewaehlterQuizZeichensatz.producer.combinePrevious().filter{$0.0 != $0.1}.map{_ in ()},
                gewaehltesQuizSetting.producer.combinePrevious().filter{$0.0 != $0.1}.map{_ in ()} ]}
    // setzt Properties für aktuelle Lektion
    private func setCurrentLektion(_ lektion:Lektion?){
        lektionsQuizSetting.value       = filterLektionsQuizSetting(lektion: lektion)
        lektionsQuizZeichenSatz.value   = QuizZeichen.createQuizZeichensatzForLektion(quizSetting:lektionsQuizSetting.value, zeichensatz: lektion?.zeichenSatzBisAktuell)
        aktuelleLektion.value           = lektion?.nummer ?? 0
        user.updateBereitsBekannteControls(quizSetting: lektionsQuizSetting.value)
        user.updateBereitsbekannteLektion()
        //falls beim letzten Mal die App beendet wurde, ohne dass die nächste Lektion initialisiert wurde
        if (lektionsQuizZeichenSatz.value.filter{ $0.status.value != .Correct}).count == 0{
            setCurrentLektion(user.nextLektion())
        }
    }
    // filtert aus dem Lektionsquizsetting die Abfragen heraus,
    // die gemäß des Quizsettings des gesamten Lektionsdurchlaufs nicht abgefragt werden
    private func filterLektionsQuizSetting(lektion:Lektion?) -> QuizSetting?{
        print("muss überdacht werden")
        guard lektion?.quizSetting?.nasalDesAnusvaraPruefe == false  , lektion?.quizSetting?.anusvaraVisargaViramaPruefe  == false else {return lektion?.quizSetting}
        
        //user Einstellungen des aktuellen Lektionsdurchlaufs berücksichtigen
        guard let mainSettings  = MainSettings.get()?.angemeldeterUser?.currentMainQuizSetting else { return QuizSetting()}
        return lektion?.quizSetting?.filterNotIn(quizSetting: mainSettings)
    }
    private func useSetting(for selSetting:SelectedSetting?){
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
    //setzt alle nötigen Einstellungen, sobald ein Quiz (erfolgreich) beendet wurde
    private func quizWurdeAbgeschlossen(){
        if selectedSetting.value == .Lektion        { setCurrentLektion(user.nextLektion()) }               // lektionsquiz:    auf nächste Lektion setzen
        else                                        { freiesUebenZeichenSatz.value = [Zeichen]() }          // freiesÜben:      Zeichensatz zurück setzen
        selectedSetting.value = nil                                                                         // selectedSetting wird zurück auf nil gesetzt  (User muss neu wählen)
    }
    //prüft, ob der User alle nötigen Einstellungen getroffen hat, um das Quiz zu starten
    func pruefeCanStartQuiz() -> Bool
        { return !(selectedSetting.value == nil || gewaehlterQuizZeichensatz.value.count == 0 || gewaehltesQuizSetting.value?.anzahlAbfragen == 0 && gewaehltesQuizSetting.value?.zeichenfeld != .Nachzeichnen || gewaehltesQuizSetting.value == nil) }
    
    //MARK: QuizModel generieren
    func getQuizModel() -> QuizModel{
        return QuizModel(quizZeichenSatz:                       gewaehlterQuizZeichensatz,
                         quizZeichenInAbfrageIstLeer:           quizZeichenInAbfrageIstLeer,
                         isLektionsquiz:                        selectedSetting.value == .Lektion,
                         currentQuizZeichenStatusHasChanged:    currentQuizZeichenStatusHasChanged,
                         konsonantenTypModus:                   gewaehltesQuizSetting.value?.konsonantTyp.konsonantTypModus)
    }
}





