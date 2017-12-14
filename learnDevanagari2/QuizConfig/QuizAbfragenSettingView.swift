//
//  QuizAbfragenSettingVC.swift
//  learnDevanagari2
//
//  Created by Matthias Pochmann on 08.11.17.
//  Copyright © 2017 Matthias Pochmann. All rights reserved.
//

import UIKit
import ReactiveSwift



class QuizAbfragenSettingViewModel{
    var iPadOrientation = (UIApplication.shared.delegate as? AppDelegate)?.iPadOrientation
    var quizSetting:MutableProperty<QuizSetting?>
    init(quizSetting: MutableProperty<QuizSetting?>) {
        self.quizSetting    = quizSetting
        
        nachZeichnen.value              = quizSetting.value?.zeichenfeld                 == .Nachzeichnen || quizSetting.value?.zeichenfeld == .AbfrageUndNachzeichnen
        umschrift.value                 = quizSetting.value?.textfeld.modus              == .InAbfrage
        vokalOderKonsonant.value        = quizSetting.value?.vokalOderKonsonant.modus    == .InAbfrage
        artikulation.value              = quizSetting.value?.artikulation.modus          == .InAbfrage
        devaSchreiben.value             = quizSetting.value?.zeichenfeld                 == .InAbfrage || quizSetting.value?.zeichenfeld == .AbfrageUndNachzeichnen
        konsonantenTyp.value            = quizSetting.value?.konsonantTyp.modus          == .InAbfrage
        vokalOderHalbvokal.value        = quizSetting.value?.vokalOderHalbvokal.modus    == .InAbfrage
        aspiration.value                = quizSetting.value?.aspiration.modus            == .InAbfrage
        stimmhaftigkeit.value           = quizSetting.value?.stimmhaftigkeit.modus       == .InAbfrage
        
        _ = SignalProducer.combineLatest(propterties).start{ [weak self] _ in
            if let newSetting = self?.update(quizSetting:self?.quizSetting.value){
                self?.quizSetting.value = newSetting
            }
        }
    }
    
    
    
    var nachZeichnen        = MutableProperty(false)
    var umschrift           = MutableProperty(false)
    var einfache:[MutableProperty<Bool>]{return [nachZeichnen,umschrift]}
    
    var vokalOderKonsonant  = MutableProperty(false)
    var artikulation        = MutableProperty(false)
    var mediums:[MutableProperty<Bool>]{return [vokalOderKonsonant,artikulation]}
    
    var devaSchreiben       = MutableProperty(false)
    var konsonantenTyp      = MutableProperty(false)
    var vokalOderHalbvokal  = MutableProperty(false)
    
    
    var aspiration          = MutableProperty(false)
    var stimmhaftigkeit     = MutableProperty(false)
    var voll:[MutableProperty<Bool>]{return [devaSchreiben,vokalOderHalbvokal,konsonantenTyp,aspiration,stimmhaftigkeit]}
    
    var propterties:[MutableProperty<Bool>] {return [nachZeichnen,umschrift,vokalOderKonsonant,artikulation,devaSchreiben,konsonantenTyp,aspiration,stimmhaftigkeit]}
    
    
    private func update(quizSetting:QuizSetting?) -> QuizSetting?{
        var quizSetting = quizSetting
        quizSetting?.zeichenfeld                = devaSchreiben.value && nachZeichnen.value ? .AbfrageUndNachzeichnen : devaSchreiben.value ? .InAbfrage :  nachZeichnen.value ? .Nachzeichnen : .NurAnzeige
        quizSetting?.textfeld.modus             = umschrift.value           ? .InAbfrage : .NurAnzeige
        quizSetting?.vokalOderKonsonant.modus   = vokalOderKonsonant.value  ? .InAbfrage : .NurAnzeige
        quizSetting?.vokalOderHalbvokal.modus   = vokalOderHalbvokal.value  ? .InAbfrage : .NurAnzeige
        quizSetting?.artikulation.modus         = artikulation.value        ? .InAbfrage : .NurAnzeige
        quizSetting?.konsonantTyp.modus         = konsonantenTyp.value      ? .InAbfrage : .NurAnzeige
        quizSetting?.aspiration.modus           = aspiration.value          ? .InAbfrage : .NurAnzeige
        quizSetting?.stimmhaftigkeit.modus      = stimmhaftigkeit.value     ? .InAbfrage : .NurAnzeige
        quizSetting?.konsonantTyp.konsonantTypModus = .Hauchlaut
        
        return quizSetting
    }
    
    
    func getMutableProperty(for abfrage:AbfrageTyp?) -> MutableProperty<Bool>?{
        guard let abfrage = abfrage else {return nil}
        switch abfrage {
        case .nachzeichnen:         return nachZeichnen
        case .umschrift:            return umschrift
        case .vokalOderKonsonant:   return vokalOderKonsonant
        case .artikulation:         return artikulation
        case .devaSchreiben:        return devaSchreiben
        case .konsonantenTyp:       return konsonantenTyp
        case .aspiration:           return aspiration
        case .stimmhaftigkeit :     return stimmhaftigkeit
        case .vokalOderHalbVokal:   return vokalOderHalbvokal
        }
    }
    func doSwitch(for stufe:AbfrageStufe,to isOn:Bool){
        func set(props:[MutableProperty<Bool>],to isON:Bool){ for prop in props {prop.value = isOn} }
        switch stufe {
        case .einfach: set(props: einfache, to: isOn)
        case .medium: set(props: mediums, to: isOn)
        case .voll: set(props: voll, to: isOn)
        }
    }
    
    
}

