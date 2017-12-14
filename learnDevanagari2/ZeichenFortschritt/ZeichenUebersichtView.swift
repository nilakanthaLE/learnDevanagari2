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

fileprivate typealias ButtonData = (String, SignalProducer<Double, NoError>?)
class ZeichenUebersichtViewModel{
    var buttonTitles = MutableProperty([String?]())
    init(){ buttonTitles.producer.startWithValues {[weak self] titles in
//        self?.scoreForButtons.value = titles.map{ ($0 ?? "",ScoreZeichen.getOrCreate(devaString: $0 )?.scoreProducer) } }
        }
    }
    fileprivate var scoreForButtons =  MutableProperty([ButtonData]())
}

class ZeichenUebersichtView:NibLoadingView{
    var viewModel:ZeichenUebersichtViewModel!   { didSet{ viewModel.scoreForButtons.signal.observeValues{ [weak self] datas in self?.setObserverForButtons(buttonDatas: datas) } }}
    func setButtonData() {
        guard viewModel.buttonTitles.value.count == 0 else {return}
        viewModel.buttonTitles.value = zeichenButtons.map{$0.currentTitle}
    }
    
    @IBOutlet var zeichenButtons: [UIButton]!   { didSet{ for button in zeichenButtons { ZeichenUebersichtView.setStyle(for: button, score: 0) } } }
    
    //helper
    private func setObserverForButtons(buttonDatas:[ButtonData]){
        for data in buttonDatas{
            let button = getButton(for: data.0)
            data.1?.producer.startWithValues{ score in ZeichenUebersichtView.setStyle(for: button, score: score) }
        }
    }
    private func getButton(for devaString:String?) -> UIButton{ return zeichenButtons.filter{$0.currentTitle == devaString}.first ?? UIButton()}
    private static func setStyle(for button:UIButton, score:Double){
        func berechneFarbe(score:Double) -> UIColor{
            guard score > 0 else    { return .clear}
            var rot:CGFloat         { return score < 0.5 ? CGFloat(1)  : CGFloat(-2 * score + 2) }
            var gruen:CGFloat       { return score < 0.5 ? CGFloat(score * 2) : CGFloat(1) }
            return UIColor.init(red: rot, green: gruen, blue: 0, alpha: 1)
        }
        let isHidden = score == 0
        button.setTitleColor(isHidden ? .clear : .white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        button.layer.borderColor  = UIColor.white.cgColor
        button.layer.borderWidth  = isHidden ? 0 : 1
        button.backgroundColor  = berechneFarbe(score: score)
    }
}


//
//
//func ~> <R> (
//    backgroundClosure:   @escaping () -> R,
//    mainClosure:         @escaping (_ result: R) -> ())
//{
//    serial_queue.async {
//        let result = backgroundClosure()
//        DispatchQueue.main.async(execute: {
//            mainClosure(result)
//        })
//    }
//}
//private let serial_queue = DispatchQueue(label: "serial-worker")

