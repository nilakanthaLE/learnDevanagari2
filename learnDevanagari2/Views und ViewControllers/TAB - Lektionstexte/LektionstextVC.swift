//
//  LektionstextVC.swift
//  learnDevanagari2
//
//  Created by Matthias Pochmann on 27.11.17.
//  Copyright © 2017 Matthias Pochmann. All rights reserved.
//

import UIKit
import ReactiveSwift

//MARK: LektionstextViewModel
// Tab für Lektionstexte
// enthält Erklärungstexte, Aufgabenbeschreibung, Zusatzaufgaben und neue vorgesetellte Zeichen
class LektionstextViewModel{
    //MARK: - MutableProperties
    var currentLektion                  = MutableProperty(0)
    var currentLektionsText             = MutableProperty(getTexteFuerLektionen()[0])
    var currentAufgabenText             = MutableProperty<String?>(nil)
    var currentZusatzAufgebenText       = MutableProperty<String?>(nil)
    var title                           = MutableProperty<String?>(nil)
    
    //MARK: - init
    init() {
        currentLektion.value            = Int(MainSettings.get()?.angemeldeterUser?.aktuelleLektion ?? 0)
        currentLektionsText             <~ currentLektion.producer.map{getTexteFuerLektionen()[$0]}
        currentAufgabenText             <~ currentLektionsText.producer.map{$0.erklaerung}
        currentZusatzAufgebenText       <~ currentLektionsText.producer.map{$0.zusatzAufgaben}
        title                           <~ currentLektion.map{Singleton.sharedInstance.lektionen[$0].title}
    }
    
    //MARK: - Methode
    func showNextLektionsText(direction:String?){
        let dif = direction == "<" ? -1 : 1
        currentLektion.value += dif
    }
    
    //MARK: - ViewModels
    func getViewModelForAnleitungErklaerungControl() -> AnleitungErklaerungControlViewModel{ return AnleitungErklaerungControlViewModel(lektionsText: currentLektionsText) }
}

class LektionstextVC: UIViewController {
    var quizViewModel:QuizViewModel?
    var firstRowLayoutConstraint:NSLayoutConstraint?
    var emptyErsatzZusatzAufgabenView = UIView()
    
    var viewModel:LektionstextViewModel!{
        didSet{
            initViewModelsForControls()
            //Signals
            neueZeichenLabelStackView.viewModel.labelText       <~ viewModel.currentLektionsText.producer.map{$0.neueZeichen}
            aufgabenLabelStackView.viewModel.labelText          <~ viewModel.currentLektionsText.producer.map{$0.aufgaben}
            zusatzAufgabenLabelStackView.viewModel.labelText    <~ viewModel.currentLektionsText.producer.map{$0.zusatzAufgaben}
            navigationItem.reactive.title                       <~ viewModel.title.producer
            iPadOrientation?.producer.startWithValues                       { [weak self] orientation in self?.setViews(for: orientation) }
            viewModel.currentLektion.producer.startWithValues               { [weak self] lektion in self?.setEnabledForSegmentedControl(lektion: lektion) }
            viewModel.currentZusatzAufgebenText.producer.startWithValues    { [weak self] text in self?.setZusatzAufgabenViews(text: text) }
        }
    }
    
    //MARK: - IBOutlets
    @IBOutlet weak var zumQuizBarButton: UIBarButtonItem!
    @IBOutlet weak var neueZeichenLabelStackView: StackLabelView!
    @IBOutlet weak var aufgabenLabelStackView: StackLabelView!
    @IBOutlet weak var zusatzAufgabenLabelStackView: StackLabelView!
    @IBOutlet weak var neueZeichenView: UIView!                         { didSet{ setStyle(for: neueZeichenView) } }
    @IBOutlet weak var aufgabenView: UIView!                            { didSet{ setStyle(for: aufgabenView) } }
    @IBOutlet weak var zusatzAufgabenView: UIView!                      { didSet{ setStyle(for: zusatzAufgabenView) } }
    @IBOutlet weak var erklaerungView: AnleitungErklaerungControl!      { didSet{ setStyle(for: erklaerungView) } }
    @IBOutlet weak var mainStack: UIStackView!
    @IBOutlet weak var firstRowStack: UIStackView!
    @IBOutlet weak var secondRowStack: UIStackView!
    @IBOutlet weak var thirdRowStack: UIStackView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    //MARK: - IBActions
    // ermöglicht Durchblättern der Anleitungen für die Lektionen
    @IBAction func segementedControlAction(_ sender: UISegmentedControl) {
        var direction:String{ return sender.selectedSegmentIndex == 0 ? "<" : ">"  }
        viewModel.showNextLektionsText(direction: direction)
        sender.selectedSegmentIndex = UISegmentedControlNoSegment
    }
    
