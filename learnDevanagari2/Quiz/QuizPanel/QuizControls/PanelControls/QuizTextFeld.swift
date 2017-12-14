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
    var text = MutableProperty<String?>("")
    required init(controlSetting: PanelControlSetting,quizModel:QuizModel) {
        super.init(controlSetting: controlSetting, quizModel: quizModel)
        text <~ userEingabe
        text <~ controlCurrentModus.producer.filter{$0 == .ShowsPruefergebnis}.map{[weak self] _ in return self?.correctAnswer.value}
        text <~ quizModel.currentQuizZeichen.producer.map{ [weak self] _ in
            quizModel.currentQuizZeichen.value?.quizSetting.textfeld.modus == .NurAnzeige ? self?.correctAnswer.value : nil
        }
        
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
            self.autocapitalizationType     = .none
            
            viewModel.userEingabe           <~ reactive.continuousTextValues
            reactive.isEnabled              <~ viewModel.isEnabled.producer
            reactive.backgroundColor        <~ viewModel.backGroundColor.producer
            reactive.text                   <~ viewModel.text.producer
            anchorHeight.reactive.constant  <~ viewModel.zeilenHoehe.producer
        }
    }
}
