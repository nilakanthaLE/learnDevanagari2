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
class ZeichenUebersichtViewModel{
    fileprivate var zeichenButtonPressed:MutableProperty<UIView?>
    fileprivate var buttonTitles = [String?](){ didSet{ buttonData = buttonTitles.map{ MutableProperty((title:$0 ?? "", score: 0)) } } }
    fileprivate var buttonData = [MutableProperty<ButtonData>]()
    
    fileprivate func updateScores(){
        for bData in buttonData{
            let title = bData.value.title
            let score = MainSettings.get()?.angemeldeterUser?.getButtonData(title: title).score ?? 0
            bData.value = (title:title,score:score)
        }
    }
    fileprivate func getButtonData(for deva:String?) -> MutableProperty<ButtonData>?{ return buttonData.filter{$0.value.title == deva}.first }
    private var userButtonData:[ButtonData]     { return (MainSettings.get()?.angemeldeterUser?.getButtonData(for: buttonTitles) ?? [ButtonData]()) }
    init(zeichenButtonPressed:MutableProperty<UIView?>){
        self.zeichenButtonPressed = zeichenButtonPressed
    }
}

class ZeichenUebersichtView:NibLoadingView{
    func updateButtonData() { viewModel.updateScores() }
    var viewModel:ZeichenUebersichtViewModel! {
        didSet{
            viewModel.buttonTitles = zeichenButtons.map{$0.currentTitle}
            for button in zeichenButtons  {
                viewModel.getButtonData(for: button.currentTitle)?.producer.startWithValues{buttonData in ZeichenUebersichtView.setStyle(for: button, score: buttonData.score)}
                viewModel.zeichenButtonPressed <~ button.reactive.controlEvents(.touchUpInside).producer.map{$0}
            }
            
        }
    }
    @IBOutlet private var zeichenButtons: [UIButton]!
    
    //helper
    static func setStyle(for view:UIView, score:Double){
        let isHidden = score == 0
        if let button = view as? UIButton{
            button.setTitleColor(isHidden ? .clear : .white, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        }
        
        
        view.layer.borderColor  = UIColor.white.cgColor
        view.layer.borderWidth  = isHidden ? 0 : 1
        view.backgroundColor  = berechneFarbe(score: score)
    }
    
    static func berechneFarbe(score:Double) -> UIColor{
        guard score > 0 else    { return .clear}
        var rot:CGFloat         { return score < 0.5 ? CGFloat(1)  : CGFloat(-2 * score + 2) }
        var gruen:CGFloat       { return score < 0.5 ? CGFloat(score * 2) : CGFloat(1) }
        return UIColor.init(red: rot, green: gruen, blue: 0, alpha: 1)
    }
}


