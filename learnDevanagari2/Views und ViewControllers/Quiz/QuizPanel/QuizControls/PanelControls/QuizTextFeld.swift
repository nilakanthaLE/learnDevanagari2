//
//  QuizTextFeld.swift
//  learnDevanagari2
//
//  Created by Matthias Pochmann on 25.10.17.
//  Copyright © 2017 Matthias Pochmann. All rights reserved.
//

import UIKit
import ReactiveSwift

class QuizTextFeldViewModel:PanelControlViewModel{
    var text                    = MutableProperty<String?>("")
    var sonderzeichenFuerBar    = MutableProperty([String]())
    var backGroundColor         = MutableProperty(colorForDefault)
    required init(controlSetting: PanelControlSetting,quizModel:QuizModel) {
        super.init(controlSetting: controlSetting, quizModel: quizModel)
        text                    <~ userEingabe
        text                    <~ controlCurrentModus.producer.filter{$0 == .ShowsPruefergebnis}.map{[weak self] _ in return self?.correctAnswer.value}
        text                    <~ quizModel.currentQuizZeichen.producer.map{ [weak self] quizZeichen in self?.getText(for: quizZeichen) }
        sonderzeichenFuerBar    <~ quizModel.sonderZeichenFuerTastaturBar
        backGroundColor         <~ controlCurrentModus.producer.map{[weak self] _ in self?.getBackGroundColor() ?? colorForDefault}
    }
    //MARK: helper
    private func getText(for quizZeichen:QuizZeichen?) -> String?{ return quizZeichen?.quizSetting.textfeld.modus == .NurAnzeige ? correctAnswer.value : nil }
}

class QuizTextFeld: UITextField,PanelControlProtocol {
    lazy var anchorHeight = heightAnchor.constraint(equalToConstant: 50)
    var quizTextFeldViewModel: QuizTextFeldViewModel { return viewModel as! QuizTextFeldViewModel }
    var viewModel: PanelControlViewModel!{
        didSet{
            anchorHeight.isActive           = true
            
            //TextFeld initialisieren
            initTextFeld()
            
            //Signale
            quizTextFeldViewModel.sonderzeichenFuerBar.producer.startWithValues { [weak self] sonderZeichen in self?.setToolbar(toolbar: self?.initToolbar(), for: sonderZeichen)}
            quizTextFeldViewModel.userEingabe   <~ reactive.continuousTextValues
            reactive.isEnabled                  <~ quizTextFeldViewModel.isEnabled.producer
            reactive.backgroundColor            <~ quizTextFeldViewModel.backGroundColor.producer
            reactive.text                       <~ quizTextFeldViewModel.text.producer
            anchorHeight.reactive.constant      <~ quizTextFeldViewModel.zeilenHoehe.producer
        }
    }
    
    //Aktion für die Sonderzeichen auf der toolbar
    // zeigt Zeichen, die nicht auf der Tastatur enthalten sind
    // (lange zeichen, ri, retroflexe, nasale, ...)
    @objc private func barButtonPressed(sender:UIBarButtonItem) { viewModel.userEingabe.value = (text ?? "") + (sender.title ?? "") }
    
    //MARK: helper
    private func initTextFeld(){
        textColor                       = UIColor.white
        textAlignment                   = .center
        spellCheckingType               = .no
        autocapitalizationType          = .none
        smartDashesType                 = .no
        smartQuotesType                 = .no
        smartInsertDeleteType           = .no
        autocorrectionType              = .no
    }
    //Toolbar initialisieren
    private func initToolbar() -> UIToolbar {
        inputAssistantItem.leadingBarButtonGroups.removeAll()
        inputAssistantItem.trailingBarButtonGroups.removeAll()
        let toolBar                     = UIToolbar.init(frame: CGRect.zero)
        toolBar.barStyle                = .default
        inputAccessoryView              = toolBar
        return toolBar
    }
    //Toolbar für Sonderzeichen anpassen
    private func setToolbar(toolbar:UIToolbar?,for sonderZeichen:[String]){
        guard sonderZeichen.count > 0 else { inputAccessoryView = nil; return }
        toolbar?.items = getToolBarButtons(for: sonderZeichen)
        toolbar?.sizeToFit()
    }
    //ToolBarButtons für Sonderzeichen erzeugen
    private func getToolBarButtons(for sonderZeichen:[String]) -> [UIBarButtonItem] {
        var ergebnis = [UIBarButtonItem]()
        for string in sonderZeichen{
            ergebnis.append(UIBarButtonItem.init(barButtonSystemItem: .flexibleSpace, target: nil, action: nil))
            ergebnis.append(UIBarButtonItem.init(title: string, style: .done, target: self, action: #selector(barButtonPressed)))
        }
        ergebnis.append(UIBarButtonItem.init(barButtonSystemItem: .flexibleSpace, target: nil, action: nil))
        return ergebnis
    }
}
