//
//  QuizPanelView.swift
//  learnDevanagari2
//
//  Created by Matthias Pochmann on 31.10.17.
//  Copyright © 2017 Matthias Pochmann. All rights reserved.
//
import UIKit
import ReactiveSwift



//MARK: ViewModel
class QuizPanelViewModel{
    var iPadOrientation = (UIApplication.shared.delegate as? AppDelegate)?.iPadOrientation
    var quizModel : QuizModel
    
    var controlSettings  = QuizSetting().allePanelControls //alle Controls
    init (quizModel:QuizModel){ self.quizModel      = quizModel }
    
    //MARK: ViewModels
    func getViewModel(for controlSetting:PanelControlSetting) -> PanelControlViewModel{ return getControlViewModelClass(for: controlSetting).init(controlSetting: controlSetting,quizModel: quizModel) }
    func getViewModelForPruefenButton() -> QuizPruefenButtonViewModel   { return  QuizPruefenButtonViewModel(quizModel: quizModel) }
    func getControlViewModelClass (for controlSetting:PanelControlSetting) -> PanelControlViewModel.Type{
        switch controlSetting.controlTyp {
        case .ArtikulationTyp:     return QuizArtikulationPickerViewModel.self
        case .TextfeldTyp:         return QuizTextFeldViewModel.self
        default:                return MultiTouchButtonViewModel.self
        }
    }
}

//MARK:View
class QuizPanelView: UIStackView {
    var controls = [PanelControlProtocol]()
    let pruefenButton =  QuizPruefenButton()
    var viewModel:QuizPanelViewModel!{
        didSet{
            axis            = .vertical
            distribution    = .fill
            
            pruefenButton.viewModel = viewModel.getViewModelForPruefenButton()
            
            setControls()
            viewModel.iPadOrientation?.producer.startWithValues     { [weak self](orientation) in self?.arrange(controls:self?.controls, for: orientation) }
        }
    }
    
    func setControls(){
        //remove all Subviews
        for view in arrangedSubviews {
            for _view in (view as? UIStackView)?.arrangedSubviews ?? [UIView](){  _view.removeFromSuperview() }
            view.removeFromSuperview()
        }
        controls = getControlArray(settings: viewModel.controlSettings)
        arrange(controls:controls, for: viewModel.iPadOrientation?.value)
    }
    
    func arrange(controls:[PanelControlProtocol]?,for orientation:IPadOrientation?){
        guard let orientation = orientation,let controls = controls else {return}
        for control in controls         { control.view.removeFromSuperview() }
        for stack in arrangedSubviews   { stack.removeFromSuperview() }
        pruefenButton.removeFromSuperview()
        
        switch orientation {
        case .landscape:
            axis            = .vertical
            distribution    = .fill
            alignment       = .fill
            for control in controls {addArrangedSubview(control.view)}
            addArrangedSubview(UIView())
            addArrangedSubview(pruefenButton)
        case .portrait:
            axis            = .horizontal
            distribution    = .fillEqually
            var stack:UIStackView{
                let _stack = UIStackView()
                _stack.axis          = .vertical
                _stack.distribution  = .fill
                addArrangedSubview(_stack)
                return _stack
            }
            let stacks = [stack,stack,stack]
            for control in controls{
                let col = control.viewModel.controlTyp.placeInArray(for: .portrait)?.column ?? 0
                stacks[col].addArrangedSubview(control.view)
            }
            stacks[0].addArrangedSubview(UIView())
            stacks[1].addArrangedSubview(UIView())
            stacks[2].addArrangedSubview(UIView())
            stacks[2].insertArrangedSubview(pruefenButton, at: 0)
        }
    }
    func getControlArray(settings:[PanelControlSetting]?) -> [PanelControlProtocol]{
        guard let settings = settings else {return [PanelControlProtocol]()}
        var array =  [PanelControlProtocol]()
        for controlSetting in settings{
            let control         = getControl(for: controlSetting)
            control.viewModel   = viewModel.getViewModel(for: controlSetting)
            array.append(control)
        }
        return array
    }
    func getControl(for controlSetting:PanelControlSetting) -> PanelControlProtocol{
        switch controlSetting.controlTyp {
        case .ArtikulationTyp: return QuizArtikulationPicker()
        case .TextfeldTyp:     return QuizTextFeld()
        default:            return MultiTouchButton()
        }
    }
}


