//
//  LektionstextVC.swift
//  learnDevanagari2
//
//  Created by Matthias Pochmann on 27.11.17.
//  Copyright © 2017 Matthias Pochmann. All rights reserved.
//

import UIKit
import ReactiveSwift


func -(lhs:UIColor,rhs:UIColor) -> UIColor{
    return lhs
}

class LektionstextViewModel{
    var iPadOrientation = (UIApplication.shared.delegate as? AppDelegate)?.iPadOrientation
    var currentLektion                  = MutableProperty(0)
    var currentLektionsText             = MutableProperty(getTexteFuerLektionen()[0])
    var currentAufgabenText             = MutableProperty<String?>(nil)
    var currentZusatzAufgebenText       = MutableProperty<String?>(nil)
    var title                           = MutableProperty<String?>(nil)
    init() {
        currentLektion.value            = Int(MainSettings.get()?.angemeldeterUser?.aktuelleLektion ?? 0)
        currentLektionsText             <~ currentLektion.producer.map{getTexteFuerLektionen()[$0]}
        currentAufgabenText             <~ currentLektionsText.producer.map{$0.erklaerung}
        currentZusatzAufgebenText       <~ currentLektionsText.producer.map{$0.zusatzAufgaben}
        title                           <~ currentLektion.map{Singleton.sharedInstance.lektionen[$0].title}
    }
    //helper
    func showNextLektionsText(direction:String?){
        let dif = direction == "<" ? -1 : 1
        currentLektion.value += dif
    }
    

    
    func getViewModelForAnleitungErklaerungControl() -> AnleitungErklaerungControlViewModel{
        return AnleitungErklaerungControlViewModel(lektionsText: currentLektionsText)
    }
}

class LektionstextVC: UIViewController {
    var quizViewModel:QuizViewModel?
    var viewModel:LektionstextViewModel!{
        didSet{
            erklaerungView.viewModel = viewModel.getViewModelForAnleitungErklaerungControl()
            
            viewModel.currentLektionsText.producer.startWithValues{[weak self] lektionstext in
                self?.neueZeichenLabelStackView.viewModel = StackLabelViewModel(labelText: lektionstext.neueZeichen)
                self?.aufgabenLabelStackView.viewModel = StackLabelViewModel(labelText: lektionstext.aufgaben)
                self?.zusatzAufgabenLabelStackView.viewModel = StackLabelViewModel(labelText: lektionstext.zusatzAufgaben)
            }
            
            
            viewModel.currentLektion.producer.startWithValues{[weak self] lektion in
                var maxLektion:Int{
                    guard let bereitsBekannteLektion = MainSettings.get()?.angemeldeterUser?.bereitsBekannteLektion else {return getTexteFuerLektionen().count - 1}
                    return Int(bereitsBekannteLektion)
                }
                self?.segmentedControl?.setEnabled(lektion < maxLektion, forSegmentAt: 1)
                self?.segmentedControl?.setEnabled(lektion > 0, forSegmentAt: 0)
            }
            
            viewModel.iPadOrientation?.producer.startWithValues{ [weak self] orientation in self?.setViews(for: orientation) }
            viewModel.currentZusatzAufgebenText.producer.startWithValues {[weak self] text in self?.setZusatzAufgabenViews(text: text) }
            
            navigationItem.reactive.title   <~ viewModel.title.producer
        }
    }
    
    @IBOutlet weak var zumQuizBarButton: UIBarButtonItem!
    @IBOutlet weak var neueZeichenLabelStackView: StackLabelView!
    @IBOutlet weak var aufgabenLabelStackView: StackLabelView!
    @IBOutlet weak var zusatzAufgabenLabelStackView: StackLabelView!
    
    @IBOutlet weak var neueZeichenView: UIView!     { didSet{ setStyle(for: neueZeichenView) } }
    @IBOutlet weak var aufgabenView: UIView!        { didSet{ setStyle(for: aufgabenView) } }
    @IBOutlet weak var zusatzAufgabenView: UIView!  { didSet{ setStyle(for: zusatzAufgabenView) } }
    
    @IBOutlet weak var mainStack: UIStackView!
    @IBOutlet weak var firstRowStack: UIStackView!
    @IBOutlet weak var secondRowStack: UIStackView!
    @IBOutlet weak var thirdRowStack: UIStackView!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!

    @IBOutlet weak var erklaerungView: AnleitungErklaerungControl!{ didSet{ setStyle(for: erklaerungView) } }
    
    
    private func setStyle(for view:UIView){
        view.layer.borderColor  = UIColor.white.cgColor
        view.layer.borderWidth  = 1.0
        view.layer.cornerRadius = 5
        view.backgroundColor    = UIColor.init(white: 0, alpha: 0.1)
    }
    
    var firstRowLayoutConstraint:NSLayoutConstraint?
    

    var emptyErsatzZusatzAufgabenView = UIView()
    private func setViews(for orientation:IPadOrientation?){
        guard let orientation = orientation else {return}
        if firstRowStack.arrangedSubviews.count == 2 { firstRowStack.arrangedSubviews[1].removeFromSuperview() }
        for subView in secondRowStack.arrangedSubviews{
            subView.removeFromSuperview()
        }
        for subView in thirdRowStack.arrangedSubviews{
            subView.removeFromSuperview()
        }
            

        switch orientation {
        case .landscape:
            firstRowStack.addArrangedSubview(neueZeichenView)
            
            firstRowLayoutConstraint = erklaerungView.widthAnchor.constraint(equalTo: neueZeichenView.widthAnchor, multiplier: 2)
            firstRowLayoutConstraint?.isActive = true
            secondRowStack.addArrangedSubview(aufgabenView)
            secondRowStack.addArrangedSubview(zusatzAufgabenView)
            secondRowStack.addArrangedSubview(emptyErsatzZusatzAufgabenView)
            thirdRowStack.isHidden = true
        case .portrait:
            
            secondRowStack.addArrangedSubview(neueZeichenView)
            secondRowStack.addArrangedSubview(aufgabenView)
            thirdRowStack.addArrangedSubview(zusatzAufgabenView)
            thirdRowStack.addArrangedSubview(emptyErsatzZusatzAufgabenView)
            thirdRowStack.isHidden = false
        }
    }
    private func setZusatzAufgabenViews(text:String?){
        emptyErsatzZusatzAufgabenView.isHidden  = text == nil ? false : true
        zusatzAufgabenView.isHidden             = text == nil ? true : false
    }

    
    override func viewDidLoad() {
        viewModel = LektionstextViewModel()
        if quizViewModel == nil { navigationItem.rightBarButtonItem = nil }
    }
    
    @IBAction func segementedControlAction(_ sender: UISegmentedControl) {
        var direction:String{ return sender.selectedSegmentIndex == 0 ? "<" : ">"  }
        viewModel.showNextLektionsText(direction: direction)
        sender.selectedSegmentIndex = UISegmentedControlNoSegment
    }
    
    //Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        quizViewModel?.isLektionsQuiz                                       = true
        (segue.destination as? QuizVC)?.viewModel                           = quizViewModel
        navigationController?.isNavigationBarHidden = true
    }
}
