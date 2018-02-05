//
//  QuizFortschrittsbalkenView.swift
//  
//
//  Created by Matthias Pochmann on 20.11.17.
//

import UIKit
import ReactiveSwift




fileprivate typealias Step          = (from: Int,dif: Int)
fileprivate typealias StepAnimation = (steps:[Step],zielStatus:QuizZeichenStatus)

//MARK: Fortschrittsbalken für Quiz
// zeigt den aktuellen Fortschritt
// Dabei werden richtige Zeichen grün unten und falsch rot oben angeordnet.
// Jedes Segment entspricht einem QuizZeichen.
// Das QuizZeichen erscheint - und wandert bei Prüfung in den richtigen oder falschen Bereich.
// Die Animation erfolgt über zwei übereinander gelegte StackVies.
// Auf dem oberem StackView läuft ein halbtransparenter View - er zeigt das aktuelle Zeichen.
// Der unterer Stackview zeigt das Ergebnis, d.h. ob ein zeichen richtig oder falsch beantwortet, bzw. noch nicht abgefragt wurde.
class QuizFortschrittsbalkenViewModel {
    //stackData = Datenbasis für Fortschrittsbalken
    // enthält array aus QuizZeichen und Index
    fileprivate var stackData                   = [QuizZeichenInBalken]()
    fileprivate var indexOfCurrentStackitem:Int?
    
    fileprivate var statusArray                 = [MutableProperty<QuizZeichenStatus>]()
    fileprivate var stepsToAnimate              = MutableProperty(StepAnimation(steps:[Step](),zielStatus:QuizZeichenStatus.Ungesichtet))
    fileprivate var isAnimatingSteps            = MutableProperty(false)
    
    //MARK: init
    init(quizModel:QuizModel){
        stackData                                           = quizModel.quizZeichenSatz.value.enumerated().map{QuizZeichenInBalken(zeichen:$0.element,index:$0.offset)}
        statusArray                                         = stackData.map{ MutableProperty($0.quizZeichen?.status.value ?? .Ungesichtet) }
        
        setIndexOfCurrentStackItem(currentQZ: quizModel.currentQuizZeichen.value)
        
        //Signals
        quizModel.currentQuizZeichen.producer.startWithValues           { [weak self] quizZeichen in self?.setIndexOfCurrentStackItem(currentQZ: quizZeichen) }
        quizModel.animateFortschrittsbalkenTo.signal.observeValues      { [weak self] status in self?.moveStackitem(toStatus: status) }
    }
    
    //MARK: helper
    //setIndexOfCurrentStackItem
    // index für neues QuizZeichen finden
    // den Status des neuen QuizZeichen im StatusArray auf InUserAbfrage setzen
    private func setIndexOfCurrentStackItem(currentQZ: QuizZeichen?){
        indexOfCurrentStackitem                             = stackData.filter{$0.quizZeichen == currentQZ}.first?.index
        statusArray[indexOfCurrentStackitem ?? 0].value     =  .InUserAbfrage
    }
    //moveStackitem
    // passt Datenbasis an Veränderung an
    // erzeugt StepArray für Animation
    private func moveStackitem(toStatus:QuizZeichenStatus?){
        guard let status = toStatus else {return}
        //stackData anpassen
        moveElementInStackData(from: indexOfCurrentStackitem, to: status.moveToIndex(anzahlElemente: stackData.count))
        //stepsToAnimate (Datenbasis für Animation)
        // besteht aus Array von EinzelSchritten
        let _stepsToAnimate         = createStepsToAnimate(from: indexOfCurrentStackitem, to: status.moveToIndex(anzahlElemente: stackData.count))
        stepsToAnimate.value        = StepAnimation(steps: _stepsToAnimate,zielStatus:status)
    }
    //StepsToAnimate
    // erzeugt Array aus Schritten
    private func createStepsToAnimate(from start:Int?, to ziel:Int?) -> [Step] {
        guard let start = start, let ziel = ziel  else {return [Step]()}
        //Anzahl abs(dif) und Richtung (stepDif) der Schritte ermitteln
        let dif = ziel - start
        var stepDif:Int { return dif == 0 ? 0 : dif > 0 ? 1 : -1 }
        // Array aus Schritten erzeugen
        return getSteps(start: start, count: abs(dif), stepDif: stepDif)
    }
    private func getSteps(start:Int,count:Int,stepDif:Int) -> [Step]{
        var iPos = start
        var ergebnis = [Step]()
        for _ in 0 ..< count{
            ergebnis.append(Step(from: iPos, dif: stepDif))
            iPos += stepDif
        }
        return ergebnis
    }
    //moveElementInStackData
    // ordnet StackData (Datenbasis) neu an
    private func moveElementInStackData(from start:Int?, to ziel:Int?){
        guard let start = start, let ziel = ziel else {return}
        let dif = ziel - start
        var _dif:Int { return dif == 0 ? 0 : dif > 0 ? 1 : -1 }
        var iPos = start
        for _ in 0 ..< abs(dif){
            stackData = rearrange(array: stackData, fromIndex: iPos, toIndex: iPos + _dif).enumerated().map{ zeichen  in
                zeichen.element.index = zeichen.offset
                return zeichen.element
            }
            iPos += _dif
        }
    }
}



