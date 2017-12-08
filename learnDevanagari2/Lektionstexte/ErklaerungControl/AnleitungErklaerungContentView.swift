//
//  AnleitungErklaerungContentView.swift
//  learnDevanagari2
//
//  Created by Matthias Pochmann on 28.11.17.
//  Copyright © 2017 Matthias Pochmann. All rights reserved.
//

import Foundation
import UIKit
import ReactiveSwift

fileprivate struct ViewInStackViewModelData{
    var isHidden    = true
    var viewModel:Any?
    init(isHidden:Bool,viewModel:Any?){
        self.isHidden           = isHidden
        self.viewModel          = viewModel
    }
}

class AnleitungErklaerungContentViewModel{
    var lektionsText : MutableProperty<LektionsText>
    var numberOfVisibleViews = MutableProperty(1)
    init(lektionsText:MutableProperty<LektionsText>){
        self.lektionsText   = lektionsText
        viewModelsForViewsInStackDataArray  <~ self.lektionsText.producer.map{AnleitungErklaerungContentViewModel.getViewModelsForViewsInStackDataArray(lektionsText: $0)}
        numberOfVisibleViews                <~ viewModelsForViewsInStackDataArray.producer.map{$0.filter{!$0.isHidden}.count}
    }
    
    
    fileprivate var viewModelsForViewsInStackDataArray   = MutableProperty([ViewInStackViewModelData]())
    private static func getViewModelsForViewsInStackDataArray(lektionsText:LektionsText?) -> [ViewInStackViewModelData]{
        guard let lektionsText = lektionsText else {return [ViewInStackViewModelData]()}
        var ergebnis = [ViewInStackViewModelData]()
        ergebnis.append(ViewInStackViewModelData(isHidden: false, viewModel: StackLabelViewModel(labelText: lektionsText.erklaerung)))
        ergebnis.append(ViewInStackViewModelData(isHidden: lektionsText.erklaerung2 == nil, viewModel: StackLabelViewModel(labelText: lektionsText.erklaerung2)))
        let artikulationsViewmodel = getViewModelsForArtikulationViews()
        for i in 0 ..< 5 {
            ergebnis.append(ViewInStackViewModelData(isHidden: !lektionsText.mitArtikulationAnleitungViews, viewModel: artikulationsViewmodel[i]))
        }
        return ergebnis
    }
    
    
    private static func getViewModelsForArtikulationViews() -> [ArtikulationsAnleitungViewModel]{
        var ergebnis = [ArtikulationsAnleitungViewModel]()
        for data in getArtikulationViewData(){
            ergebnis.append( ArtikulationsAnleitungViewModel(artikulationAnleitungViewData: data) )
        }
        return ergebnis
    }
}

class AnleitungErklaerungContentView: NibLoadingView {
    var viewModel:AnleitungErklaerungContentViewModel!{
        didSet{
            viewModel.viewModelsForViewsInStackDataArray.producer.startWithValues{[weak self] array in self?.setViewsInStack(dataArray:array)}
        }
    }
    @IBOutlet private weak var stack: UIStackView!
    private func setViewsInStack(dataArray:[ViewInStackViewModelData]){
        for subview in stack.arrangedSubviews.enumerated(){
            subview.element.isHidden                                    = dataArray[subview.offset].isHidden
            (subview.element as? StackLabelView)?.viewModel             = dataArray[subview.offset].viewModel as? StackLabelViewModel
            (subview.element as? ArtikulationsAnleitungView)?.viewModel = dataArray[subview.offset].viewModel as? ArtikulationsAnleitungViewModel
        }
    }
}
