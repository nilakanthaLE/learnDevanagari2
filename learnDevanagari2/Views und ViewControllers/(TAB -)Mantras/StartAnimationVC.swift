//
//  StartAnimationVC.swift
//  learnDevanagari2
//
//  Created by Matthias Pochmann on 07.12.17.
//  Copyright © 2017 Matthias Pochmann. All rights reserved.
//

import UIKit
import ReactiveSwift

//MARK: StartAnimation
// zeigt die Animation, nach Start der App
// die Mantras werden Zeichen für Zeichen geschrieben
class StartAnimationViewModel:MantraViewModelProtocol{
    var labelTexte : [MutableProperty<NSAttributedString>]
    
    //MARK: init
    init(attrStrings:[NSAttributedString]){ labelTexte  = attrStrings.map{ MutableProperty( $0.asMutableAttrStrg.colorCharacters(in: NSMakeRange(0, $0.length), color: UIColor.clear)) } }
    
    //MARK: methode
    //animateLabelTexte
    // animiert alle Labels
    // ruft sich selbst auf, bis alle Labels erschienen sind
    func animateLabelTexte(){
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
    
    //MARK: helper
    //animateLabelText
    // animiert ein einzelnes Label
    // nach und nach werden alle Zeichen sichtbar
    private func animateLabelText(_ labelText: MutableProperty<NSAttributedString>,labelID:Int,completion:@escaping ()->Void) {
        var currentStepIndex = 0
        func animateStep(){
            guard currentStepIndex < labelText.value.length else {completion(); return}
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.03){
                var range = NSMakeRange(currentStepIndex, 1)
                //Ausnahmen wegen Apple Bug
                // (kommt mit einigen Ligaturen nicht zurecht)
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
}
class StartAnimationVC: MantraBasicVC {
    override func viewDidLoad() {
        viewModel = StartAnimationViewModel(attrStrings:MantraViewIPadV().sortedLabels.map{$0.attributedText ?? NSAttributedString()})
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        (viewModel as? StartAnimationViewModel)?.animateLabelTexte()
    }
}


//MARK: BasisKlassen und Protocol für MantraViews
class MantraBasicVC:UIViewController{
    var viewModel:MantraViewModelProtocol!
    let mantraViewIPadH = MantraViewIPadH()
    let mantraViewIPadV = MantraViewIPadV()
    override func viewDidLoad() {
        //je nach Orientierung des Geräts wird eine andere Anordnung der Mantras angezeigt
        iPadOrientation?.producer.startWithValues{[weak self] orientation in
            guard let orientation = orientation else {return}
            switch orientation{
            case .landscape:    self?.view = self?.mantraViewIPadH
            case .portrait:     self?.view = self?.mantraViewIPadV
            }
        }
        //verbindet die texte der Labels mit den ViewModel Daten
        for label in mantraViewIPadH.sortedLabels{ label.reactive.attributedText <~ viewModel.labelTexte[label.tag] }
        for label in mantraViewIPadV.sortedLabels{ label.reactive.attributedText <~ viewModel.labelTexte[label.tag] }
    }
}
protocol MantraViewModelProtocol{
    var labelTexte : [MutableProperty<NSAttributedString>] {get set}
}
