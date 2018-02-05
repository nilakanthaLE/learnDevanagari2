//
//  QuizZeichenfeldView.swift
//  learnDevanagari2
//
//  Created by Matthias Pochmann on 06.11.17.
//  Copyright © 2017 Matthias Pochmann. All rights reserved.
//

import UIKit
import TesseractOCR
import ReactiveSwift


//MARK:QuizZeichenfeld
// Ein Zeichenfeld mit Texterkennung
// wenn Ok gedrückt wird, versucht tesseract das gezeichnete Zeichen zu erkennen
class QuizZeichenfeldViewModel{
    var showsZeichenFeld:MutableProperty<Bool>
    
    //MARK: Mutable Properties
    var userEingabePrüfen       = MutableProperty(false)
    var erkannteZeichen         = MutableProperty([String]())
    var erkanntesZeichen        = MutableProperty<String?>(nil)
    var nachZeichnenLabelText   = MutableProperty<String?>(nil)
    var backGroundColor         = MutableProperty(colorForDefault)
    var charWhiteList           = MutableProperty("")
    var useTesseract            = MutableProperty(false)
    
    //MARK: init
    init(quizModel:QuizModel, showsZeichenFeld    : MutableProperty<Bool>) {
        self.showsZeichenFeld                       = showsZeichenFeld
        quizModel.userEingabe.devanagari            <~ erkanntesZeichen
        quizModel.userEingabeDevaErkannteZeichen    <~ erkannteZeichen
        nachZeichnenLabelText                       <~ quizModel.currentQuizZeichen.producer.map { $0?.quizSetting.zeichenfeld == .Nachzeichnen ? $0?.zeichen.devanagari : nil }
        charWhiteList                               <~ quizModel.quizZeichenSatz.map{$0.map{$0.zeichen.devanagari ?? nil} .filter{$0 != nil} .reduce("") {$0 + $1!} }
        useTesseract                                <~ quizModel.currentQuizZeichen.producer.map   { $0?.quizSetting.zeichenfeld != .Nachzeichnen }
    }
}

class QuizZeichenfeldView: ZeichenfeldView,G8TesseractDelegate {
    private var tesseract: G8Tesseract?
    var viewModel : QuizZeichenfeldViewModel!{
        didSet{
            isUserInteractionEnabled = true
            initTesseract()
            //Nachzeichnen Label im Hintergrund
            // zeigt das korrekte Zeichen an, das der User nachzeichnen kann
            nachZeichnenLabel.reactive.text                     <~ viewModel.nachZeichnenLabelText.producer
            viewModel.nachZeichnenLabelText.producer.start()    { [weak self] _ in self?.currentSize = self?.bounds.size }
        }
    }
    
    //MARK: Button Actions
    override func resetButtonPressed(_ sender: UIButton)    { currentSize = bounds.size }
    override func okButtonPressed(_ sender: UIButton)       {
        // falls Nachzeichenmodus, wird tesseract nicht genutzt
        if viewModel.useTesseract.value { ocr(for: imageView.image) }
        viewModel.showsZeichenFeld.value = false
    }
    
    //MARK: helper
    //startet das Erkennen des gezeichneten Zeichen
    // setzt viewModel Werte
    private func ocr(for image:UIImage?){
        guard let image = image else {return}
        //tesseract für die Erkennung initialisieren
        tesseract?.image            = image
        tesseract?.charWhitelist    = viewModel.charWhiteList.value
        tesseract?.recognize()
        // Ergebnis (erkannte Zeichen) holen und ins Strings umwandeln
        let recognized              = tesseract?.characterChoices as? [[G8RecognizedBlock]]
        let charArray               = getCharArray(for:recognized)
        //ViewModel Werte für erkannte Zeichen setzen
        viewModel.erkannteZeichen.value     = charArray
        viewModel.erkanntesZeichen.value    = charArray.first
    }
    //wandelt das Ergebnisarray von Tesseract in Array aus Strings um
    private func getCharArray(for recognizedArray:[[G8RecognizedBlock]]?) -> [String]{
        var ergebnis = Set<String>()
        _ = recognizedArray.map   { (block)  in
            block.map{ (_block) in
                let sorted = _block.sorted{$0.confidence > $1.confidence}
                _ = sorted.map{ (__block)  in ergebnis.insert(__block.text) }
            }
        }
        return Array(ergebnis.filter{$0 != " "})
    }
    //inititalisiert Tesseract
    private func initTesseract(){
        tesseract                       = G8Tesseract(language: "san", engineMode: G8OCREngineMode.tesseractOnly)
        tesseract?.delegate             = self
        tesseract?.pageSegmentationMode = .singleWord
    }
}









