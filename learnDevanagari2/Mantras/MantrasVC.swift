//
//  MantrasVC.swift
//  learnDevanagari2
//
//  Created by Matthias Pochmann on 04.12.17.
//  Copyright © 2017 Matthias Pochmann. All rights reserved.
//

import UIKit
import ReactiveSwift

class MantrasViewModel{
    var currentLektion          = MutableProperty(0)
    var labelTexte : [MutableProperty<NSAttributedString>]
    
    var iPadOrientation = (UIApplication.shared.delegate as? AppDelegate)?.iPadOrientation
    
   
    
    var labelTexteBereitsBekanntSichtbar = [NSAttributedString]()
    
    init(attrStrings:[NSAttributedString]){
        labelTexte                          = attrStrings.map{MutableProperty($0)}
        labelTexteBereitsBekanntSichtbar    = labelTexte.map{$0.value}
        currentLektion.producer.startWithValues{[weak self] lektion in
            //update der Labeltexte --> bekannte Zeichen weiß
            guard let _self = self else {return}
            let bereitsBekannteZeichen      = ScoreZeichen.getAllScoreGreaterZero(bisLektion: lektion - 2).map{$0.devanagari ?? ""}
            let rangesFuerBereitsBekannte   = MantrasViewModel.getRanges(for: bereitsBekannteZeichen,attrStrings: attrStrings)
            for ranges in rangesFuerBereitsBekannte.enumerated(){
                let labelText                       = _self.labelTexte[ranges.offset]
                var mutableAttrLabelText            = NSMutableAttributedString(attributedString:labelText.value)
                var labelTextSichtbar               = NSMutableAttributedString(attributedString:_self.labelTexteBereitsBekanntSichtbar[ranges.offset])
                labelTextSichtbar.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.init(white: 1, alpha: 0.5), range: NSMakeRange(0, mutableAttrLabelText.length))
                mutableAttrLabelText.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.clear, range: NSMakeRange(0, mutableAttrLabelText.length))
                for range in ranges.element{
                    mutableAttrLabelText    = NSMutableAttributedString(attributedString: mutableAttrLabelText.colorChar(in: range, color: .white))
                    labelTextSichtbar       = NSMutableAttributedString(attributedString: labelTextSichtbar.colorChar(in: range, color: .white))
                }
                labelText.value = mutableAttrLabelText
                _self.labelTexteBereitsBekanntSichtbar[ranges.offset]   = labelTextSichtbar
            }
        }
    }
    
    //animation für neu gelernte Zeichen
    //update der LabelTexte --> neue Zeichen werden grün
    func startAnimationForNeuGelernte(){
        let lektion     = currentLektion.value
        let attrStrings = labelTexte.map{$0.value}
        let neuGelernteZeichen              = ScoreZeichen.getAllScoreGreaterZero(fuerLektion: lektion - 1).map{$0.devanagari ?? ""}
        let rangesFuerNeuGelernte           = MantrasViewModel.getRanges(for: neuGelernteZeichen,attrStrings: attrStrings)
        animateLabeltexte(labelRanges: rangesFuerNeuGelernte)
    }
    private func animateLabeltexte(labelRanges:[[NSRange]]){
        var currentStepIndex = 0
        func animateLabel(){
            guard currentStepIndex < labelRanges.count else {return}
            let labelText   = labelTexte[currentStepIndex]
            let ranges       = labelRanges[currentStepIndex]
            
            var labelTextVorher = labelText.value
            if ranges.count > 0 { labelText.value     = labelTexteBereitsBekanntSichtbar[currentStepIndex] }
            animationForOneLabelText(labelText, ranges: ranges) {
                currentStepIndex += 1
                func hideLabelText(completion:@escaping ()->Void){
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                        //grüne zu labelTextVorher hinzu
                        for range in ranges{ labelTextVorher = labelTextVorher.colorChar(in: range, color: .green) }
                        labelText.value     = labelTextVorher
                        completion()
                    }
                }
                if ranges.count > 0 {hideLabelText { DispatchQueue.main.asyncAfter(deadline: .now() + 1){ animateLabel() } }}
                else {animateLabel()}
            }
        }
        animateLabel()
    }
    private func animationForOneLabelText(_ labelText:MutableProperty<NSAttributedString>,ranges:[NSRange],completion:@escaping ()->Void){
        var currentStepIndex = 0
        func animateZeichen(){
            guard currentStepIndex < ranges.count else { completion(); return}
            let range = ranges[currentStepIndex]
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                labelText.value = labelText.value.colorChar(in: range, color: .green)
                currentStepIndex += 1
                animateZeichen()
            }
        }
        animateZeichen()
    }
    private static func getRanges(for zeichen:[String],attrStrings:[NSAttributedString]) -> [[NSRange]]{
        return attrStrings.map{labelText in zeichen.map {labelText.string.rangesWithoutVokalzeichen(of: $0)}.flatMap { $0 } }
    }
}

class MantrasVC: UIViewController {
    var viewModel:MantrasViewModel! = MantrasViewModel(attrStrings:MantraViewIPadV().labels.sorted{$1.tag > $0.tag }.map{$0.attributedText ?? NSAttributedString()})
    
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
        viewModel.currentLektion.value = (UIApplication.shared.delegate as? AppDelegate)!.aktuelleLektion.value?.nummer ?? 0
        super.viewDidAppear(animated)
        viewModel.startAnimationForNeuGelernte()
    }

    
    
    

    
    
    var labels: [UILabel]!

}


//extension UILabel {
//    func boundingRectForCharacterRange(range: NSRange) -> CGRect? {
//
//        guard let attributedText = attributedText else { return nil }
//
//        let textStorage     = NSTextStorage(attributedString: attributedText)
//        let layoutManager   = NSLayoutManager()
//
//        textStorage.addLayoutManager(layoutManager)
//
//        let textContainer = NSTextContainer(size: bounds.size)
//        textContainer.lineFragmentPadding = 0.0
//
//        layoutManager.addTextContainer(textContainer)
//
//        var glyphRange = NSRange()
//
//        // Convert the range for glyphs.
//        layoutManager.characterRange(forGlyphRange: range, actualGlyphRange: &glyphRange)
//
//        return layoutManager.boundingRect(forGlyphRange: glyphRange, in: textContainer)
//    }
//}

//class LupenView:UIView{
//
//
//    let lineWidth:CGFloat = 3
//     // Only override draw() if you perform custom drawing.
//     // An empty implementation adversely affects performance during animation.
//    override func draw(_ rect: CGRect) {
//        backgroundColor = .clear
//        let context = UIGraphicsGetCurrentContext()
//        context?.addEllipse(in: bounds.insetBy(dx: lineWidth/2, dy: lineWidth/2))
//        context?.setStrokeColor(UIColor.blue.cgColor)
//        context?.setLineWidth(lineWidth)
//        context?.strokePath()
//    }
//
//
//
//}