    //MARK: - ViewController LifeCycle
    override func viewDidLoad() {
        viewModel = LektionstextViewModel()
        if quizViewModel == nil { navigationItem.rightBarButtonItem = nil }
    }
    
    //MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        quizViewModel?.isLektionsQuiz                                       = true
        (segue.destination as? QuizVC)?.viewModel                           = quizViewModel
        navigationController?.isNavigationBarHidden = true
    }
    
    //MARK: - helper
    
    private func setEnabledForSegmentedControl(lektion:Int){
        var maxLektion:Int{
            guard let bereitsBekannteLektion = MainSettings.get()?.angemeldeterUser?.bereitsBekannteLektion else {return getTexteFuerLektionen().count - 1}
            return Int(bereitsBekannteLektion)
        }
        segmentedControl?.setEnabled(lektion < maxLektion, forSegmentAt: 1)
        segmentedControl?.setEnabled(lektion > 0, forSegmentAt: 0)
    }
    //initViewModelsForControls
    // inititalisiert die ViewModels für die InformationsBoxen
    private func initViewModelsForControls(){
        erklaerungView.viewModel                    = viewModel.getViewModelForAnleitungErklaerungControl()
        neueZeichenLabelStackView.viewModel         = StackLabelViewModel(labelText: "")
        aufgabenLabelStackView.viewModel            = StackLabelViewModel(labelText: "")
        zusatzAufgabenLabelStackView.viewModel      = StackLabelViewModel(labelText: "")
    }
    //setZusatzAufgabenViews
    // Zusatzaufgaben entweder mit Text oder leer
    private func setZusatzAufgabenViews(text:String?){
        emptyErsatzZusatzAufgabenView.isHidden  = text == nil ? false : true
        zusatzAufgabenView.isHidden             = text == nil ? true : false
    }
    //setStyle
    // Style (Border, Farbe) setzen
    private func setStyle(for view:UIView){
        view.layer.borderColor      = UIColor.white.cgColor
        view.layer.borderWidth      = 1.0
        view.layer.cornerRadius     = 5
        view.backgroundColor        = UIColor.init(white: 0, alpha: 0.1)
    }
    //setViews
    // past die Anzeige an die Ausrichtung des Geräts an
    private func setViews(for orientation:IPadOrientation?){
        guard let orientation = orientation else {return}
        cleanStacks()
        switch orientation {
            case .landscape: setStacksForLandscape()
            case .portrait: setStacksForPortrait()
        }
    }
    private func cleanStacks(){
        if firstRowStack.arrangedSubviews.count == 2    { firstRowStack.arrangedSubviews[1].removeFromSuperview() }
        for subView in secondRowStack.arrangedSubviews  { subView.removeFromSuperview() }
        for subView in thirdRowStack.arrangedSubviews   { subView.removeFromSuperview() }
    }
    private func setStacksForLandscape(){
        firstRowStack.addArrangedSubview(neueZeichenView)
        firstRowLayoutConstraint = erklaerungView.widthAnchor.constraint(equalTo: neueZeichenView.widthAnchor, multiplier: 2)
        firstRowLayoutConstraint?.isActive = true
        secondRowStack.addArrangedSubview(aufgabenView)
        secondRowStack.addArrangedSubview(zusatzAufgabenView)
        secondRowStack.addArrangedSubview(emptyErsatzZusatzAufgabenView)
        thirdRowStack.isHidden = true
    }
    private func setStacksForPortrait(){
        secondRowStack.addArrangedSubview(neueZeichenView)
        secondRowStack.addArrangedSubview(aufgabenView)
        thirdRowStack.addArrangedSubview(zusatzAufgabenView)
        thirdRowStack.addArrangedSubview(emptyErsatzZusatzAufgabenView)
        thirdRowStack.isHidden = false
    }
}
