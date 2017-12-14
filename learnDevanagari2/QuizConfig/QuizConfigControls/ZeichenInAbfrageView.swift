//
//  ZeichenInAbfrageView.swift
//  learnDevanagari2
//
//  Created by Matthias Pochmann on 18.11.17.
//  Copyright © 2017 Matthias Pochmann. All rights reserved.
//

import UIKit
import ReactiveSwift
import Result

class ZeichenInAbfrageViewModel{
    var zeichenArray        = MutableProperty([[(title:String,color:UIColor)]]())
    var editButtonIsHidden  = MutableProperty(false)
    init(zeichenSatz:MutableProperty<[QuizZeichen]>,editable:Bool){
        editButtonIsHidden.value    = !editable
        zeichenArray <~ zeichenSatz.producer.map { ZeichenInAbfrageViewModel.getZeichenArray(quizZeichen: $0)}
        
        var updateProducers = CompositeDisposable()
        zeichenSatz.producer.startWithValues {[weak self] quizZeichen in
            guard let _self = self else {return}
            updateProducers.dispose()
            updateProducers = CompositeDisposable()
            updateProducers += _self.zeichenArray <~ SignalProducer.merge(zeichenSatz.value.map{$0.status.producer}).map{_ in ZeichenInAbfrageViewModel.getZeichenArray(quizZeichen: zeichenSatz.value)}
        }
    }
    
    
    
    static func getZeichenArray(quizZeichen:[QuizZeichen]) -> [[(title:String,color:UIColor)]]{
        //array aus arrays von Zeichen und Anteil korrekter Antworten
        func arrayOfSame(array:[QuizZeichen])-> [[QuizZeichen]]{
            return array.sorted{$0.zeichen.devanagari ?? "" < $1.zeichen.devanagari ?? ""}.reduce([[QuizZeichen]]()) { (result, quizZeichen) in
                var result = result
                if result.last?.first?.zeichen.devanagari == quizZeichen.zeichen.devanagari { result[result.count - 1].append(quizZeichen)}
                else { result.append([quizZeichen]) }
                return result
            }
        }
        func arrayOfZeichenWithAnteilCorrect(array:[[QuizZeichen]]) -> [(zeichen:Zeichen?,anteilCorrect:Double)]{
            return array.reduce([(zeichen:Zeichen?,anteilCorrect:Double)](), { (result, arrayQZ)  in
                let correct:Double = Double(arrayQZ.filter{$0.status.value == .Correct}.count)
                return result.arrayByAppending(o: (zeichen:arrayQZ.first?.zeichen,anteilCorrect: correct/Double(arrayQZ.count)))
            })
        }
        var zeichenMitAnteilCorrect = arrayOfZeichenWithAnteilCorrect(array:arrayOfSame(array: quizZeichen))
        let anzahlReihen            = Int(ceil(sqrt(Double(zeichenMitAnteilCorrect.count))))
        let array                   = Array.init(repeating: Array.init(repeating: String(), count: anzahlReihen), count: anzahlReihen)
        
        func getAndRemoveFirst() -> (title:String,color:UIColor)  {
            if zeichenMitAnteilCorrect.count > 0{
                let zeichen = zeichenMitAnteilCorrect.removeFirst()
                return (title:zeichen.zeichen?.devanagari ?? String(),color:zeichen.anteilCorrect == 0 ? .clear : zeichen.anteilCorrect == 1 ? .green : .yellow)
            }
            return (title: String() , color : .clear)
        }
        return array.map{row in row.map{_ in  getAndRemoveFirst()} }
    }
}
class ZeichenInAbfrageView: NibLoadingView {
    var viewModel:ZeichenInAbfrageViewModel!{
        didSet{
            editButton.reactive.isHidden <~ viewModel.editButtonIsHidden
            viewModel.zeichenArray.producer.startWithValues(){[weak self] zeichenArray in
                self?.updateStack(zeichenArray: zeichenArray)
            }
        }
    }
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    
    func updateStack(zeichenArray:[[(title:String,color:UIColor)]]){
        for subview in stackView.arrangedSubviews {subview.removeFromSuperview()}
        stackView.distribution  = .fillEqually
        _ = zeichenArray.map{ row in
            let hStack = UIStackView()
            hStack.axis             =       .horizontal
            hStack.distribution     =       .fillEqually
            stackView.addArrangedSubview(hStack)
            _ = row.map{ devaString in
                let centeredLabel = ViewWithLabelInCenter(frame: CGRect.zero)
                centeredLabel.label.text                = devaString.title
                centeredLabel.view.backgroundColor      = devaString.color
                hStack.addArrangedSubview(centeredLabel)
            }
        }
    }

    @IBAction func editButtonPressed(_ sender: UIButton) {
        editButtonAction?()
    }
    var editButtonAction:(()->Void)?
}

class ViewWithLabelInCenter:NibLoadingView{
    @IBOutlet weak var label: UILabel!{
        didSet{
            label.backgroundColor     = .clear
            layer.borderColor = UIColor.black.cgColor
            layer.borderWidth = 0.25
        }
    }
}
