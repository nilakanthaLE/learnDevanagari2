//
//  QuizArtikulationPicker.swift
//  learnDevanagari2
//
//  Created by Matthias Pochmann on 25.10.17.
//  Copyright © 2017 Matthias Pochmann. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift

class QuizArtikulationPickerViewModel:PanelControlViewModel{
    var iPadOrientation = (UIApplication.shared.delegate as? AppDelegate)?.iPadOrientation
    let artikulationen = ["-----","velar","palatal","retroflex","dental","labial"]
    
    var selectedRow     = MutableProperty(0)
    
    required init(controlSetting: PanelControlSetting,quizModel:QuizModel) {
        super.init(controlSetting: controlSetting, quizModel: quizModel)
        selectedRow         <~ controlCurrentModus.producer.filter{$0 == .ShowsPruefergebnis || $0 == .Anzeige }.map{[weak self] _ in self?.correctRow ?? 0}
    }
    //helper
    var correctRow:Int? { return correctAnswer.value == nil ? nil : artikulationen.index(of: correctAnswer.value!) }
}

class QuizArtikulationPicker: UIPickerView,UIPickerViewDelegate,UIPickerViewDataSource,PanelControlProtocol {
    lazy var anchorHeightPortrait   = heightAnchor.constraint(equalToConstant: 50)
    lazy var anchorHeightLandscape  = heightAnchor.constraint(equalTo: widthAnchor)
    var artikulationPickerViewModel:QuizArtikulationPickerViewModel{ return (viewModel as! QuizArtikulationPickerViewModel) }
    var viewModel:PanelControlViewModel!{
        didSet{
            anchorHeightLandscape.priority = UILayoutPriority(999)
            anchorHeightPortrait.priority = UILayoutPriority(999)
            delegate        = self
            dataSource      = self
            reactive.isUserInteractionEnabled       <~ viewModel.isEnabled
            reactive.backgroundColor                <~ artikulationPickerViewModel.backGroundColor.producer
            reactive.selectedRow(inComponent: 0)    <~ artikulationPickerViewModel.selectedRow.producer
            reactive.isHidden                       <~ viewModel.isHidden.producer
            viewModel.userEingabe                   <~ reactive.selections.map                  { [weak self] (row,component)  in self?.artikulationPickerViewModel.artikulationen[row] }
            anchorHeightPortrait.reactive.constant  <~ viewModel.zeilenHoehe.producer.map       { $0 * 2 }
            
            artikulationPickerViewModel.iPadOrientation?.producer.startWithValues{ [weak self]  (orientation) in
                self?.anchorHeightLandscape.isActive    = (orientation == .landscape)
                self?.anchorHeightPortrait.isActive     = (orientation == .portrait)
            }
            
        }
    }
    //MARK: pickerView DataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int                                                 { return 1 }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int                  { return artikulationPickerViewModel.artikulationen.count  }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?   { return artikulationPickerViewModel.artikulationen[row]}
}
