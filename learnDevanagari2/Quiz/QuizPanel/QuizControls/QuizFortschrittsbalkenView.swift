//
//  QuizFortschrittsbalkenView.swift
//  
//
//  Created by Matthias Pochmann on 20.11.17.
//

import UIKit
import ReactiveSwift
import Result

fileprivate func color(for status:QuizZeichenStatus?) -> UIColor {
    guard let status = status else {return .blue}
    switch status {
    case .Correct:              return .green
    case .FalschBeantwortet:    return UIColor.init(red: 1, green: 0, blue: 0, alpha: 0.5)
    case .Ungesichtet:          return UIColor(white: 1, alpha: 0.2)
    case .InUserAbfrage:        return UIColor(white: 0.5, alpha: 0.2)
    }
}
fileprivate typealias Step          = (from: Int,dif: Int)
fileprivate typealias StepAnimation = (steps:[Step],zielStatus:QuizZeichenStatus)

class QuizFortschrittsbalkenViewModel {
    class QuizZeichenInBalken {
        var quizZeichen:QuizZeichen?
        var index:Int = 0
        init(zeichen:QuizZeichen?,index:Int){
            self.quizZeichen = zeichen
            self.index  = index
        }
    }
    var quizModel:QuizModel
    var stackData                   = [QuizZeichenInBalken]()
    var indexOfCurrentStackitem:Int?
    
    var statusArray                             = [MutableProperty<QuizZeichenStatus>]()
    fileprivate var stepsToAnimate              = MutableProperty(StepAnimation(steps:[Step](),zielStatus:QuizZeichenStatus.Ungesichtet))
    var isAnimatingSteps                        = MutableProperty(false)
    
    
    init(quizModel:QuizModel){
        self.quizModel                  = quizModel
        stackData                       = quizModel.quizZeichenSatz.value.enumerated().map{QuizZeichenInBalken(zeichen:$0.element,index:$0.offset)}
        statusArray                     = stackData.map{ MutableProperty($0.quizZeichen?.status.value ?? .Ungesichtet) }
        
        indexOfCurrentStackitem = stackData.filter{$0.quizZeichen == quizModel.currentQuizZeichen.value}.first?.index
        statusArray[indexOfCurrentStackitem ?? 0].value   =  .InUserAbfrage
        
        quizModel.currentQuizZeichen.producer.combinePrevious().startWithValues{ [weak self](oldValue,newValue) in
            //Animation für das letzte Zeichen, falls es nachzeichnen war
            if oldValue?.quizSetting.zeichenfeld == .Nachzeichnen{
                self?.indexOfCurrentStackitem = self?.stackData.filter{$0.quizZeichen == oldValue}.first?.index
                self?.moveStackitem(toStatus: .Correct)
            }
            
            self?.indexOfCurrentStackitem = self?.stackData.filter{$0.quizZeichen == newValue}.first?.index
            self?.statusArray[self?.indexOfCurrentStackitem ?? 0].value   =  .InUserAbfrage
        }
        
        quizModel.userEingabePrüfen.signal.filter{$0 == true}.observe { [weak self] _ in
            let status  = quizModel.isUserEingabeCorrect ? QuizZeichenStatus.Correct : QuizZeichenStatus.FalschBeantwortet
            self?.moveStackitem(toStatus: status)
        }
    }
    
