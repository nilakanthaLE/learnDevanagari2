//
//  ZeichenInAbfrageView.swift
//  learnDevanagari2
//
//  Created by Matthias Pochmann on 18.11.17.
//  Copyright © 2017 Matthias Pochmann. All rights reserved.
//

import UIKit
import ReactiveSwift
//import Result

protocol AbfrageZeichenViewModelProtocol:class {
    var zeichenArray:MutableProperty<[[(title:String,color:UIColor)]]>{get set}
    var editButtonIsHidden:MutableProperty<Bool> {get set}
}

class ZeichenInAbfrageViewModel:AbfrageZeichenViewModelProtocol{
    var zeichenArray        = MutableProperty([[(title:String,color:UIColor)]]())
    var editButtonIsHidden  = MutableProperty(false)
    var quizZeichenSatz:MutableProperty<[QuizZeichen]>
    init(zeichenSatz:MutableProperty<[QuizZeichen]>,editable:Bool, currentQuizZeichenStatusHasChanged:MutableProperty<QuizZeichen?>){
        quizZeichenSatz             = zeichenSatz
        editButtonIsHidden.value    = !editable
        zeichenArray <~ zeichenSatz.producer.map { ZeichenInAbfrageViewModel.getZeichenArray(quizZeichen: $0)}
        
        currentQuizZeichenStatusHasChanged.producer.startWithValues { [weak self] devaString in
            self?.setColor(for: devaString)
        }
    }
    
    
    private func setColor(for quizZeichen:QuizZeichen?){
        guard let quizZeichen = quizZeichen else {return}
        func updateZeichenArray(for quizZeichen:QuizZeichen) -> [[(title:String,color:UIColor)]]{
            var arbeitsArray    = zeichenArray.value
            guard let devaString = quizZeichen.zeichen.devanagari, let index     = getIndex(for: devaString, in: arbeitsArray.map{$0.map{$0.title}}) else {return arbeitsArray}
            var color:UIColor{
                let sameArray                   = ZeichenInAbfrageViewModel.arrayOfSame(array: quizZeichenSatz.value)
                let qZeichenMitAnteilCorrect    = ZeichenInAbfrageViewModel.arrayOfZeichenWithAnteilCorrect(array: sameArray)
                let anteilCorrect               = qZeichenMitAnteilCorrect.filter{$0.quizZeichen?.zeichen.devanagari == devaString}.first?.anteilCorrect ?? 0
                return ZeichenInAbfrageViewModel.colorForAnteilCorrect(anteilCorrect)
            }
            arbeitsArray[index.x][index.y].color = color
            return arbeitsArray
        }
        zeichenArray.value = updateZeichenArray(for: quizZeichen)
    }
    //array aus arrays von Zeichen und Anteil korrekter Antworten
    static func arrayOfSame(array:[QuizZeichen])-> [[QuizZeichen]]{
        return array.sorted{$0.zeichen.devanagari ?? "" < $1.zeichen.devanagari ?? ""}.reduce([[QuizZeichen]]()) { (result, quizZeichen) in
            var result = result
            if result.last?.first?.zeichen.devanagari == quizZeichen.zeichen.devanagari { result[result.count - 1].append(quizZeichen)}
            else { result.append([quizZeichen]) }
            return result
        }
    }
    static func arrayOfZeichenWithAnteilCorrect(array:[[QuizZeichen]]) -> [(quizZeichen:QuizZeichen?,anteilCorrect:Double)]{
        return array.reduce([(quizZeichen:QuizZeichen?,anteilCorrect:Double)](), { (result, arrayQZ)  in
            let correct:Double = Double(arrayQZ.filter{$0.status.value == .Correct}.count)
            return result.arrayByAppending(o: (quizZeichen:arrayQZ.first,anteilCorrect: correct/Double(arrayQZ.count)))
        })
    }
    static func colorForAnteilCorrect(_ anteilCorrect:Double) -> UIColor{
        return anteilCorrect == 0 ? .clear : anteilCorrect == 1 ? .green : .yellow
    }
    static func getZeichenArray(quizZeichen:[QuizZeichen]) -> [[(title:String,color:UIColor)]]{
        let start = Date()
        
        var zeichenMitAnteilCorrect = arrayOfZeichenWithAnteilCorrect(array:arrayOfSame(array: quizZeichen))
        let anzahlReihen            = Int(ceil(sqrt(Double(zeichenMitAnteilCorrect.count))))
        let array                   = Array.init(repeating: Array.init(repeating: String(), count: anzahlReihen), count: anzahlReihen)
        
        func getAndRemoveFirst() -> (title:String,color:UIColor)  {
            if zeichenMitAnteilCorrect.count > 0{
                let zeichenMitCorrect = zeichenMitAnteilCorrect.removeFirst()
                return (title:zeichenMitCorrect.quizZeichen?.anusvaraVisargaViramaZeichen?.devanagari ?? zeichenMitCorrect.quizZeichen?.zeichen.devanagari ?? String(),color:colorForAnteilCorrect(zeichenMitCorrect.anteilCorrect))
            }
            return (title: String() , color : .clear)
        }
        return array.map{row in row.map{_ in  getAndRemoveFirst()} }
    }
}


class ZeichenInAbfrageView: AbfrageZeichenView {
    
    override func editButtonPressed(_ sender: UIButton) {
        editButtonAction?()
    }
    
    var viewModel:AbfrageZeichenViewModelProtocol!{
        didSet{
            editButton.reactive.isHidden <~ viewModel.editButtonIsHidden.producer
            viewModel.zeichenArray.producer.startWithValues(){[weak self] zeichenArray in
                self?.updateStack(zeichenArray: zeichenArray)
            }
        }
    }
    var editButtonAction:(()->Void)?
    override func updateStack(zeichenArray:[[(title:String,color:UIColor)]]){
        let start = Date()
        defer { print("updateStack dauer: \(Date().timeIntervalSince(start))") }
        
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
}


class AbfrageZeichenView: NibLoadingView{
    override var nibName: String{return "ZeichenInAbfrageView"}
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    @IBAction func editButtonPressed(_ sender: UIButton){}
    func updateStack(zeichenArray:[[(title:String,color:UIColor)]]){}
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
