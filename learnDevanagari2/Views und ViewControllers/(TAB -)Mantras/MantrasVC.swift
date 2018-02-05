//
//  MantrasVC.swift
//  learnDevanagari2
//
//  Created by Matthias Pochmann on 04.12.17.
//  Copyright © 2017 Matthias Pochmann. All rights reserved.
//

import UIKit
import ReactiveSwift



class MantrasViewModel:MantraViewModelProtocol{
    //MARK: MutableProperties
    //Array von Mutable Properties mit Label Texten
    // jede Änderung eines LabelTexts wird direkt angezeigt
    var labelTexte : [MutableProperty<NSAttributedString>]

    //sichtbare LabelTexte - enthalten weiße (bekannte) Zeichen
    // sind schwach sichtbar enthalten noch keine grüne Zeichen (Vor Animation grüne Zeichen)
    private var labelTexteHalbTransparent = [NSAttributedString]()
    
    //MARK: init
    init(attrStrings:[NSAttributedString]){
        labelTexte                          = attrStrings.map{MutableProperty($0)}
        labelTexteHalbTransparent           = labelTexte.map{$0.value}
    }
    
    var lektion:Int{ return Int(MainSettings.get()?.angemeldeterUser?.aktuelleLektion ?? 0) }
    
    //MARK: Methods
    //initLektion
    // bevor das View erscheint, werden die labelTexte passend zur aktuellen Lektion gesetzt
    func initLektion(){
        let bereitsBekannteZeichen      = MainSettings.get()?.angemeldeterUser?.allScoreZeichenGreaterZero(bisLektion: lektion - 2).map{$0.devanagari ?? ""}
        let rangesFuerBereitsBekannte   = String.getRanges(for: bereitsBekannteZeichen,attrStrings: labelTexte.map{$0.value})
        
        //rangesFuerBereitsBekannte enthält für jedes Label Ranges der bereits bekannten Zeichen
        // für jedes Label wird:
        // 1) ein attributeText erstellt, bei dem alle bekannten Zeichen weiß sind - alle anderen Zeichen sind nicht sichtbar
        // 2) ein zweiter attributeText erstellt, bei dem alle bekannten Zeichen weiß sind - alle anderen Zeichen schwach sichtbar sind
        for ranges in rangesFuerBereitsBekannte.enumerated(){
            //Mutable AttributedStrings für labelTexte und schwach sichtbare Label Texte erstellen
            let labelText                   = labelTexte[ranges.offset].value.asMutableAttrStrg
            let labelTextSchwachSichtbar    = labelTexteHalbTransparent[ranges.offset].asMutableAttrStrg
            //alle Zeichen entweder auf nicht sichbar oder schwach sichtbar setzen
            _ = labelText.colorCharacters(in: NSMakeRange(0, labelText.length), color: UIColor.clear)
            _ = labelTextSchwachSichtbar.colorCharacters(in: NSMakeRange(0, labelText.length), color: UIColor.init(white: 1, alpha: 0.5))
            //bei beiden Typen (schwach und nicht sichbar) alle bekannten Zeichen weiß färben
            for range in ranges.element{
                _ = labelText.colorCharacters(in: range, color: .white)
                _ = labelTextSchwachSichtbar.colorCharacters(in: range, color: .white)
            }
            //veränderten Wert neu setzen (für signal)
            labelTexte[ranges.offset].value                         = labelText
        }
    }
    //startAnimationForNeuGelernte
    // startet die Animation für das ergrünen neue gelernter Zeichen
    func startAnimationForNeuGelernte(){
        let attrStrings                     = labelTexte.map{$0.value}
        let neuGelernteZeichen              = MainSettings.get()?.angemeldeterUser?.allScoreZeichenGreaterZero(fuerLektion: lektion - 1).map{$0.devanagari ?? ""}
        let rangesFuerNeuGelernte           = String.getRanges(for: neuGelernteZeichen,attrStrings: attrStrings)
        animateLabeltexte(labelRanges: rangesFuerNeuGelernte)
    }
    
