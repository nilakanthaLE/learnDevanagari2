//
//  AbfragenUndAnzeigenView.swift
//  learnDevanagari2
//
//  Created by Matthias Pochmann on 19.11.17.
//  Copyright © 2017 Matthias Pochmann. All rights reserved.
//

import UIKit
import ReactiveSwift

enum SettingModus { case InAbfrage, Anzeige}
class AbfragenUndAnzeigenViewModel{
    var labelText           = MutableProperty<String?> (nil)
    var editButtonIsHidden  = MutableProperty(true)
    var stackLabelStrings   = MutableProperty([String]())
    init(quizSetting:MutableProperty<QuizSetting?> ,editable:Bool,settingModus:SettingModus){
        switch settingModus {
        case .InAbfrage:
            stackLabelStrings <~ quizSetting.producer.map{$0?.abfragen.map{$0.controlName ?? "Fehler"} ?? [String]()}
            labelText.value     = "Abgefragt wird:"
        case .Anzeige:
            stackLabelStrings <~ quizSetting.producer.map{$0?.anzeigen.map{$0.controlName ?? "Fehler"} ?? [String]()}
            labelText.value     = "Angezeigt wird:"
        }
        editButtonIsHidden.value    = !editable
        isHidden                <~ stackLabelStrings.producer.map{ $0.count == 0 && !editable}
    }
    var isHidden            = MutableProperty(true)
}

class AbfragenUndAnzeigenView: NibLoadingView {
    var viewModel:AbfragenUndAnzeigenViewModel!{
        didSet{
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
            viewModel.stackLabelStrings.producer.startWithValues {  updateStack(with: $0) }
            label.reactive.text             <~ viewModel.labelText.producer
            editButton.reactive.isHidden    <~ viewModel.editButtonIsHidden.producer
            reactive.isHidden               <~ viewModel.isHidden
        }
    }
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var stack: UIStackView!
    @IBAction func editButtonAction(_ sender: UIButton) {
        editButtonAction?()
    }
    var editButtonAction:(()->Void)?
}
