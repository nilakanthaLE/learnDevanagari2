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
    var quizModel : QuizModel
    var controlSettings     = QuizSetting().allePanelControls //alle möglichen Controls
   
    init (quizModel:QuizModel)          { self.quizModel      = quizModel }
    
    //MARK: ViewModels
    func getViewModel(for controlSetting:PanelControlSetting) -> PanelControlViewModel  { return getControlViewModelClass(for: controlSetting).init(controlSetting: controlSetting,quizModel: quizModel) }
    func getViewModelForPruefenButton() -> QuizPruefenButtonViewModel                   { return  QuizPruefenButtonViewModel(quizModel: quizModel) }
    func getControlViewModelClass (for controlSetting:PanelControlSetting) -> PanelControlViewModel.Type{
        switch controlSetting.controlTyp {
        case .ArtikulationTyp:     return QuizArtikulationPickerViewModel.self
        case .TextfeldTyp:         return QuizTextFeldViewModel.self
        default:                    return MultiTouchButtonViewModel.self
        }
    }
}

//MARK:View
class QuizPanelView: UIStackView {
    let pruefenButton   =  QuizPruefenButton()
    var viewModel:QuizPanelViewModel!{
        didSet{
            pruefenButton.viewModel     = viewModel.getViewModelForPruefenButton()
            let controls                = getControlArray(settings: viewModel.controlSettings)
            
            //observiert die Ausrichgung des Geräts
            // arrangiert die Controls
            iPadOrientation?.producer.startWithValues     { [weak self](orientation) in self?.arrange(controls:controls, for: orientation) }
        }
    }
    
    //MARK: helper
    // Controls passend zur Orientierung des Geräts arrangieren
    private func arrange(controls:[PanelControlProtocol]?,for orientation:IPadOrientation?){
        guard let orientation = orientation,let controls = controls else {return}
        cleanStack(controls)
        setStackBasics(orientation:orientation)
        switch orientation {
        case .landscape: setControlsLandscape(controls)
        case .portrait: setControlsPortrait(controls)
        }
    }
    // grundlegende Einstellung des HauptStackViews vornehmen
    private func setStackBasics(orientation:IPadOrientation) {
        axis            = orientation == .landscape ? .vertical : .horizontal
        distribution    = orientation == .landscape ? .fill : .fillEqually
    }
    // Controls für Landscape und Portrait arrangieren
    private func setControlsLandscape(_ controls: [PanelControlProtocol]) {
        for control in controls {addArrangedSubview(control.view)}
        addArrangedSubview(UIView())
        addArrangedSubview(pruefenButton)
    }
    private func setControlsPortrait(_ controls: [PanelControlProtocol]) {
        // in der Portrait Ansicht besteht das Panel aus drei horizontal angeordneten Stackviews
        // diese Substackviews sind vertikal ausgerichtet
        let subStacks =  [addArrangedSubviewAndReturn(view: UIStackView.verticalFilled()) , addArrangedSubviewAndReturn(view: UIStackView.verticalFilled()) , addArrangedSubviewAndReturn(view: UIStackView.verticalFilled())]
        // Zuordnung der Controls zum jeweils passenden StackView
        for control in controls{
            let col = control.viewModel.controlTyp.placeInArray(for: .portrait)?.column ?? 0
            subStacks[col].addArrangedSubview(control.view)
        }
        //Leere Views zum auffüllen, falls nicht alle Controls angezeigt werden
        subStacks[0].addArrangedSubview(UIView())
        subStacks[1].addArrangedSubview(UIView())
        subStacks[2].addArrangedSubview(UIView())
        //Prüfen Button der letzten Spalte und ersten Zeile hinzufügen
        subStacks[2].insertArrangedSubview(pruefenButton, at: 0)
    }
    // leert den StackView
    private func cleanStack(_ controls: [PanelControlProtocol]) {
        for control in controls         { control.view.removeFromSuperview() }
        for stack in arrangedSubviews   { stack.removeFromSuperview() }
        pruefenButton.removeFromSuperview()
    }
    //getControlArray erzeugt ein Array von PanelControls
    // enthält alle möglichen Controls mit ViewModel
    private func getControlArray(settings:[PanelControlSetting]?)   -> [PanelControlProtocol]   { return (settings ?? [PanelControlSetting]()).map    { getControl(for: $0) } }
    //liefert passendes Control mit ViewModel zum Setting
    private func getControl(for controlSetting:PanelControlSetting) -> PanelControlProtocol     {
        //das passende Control finden und initialisieren
        let control:PanelControlProtocol = {
            switch controlSetting.controlTyp {
            case .ArtikulationTyp:  return QuizArtikulationPicker()
            case .TextfeldTyp:      return QuizTextFeld()
            default:                return MultiTouchButton()
            }
        }()
        // das passende viewModel setzen
        control.viewModel   = viewModel.getViewModel(for: controlSetting)
        return control
    }
}

//MARK: Protocols
//Protokol für die ViewModels aller PanelControls
protocol PanelControlViewModelProtocol {
    var isHidden:       MutableProperty<Bool> {get set}
    var zeilenHoehe:    MutableProperty<CGFloat> {get set}
    var userEingabe:    MutableProperty<String?> {get set}
    init(controlSetting:PanelControlSetting,quizModel:QuizModel)
}
//Protokol für alle PanelControls
protocol PanelControlProtocol:class{
    var view: UIView { get }
    var viewModel:PanelControlViewModel! {get set}
}
//Extension für PanelControlProtocol
// vereinfacht Zugriff auf view
extension PanelControlProtocol where Self: UIView { var view: UIView { return self } }
