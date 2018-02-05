//
//  AbfragenUndAnzeigenView.swift
//  learnDevanagari2
//
//  Created by Matthias Pochmann on 19.11.17.
//  Copyright © 2017 Matthias Pochmann. All rights reserved.
//

import UIKit
import ReactiveSwift

//MARK: AbfragenUndAnzeigen
// Control, das anzeigt, welche Abfragen bzw. Anzeigen im Quiz enthalten sein werden
class AbfragenUndAnzeigenViewModel{
    var isHidden            = MutableProperty(true)
    var editButtonIsHidden  = MutableProperty(true)
    var labelText           = MutableProperty<String?> (nil)
    var stackLabelStrings   = MutableProperty([String]())
    var segueIdentifier: MutableProperty<String>?
    
    //MARK: init
    init(quizSetting:MutableProperty<QuizSetting?> ,editable:Bool,settingModus:SettingModus, segueIdentifier: MutableProperty<String>? = nil){
        //inititiale Werte setzen
        // segueIdentifier startet segue, falls gesetzt wird
        self.segueIdentifier        =  segueIdentifier
        editButtonIsHidden.value    = !editable
        
        //isHidden
        // das Control ist nicht sichtbar, wenn:
        // das QuizSetting keine relevaten Abfragen oder Anzeigen enthält und
        // das Control zum LektionsQuiz gehört
        isHidden                    <~ stackLabelStrings.producer.map{ $0.count == 0 && !editable}
        
        //settingModus
        // entscheidet darüber, ob das Control Abfragen oder Anzeigen zeigt
        switch settingModus {
        case .InAbfrage:
            stackLabelStrings       <~ quizSetting.producer.map{$0?.abfragen.map{$0.controlName ?? "Fehler"} ?? [String]()}
            labelText.value         = "Abgefragt wird:"
        case .Anzeige:
            stackLabelStrings       <~ quizSetting.producer.map{$0?.anzeigen.map{$0.controlName ?? "Fehler"} ?? [String]()}
            labelText.value         = "Angezeigt wird:"
        }
    }
}

class AbfragenUndAnzeigenView: NibLoadingView {
    var viewModel:AbfragenUndAnzeigenViewModel!{
        didSet{
            //update der Anzeige, welche Abfragen bzw. Anzeigen Bestandteil des Quizzes sind
            viewModel.stackLabelStrings.producer.startWithValues {[weak self] strings in  self?.updateStack(with: strings) }
            
            //label = Überschrift (Abfragen oder Anzeigen)
            label.reactive.text             <~ viewModel.labelText.producer
            //isHidden für Control und Editbutton
            editButton.reactive.isHidden    <~ viewModel.editButtonIsHidden.producer
            reactive.isHidden               <~ viewModel.isHidden
            
            //wenn der editKnopf gedrückt wird:
            // wird segueIdentifier gesetzt
            // -> startet segue
            if let segueIdentifier = viewModel.segueIdentifier { segueIdentifier  <~ editButton.reactive.controlEvents(UIControlEvents.touchUpInside).signal.map{_ in "showQuizAbfragenConfig"} }
        }
    }
    
    //MARK: Outlets
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var stack: UIStackView!
    
    //MARK: helper
    func updateStack(with stackLabelStrings:[String]){
        for subview in stack.arrangedSubviews { subview.removeFromSuperview() }
        for string in stackLabelStrings{
            let label = UILabel()
            label.text  = string
            
            label.heightAnchor.constraint(equalToConstant: 20).isActive = true
            stack.addArrangedSubview(label)
        }
        if stackLabelStrings.count == 0 {
            let label = UILabel()
            label.heightAnchor.constraint(equalToConstant: 10).isActive = true
            stack.addArrangedSubview(label)
        }
    }
}
