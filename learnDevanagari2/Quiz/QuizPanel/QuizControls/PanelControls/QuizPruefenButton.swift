//
//  QuizPruefenButton.swift
//  learnDevanagari2
//
//  Created by Matthias Pochmann on 02.11.17.
//  Copyright © 2017 Matthias Pochmann. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift

class QuizPruefenButtonViewModel{
    var quizModel:QuizModel
    var zeilenHoehe:MutableProperty<CGFloat> = MutableProperty(30.0)
    init(quizModel:QuizModel){
        self.quizModel = quizModel
        buttonZustand               <~ quizModel.currentQuizZeichen.producer.map{ ($0?.status.value == .Correct ||  $0?.status.value == .FalschBeantwortet) ? .NaechstesZeichen : .Pruefen }
        zeilenHoehe                 <~ quizModel.zeilenHoehe
     }
    
    var buttonZustand  = MutableProperty(PruefenButtonZustand.Pruefen)

    func buttonPressed(){
        switch buttonZustand.value {
        case .NaechstesZeichen:
            quizModel.nextZeichenPressed.value = Void()
        case .Pruefen:
            buttonZustand.value = buttonZustand.value.toggleNext()
            quizModel.pruefenPressed.value = Void()
            
        }
    }
}

class QuizPruefenButton: UIButton {
    lazy var anchorHeight = heightAnchor.constraint(equalToConstant: 50)
    var viewModel:QuizPruefenButtonViewModel!{
        didSet{
            backgroundColor         = colorForDefault
            anchorHeight.isActive   = true
            reactive.title(for: .normal)    <~ viewModel.buttonZustand.map{$0.rawValue}
            anchorHeight.reactive.constant  <~ viewModel.zeilenHoehe
            
            reactive.controlEvents(.touchUpInside).producer.start(){[weak self] _ in
                self?.viewModel.buttonPressed()
            }
        }
    }
}


enum PruefenButtonZustand:String{
    case Pruefen            = "Eingabe prüfen"
    case NaechstesZeichen   = "nächstes Zeichen"
    func toggleNext() -> PruefenButtonZustand{
        switch self {
        case .Pruefen:          return .NaechstesZeichen
        case .NaechstesZeichen: return .Pruefen
        }
    }
}
