//
//  StartAnimationVC.swift
//  learnDevanagari2
//
//  Created by Matthias Pochmann on 07.12.17.
//  Copyright © 2017 Matthias Pochmann. All rights reserved.
//

import UIKit
import ReactiveSwift

class StartAnimationViewModel{
    var labelTexte : [MutableProperty<NSAttributedString>]
    var iPadOrientation = (UIApplication.shared.delegate as? AppDelegate)?.iPadOrientation
    
    init(attrStrings:[NSAttributedString]){
        func setClearColor(for attrString:NSAttributedString) -> NSAttributedString{
            let mutableAttrString = NSMutableAttributedString(attributedString: attrString)
            mutableAttrString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.clear, range: NSMakeRange(0, mutableAttrString.length))
            return mutableAttrString
        }
        labelTexte  = attrStrings.map{MutableProperty(setClearColor(for:$0))}
    }
    
    func animateLabelTexte(){
        func animateLabelText(_ labelText: MutableProperty<NSAttributedString>,labelID:Int,completion:@escaping ()->Void) {
            var currentStepIndex = 0
            func animateStep(){
                guard currentStepIndex < labelText.value.length else {completion(); return}
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.03){
                    var range = NSMakeRange(currentStepIndex, 1)
                    //Ausnahmen
                    if labelID == 7 && currentStepIndex == 33 {range = NSMakeRange(currentStepIndex, 3)}
                    if labelID == 8 && currentStepIndex == 13 {range = NSMakeRange(currentStepIndex, 2)}
                    if labelID == 9 && currentStepIndex == 24 {range = NSMakeRange(currentStepIndex, 3)}
                    
                    labelText.value = labelText.value.colorChar(in: range, color: .white)
                    currentStepIndex += 1
                    animateStep()
                }
            }
            animateStep()
        }
        var currentStepIndex = 0
        func animateLabel(){
            guard currentStepIndex < labelTexte.count else {return}
            let labelText = labelTexte[currentStepIndex]
            animateLabelText(labelText,labelID: currentStepIndex){
                animateLabel()
                currentStepIndex += 1
            }
        }
        animateLabel()
    }
    
}

class StartAnimationVC: UIViewController {
    var viewModel = StartAnimationViewModel(attrStrings:MantraViewIPadV().labels.sorted{$1.tag > $0.tag }.map{$0.attributedText ?? NSAttributedString()})
    let mantraViewIPadH = MantraViewIPadH()
    let mantraViewIPadV = MantraViewIPadV()
    
    override func viewDidLoad() {
        viewModel.iPadOrientation?.producer.startWithValues{[weak self] orientation in
            guard let orientation = orientation else {return}
            switch orientation{
            case .landscape:    self?.view = self?.mantraViewIPadH
            case .portrait:     self?.view = self?.mantraViewIPadV
            }
        }
        for label in mantraViewIPadH.labels.sorted(by: {$1.tag > $0.tag }).enumerated(){ label.element.reactive.attributedText <~ viewModel.labelTexte[label.offset] }
        for label in mantraViewIPadV.labels.sorted(by: {$1.tag > $0.tag }).enumerated(){ label.element.reactive.attributedText <~ viewModel.labelTexte[label.offset] }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.animateLabelTexte()
    }
}
