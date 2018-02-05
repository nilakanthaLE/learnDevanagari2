//
//  ConfigZeichensatzVC.swift
//  learnDevanagari2
//
//  Created by Matthias Pochmann on 19.11.17.
//  Copyright © 2017 Matthias Pochmann. All rights reserved.
//

import UIKit
import ReactiveSwift

//MARK: ConfigZeichensatzViewModel
// ViewModel für Konfigurierung des Zeichensatzes fürs freie Üben
class ConfigZeichensatzViewModel{
    //MARK: Mutable Properties
    // Zeichensätze
    fileprivate var anzahlAusGrundauswahl                   = MutableProperty(0)
    fileprivate var grundAuswahl                            = MutableProperty([Zeichen]())
    fileprivate var gewaehltAusGrundauswahl                 = MutableProperty([Zeichen]())
    fileprivate var basisZeichensatzFuerZeichenAuswahlTyp   = MutableProperty([Zeichen]())
    // ZeichenauswahlTyp (Zufall / selten geübt / häufig falsch)
    fileprivate var zeichenAuswahlTyp:MutableProperty<ZeichenAuswahlTyp>
    fileprivate var gewaehlteLektionen:MutableProperty<[Lektion]>
    //MARK: init
    init(quizConfigModel:QuizConfigModel){
        //INITIALE WERTE
        zeichenAuswahlTyp                   = quizConfigModel.configZeichensatzZeichenAuswahlTyp
        gewaehlteLektionen                  = quizConfigModel.configZeichensatzGewaehlteLektionen
        //grundAuswahl
        // .count bestimmt den maximalwert des Silders
        // wird im PopoverMenu eingestellt
        grundAuswahl                        = quizConfigModel.configZeichensatzGrundauswahl
        //gewählt aus Grundauswahl
        // wird per slider und zeichenAuswahlTyp konfiguriert
        // entspricht dem Zeichensatz fürs freie Üben
        gewaehltAusGrundauswahl             = quizConfigModel.freiesUebenZeichenSatz
        //anzahl aus Grundauswahl
        // entspricht initial der Anzahl von gewaehltAusGrundauswahl
        anzahlAusGrundauswahl.value         = gewaehltAusGrundauswahl.value.count
        
        //basisZeichensatzFuerZeichenAuswahlTyp
        // der zeichenAuswahlTyp (Zufall / selten geübt / häufig falsch) wird per SegmentedControl gesetzt
        // dadurch wird die ZeichenGrundauswahl gemäß dem eingestellten Kriterium  sortiert
        basisZeichensatzFuerZeichenAuswahlTyp       <~ zeichenAuswahlTyp.producer.map { Zeichen.sortZeichenSatz(aus: quizConfigModel.configZeichensatzGrundauswahl.value, user: MainSettings.get()?.angemeldeterUser, zeichenAuswahlTyp: $0)}
        //gewählt aus Grundauswahl bzw. freiesUebenZeichenSatz wird gesetzt:
        // 1) wenn sich der zeichenAuswahlTyp und mit diesem der basisZeichensatzFuerZeichenAuswahlTyp ändert
        // 2) wenn die anzahlAusGrundauswahl per slider gesetzt wird
        gewaehltAusGrundauswahl                     <~ basisZeichensatzFuerZeichenAuswahlTyp.signal.map { Array($0.prefix(quizConfigModel.freiesUebenZeichenSatz.value.count)) }
        gewaehltAusGrundauswahl                     <~ anzahlAusGrundauswahl.signal.map {[weak self] anzahl in return Array((self?.basisZeichensatzFuerZeichenAuswahlTyp.value ?? [Zeichen]()).prefix(anzahl)) }
    }
    
    //MARK: ViewModels
    func getViewModelForZeichensatzInAbfrageView()  -> ZeichenImQuadratViewModelProtocol    { return ZeichenAuswahlConfigViewModel.init(grundauswahl: grundAuswahl, gewaehltausGrundauswahl: gewaehltAusGrundauswahl) }
    func getViewModelForGrundauswahlPopoverVC()     -> GrundauswahlPopoverViewModel         { return GrundauswahlPopoverViewModel(configZeichensatzGewaehlteLektionen: gewaehlteLektionen) }
}

//MARK: ConfigZeichensatzViewController
class ConfigZeichensatzVC: UIViewController {
    var viewModel:ConfigZeichensatzViewModel!
    
    //MARK: ViewController LifeCycle
    override func viewDidLoad() {
        //Slider
        viewModel.anzahlAusGrundauswahl         <~ slider.reactive.values.producer.map          {Int($0.rounded())}
        slider.reactive.maximumValue            <~ viewModel.grundAuswahl.producer.map          {Float($0.count)}
        slider.reactive.value                   <~ viewModel.anzahlAusGrundauswahl.producer.map {Float($0)}
        
        //Segmented Control
        viewModel.zeichenAuswahlTyp                     <~ segmentedControl.reactive.controlEvents(UIControlEvents.valueChanged).map{ZeichenAuswahlTyp(rawValue: $0.selectedSegmentIndex) ?? ZeichenAuswahlTyp.Zufall}
        segmentedControl.reactive.selectedSegmentIndex  <~ viewModel.zeichenAuswahlTyp.producer.map{$0.rawValue}
    }
    
    //MARK: Outlets
    @IBOutlet weak var zeichenInAbfrageView: ZeichenImQuadratView!  { didSet{ zeichenInAbfrageView.viewModel = viewModel.getViewModelForZeichensatzInAbfrageView() } }
    @IBOutlet weak var auswahlView: UIView!                         { didSet{ setBorder(for: auswahlView) } }
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    //MARK: helper
    private func setBorder(for view:UIView){
        view.layer.borderColor = UIColor.darkGray.cgColor
        view.layer.borderWidth = 2.0
    }
    
    //MARK: segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        (segue.destination.contentViewController as? GrundauswahlPopoverVC)?.viewModel = viewModel.getViewModelForGrundauswahlPopoverVC()
    }
}



