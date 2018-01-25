//
//  QuizAbfragenSettingVC.swift
//  learnDevanagari2
//
//  Created by Matthias Pochmann on 08.11.17.
//  Copyright © 2017 Matthias Pochmann. All rights reserved.
//

import UIKit
import ReactiveSwift


fileprivate typealias SwitchStatus = (isOn:Bool,isEnabled:Bool)

class QuizAbfragenSettingViewModel{
    var iPadOrientation = (UIApplication.shared.delegate as? AppDelegate)?.iPadOrientation
    var quizSetting:MutableProperty<QuizSetting?>
    var isFreiesUebensetting:Bool
    init(quizSetting: MutableProperty<QuizSetting?>,isFreiesUebensetting:Bool) {
        self.quizSetting            = quizSetting
        self.isFreiesUebensetting   = isFreiesUebensetting
        
        //isOn setzen
        nachZeichnen.value.isOn              = quizSetting.value?.zeichenfeld                 == .Nachzeichnen || quizSetting.value?.zeichenfeld == .AbfrageUndNachzeichnen
        umschrift.value.isOn                 = quizSetting.value?.textfeld.modus              == .InAbfrage
        vokalOderKonsonant.value.isOn        = quizSetting.value?.vokalOderKonsonant.modus    == .InAbfrage
        artikulation.value.isOn              = quizSetting.value?.artikulation.modus          == .InAbfrage
        devaSchreiben.value.isOn             = quizSetting.value?.zeichenfeld                 == .InAbfrage || quizSetting.value?.zeichenfeld == .AbfrageUndNachzeichnen
        konsonantenTyp.value.isOn            = quizSetting.value?.konsonantTyp.modus          == .InAbfrage
        vokalOderHalbvokal.value.isOn        = quizSetting.value?.vokalOderHalbvokal.modus    == .InAbfrage
        aspiration.value.isOn                = quizSetting.value?.aspiration.modus            == .InAbfrage
        stimmhaftigkeit.value.isOn           = quizSetting.value?.stimmhaftigkeit.modus       == .InAbfrage
        
        //update QuizSetting, falls Switchs gesetzt werden
        _ = SignalProducer.combineLatest(propterties).start{ [weak self] _ in
            if let newSetting = self?.update(quizSetting:self?.quizSetting.value){ self?.quizSetting.value = newSetting }
        }
        
        //isEnabled setzen
        if isFreiesUebensetting         {
            let bekannteControls  = MainSettings.get()?.angemeldeterUser?.bekannteControls ?? Set<ControlTyp>()
            nachZeichnen.value.isEnabled        = AbfrageTyp.umschrift.isEnabled(for: bekannteControls)
            umschrift.value.isEnabled           = AbfrageTyp.umschrift.isEnabled(for: bekannteControls)
            vokalOderKonsonant.value.isEnabled  = AbfrageTyp.vokalOderKonsonant.isEnabled(for: bekannteControls)
            artikulation.value.isEnabled        = AbfrageTyp.artikulation.isEnabled(for: bekannteControls)
            devaSchreiben.value.isEnabled       = AbfrageTyp.devaSchreiben.isEnabled(for: bekannteControls)
            konsonantenTyp.value.isEnabled      = AbfrageTyp.konsonantenTyp.isEnabled(for: bekannteControls)
            vokalOderHalbvokal.value.isEnabled  = AbfrageTyp.vokalOderHalbVokal.isEnabled(for: bekannteControls)
            aspiration.value.isEnabled          = AbfrageTyp.aspiration.isEnabled(for: bekannteControls)
            stimmhaftigkeit.value.isEnabled     = AbfrageTyp.stimmhaftigkeit.isEnabled(for: bekannteControls)
        }
    }
    
    
    fileprivate var nachZeichnen        = MutableProperty((isOn:false,isEnabled:true))
    fileprivate var umschrift           = MutableProperty((isOn:false,isEnabled:true))
    fileprivate var einfache:[MutableProperty<SwitchStatus>]{return [nachZeichnen,umschrift]}
    
    fileprivate var vokalOderKonsonant  = MutableProperty((isOn:false,isEnabled:true))
    fileprivate var artikulation        = MutableProperty((isOn:false,isEnabled:true))
    fileprivate var mediums:[MutableProperty<SwitchStatus>]{return [vokalOderKonsonant,artikulation]}
    
    fileprivate var devaSchreiben       = MutableProperty((isOn:false,isEnabled:true))
    fileprivate var konsonantenTyp      = MutableProperty((isOn:false,isEnabled:true))
    fileprivate var vokalOderHalbvokal  = MutableProperty((isOn:false,isEnabled:true))
    
    
    fileprivate var aspiration          = MutableProperty((isOn:false,isEnabled:true))
    fileprivate var stimmhaftigkeit     = MutableProperty((isOn:false,isEnabled:true))
    fileprivate var voll:[MutableProperty<SwitchStatus>]{return [devaSchreiben,vokalOderHalbvokal,konsonantenTyp,aspiration,stimmhaftigkeit]}
    
