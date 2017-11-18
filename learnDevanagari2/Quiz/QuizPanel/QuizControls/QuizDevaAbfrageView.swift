//
//  QuizDevaAbfrageView.swift
//  learnDevanagari2
//
//  Created by Matthias Pochmann on 12.11.17.
//  Copyright © 2017 Matthias Pochmann. All rights reserved.
//

import UIKit
import ReactiveSwift

class QuizDevaAbfrageViewModel{
    var quizModel:QuizModel
    
    
    var correctAnswer: MutableProperty<String?> = MutableProperty(nil)
    
    var backGroundColor     = MutableProperty(colorForDefault)
    var zeichenFeldIsHidden = MutableProperty(true)
    var devaButtonIsHidden  = MutableProperty(false)
    var devaButtonTitle     = MutableProperty<String?>("?")
    var devaButtonIsEnabled = MutableProperty(false)
    var showsZeichenFeld    = MutableProperty(false)
    var okButtonIsHidden    = MutableProperty(false)
    
    init(quizModel:QuizModel){
        self.quizModel = quizModel
        zeichenFeldIsHidden <~ showsZeichenFeld.producer.map{!$0}
        devaButtonIsHidden  <~ showsZeichenFeld.producer
        
        devaButtonTitle     <~ quizModel.userEingabe.devanagari.producer.filter{$0 != nil}
        devaButtonTitle     <~ quizModel.currentQuizZeichen.producer.map{ $0?.titleForZeichenfeldButton }
        showsZeichenFeld    <~ quizModel.currentQuizZeichen.producer.map{ $0?.quizSetting.zeichenfeld == .Nachzeichnen}
        okButtonIsHidden    <~ quizModel.currentQuizZeichen.producer.map{ $0?.quizSetting.zeichenfeld == .Nachzeichnen}
        devaButtonIsEnabled <~ quizModel.currentQuizZeichen.producer.map{ $0?.quizSetting.zeichenfeld != .NurAnzeige  }
        backGroundColor     <~ quizModel.userEingabePrüfen.producer.map{[weak self] _ in self?.getBackGroundColor() ?? colorForDefault}
        devaButtonTitle     <~ quizModel.userEingabePrüfen.producer.filter{$0 == true}.map{[weak self] _ in self?.correctAnswer.value }
        
        quizModel.currentQuizZeichen.producer.startWithValues           { [weak self] quizZeichen in
            self?.correctAnswer.value   = quizZeichen?.zeichen.devanagari
            self?.backGroundColor.value = self?.getBackGroundColor() ?? colorForDefault
        }
    }
    func getViewModelForZeichenFeld() -> QuizZeichenfeldViewModel {return QuizZeichenfeldViewModel(quizModel:quizModel,showsZeichenFeld:showsZeichenFeld)}
    
    private func getBackGroundColor() -> UIColor{
        if quizModel.userEingabePrüfen.value   {
            let currentQuizZeichen = self.quizModel.currentQuizZeichen.value
            return currentQuizZeichen?.quizSetting.zeichenfeld == .NurAnzeige ? colorForCorrect : quizModel.userEingabe.devanagari.value == correctAnswer.value ? colorForCorrect : colorForWrong
        }
        return colorForDefault
    }
    
}

class QuizDevaAbfrageView: UIStackView {
    
    
    var zeichenFeld:QuizZeichenfeldView!            { didSet{zeichenFeld.viewModel = viewModel.getViewModelForZeichenFeld() } }
    var devaButton:QuizDevaButton!
    
    var viewModel:QuizDevaAbfrageViewModel!{
        didSet{
            axis            = .horizontal
            distribution    = .fill
            alignment       = .fill
            
            zeichenFeld     = QuizZeichenfeldView(frame: CGRect.zero)
            devaButton      = QuizDevaButton(frame:CGRect.zero)
            addArrangedSubview(zeichenFeld)
            addArrangedSubview(devaButton)
            
            zeichenFeld.okButton.reactive.isHidden          <~ viewModel.okButtonIsHidden
            devaButton.reactive.isHidden                    <~ viewModel.devaButtonIsHidden
            zeichenFeld.reactive.isHidden                   <~ viewModel.zeichenFeldIsHidden
            devaButton.reactive.title(for: .normal)         <~ viewModel.devaButtonTitle.producer.map{$0 ?? ""}
            devaButton.reactive.isEnabled                   <~ viewModel.devaButtonIsEnabled
            devaButton.reactive.backgroundColor             <~ viewModel.backGroundColor
            
            viewModel.showsZeichenFeld                      <~ devaButton.reactive.controlEvents(.touchUpInside).signal.map{_ in true}
        }
    }
}

class QuizDevaButton:UIButton{
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = colorForDefault
        titleLabel?.adjustsFontSizeToFitWidth = true
        titleLabel?.minimumScaleFactor = 0.5
        titleLabel?.numberOfLines   = 1
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
    }
    
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented")  }
    
    var lastSize = CGSize.zero
    override func layoutSubviews() {
        super.layoutSubviews()
        if lastSize != bounds.size{
            titleLabel?.font = UIFont.boldSystemFont(ofSize: (bounds.size.height / 2))
        }
        lastSize = bounds.size
    }
}