class QuizFortschrittsbalkenView: NibLoadingView {
    var viewModel:QuizFortschrittsbalkenViewModel!{
        didSet{
            // stack initialisieren
            initStack(statusArray: viewModel.statusArray)
            
            viewModel.stepsToAnimate.signal.observeValues                       { [weak self] stepAnimation in self?.animateSteps(stepAnimation: stepAnimation ) }
            viewModel.isAnimatingSteps.signal.filter{$0 == false}.observeValues { [weak self] _ in self?.animateErscheinenNeuesQuizZeichen(view: self?.viewNeedsStatusAnimationToInAbfrage) }
        }
    }
    
    //Mark: Outlets
    @IBOutlet weak var bottomStack: UIStackView!
    @IBOutlet weak var topStack: UIStackView!
    
    //MARK: Properties
    var viewNeedsStatusAnimationToInAbfrage:UIView?
    var animationBreak          = false
    let gesamtAnimationsDauer   = 1.0
    var dauerAnimationStep:Double   { return gesamtAnimationsDauer / Double(bottomStack.arrangedSubviews.count ) }
    
    //MARK: helper
    //StackInitialisierung
    // der obere und der untere Stack wird mit Views aufgefüllt
    private func initStack(statusArray:[MutableProperty<QuizZeichenStatus>]){
        for subview in bottomStack.arrangedSubviews {subview.removeFromSuperview()}
        for status in statusArray.reversed(){
            //bottom Stack View - zeigt Farbe für Status des QuizZeichens (grün,rot usw)
            initBottomStackView(with: status.value.colorFortschrittsbalken)
            //top Stack View - für Laufanimation
            initTopStackView(status)
        }
    }
    private func initBottomStackView(with color:UIColor){
        let view                = UIView()
        view.layer.borderColor  = UIColor.white.cgColor
        view.layer.borderWidth  = 1
        view.backgroundColor    = color
        bottomStack.addArrangedSubview(view)
    }
    fileprivate func initTopStackView(_ status: MutableProperty<QuizZeichenStatus>) {
        let view = UIView()
        topStack.addArrangedSubview(view)
        status.producer.filter{$0 == .InUserAbfrage}.startWithValues{[weak self] _ in
            //wenn bereits eine Animation läuft, wird die nächste Animation (Erscheinen neues QZ) zurück gestellt
            if self?.viewModel.isAnimatingSteps.value == true       { self?.viewNeedsStatusAnimationToInAbfrage = view }
            else                                                    { self?.animateErscheinenNeuesQuizZeichen(view: view) }
        }
    }
    //Animation für das Erscheinen eines neuen quizZeichens
    private func animateErscheinenNeuesQuizZeichen(view:UIView?){
        UIView.animate(withDuration: 0.1, delay: 0.1, options: .allowUserInteraction, animations: { view?.backgroundColor = QuizZeichenStatus.InUserAbfrage.colorFortschrittsbalken })
        viewNeedsStatusAnimationToInAbfrage = nil
    }
    //Animation der Bewegung im Fortschrittsbalken
    private func animateSteps(stepAnimation:StepAnimation){
        if viewModel.isAnimatingSteps.value { animationBreak = true }
        viewModel.isAnimatingSteps.value    = true
        var currentStepIndex                = 0
        //animateStep
        // Methode animiert einen einzelnen Schritt
        // ruft sich selbst nach Beendigung der Animation auf
        // solange bis letzter Schritt erreicht wurde
        func animateStep(){
            let duration            = animationBreak ? 0 : dauerAnimationStep
            //prüft auf letzten Schritt
            // falls letzter Schritt Animation für letzten Schritt
            guard currentStepIndex < stepAnimation.steps.count else   { animateLastStep(stepAnimation:stepAnimation,currentStepIndex: currentStepIndex); return }
            
            let step    = stepAnimation.steps[currentStepIndex]
            UIView.animate(withDuration: duration,
                           animations: {[weak self] in self?.animataNotLastStep(step,
                                                                                zielStatus: stepAnimation.zielStatus,
                                                                                currentStepIndex: &currentStepIndex) },
                           completion: { _ in  animateStep() })
        }
        animateStep()
    }
    private func animataNotLastStep(_ step:Step,zielStatus:QuizZeichenStatus, currentStepIndex:inout Int) {
        let arrangedSubviewsTop     = topStack.arrangedSubviews
        let arrangedSubviewsBottom  = bottomStack.arrangedSubviews
        let from                    = arrangedSubviewsTop.count  - 1 - step.from
        let dif                     = -step.dif
        
        //topStack
        arrangedSubviewsTop[from].backgroundColor           = UIColor.clear
        arrangedSubviewsTop[from + dif].backgroundColor     = QuizZeichenStatus.InUserAbfrage.colorFortschrittsbalken
        
        //bottomStack
        if arrangedSubviewsBottom[from + dif].backgroundColor == zielStatus.colorFortschrittsbalken{
            arrangedSubviewsBottom[from].backgroundColor  = zielStatus.colorFortschrittsbalken
        }
        currentStepIndex += 1
    }
    private func animateLastStep(stepAnimation:StepAnimation,currentStepIndex:Int) {
        let arrangedSubviewsTop     = topStack.arrangedSubviews
        let arrangedSubviewsBottom  = bottomStack.arrangedSubviews
        //Index des letzten Views
        var lastViewIndex:Int{
            if stepAnimation.steps.count > 0{
                let step = stepAnimation.steps[currentStepIndex - 1]
                let from = arrangedSubviewsTop.count - 1 - step.from
                return from - step.dif
            }
            return stepAnimation.zielStatus == .Correct ? arrangedSubviewsBottom.count - 1 : 0
        }
        
        UIView.animate(withDuration: dauerAnimationStep) {
            arrangedSubviewsBottom[lastViewIndex].backgroundColor   = stepAnimation.zielStatus.colorFortschrittsbalken
            arrangedSubviewsTop[lastViewIndex].backgroundColor      = UIColor.clear
        }
        viewModel.isAnimatingSteps.value    = false
        animationBreak                      = false
    }
}

//MARK: QuizZeichenInBalken
// enthält ein QuizZeichen und die Position im Stack
fileprivate class QuizZeichenInBalken {
    var quizZeichen:QuizZeichen?
    var index:Int
    init(zeichen:QuizZeichen?,index:Int){
        self.quizZeichen    = zeichen
        self.index          = index
    }
}

