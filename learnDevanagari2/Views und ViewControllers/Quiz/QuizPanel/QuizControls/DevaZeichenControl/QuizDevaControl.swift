//
//  QuizDevaAbfrageView.swift
//  learnDevanagari2
//
//  Created by Matthias Pochmann on 12.11.17.
//  Copyright © 2017 Matthias Pochmann. All rights reserved.
//

import UIKit
import ReactiveSwift

//MARK: QuizDevaAbfrage
// Control für die Abfrage und Anzeige des Devanagari-Zeichens
// enthält
// 1) Button, der entweder die richtige Antwort, die Userwahl oder ein Fragezeichen zeigt
// 2) ein Zeichenfeld auf das der User zeichnen kann
class QuizDevaAbfrageViewModel{
    var quizModel:QuizModel
    
    var devaButtonTitle     = MutableProperty<String?>("?")
    var correctAnswer       = MutableProperty<String?>(nil)
    var backGroundColor     = MutableProperty(colorForDefault)
    var zeichenFeldIsHidden = MutableProperty(true)
    var devaButtonIsHidden  = MutableProperty(false)
    var devaButtonIsEnabled = MutableProperty(false)
    var showsZeichenFeld    = MutableProperty(false)
    var okButtonIsHidden    = MutableProperty(false)
    
    init(quizModel:QuizModel){
        self.quizModel = quizModel
        zeichenFeldIsHidden <~ showsZeichenFeld.producer.map{!$0}
        devaButtonIsHidden  <~ showsZeichenFeld.producer
        
        //der angezeigte Titel auf dem HauptKnopf, wenn der User ein Zeichen gezeichnet hat
        // oder ein vorgeschlagenes gewählt hat
        devaButtonTitle     <~ quizModel.userEingabe.devanagari.producer.filter{$0 != nil}
        
        //Initialisierungen, wenn ein neues QuizZeichen gesetzt wird
        devaButtonTitle     <~ quizModel.currentQuizZeichen.producer.map{ $0?.titleForZeichenfeldButton }
        showsZeichenFeld    <~ quizModel.currentQuizZeichen.producer.map{ $0?.quizSetting.zeichenfeld == .Nachzeichnen}
        okButtonIsHidden    <~ quizModel.currentQuizZeichen.producer.map{ $0?.quizSetting.zeichenfeld == .Nachzeichnen}
        devaButtonIsEnabled <~ quizModel.currentQuizZeichen.producer.map{ $0?.quizSetting.zeichenfeld != .NurAnzeige  }
        backGroundColor     <~ quizModel.currentQuizZeichen.producer.map{ _ in colorForDefault}
        correctAnswer       <~ quizModel.currentQuizZeichen.producer.map{ $0?.nasalDesAnusvaraZeichen?.devanagari ?? $0?.anusvaraVisargaViramaZeichen?.devanagari  ?? $0?.zeichen.devanagari }
        
        
        //Prüfergebnisse anzeigen
        backGroundColor     <~ quizModel.zeigePruefergebnisse.signal.map{[weak self] _ in self?.getBackGroundColor() ?? colorForDefault}
        devaButtonTitle     <~ quizModel.zeigePruefergebnisse.signal.map{[weak self] _ in self?.correctAnswer.value }
    }
    
    //MARK: helper
    private func getBackGroundColor() -> UIColor{
        if quizModel.currentQuizZeichen.value?.quizSetting.zeichenfeld == .NurAnzeige       { return colorForDefault}
        if quizModel.userEingabe.devanagari.value == correctAnswer.value                    { return colorForCorrect }
        return colorForWrong
    }
    
    //MARK: ViewModel
    func getViewModelForZeichenFeld() -> QuizZeichenfeldViewModel {return QuizZeichenfeldViewModel(quizModel:quizModel,showsZeichenFeld:showsZeichenFeld)}
}

class QuizDevaAbfrageView: UIStackView {
    //Zeichenfeld und DevaButton
    var zeichenFeld:QuizZeichenfeldView!            { didSet { zeichenFeld.viewModel = viewModel.getViewModelForZeichenFeld() } }
    var devaButton:QuizDevaButton!
    
    var viewModel:QuizDevaAbfrageViewModel!{
        didSet{
            //zeichenfeld und devaButton initialisieren
            // und dem StackView hinzufügen
            zeichenFeld     = QuizZeichenfeldView(frame: CGRect.zero)
            devaButton      = QuizDevaButton(frame:CGRect.zero)
            addArrangedSubview(zeichenFeld)
            addArrangedSubview(devaButton)
            
            //Signale für das Zeichenfeld
            zeichenFeld.okButton.reactive.isHidden          <~ viewModel.okButtonIsHidden
            zeichenFeld.reactive.isHidden                   <~ viewModel.zeichenFeldIsHidden
            
            //Signale für den Devanagari Button
            devaButton.reactive.title(for: .normal)         <~ viewModel.devaButtonTitle.producer.map{$0 ?? ""}
            devaButton.reactive.isEnabled                   <~ viewModel.devaButtonIsEnabled
            devaButton.reactive.isHidden                    <~ viewModel.devaButtonIsHidden
            devaButton.reactive.backgroundColor             <~ viewModel.backGroundColor
        
            //Aktion für den DevanagariButton (zeigt Zeichenfeld)
            viewModel.showsZeichenFeld                      <~ devaButton.reactive.controlEvents(.touchUpInside).signal.map{_ in true}
        }
    }
}

class QuizDevaButton:UIButton{
    //MARK: layoutSubviews
    var lastSize = CGSize.zero
    override func layoutSubviews() {
        super.layoutSubviews()
        //passt die Größe der Schrift auf die Höhe des Knopfs an
        if lastSize != bounds.size{ titleLabel?.font = UIFont.boldSystemFont(ofSize: (bounds.size.height / 2)) }
        lastSize = bounds.size
    }
    
    //MARK: init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor                         = colorForDefault
        titleLabel?.adjustsFontSizeToFitWidth   = true
        titleLabel?.minimumScaleFactor          = 0.1
        titleLabel?.numberOfLines               = 1
        titleLabel?.font                        = UIFont.boldSystemFont(ofSize: 20)
    }
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented")  }
}