    //MARK: helper
    //animateLabeltexte
    // LabelTexte updaten --> neue Zeichen werden grün
    private func animateLabeltexte(labelRanges:[[NSRange]]){
        var currentStepIndex = 0
        //animateLabel
        // wird nach und nach für alle Label gestartet
        // 1) das aktuelle Label erscheint - wird halbtransparent mit bekannten zeichen weiß
        // 2) alle neu gelernten Zeichen werden nach und nach grün
        func animateLabel(){
            guard currentStepIndex < labelRanges.count else {return}
            let labelText       = labelTexte[currentStepIndex]
            let ranges          = labelRanges[currentStepIndex]
            //der aktuelle (unsichtbare) Labeltext wird zwischengespeichert
            // wenn es zu grünende Zeichen gibt, wird der halbtransparente Labeltext als Labeltext gesetzt
            // -> Label erscheint
            var labelTextVorher = labelText.value.asMutableAttrStrg
            if ranges.count > 0 { labelText.value     = labelTexteHalbTransparent[currentStepIndex] }
            
            //das Ergrünen neue gelernter Zeichen wird animiert
            animationForOneLabelText(labelText,labelTextVorher: labelTextVorher, ranges: ranges) {
                currentStepIndex += 1
                //das Label wird wieder auf den Text mit voll transparenter Schrift zurück gesetzt
                // -> nur weiße und grüne Zeichen sind noch sichtbar
                func hideLabelText(completion:@escaping ()->Void){
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                        labelText.value     = labelTextVorher
                        completion()
                    }
                }
                //wenn es zu grünende Zeichen für das Label gibt, wird das aktuelle Label zurückgesetzt (hideLabelText)
                // nicht mehr halbtransparente Schrift - sondern nur noch bekannte Zeichen sichtbar (weiß + grün)
                // -> danach mit nächstem Label neu starten
                if ranges.count > 0 { hideLabelText { DispatchQueue.main.asyncAfter(deadline: .now() + 1){ animateLabel() } }}
                else                { animateLabel() }
            }
        }
        animateLabel()
    }
    //animationForOneLabelText
    // animiert ein einzelnes Label
    // neu gelernte Zeichen werden nach und nach grün
    private func animationForOneLabelText(_ labelText:MutableProperty<NSAttributedString>,labelTextVorher:NSMutableAttributedString, ranges:[NSRange],completion:@escaping ()->Void){
        var currentStepIndex = 0
        //ein einzelnes grünes Zeichen erscheint
        // wird solange gestartet, bis alle neu gelernten Zeichen im Label grün geworden ist
        func animateZeichen(){
            guard currentStepIndex < ranges.count else { completion(); return}
            let range = ranges[currentStepIndex]
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                //der aktuelle Labeltext erhält ein update - enthält ein neues grünes Zeichen
                // der zwischen gespeicherte Labeltext erhält dieses neue grüne Zeichen auch
                labelText.value = labelText.value.colorChar(in: range, color: .green)
                _ = labelTextVorher.colorCharacters(in: range, color: .green)
                currentStepIndex += 1
                // neu starten mit nächstem grünen Zeichen
                animateZeichen()
            }
        }
        animateZeichen()
    }
    
}

class MantrasVC: MantraBasicVC {
    //MARK. Outlet
    @IBOutlet weak var weiterBarButton: UIBarButtonItem!
    
    //MARK: Properties
    var dismissToQuizConfigVC:MutableProperty<Void>?
    
    //MARK: ViewController LifeCycle
    override func viewDidLoad() {
        viewModel = MantrasViewModel(attrStrings:MantraViewIPadV().sortedLabels.map{$0.attributedText ?? NSAttributedString()})
        //wenn dismissToQuizConfigVC gesetzt ist, wird das Mantraview nach dem Lektionsquiz angezeigt
        // in diesem Fall führt ein BarButton "weiter" zur Zeichenübersicht und von dort zum QuizConfigVC zurück
        if dismissToQuizConfigVC == nil { navigationItem.rightBarButtonItem = nil }
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //vor dem Erscheinen des VC
        // -> Labels passend für aktuelle Lektion setzen
        (viewModel as? MantrasViewModel)?.initLektion()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //mit dem Erscheinen des VC
        // -> neu gelernte Zeichen werden nach und nach grün
        (viewModel as? MantrasViewModel)?.startAnimationForNeuGelernte()
    }
    
    //MARK: segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { (segue.destination.contentViewController as? ZeichenUbersichtVC)?.dismissToQuizConfigVC = dismissToQuizConfigVC }
}

//MARK: Views für Mantras
class MantraViewIPadH:NibLoadingView {
    @IBOutlet private var labels: [UILabel]!
    var sortedLabels:[UILabel]{ return labels.sorted(by: {$1.tag > $0.tag })}
}
class MantraViewIPadV:NibLoadingView {
    @IBOutlet private var labels: [UILabel]!
    var sortedLabels:[UILabel]{ return labels.sorted(by: {$1.tag > $0.tag })}
}


