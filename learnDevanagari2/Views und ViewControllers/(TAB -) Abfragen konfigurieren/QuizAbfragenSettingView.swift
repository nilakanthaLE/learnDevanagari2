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

//QuizAbfragenSetting
// mit diesem Control werden die Abfragen für das Quiz eingestellt
// 1) beim freien Üben bezieht sich die Einstellung auf das kommende einzelne Quiz
// 2) vor der ersten Lektion werden die Abfragen für den gesamten Lektionsdurchlauf festgelegt
class QuizAbfragenSettingViewModel{
    
    //MARK: init
    init(quizSetting: MutableProperty<QuizSetting?>,isFreiesUebensetting:Bool) {
        //isOn setzen
        setIsOn(quizSetting.value)
        //isEnabled setzen
        setIsEnabled(isFreiesUebensetting)
        //update QuizSetting, falls Switchs gesetzt werden
        _ = SignalProducer.combineLatest(propterties).start{ [weak self] _ in if let newSetting = self?.update(quizSetting:quizSetting.value){ quizSetting.value = newSetting } }
    }
    
    //MARK: Mutable Properties
    // isON und isEnabled MutableProperties für switches
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
    
    //MARK: helper
    //isOn setzen
    private func setIsOn (_ quizSetting:QuizSetting?){
        nachZeichnen.value.isOn         = quizSetting?.zeichenfeld                 == .Nachzeichnen || quizSetting?.zeichenfeld == .AbfrageUndNachzeichnen
        devaSchreiben.value.isOn        = quizSetting?.zeichenfeld                 == .InAbfrage || quizSetting?.zeichenfeld == .AbfrageUndNachzeichnen
        umschrift.value.isOn            = quizSetting?.textfeld.modus              == .InAbfrage
        vokalOderKonsonant.value.isOn   = quizSetting?.vokalOderKonsonant.modus    == .InAbfrage
        artikulation.value.isOn         = quizSetting?.artikulation.modus          == .InAbfrage
        konsonantenTyp.value.isOn       = quizSetting?.konsonantTyp.modus          == .InAbfrage
        vokalOderHalbvokal.value.isOn   = quizSetting?.vokalOderHalbvokal.modus    == .InAbfrage
        aspiration.value.isOn           = quizSetting?.aspiration.modus            == .InAbfrage
        stimmhaftigkeit.value.isOn      = quizSetting?.stimmhaftigkeit.modus       == .InAbfrage
    }
    //isEnabled setzen
    private func setIsEnabled(_ isFreiesUeben:Bool){
        guard isFreiesUeben else {return}
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
    //update
    // immer, wenn ein Switch geschalten wird, ändert sich das Quizsetting
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
    //findet für den AbfrageTyp die passende MutableProperty
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
    //bei tap auf Einfach,Medium oder Vollständig,
    // werden die zu dieser Stufe gehörenden Controls gesetzt
    fileprivate func doSwitch(for stufe:AbfrageStufe) {
        set(props: einfache, to: true)
        set(props: mediums, to: stufe == .einfach ? false : true)
        set(props: voll, to: stufe == .voll ? true : false)
    }
    // setzt isOn Status mehrere Properties
    private func set(props:[MutableProperty<SwitchStatus>],to isON:Bool){
        for prop in props { if prop.value.isEnabled { prop.value.isOn = isON } }
    }
}

class QuizAbfragenSettingView: NibLoadingView {
    var viewModel:QuizAbfragenSettingViewModel!{
        didSet{
            iPadOrientation?.signal.observeValues { [weak self] (orientation) in self?.setOrientation(orientation: orientation) }
            initSwitchs()
        }
    }
    //MARK: Outlets
    @IBOutlet weak var mainStack: UIStackView!
    @IBOutlet weak var nachzeichnen:UISwitch!
    @IBOutlet weak var umschrift: UISwitch!
    @IBOutlet weak var vokalOderKonsonant: UISwitch!
    @IBOutlet weak var artikulation: UISwitch!
    @IBOutlet weak var devaSchreiben: UISwitch!
    @IBOutlet weak var konsonantenType: UISwitch!
    @IBOutlet weak var vokalOderHalbvokal: UISwitch!
    @IBOutlet weak var aspiration: UISwitch!
    @IBOutlet weak var stimmhaftigkeit:UISwitch!
    
    //MARK: IBActions (Tap-Gestures)
    @IBAction func tapOnEinfach(_ sender: UITapGestureRecognizer)   { viewModel.doSwitch(for: .einfach) }
    @IBAction func tapOnMedium(_ sender: UITapGestureRecognizer)    { viewModel.doSwitch(for: .medium) }
    @IBAction func tapOnVoll(_ sender: UITapGestureRecognizer)      { viewModel.doSwitch(for: .voll) }

    //MARK: helper
    //setOrientation
    // setzt den Stackview passend zur Ausrichtung des Gerätes
    private func setOrientation(orientation:IPadOrientation?){
        guard let orientation = orientation else {return}
        switch orientation{
        case .landscape:
            mainStack.axis              = .horizontal
            mainStack.distribution      = .fillEqually
            mainStack.alignment         = .firstBaseline
        case .portrait:
            mainStack.axis              = .vertical
            mainStack.distribution      = .fill
            mainStack.alignment         = .fill
        }
    }
    //init switchs
    // verbindet Switch mit passender MutableProperty
    // (für isOn und IsEnabled) aus ViewModel
    private func initSwitchs(){
        func initSwitch(for _switch:UISwitch,abfrage:AbfrageTyp){
            guard let prop = viewModel?.getMutableProperty(for: abfrage) else {return}
            _switch.reactive.isOn       <~ prop.map{$0.isOn}
            _switch.reactive.isEnabled  <~ prop.map{$0.isEnabled}
            prop                        <~ _switch.reactive.isOnValues.map{(isOn:$0,isEnabled:prop.value.isEnabled)}
        }
        initSwitch(for: nachzeichnen,       abfrage: .nachzeichnen)
        initSwitch(for: umschrift,          abfrage: .umschrift)
        initSwitch(for: vokalOderKonsonant, abfrage: .vokalOderKonsonant)
        initSwitch(for: artikulation,       abfrage: .artikulation)
        initSwitch(for: devaSchreiben,      abfrage: .devaSchreiben)
        initSwitch(for: konsonantenType,    abfrage: .konsonantenTyp)
        initSwitch(for: vokalOderHalbvokal, abfrage: .vokalOderHalbVokal)
        initSwitch(for: aspiration,         abfrage: .aspiration)
        initSwitch(for: stimmhaftigkeit,    abfrage: .stimmhaftigkeit)
    }
}


