 //
//  QuizVC.swift
//  learnDevanagari2
//
//  Created by Matthias Pochmann on 31.10.17.
//  Copyright © 2017 Matthias Pochmann. All rights reserved.
//

import UIKit
import ReactiveSwift

 //MARK: Quiz
 // enthält vier Komponenten:
 // 1) das Zeichenfeld für die Anzeige und Abfrage des DevanagariZeichens
 // 2) das Panel für Abfragen (Umschrift,VokalOderKonsonant, ... )
 // 3) Fortschrittsbalken
 // 4) die Anzeige der von der Texterkennung gefunden Antworten (Zeichnen Devanagari)
class QuizViewModel{
    var dismissToQuizConfigVC:MutableProperty<Void>?  //dismissToQuizConfigVC
    var isLektionsQuiz = false
    var quizModel : QuizModel
    var safeAreaSize = MutableProperty(CGSize.zero)
    
    //MARK: init
    init (quizModel:QuizModel){
        self.quizModel          = quizModel
        self.quizModel.zeilenHoehe      <~ safeAreaSize.producer.map{ QuizViewModel.getZeilenHoehe(for: iPadOrientation?.value, safeAreaSize: $0)}
    }
    
    //MARK: helper
    //ermittelt Zeilenhöhe für das Panel
    // portrait:    3 Zeilen
    // landscape:   7 Zeilen
    private static func getZeilenHoehe(for orientation:IPadOrientation?,safeAreaSize:CGSize) -> CGFloat{
        guard let orientation  = orientation else {return 0}
        switch  orientation {
        case .portrait: return (safeAreaSize.height - safeAreaSize.width) / 3
        default:        return (safeAreaSize.height - ( safeAreaSize.width - safeAreaSize.height )) / 7
        }
    }
    
    //MARK: ViewModels
    func getViewModelForPanel() -> QuizPanelViewModel                           { return QuizPanelViewModel(quizModel:quizModel) }
    func getViewModelForQuizDevaAbfrage()    -> QuizDevaAbfrageViewModel        { return QuizDevaAbfrageViewModel(quizModel:quizModel) }
    func getViewModelForDevaAntwortenStack() -> DevaAntwortenStackViewModel     { return DevaAntwortenStackViewModel(quizModel:quizModel) }
    func getViewModelForFortschrittsbalken() -> QuizFortschrittsbalkenViewModel { return QuizFortschrittsbalkenViewModel(quizModel: quizModel)}
}

class QuizVC: UIViewController {
    var lastSize:CGSize?
    
    var viewModel:QuizViewModel!    {
        didSet{
            //Observiert Änderung der Ausrichtung des Geräts
            // -> passt Orientierung des Stackviews an
            iPadOrientation?.producer.startWithValues{[weak self] orientation in self?.setAxis(iPadOrientation: orientation) }
            //observiert MutableProperty, die immer gesetzt wird, wenn das letzte QuizZeichen richtig beantwortet wurde
            // --> Lektionsquiz: zeigt Mantrafortschritt
            // --> freies Üben: zurück zur Startseite
            viewModel.quizModel.quizZeichenInAbfrageIstLeer.signal.observeValues{[weak self] _ in
                if self?.viewModel.isLektionsQuiz == true   { self?.performSegue(withIdentifier: "goToMantras", sender: nil) }
                else                                        { self?.viewModel.dismissToQuizConfigVC?.value = Void() }
            }
        }
    }
    
    //MARK: IBOutlets
    // vier Komponenten + Stackview
    @IBOutlet weak var mainStack: UIStackView!                                      { didSet { setAxis(iPadOrientation:iPadOrientation?.value) } }
    @IBOutlet weak var quizDevaAbfrage: QuizDevaAbfrageView!                        { didSet { quizDevaAbfrage.viewModel = viewModel?.getViewModelForQuizDevaAbfrage() } }
    @IBOutlet weak var quizPanelView: QuizPanelView!                                { didSet { quizPanelView.viewModel   = viewModel?.getViewModelForPanel() } }
    @IBOutlet weak var vorgeschlageneDevaAntwortenStack: DevaAntwortenStackView!    { didSet { vorgeschlageneDevaAntwortenStack.viewModel = viewModel.getViewModelForDevaAntwortenStack() } }
    @IBOutlet weak var fortschrittsBalken: QuizFortschrittsbalkenView!              { didSet { fortschrittsBalken.viewModel = viewModel.getViewModelForFortschrittsbalken()}}
    
    //MARK: IBAction
    @IBAction private func zurueckButtonPressed(_ sender: UIButton)                 { viewModel.dismissToQuizConfigVC?.value = Void() }
    
    //MARK: LayoutSubviews
    // registriert die Änderung der Ausmaße des Views
    // -> passt Zeilenhöhe für Panelcontrols an
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setSafeAreaSize()
    }
    
    //MARK: helper
    // passt die Ausrichtung des Stackviews an die Orientierung des Geräts an
    private func setAxis(iPadOrientation:IPadOrientation?){
        guard let iPadOrientation = iPadOrientation else {return}
        switch (iPadOrientation){
        case .portrait:                         mainStack?.axis              = .vertical
        default:                                mainStack?.axis              = .horizontal
        }
    }
    //wenn sich die Ausmaße des Views ändern
    // wird die neu Größe in MutableProperty geschrieben
    // -> Zeilenhöhe für Panelcontrols werden angepasst
    private func setSafeAreaSize() {
        let safeAreaSize = view.safeAreaLayoutGuide.layoutFrame.size
        if lastSize     != safeAreaSize{  viewModel.safeAreaSize.value = safeAreaSize }
        lastSize        = safeAreaSize
    }
    
    //MARK: segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { (segue.destination.contentViewController as? MantrasVC)?.dismissToQuizConfigVC = viewModel.dismissToQuizConfigVC }
}