    //MARK: helper
    private func moveStackitem(toStatus:QuizZeichenStatus?){
        guard let status = toStatus else {return}
        var moveTo:Int?{
            switch status{
            case .Correct: return 0
            case .FalschBeantwortet: return stackData.count - 1
            default: return nil
            }
        }
        moveElementInStackData(from: indexOfCurrentStackitem, to: moveTo)
        stepsToAnimate.value        = StepAnimation(steps:createStepsToAnimate(from: indexOfCurrentStackitem, to: moveTo),zielStatus:status)
    }
    private func createStepsToAnimate(from start:Int?, to ziel:Int?) -> [(from: Int,dif: Int)] {
        guard let start = start, let ziel = ziel else {return [(from: Int,dif: Int)]()}
        let dif = ziel - start
        var stepDirection:Int { return dif == 0 ? 0 : dif > 0 ? 1 : -1 }
        var iPos = start
        var ergebnis = [(from: Int,dif: Int)]()
        for _ in 0 ..< abs(dif){
            ergebnis.append((from: iPos, dif: stepDirection))
            iPos += stepDirection
        }
        return ergebnis
    }
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
    //Animation: zwei stackviews übereinander
    //auf oberem StackView läuft halbtransparente Farbe
    //unterer Stackview zeigt Ergebnis
    @IBOutlet weak var bottomStack: UIStackView!
    @IBOutlet weak var topStack: UIStackView!
    var dauerAnimationStep:Double{
        let gesamtDauer = 1.0
        return gesamtDauer / Double(bottomStack.arrangedSubviews.count )
    }
    var viewNeedsStatusAnimationToInAbfrage:UIView?
    var viewModel:QuizFortschrittsbalkenViewModel!{
        didSet{
            func initStack(statusArray:[MutableProperty<QuizZeichenStatus>]){
                for subview in bottomStack.arrangedSubviews {subview.removeFromSuperview()}
                for status in statusArray.reversed(){
                    //bottom (grün,rot usw)
                    let view = UIView()
                    view.layer.borderColor  = UIColor.white.cgColor
                    view.layer.borderWidth  = 1
                    bottomStack.addArrangedSubview(view)
                    view.backgroundColor = status.value == .Correct ? color(for: status.value) : color(for: QuizZeichenStatus.Ungesichtet)
                    //top (laufAnimantion Label)
                    let view2 = UIView()
                    topStack.addArrangedSubview(view2)
                    status.producer.filter{$0 == .InUserAbfrage}.startWithValues{[weak self] _ in
                        if self?.viewModel.isAnimatingSteps.value == true       { self?.viewNeedsStatusAnimationToInAbfrage = view2 }
                        else                                                    { self?.animateStatusForNewCurrentQuizZeichen(view: view2) }
                    }
                }
            }
            initStack(statusArray: viewModel.statusArray)
            
            viewModel.stepsToAnimate.signal.observeValues{[weak self] stepAnimation in self?.animateSteps(stepAnimation: stepAnimation,arrangedSubviewsTop: self?.topStack.arrangedSubviews,arrangedSubviewsBottom: self?.bottomStack.arrangedSubviews ) }
            viewModel.isAnimatingSteps.signal.filter{$0 == false}.observeValues { [weak self] _ in
                self?.animateStatusForNewCurrentQuizZeichen(view: self?.viewNeedsStatusAnimationToInAbfrage)
            }
        }
    }
    //helper
    private func animateStatusForNewCurrentQuizZeichen(view:UIView?){
        guard let view = view else {return}
        UIView.animate(withDuration: 0.1, delay: 0.1, options: .allowUserInteraction, animations: {
            view.backgroundColor = color(for: .InUserAbfrage)
        }) {_ in }
        viewNeedsStatusAnimationToInAbfrage = nil
    }
    var animationBreak = false
    private func animateSteps(stepAnimation:StepAnimation,arrangedSubviewsTop:[UIView]?,arrangedSubviewsBottom:[UIView]?){
        if viewModel.isAnimatingSteps.value {animationBreak = true}
        guard let arrangedSubviewsTop = arrangedSubviewsTop, let arrangedSubviewsBottom = arrangedSubviewsBottom  else {return}
        viewModel.isAnimatingSteps.value = true
        let steps       = stepAnimation.steps
        let zielStatus  = stepAnimation.zielStatus
        var currentStepIndex = 0
        func animateStep(){
            let duration = animationBreak ? 0 : dauerAnimationStep
            guard currentStepIndex < steps.count
                else {
                    var lastViewIndex:Int{
                        if steps.count > 0{
                            let step = steps[currentStepIndex - 1]
                            let from = arrangedSubviewsTop.count - 1 - step.from
                            let dif  = -step.dif
                            return from + dif
                        }
                        return stepAnimation.zielStatus == .Correct ? arrangedSubviewsBottom.count - 1 : 0
                    }
                    UIView.animate(withDuration: dauerAnimationStep) {
                        arrangedSubviewsBottom[lastViewIndex].backgroundColor   = color(for: zielStatus)
                        arrangedSubviewsTop[lastViewIndex].backgroundColor      = UIColor.clear
                    }
                    viewModel.isAnimatingSteps.value = false
                    animationBreak = false
                    return
            }
            let step = steps[currentStepIndex]
            UIView.animate(withDuration: duration, animations: {
                let from = arrangedSubviewsTop.count  - 1 - step.from
                let dif  = -step.dif
                //topStack
                var fromView    = arrangedSubviewsTop[from]
                var toView      = arrangedSubviewsTop[from + dif]
                fromView.backgroundColor    = UIColor.clear
                toView.backgroundColor      = color(for: .InUserAbfrage)
                
                //bottomStack
                fromView        = arrangedSubviewsBottom[from]
                toView          = arrangedSubviewsBottom[from + dif]
                let zielFarbe   = color(for: zielStatus)
                if toView.backgroundColor == zielFarbe{
                    fromView.backgroundColor  = zielFarbe
                }
                currentStepIndex += 1
            }, completion: { _ in
                animateStep()
            })
        }
        animateStep()
    }
}


fileprivate func rearrange<T>(array: Array<T>, fromIndex: Int, toIndex: Int) -> Array<T>{
    var arr = array
    let element = arr.remove(at: fromIndex)
    arr.insert(element, at: toIndex)
    
    return arr
}

extension UIColor {
    
    func add(overlay: UIColor) -> UIColor {
        var bgR: CGFloat = 0
        var bgG: CGFloat = 0
        var bgB: CGFloat = 0
        var bgA: CGFloat = 0
        
        var fgR: CGFloat = 0
        var fgG: CGFloat = 0
        var fgB: CGFloat = 0
        var fgA: CGFloat = 0
        
        self.getRed(&bgR, green: &bgG, blue: &bgB, alpha: &bgA)
        overlay.getRed(&fgR, green: &fgG, blue: &fgB, alpha: &fgA)
        
        let r = fgA * fgR + (1 - fgA) * bgR
        let g = fgA * fgG + (1 - fgA) * bgG
        let b = fgA * fgB + (1 - fgA) * bgB
        
//        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
        return UIColor(red: r, green: g, blue: b, alpha: fgA)
    }
}