    fileprivate var propterties:[MutableProperty<SwitchStatus>] {return [nachZeichnen,umschrift,vokalOderKonsonant,artikulation,devaSchreiben,konsonantenTyp,aspiration,stimmhaftigkeit]}
    
    
    private func update(quizSetting:QuizSetting?) -> QuizSetting?{    
        var quizSetting = quizSetting
        quizSetting?.zeichenfeld                = devaSchreiben.value.isOn && nachZeichnen.value.isOn ? .AbfrageUndNachzeichnen : devaSchreiben.value.isOn ? .InAbfrage :  nachZeichnen.value.isOn ? .Nachzeichnen : .NurAnzeige
        quizSetting?.textfeld.modus             = umschrift.value.isOn           ? .InAbfrage : umschrift.value.isEnabled ? .NurAnzeige : .Versteckt
        quizSetting?.vokalOderKonsonant.modus   = vokalOderKonsonant.value.isOn  ? .InAbfrage : vokalOderKonsonant.value.isEnabled ? .NurAnzeige : .Versteckt
        quizSetting?.vokalOderHalbvokal.modus   = vokalOderHalbvokal.value.isOn  ? .InAbfrage : vokalOderHalbvokal.value.isEnabled ? .NurAnzeige : .Versteckt
        quizSetting?.artikulation.modus         = artikulation.value.isOn        ? .InAbfrage : artikulation.value.isEnabled ? .NurAnzeige : .Versteckt
        quizSetting?.konsonantTyp.modus         = konsonantenTyp.value.isOn      ? .InAbfrage : konsonantenTyp.value.isEnabled ? .NurAnzeige : .Versteckt
        quizSetting?.aspiration.modus           = aspiration.value.isOn          ? .InAbfrage : aspiration.value.isEnabled ? .NurAnzeige : .Versteckt
        quizSetting?.stimmhaftigkeit.modus      = stimmhaftigkeit.value.isOn     ? .InAbfrage : stimmhaftigkeit.value.isEnabled ? .NurAnzeige : .Versteckt
        quizSetting?.konsonantTyp.konsonantTypModus = .Hauchlaut
        
        return quizSetting
    }
    
    
    fileprivate func getMutableProperty(for abfrage:AbfrageTyp?) -> MutableProperty<SwitchStatus>?{
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
    fileprivate func doSwitch(for stufe:AbfrageStufe,to isOn:Bool){
        func set(props:[MutableProperty<SwitchStatus>],to isON:Bool){
            for prop in props {
                if prop.value.isEnabled { prop.value.isOn = isOn }
            }
        }
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
    @IBOutlet var nachzeichnen: [UISwitch]!
    @IBOutlet var umschrift: [UISwitch]!
    
    @IBOutlet var vokalOderKonsonant: [UISwitch]!
    @IBOutlet var artikulation: [UISwitch]!
    @IBOutlet var devaSchreiben: [UISwitch]!
    @IBOutlet var konsonantenType: [UISwitch]!
    @IBOutlet var vokalOderHalbvokal: [UISwitch]!
    @IBOutlet var aspiration: [UISwitch]!
    @IBOutlet var stimmhaftigkeit: [UISwitch]!      
    
    
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
            iSwitch.reactive.isOn       <~ prop.map{$0.isOn}
            prop                        <~ iSwitch.reactive.isOnValues.map{(isOn:$0,isEnabled:prop.value.isEnabled)}
            iSwitch.reactive.isEnabled  <~ prop.map{$0.isEnabled}
        }
    }
}

fileprivate enum AbfrageStufe{case einfach,medium,voll}


fileprivate enum AbfrageTyp{
    case nachzeichnen
    case umschrift
    case vokalOderKonsonant
    case artikulation
    
    case devaSchreiben
    case konsonantenTyp
    
    case aspiration
    case stimmhaftigkeit
    case vokalOderHalbVokal
    
    var controlTyp:ControlTyp{
        switch self {
        case .nachzeichnen:         return .ZeichenfeldTyp
        case .umschrift:            return .TextfeldTyp
        case .vokalOderKonsonant:   return .VokalOderKonsonantTyp
        case .artikulation:         return .ArtikulationTyp
        case .devaSchreiben:        return .ZeichenfeldTyp
        case .konsonantenTyp:       return .KonsonantTyp
        case .aspiration:           return .AspirationTyp
        case .stimmhaftigkeit:      return .StimmhaftigkeitTyp
        case .vokalOderHalbVokal:   return .VokalOderHalbvokalTyp
        }

    }
    
    func isEnabled(for bekannteControls:Set<ControlTyp>) -> Bool{
        guard self != .nachzeichnen else { return true}
        return bekannteControls.contains(self.controlTyp)
    }
}
