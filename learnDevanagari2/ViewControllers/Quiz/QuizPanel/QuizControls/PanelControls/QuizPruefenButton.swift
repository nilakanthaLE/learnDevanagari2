//
//  QuizPruefenButton.swift
//  learnDevanagari2
//
//  Created by Matthias Pochmann on 02.11.17.
//  Copyright © 2017 Matthias Pochmann. All rights reserved.
//

import UIKit
import ReactiveSwift

class QuizPruefenButtonViewModel{
    var quizModel:QuizModel
    var zeilenHoehe:MutableProperty<CGFloat> = MutableProperty(30.0)
    var buttonZustand:MutableProperty<PruefenButtonZustand?> = MutableProperty(nil)
    init(quizModel:QuizModel){
        self.quizModel = quizModel
        buttonZustand               <~ quizModel.currentQuizZeichen.producer.map{ ($0?.status.value == .Correct ||  $0?.status.value == .FalschBeantwortet) ? .NaechstesZeichen : .Pruefen }
        zeilenHoehe                 <~ quizModel.zeilenHoehe
        buttonZustand               <~ quizModel.pruefenButtonZustand.producer
     }
    func buttonPressed(){ quizModel.pruefenButtonHasAnAction.value = Void() }
}

class QuizPruefenButton: UIButton {
    lazy var anchorHeight = heightAnchor.constraint(equalToConstant: 50)
    var viewModel:QuizPruefenButtonViewModel!{
        didSet{
            backgroundColor         = colorForDefault
            anchorHeight.isActive   = true
            reactive.title(for: .normal)    <~ viewModel.buttonZustand.map{$0?.rawValue ?? "fehlt"}
            anchorHeight.reactive.constant  <~ viewModel.zeilenHoehe
            
            //Button pressed Action
            reactive.controlEvents(.touchUpInside).producer.start(){[weak self] _ in self?.viewModel.buttonPressed() }
        }
    }
}


enum PruefenButtonZustand:String{
    case Pruefen            = "Eingabe prüfen"
    case NaechstesZeichen   = "nächstes Zeichen"
    case QuizBeenden        = "Quiz beenden"
}