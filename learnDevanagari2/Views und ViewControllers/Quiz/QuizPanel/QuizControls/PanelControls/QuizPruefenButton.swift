//
//  QuizPruefenButton.swift
//  learnDevanagari2
//
//  Created by Matthias Pochmann on 02.11.17.
//  Copyright © 2017 Matthias Pochmann. All rights reserved.
//

import UIKit
import ReactiveSwift

//MARK: QuizPruefenButton
// Button für:
// 1) Prüfen der Usereingabe
// 2) zum nächsten Zeichen wechseln
// 3) das Quiz beenden
class QuizPruefenButtonViewModel{
    var zeilenHoehe                 = MutableProperty<CGFloat> (30.0)
    var buttonZustand               = MutableProperty<PruefenButtonZustand?>(nil)
    var pruefenButtonHasAnAction:MutableProperty<Void>
    init(quizModel:QuizModel){
        buttonZustand               <~ quizModel.currentQuizZeichen.producer.map{ ($0?.status.value == .Correct ||  $0?.status.value == .FalschBeantwortet) ? .NaechstesZeichen : .Pruefen }
        zeilenHoehe                 <~ quizModel.zeilenHoehe
        buttonZustand               <~ quizModel.pruefenButtonZustand.producer
        pruefenButtonHasAnAction    = quizModel.pruefenButtonHasAnAction
     }
}

class QuizPruefenButton: UIButton {
    var viewModel:QuizPruefenButtonViewModel!{
        didSet{
            backgroundColor         = colorForDefault
            let anchorHeight        = heightAnchor.constraint(equalToConstant: 50)
            anchorHeight.isActive   = true
            
            reactive.title(for: .normal)        <~ viewModel.buttonZustand.map{$0?.rawValue ?? "fehlt"}
            anchorHeight.reactive.constant      <~ viewModel.zeilenHoehe
            viewModel.pruefenButtonHasAnAction  <~ reactive.controlEvents(.touchUpInside).producer.map{_ in Void()}
        }
    }
}



