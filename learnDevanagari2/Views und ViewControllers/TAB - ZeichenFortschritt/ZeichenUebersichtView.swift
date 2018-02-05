//
//  ZeichenUebersichtView.swift
//  learnDevanagari2
//
//  Created by Matthias Pochmann on 29.11.17.
//  Copyright © 2017 Matthias Pochmann. All rights reserved.
//

import Foundation
import UIKit
import ReactiveSwift
import Result

typealias ButtonData = (title:String, score: Double)

//MARK: - ZeichenUebersichtViewModel
// zeigt den aktuellen Fortschritt der (Grund-)Zeichen
class ZeichenUebersichtViewModel{
    //MARK: - Properties
    fileprivate var zeichenButtonPressed:MutableProperty<UIView?>
    fileprivate var buttonTitles    = [String?](){ didSet{ buttonData = buttonTitles.map{ MutableProperty((title:$0 ?? "", score: 0)) } } }
    fileprivate var buttonData      = [MutableProperty<ButtonData>]()
    private var userButtonData:[ButtonData]     { return (getButtonData(for: buttonTitles) ) }
    
    //MARK: - init
    init(zeichenButtonPressed:MutableProperty<UIView?>){ self.zeichenButtonPressed = zeichenButtonPressed }
    
    //MARK: - helper
    fileprivate func getButtonData(for deva:String?)        -> MutableProperty<ButtonData>?     { return buttonData.filter{$0.value.title == deva}.first }
    fileprivate func getButtonData(title:String?)           -> ButtonData                       { return (title ?? "" , MainSettings.get()?.angemeldeterUser?.getScoreZeichen(for: title)?.grundZeichenScore ?? 0) }
    fileprivate func getButtonData(for titles:[String?])    -> [ButtonData]                     { return titles.map { getButtonData(title: $0) } }
    fileprivate func updateScores(){
        for bData in buttonData{
            let title = bData.value.title
            let score = getButtonData(title: title).score
            bData.value = (title:title,score:score)
        }
    }
}

class ZeichenUebersichtView:NibLoadingView{
    func updateButtonData() { viewModel.updateScores() }
    var viewModel:ZeichenUebersichtViewModel! {
        didSet{
            viewModel.buttonTitles = zeichenButtons.map{$0.currentTitle}
            //Signals für Zeichen-Buttons setzen
            // 1) Style (Farbe, Rahmen usw. setzen)
            // 2) ViewModel Action für Button Pressed setzen (Popup für SubZeichen anzeigen)
            for button in zeichenButtons  {
                viewModel.getButtonData(for: button.currentTitle)?.producer.startWithValues     { buttonData in button.setStyle(for: buttonData.score) }
                viewModel.zeichenButtonPressed <~ button.reactive.controlEvents(.touchUpInside).producer.map{$0}
            }
        }
    }
    //MARK: - IBOutlets
    @IBOutlet private var zeichenButtons: [UIButton]!
}


