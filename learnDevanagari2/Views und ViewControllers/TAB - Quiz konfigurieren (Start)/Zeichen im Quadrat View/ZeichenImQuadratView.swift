//
//  ZeichenInAbfrageView.swift
//  learnDevanagari2
//
//  Created by Matthias Pochmann on 18.11.17.
//  Copyright © 2017 Matthias Pochmann. All rights reserved.
//

import UIKit
import ReactiveSwift

//MARK:ZeichenImQuadratViewModelProtocol
// Protokol für die Verwendbarkeit verschiedener Viewmodels für das ZeichenImQuadratView
//1) Zeichen in der Lektion + Zeichen für freies Üben
//2) Zeichen in der Grundauswahl bei der Konfiguration des Abfragezeichensatzes fürs freie Üben
protocol ZeichenImQuadratViewModelProtocol:class {
    var zeichenUndFarbeArray:MutableProperty<[[(title:String,color:UIColor)]]>{get set}
    var editButtonIsHidden:MutableProperty<Bool> {get set}
}

//MARK: ViewModel
class AbfrageZeichenViewModel:ZeichenImQuadratViewModelProtocol{
    var zeichenUndFarbeArray    = MutableProperty([[(title:String,color:UIColor)]]())
    var editButtonIsHidden      = MutableProperty(false)
    var quizZeichenSatz:MutableProperty<[QuizZeichen]>
    var segueIdentifier:MutableProperty<String>?
    var arrayOfSameQZ = MutableProperty([[QuizZeichen]]())
    init(zeichenSatz:MutableProperty<[QuizZeichen]>,editable:Bool, currentQuizZeichenStatusHasChanged:MutableProperty<QuizZeichen?>,segueIdentifier:MutableProperty<String>?){
        quizZeichenSatz             = zeichenSatz
        editButtonIsHidden.value    = !editable
        self.segueIdentifier        = segueIdentifier
        
        // wenn sich der QuizZeichenSatz ändert, wird
        // 1) neues Array mitSubarray aus Quizzeichen identischer Zeichen generiert
        arrayOfSameQZ           <~ zeichenSatz.producer.map     { AbfrageZeichenViewModel.arrayOfSame(array: $0)}
        
        // 2) update des Arrays von Zeichen und Anzeigefarbe
        zeichenUndFarbeArray    <~ arrayOfSameQZ.producer.map   { AbfrageZeichenViewModel.getZeichenArray(arrayOfSame: $0)}
        
        //Wenn der User im Quiz die Abfragen eines Zeichen beantwortet
        // wird die Farbe des Zeichens aktualisiert
        // repräsentiert den Abfragestatus des  Zeichens:
        //.clear    = noch kein QuizZeichen wurd abgefragt
        //.yellow   = mindestens ein QuizZeichen wurde korrekt beantwortet, aber nicht alle
        //.green    = alle QuizZeichen zum Zeichen wurden korrekt beantwortet
        currentQuizZeichenStatusHasChanged.producer.startWithValues { [weak self] quizZeichen in self?.setColor(for: quizZeichen) }
    }
    
