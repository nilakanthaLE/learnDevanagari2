//
//  ConfigZeichensatzVC.swift
//  learnDevanagari2
//
//  Created by Matthias Pochmann on 19.11.17.
//  Copyright © 2017 Matthias Pochmann. All rights reserved.
//

import UIKit
import ReactiveSwift

enum ZeichenAuswahlTyp:Int{
    case Zufall = 0
    case SeltenGeuebt = 1
    case HauefigFalsch = 2
}

class ConfigZeichensatzViewModel{
    var quizConfigModel:QuizConfigModel
    init(quizConfigModel:QuizConfigModel){
        self.quizConfigModel = quizConfigModel
        
        
        anzahlAusGrundauswahl.value         = quizConfigModel.configZeichensatzGewaehltausGrundauswahl.value.count

        quizConfigModel.freiesUebenZeichenSatz          <~ gewaehltAusGrundauswahl
        
        grundAuswahl                                    <~ quizConfigModel.configZeichensatzGrundauswahl
        gewaehltAusGrundauswahl                         <~ quizConfigModel.configZeichensatzGewaehltausGrundauswahl
        
        //anzahlGrundauswahl wird von User per Slider gesetzt
        //user wählt ZeichenAuswahlTyp
        //--> Zeichensatz bestimmen
        anzahlAusGrundauswahl   <~ grundAuswahl.signal.filter{[weak self] grundauswahl in grundauswahl.count < self?.anzahlAusGrundauswahl.value ?? 0}.map{$0.count}
        
        
        basisZeichensatzFuerZeichenAuswahlTyp                       <~ zeichenAuswahlTyp.signal.map {[weak self] zeichenAuswahlTyp in
            Zeichen.sortZeichenSatz(aus: self?.grundAuswahl.value, user: MainSettings.get()?.angemeldeterUser, zeichenAuswahlTyp: zeichenAuswahlTyp)}
        quizConfigModel.configZeichensatzGewaehltausGrundauswahl    <~ basisZeichensatzFuerZeichenAuswahlTyp.signal.map{[weak self] basisZeichenSatz in
            let anzahl = self?.anzahlAusGrundauswahl.value ?? 0
            return Array(basisZeichenSatz.prefix(anzahl))
        }
        quizConfigModel.configZeichensatzGewaehltausGrundauswahl    <~ anzahlAusGrundauswahl.signal.map{[weak self] anzahl in
            
            
            let basisZeichenSatz = self?.basisZeichensatzFuerZeichenAuswahlTyp.value ?? [Zeichen]()
            return Array(basisZeichenSatz.prefix(anzahl))
        }
    }
    
    //Mutable Properties
    var grundAuswahl            = MutableProperty([Zeichen]())
    var gewaehltAusGrundauswahl = MutableProperty([Zeichen]())
    var anzahlAusGrundauswahl   = MutableProperty(0)
    
    var basisZeichensatzFuerZeichenAuswahlTyp = MutableProperty([Zeichen]())
    
    
    
    fileprivate var zeichenAuswahlTyp       = MutableProperty(ZeichenAuswahlTyp.Zufall)
    
    func getViewModelForZeichensatzInAbfrageView() -> AbfrageZeichenViewModelProtocol{
        return ZeichenAuswahlConfigViewModel.init(configZeichensatzGrundauswahl: quizConfigModel.configZeichensatzGrundauswahl, configZeichensatzGewaehltausGrundauswahl: quizConfigModel.configZeichensatzGewaehltausGrundauswahl)
    }
    func getViewModelForGrundauswahlPopoverVC() -> GrundauswahlPopoverViewModel{
        return GrundauswahlPopoverViewModel(configZeichensatzGewaehlteLektionen: quizConfigModel.configZeichensatzGewaehlteLektionen, gesamtZeichensatz: quizConfigModel.gesamtZeichenSatz)
    }
}

class ConfigZeichensatzVC: UIViewController {
    var viewModel:ConfigZeichensatzViewModel!
    override func viewDidLoad() {
        viewModel.anzahlAusGrundauswahl         <~ slider.reactive.values.producer.map{Int($0.rounded())}
        slider.reactive.maximumValue            <~ viewModel.grundAuswahl.producer.map{Float($0.count)}
        slider.reactive.value                   <~ viewModel.anzahlAusGrundauswahl.producer.map{Float($0)}
        
        //Button Actions
        viewModel.zeichenAuswahlTyp             <~ segmentedControl.reactive.controlEvents(UIControlEvents.valueChanged).map{ZeichenAuswahlTyp(rawValue: $0.selectedSegmentIndex) ?? ZeichenAuswahlTyp.Zufall}
    }
    

    
    //Outlets
    @IBOutlet weak var zeichenInAbfrageView: ZeichenInAbfrageView!{ didSet{ zeichenInAbfrageView.viewModel = viewModel.getViewModelForZeichensatzInAbfrageView() } }
    @IBOutlet weak var auswahlView: UIView!     { didSet{ setBorder(for: auswahlView) } }
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    //helper
    private func setBorder(for view:UIView){
        view.layer.borderColor = UIColor.darkGray.cgColor
        view.layer.borderWidth = 2.0
    }
    
    //MARK: segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        (segue.destination.contentViewController as? GrundauswahlPopoverVC)?.viewModel = viewModel.getViewModelForGrundauswahlPopoverVC()
    }
}
