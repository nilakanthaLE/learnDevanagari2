//
//  ZeichenInAbfrageView.swift
//  learnDevanagari2
//
//  Created by Matthias Pochmann on 18.11.17.
//  Copyright © 2017 Matthias Pochmann. All rights reserved.
//

import UIKit
import ReactiveSwift

class ZeichenInAbfrageViewModel{
    
    init(zeichenSatz:MutableProperty<[Zeichen]>,editable:Bool){
        editButtonIsHidden.value    = !editable
        zeichenSatz.producer.startWithValues { [weak self] zeichen in
            let anzahlReihen            = Int(ceil(sqrt(Double(zeichen.count))))
            let array                   = Array.init(repeating: Array.init(repeating: String(), count: anzahlReihen), count: anzahlReihen)
            var _zeichen                = zeichen
            func getAndRemoveFirst() -> String  { return _zeichen.count > 0 ? _zeichen.removeFirst().devanagari ?? String() : String() }
            self?.zeichenArray.value    = array.map{row in row.map{_ in  getAndRemoveFirst()} }
        }
    }
    var zeichenArray        = MutableProperty([[String]]())
    var editButtonIsHidden  = MutableProperty(false)
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
    
    func updateStack(zeichenArray:[[String]]){
        for subview in stackView.arrangedSubviews {subview.removeFromSuperview()}
        stackView.distribution  = .fillEqually
        _ = zeichenArray.map{ row in
            let hStack = UIStackView()
            hStack.axis             =       .horizontal
            hStack.distribution     =       .fillEqually
            stackView.addArrangedSubview(hStack)
            _ = row.map{ devaString in
                let centeredLabel = ViewWithLabelInCenter(frame: CGRect.zero)
                centeredLabel.label.text = devaString
                centeredLabel.layer.borderColor = UIColor.black.cgColor
                centeredLabel.layer.borderWidth = 0.25
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
    @IBOutlet weak var label: UILabel!
}