class QuizAbfragenSettingView: NibLoadingView {
    var viewModel:QuizAbfragenSettingViewModel!{
        didSet{
            viewModel.iPadOrientation?.signal.observeValues { [weak self] (orientation) in
                guard let orientation = orientation else {return}
                switch orientation{
                case .landscape:
                    self?.mainStack.axis            = .horizontal
                    self?.mainStack.distribution    = .fillEqually
                    self?.mainStack.alignment       = .firstBaseline
                case .portrait:
                    self?.mainStack.axis = .vertical
                    self?.mainStack.distribution    = .fill
                    self?.mainStack.alignment       = .fill
                }
            }
            initSwitchs(for: nachzeichnen, abfrage: .nachzeichnen)
            initSwitchs(for: umschrift, abfrage: .umschrift)
            initSwitchs(for: vokalOderKonsonant, abfrage: .vokalOderKonsonant)
            initSwitchs(for: artikulation, abfrage: .artikulation)
            initSwitchs(for: devaSchreiben, abfrage: .devaSchreiben)
            initSwitchs(for: konsonantenType, abfrage: .konsonantenTyp)
            initSwitchs(for: vokalOderHalbvokal, abfrage: .vokalOderHalbVokal)
            initSwitchs(for: aspiration, abfrage: .aspiration)
            initSwitchs(for: stimmhaftigkeit, abfrage: .stimmhaftigkeit)
        }
    }
    
    @IBOutlet weak var mainStack: UIStackView!
    @IBOutlet var nachzeichnen: [UISwitch]!         //{ didSet{ initSwitchs(for: nachzeichnen, abfrage: .nachzeichnen) } }
    @IBOutlet var umschrift: [UISwitch]!            //{ didSet{ initSwitchs(for: umschrift, abfrage: .umschrift) } }
    
    @IBOutlet var vokalOderKonsonant: [UISwitch]!   //{ didSet{ initSwitchs(for: vokalOderKonsonant, abfrage: .vokalOderKonsonant) } }
    @IBOutlet var artikulation: [UISwitch]!         //{ didSet{ initSwitchs(for: artikulation, abfrage: .artikulation) } }
    
    @IBOutlet var devaSchreiben: [UISwitch]!        //{ didSet{ initSwitchs(for: devaSchreiben, abfrage: .devaSchreiben) } }
    @IBOutlet var konsonantenType: [UISwitch]!      //{ didSet{ initSwitchs(for: konsonantenType, abfrage: .konsonantenTyp) } }
    @IBOutlet var vokalOderHalbvokal: [UISwitch]!   //{ didSet{ initSwitchs(for: vokalOderHalbvokal, abfrage: .vokalOderHalbVokal) } }
    @IBOutlet var aspiration: [UISwitch]!           //{ didSet{ initSwitchs(for: aspiration, abfrage: .aspiration) } }
    @IBOutlet var stimmhaftigkeit: [UISwitch]!      //{ didSet{ initSwitchs(for: stimmhaftigkeit, abfrage: .stimmhaftigkeit) } }
    
    
    @IBAction func tapOnEinfach(_ sender: UITapGestureRecognizer) {
        viewModel.doSwitch(for: .einfach, to: true)
        viewModel.doSwitch(for: .medium, to: false)
        viewModel.doSwitch(for: .voll, to: false)
    }
    @IBAction func tapOnMedium(_ sender: UITapGestureRecognizer) {
        viewModel.doSwitch(for: .einfach, to: true)
        viewModel.doSwitch(for: .medium, to: true)
        viewModel.doSwitch(for: .voll, to: false)
    }
    @IBAction func tapOnVoll(_ sender: UITapGestureRecognizer) {
        viewModel.doSwitch(for: .einfach, to: true)
        viewModel.doSwitch(for: .medium, to: true)
        viewModel.doSwitch(for: .voll, to: true)
    }
    //helper
    private func initSwitchs(for switchs:[UISwitch],abfrage:AbfrageTyp){
        for iSwitch in switchs{
            guard let prop = viewModel?.getMutableProperty(for: abfrage) else {return}
            iSwitch.reactive.isOn   <~ prop
            prop                    <~ iSwitch.reactive.isOnValues
        }
    }
}

enum AbfrageStufe{case einfach,medium,voll}


enum AbfrageTyp{
    case nachzeichnen
    case umschrift
    case vokalOderKonsonant
    case artikulation
    
    case devaSchreiben
    case konsonantenTyp
    
    case aspiration
    case stimmhaftigkeit
    case vokalOderHalbVokal
}
