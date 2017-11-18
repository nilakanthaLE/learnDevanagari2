//
//  DevaAntwortenStackView.swift
//  learnDevanagari2
//
//  Created by Matthias Pochmann on 13.11.17.
//  Copyright © 2017 Matthias Pochmann. All rights reserved.
//

import UIKit
import ReactiveSwift

class DevaAntwortenStackViewModel{
    init(quizModel:QuizModel){
        devaAntworten                       <~ quizModel.userEingabeDevaErkannteZeichen
        quizModel.userEingabe.devanagari    <~ gewaehlteAntwort
        devaAntworten                       <~ quizModel.currentQuizZeichen.producer.map{_ in [String]()}
    }
    var devaAntworten = MutableProperty([String]())
    var gewaehlteAntwort = MutableProperty<String?>(nil)
}

class DevaAntwortenStackView: UIStackView {
    var viewModel:DevaAntwortenStackViewModel!{
        didSet{
            viewModel.devaAntworten.producer.startWithValues{ [weak self] antworten in
                self?.updateStack(antworten: antworten)
            }
            viewModel.devaAntworten.signal.observeValues { (ergebnis) in
                print("-> \(ergebnis)")
            }
        }
    }
    private func updateStack(antworten:[String]){
        for subView in arrangedSubviews{ subView.removeFromSuperview()}
        for antwort in antworten{
            let button = UIButton()
            button.setTitle(antwort, for: .normal)
            viewModel.gewaehlteAntwort <~ button.reactive.controlEvents(.touchUpInside).signal.map{$0.currentTitle}
            addArrangedSubview(button)
        }
    }


}