//MARK: Extensions
protocol ControlViewModel {
    var controlCurrentModus:MutableProperty<ControlCurrentModus> {get set}
    
}
protocol PanelControlViewModelProtocol:ControlViewModel {
    var isHidden:MutableProperty<Bool> {get set}
    var zeilenHoehe:MutableProperty<CGFloat> {get set}
    var userEingabe:MutableProperty<String?> {get set}
    init(controlSetting:PanelControlSetting,quizModel:QuizModel)
}
extension PanelControlViewModelProtocol{
    //Model Interaktionen
    func isHidden(controlCurrentModus:ControlCurrentModus ,usereingabe:UserAntwortZeichen?, controlTyp:ControlTyp, controlModus: PanelControlModus?, korrekteAntwort:Zeichen?, vokalOderKonsShowsAnswer: PanelControlModus? ) -> Bool{
        guard let usereingabe = usereingabe, controlCurrentModus != .Versteckt, controlModus != .Versteckt else {return true}
        
        
        
        let wirdGeprueft = controlCurrentModus == .ShowsPruefergebnis
        
        let showsAnswer             = vokalOderKonsShowsAnswer == .NurAnzeige && controlModus == .NurAnzeige // nur wenn showsAnswer / selected von vokal oder Konsonant
        let vokalForShowsAnswer     = showsAnswer ? korrekteAntwort?.vokalOderKonsonant == VokalOderKonsonant.Vokal.rawValue : false
        let konsonantForShowsAnswer = showsAnswer ? korrekteAntwort?.vokalOderKonsonant == VokalOderKonsonant.Konsonant.rawValue : false
        
        let vokalForKorrekt         = wirdGeprueft ? korrekteAntwort?.vokalOderKonsonant == VokalOderKonsonant.Vokal.rawValue : false
        let konsonantForKorrekt     = wirdGeprueft ? korrekteAntwort?.vokalOderKonsonant == VokalOderKonsonant.Konsonant.rawValue : false
        
        let vokalKonsNil            = usereingabe.vokalOderKonsonant.value   == nil && !wirdGeprueft && !showsAnswer
        let vokal                   = usereingabe.vokalOderKonsonant.value   == VokalOderKonsonant.Vokal.rawValue
        let konsonant               = usereingabe.vokalOderKonsonant.value   == VokalOderKonsonant.Konsonant.rawValue
        
        let vokalHalbVokalNil       = usereingabe.vokalOderHalbvokal.value   == nil && !wirdGeprueft && !showsAnswer
        let einfVokal               = usereingabe.vokalOderHalbvokal.value   == VokalOderHalbvokal.Vokal.rawValue
        
//        let controlIsVersteckt = controlSetting.modus == .Versteckt
        
        switch controlTyp {
        case .VokalOderKonsonantTyp:   return false
        case .VokalOderHalbvokalTyp:   return vokalKonsNil || konsonant || konsonantForKorrekt || konsonantForShowsAnswer //|| controlIsVersteckt
        case .ArtikulationTyp :        return vokalKonsNil || (vokal && (vokalHalbVokalNil || einfVokal)) || vokalForKorrekt || vokalForShowsAnswer //|| controlIsVersteckt
        case .AspirationTyp :          return vokalKonsNil || vokal || vokalForKorrekt || vokalForShowsAnswer //|| controlIsVersteckt
        case .StimmhaftigkeitTyp:      return vokalKonsNil || vokal || vokalForKorrekt || vokalForShowsAnswer //|| controlIsVersteckt
        case .KonsonantTyp :            return vokalKonsNil || vokal || vokalForKorrekt || vokalForShowsAnswer //|| controlIsVersteckt
        case .ZeichenfeldTyp:          return false
        case .TextfeldTyp:             return false
        }
    }
}
protocol PanelControlProtocol:class{
    var view: UIView { get }
    var viewModel:PanelControlViewModel! {get set}
}
extension PanelControlProtocol where Self: UIView {
    var view: UIView { return self }
}