    //MARK: helper
    // aktualisiert den Farbewert für ein QuizZeichen
    private func setColor(for quizZeichen:QuizZeichen?){
        guard let index  = getIndex(for: quizZeichen?.devaString, in: zeichenUndFarbeArray.value.map{$0.map{$0.title}}) else {return}
        let quizZeichenMitGesuchtemZeichen                  = (arrayOfSameQZ.value.filter{$0.first?.zeichen.devanagari == quizZeichen?.zeichen.devanagari}).first ?? [QuizZeichen]()
        let zeichenWithAnteilCorrect                        = AbfrageZeichenViewModel.zeichenWithAnteilCorrect(quizZeichen: quizZeichenMitGesuchtemZeichen)
        zeichenUndFarbeArray.value[index.x][index.y].color  = AbfrageZeichenViewModel.colorForAnteilCorrect(zeichenWithAnteilCorrect.anteilCorrect)
    }
    // das QuizZeichenArray kann für einzelne Zeichen mehrere QuizZeichen enthalten (Abfrage zeichenfeld / Anzeige Zeichenfeld)
    // Methode erzeugt ein Array in denen QuizZeichen mit identischem Zeichen in Subarray gruppiert werden
    static func arrayOfSame(array:[QuizZeichen])-> [[QuizZeichen]]{
        //1) Array nach zeichen.devanagari sortieren
        //2) zweidimensionales ZielArray erzeugen
        //3) durch Array (1) iterieren und dem Zielarray
        // entweder das aktuellen QuizZeichen in einem neuen Subarray oder zum letzten Subarray hinzufügen
        // wenn das letzte Zeichen gleich dem Vorgängerzeichen ist -> dem letzten Subarray hinzufügen
        // sonst in einem neuen Subarray hinzufügen
        return array.sorted{$0.zeichen.devanagari ?? "" < $1.zeichen.devanagari ?? ""}.reduce([[QuizZeichen]]()) { (result, quizZeichen) in
            var result = result
            if result.last?.first?.zeichen.devanagari == quizZeichen.zeichen.devanagari { result[result.count - 1].append(quizZeichen) }
            else { result.append([quizZeichen]) }
            return result
        }
    }
    // Methode, die ein Array aus QuizZeichen mit gleichem Zeichen
    // in ein QuadratArray von title-farbe Paaren umwandelt
    static func getZeichenArray(arrayOfSame:[[QuizZeichen]]) -> [[(title:String,color:UIColor)]]{
        //erzeugt ein Array mit <QuizZeichen und anteilCorrect>
        var zeichenMitAnteilCorrect = arrayOfZeichenWithAnteilCorrect(array:arrayOfSame)
        //erzeugt QuadratArray mit leeren Strings
        let quadratArray            = createQuadratArray(menge: zeichenMitAnteilCorrect.count, repeating: String())
        // wandelt ein <ZeichenMitAnteilCorrect> in Tuple aus <titleUndFarbe> um
        func createStringUndFarbe(fuer anteilCorrectZeichen:(quizZeichen: QuizZeichen?, anteilCorrect: Double)?) -> (title:String,color:UIColor){
            let title = anteilCorrectZeichen?.quizZeichen?.anusvaraVisargaViramaZeichen?.devanagari ?? anteilCorrectZeichen?.quizZeichen?.zeichen.devanagari ?? String()
            let color   = colorForAnteilCorrect(anteilCorrectZeichen?.anteilCorrect)
            return (title: title , color : color)
        }
        return quadratArray.map{row in row.map{_ in createStringUndFarbe(fuer: getAndRemoveFirst(from: &zeichenMitAnteilCorrect))}}
    }
    //Methode, die ein Array aus QuizZeichen mit gleichem Zeichen
    // in ein Array aus Paaren von <Quizzeichen (eins pro Subarray) und dem Anteil richtiger Antworten> umwandelt
    static func arrayOfZeichenWithAnteilCorrect(array:[[QuizZeichen]]) -> [(quizZeichen:QuizZeichen?,anteilCorrect:Double)]{
        return array.map{zeichenWithAnteilCorrect(quizZeichen: $0)}
    }
    //ermittelt die Farbe für den Correct Wert
    // nil oder 0: clear | 1: grün | zwischen 0 und 1: gelb
    static func colorForAnteilCorrect(_ anteilCorrect:Double?) -> UIColor{ return anteilCorrect == 1 ? .green : anteilCorrect ?? 0 > 0 ? .yellow : .clear }
    
    //aus Subarray von QuizZeichen gleicher Zeichen
    // wird ein Tuple aus erstem QZ und anteilCorrecter QZ im Subarray erzeugt
    static func zeichenWithAnteilCorrect(quizZeichen:[QuizZeichen]) -> (quizZeichen:QuizZeichen?,anteilCorrect:Double){
        guard quizZeichen.count > 0 else {return (quizZeichen:nil,anteilCorrect:0) }
        let correct:Double = Double(quizZeichen.filter{$0.status.value == .Correct}.count)
        return (quizZeichen:quizZeichen.first,anteilCorrect:correct/Double(quizZeichen.count))
    }
}

//MARK:ZeichenImQuadratView
// Anzeige von Zeichen
// besteht aus einem Quadrat mit gleicher Anzahl von Zeilen und Spalten
// zeigt Zeichen für:
// 1) Zeichen in der Lektion, 2) Zeichen für freies Üben
// 3) Zeichen in der Grundauswahl bei der Konfiguration des Abfragezeichensatzes fürs freie Üben
class ZeichenImQuadratView: ZeichenView {
    var viewModel:ZeichenImQuadratViewModelProtocol!{
        didSet{
            editButton.reactive.isHidden                                                                <~ viewModel.editButtonIsHidden.producer
            viewModel.zeichenUndFarbeArray.producer.startWithValues()                                   { [weak self] zeichenArray in self?.updateStack(zeichenArray: zeichenArray) }
            if let segueIdentifier = (viewModel as? AbfrageZeichenViewModel)?.segueIdentifier           { segueIdentifier  <~ editButton.reactive.controlEvents(UIControlEvents.touchUpInside).signal.map{_ in "showZeichenSatzConfig"} }
        }
    }
    override func updateStack(zeichenArray:[[(title:String,color:UIColor)]]){
        let start = Date()
        defer { print("updateStack dauer: \(Date().timeIntervalSince(start))") }
        
        //Subviews entfernen
        for subview in stackView.arrangedSubviews {subview.removeFromSuperview()}
        
        // StackView in StackView neu aufbauen - mit Titel und Color
        for row in zeichenArray{
            let hStack = UIStackView.horizontalEquallyFilled()
            for element in row  { hStack.addArrangedSubview(ViewWithLabelInCenter.init(title: element.title, color: element.color)) }
            stackView.addArrangedSubview(hStack)
        }
    }
}

//MARK: BasisKlasse für ZeichenImQuadratView
class ZeichenView: NibLoadingView{
    override var nibName: String{return "ZeichenView"}
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var stackView: UIStackView! 
    func updateStack(zeichenArray:[[(title:String,color:UIColor)]]){}
}





