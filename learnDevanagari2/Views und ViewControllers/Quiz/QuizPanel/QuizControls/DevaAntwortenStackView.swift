//
//  DevaAntwortenStackView.swift
//  learnDevanagari2
//
//  Created by Matthias Pochmann on 13.11.17.
//  Copyright © 2017 Matthias Pochmann. All rights reserved.
//

import UIKit
import ReactiveSwift

//MARK:DevaAntworten
// zeigt die Zeichen an, die von Tesseract erkannt wurden
// der User kann daraus die passende Antwort wählen
// ist notwendig, weil Tesseract Handschrift nicht genau genug erkennt
class DevaAntwortenStackViewModel{
    var devaAntworten       = MutableProperty([String]())
    var gewaehlteAntwort    = MutableProperty<String?>(nil)
    init(quizModel:QuizModel){
        devaAntworten                       <~ quizModel.userEingabeDevaErkannteZeichen
        quizModel.userEingabe.devanagari    <~ gewaehlteAntwort
        devaAntworten                       <~ quizModel.currentQuizZeichen.producer.map{_ in [String]()}
    }
}

class DevaAntwortenStackView: UIStackView {
    var viewModel:DevaAntwortenStackViewModel!{ didSet{ viewModel.devaAntworten.producer.startWithValues{ [weak self] antworten in self?.updateStack(antworten: antworten) } } }
    private func updateStack(antworten:[String]){
        for subView in arrangedSubviews{ subView.removeFromSuperview()}
        for antwort in antworten{
            let button = UIButton(title: antwort)
            addArrangedSubview(button)
            viewModel.gewaehlteAntwort <~ button.reactive.controlEvents(.touchUpInside).signal.map{$0.currentTitle}
        }
    }
}


