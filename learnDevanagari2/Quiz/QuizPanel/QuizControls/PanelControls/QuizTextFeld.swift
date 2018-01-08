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
    required init(controlSetting: PanelControlSetting,quizModel:QuizModel) {
        super.init(controlSetting: controlSetting, quizModel: quizModel)
        text <~ userEingabe
        text <~ controlCurrentModus.producer.filter{$0 == .ShowsPruefergebnis}.map{[weak self] _ in return self?.correctAnswer.value}
        text <~ quizModel.currentQuizZeichen.producer.map{ [weak self] _ in
            quizModel.currentQuizZeichen.value?.quizSetting.textfeld.modus == .NurAnzeige ? self?.correctAnswer.value : nil
        }
        sonderzeichenFuerBar   <~ quizModel.sonderZeichenFuerTastaturBar
    }
}

class QuizTextFeld: UITextField,PanelControlProtocol {
    lazy var anchorHeight = heightAnchor.constraint(equalToConstant: 50)
    var viewModel: PanelControlViewModel!{
        didSet{
            guard let viewModel = viewModel as? QuizTextFeldViewModel else {return}
            anchorHeight.isActive           = true
            textColor                       = UIColor.white
            textAlignment                   = .center
            spellCheckingType               = .no
            autocapitalizationType          = .none
            smartDashesType                 = .no
            smartQuotesType                 = .no
            smartInsertDeleteType           = .no
            autocorrectionType              = .no
            
            inputAssistantItem.leadingBarButtonGroups.removeAll()
            inputAssistantItem.trailingBarButtonGroups.removeAll()
            
            //ToolBar
            let toolBar                     = UIToolbar.init(frame: CGRect.zero)
            inputAccessoryView              = toolBar
            toolBar.barStyle                = .default
            
            viewModel.sonderzeichenFuerBar.producer.startWithValues { [weak self] sonderZeichen in
                guard sonderZeichen.count > 0 else {
                    self?.inputAccessoryView = nil
                    return
                }
                var barItems:[UIBarButtonItem]  = {
                    var ergebnis = [UIBarButtonItem]()
                    for string in sonderZeichen{
                        ergebnis.append(UIBarButtonItem.init(barButtonSystemItem: .flexibleSpace, target: nil, action: nil))
                        ergebnis.append(UIBarButtonItem.init(title: string, style: .done, target: self, action: #selector(self?.barButtonPressed)))
                    }
                    ergebnis.append(UIBarButtonItem.init(barButtonSystemItem: .flexibleSpace, target: nil, action: nil))
                    return ergebnis
                }()
                toolBar.items = barItems
                toolBar.sizeToFit()
            }
            
            var flexibleSpace:UIBarButtonItem{
                return UIBarButtonItem.init(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            }
            
            viewModel.userEingabe           <~ reactive.continuousTextValues
            reactive.isEnabled              <~ viewModel.isEnabled.producer
            reactive.backgroundColor        <~ viewModel.backGroundColor.producer
            reactive.text                   <~ viewModel.text.producer
            anchorHeight.reactive.constant  <~ viewModel.zeilenHoehe.producer
        }
    }
    @objc private func barButtonPressed(sender:UIBarButtonItem){
        guard let title = sender.title else {return}
        text = (text ?? "") + title
    }
}
