 //
//  QuizVC.swift
//  learnDevanagari2
//
//  Created by Matthias Pochmann on 31.10.17.
//  Copyright © 2017 Matthias Pochmann. All rights reserved.
//

import UIKit
import ReactiveSwift


class QuizViewModel{
    var dismissToRoot:MutableProperty<Void>?
    var isLektionsQuiz = false
    var quizModel : QuizModel
    var iPadOrientation = (UIApplication.shared.delegate as? AppDelegate)?.iPadOrientation
    init (quizModel:QuizModel){
        self.quizModel          = quizModel
        self.quizModel.zeilenHoehe  <~ safeAreaSize.producer.map{[weak self] safeAreaSize in self?.getZeilenHoehe(for: self?.iPadOrientation?.value, safeAreaSize: safeAreaSize) ?? 0}
    }
    
    var safeAreaSize = MutableProperty(CGSize.zero)
    
    //MARK: helper
    func getZeilenHoehe(for orientation:IPadOrientation?,safeAreaSize:CGSize) -> CGFloat{
        guard let orientation  = orientation else {return 0}
        switch  orientation {
        case .portrait: return (safeAreaSize.height - safeAreaSize.width) / 3
        default:        return (safeAreaSize.height - ( safeAreaSize.width - safeAreaSize.height )) / 7
        }
    }
    
    //MARK: ViewModels
    func getViewModelForPanel() -> QuizPanelViewModel                           { return QuizPanelViewModel(quizModel:quizModel) }
    func getViewModelForQuizDevaAbfrage()    -> QuizDevaAbfrageViewModel        { return QuizDevaAbfrageViewModel(quizModel:quizModel) }
    func getViewModelForDevaAntwortenStack() -> DevaAntwortenStackViewModel     { return DevaAntwortenStackViewModel(quizModel:quizModel) }
    func getViewModelForFortschrittsbalken() -> QuizFortschrittsbalkenViewModel { return QuizFortschrittsbalkenViewModel(quizModel: quizModel)}
}

class QuizVC: UIViewController {
    
    var viewModel:QuizViewModel!    {
        didSet{
            viewModel.iPadOrientation?.producer.startWithValues{[weak self] orientation in self?.setAxis(iPadOrientation: orientation) }
            //wenn QuizZeichensatz leer ist, dann zurück zu QuizConfigVC
            viewModel.quizModel.quizZeichenInAbfrageIstLeer.signal.observeValues{[weak self] _ in
                if self?.viewModel.isLektionsQuiz == true{ self?.performSegue(withIdentifier: "goToMantras", sender: nil) }
                else{  self?.dismiss(animated: true, completion: nil) } 
            }
        }
    }
    
    @IBOutlet weak var mainStack: UIStackView!                          { didSet { setAxis(iPadOrientation:viewModel?.iPadOrientation?.value) } }
    @IBOutlet weak var quizDevaAbfrage: QuizDevaAbfrageView!            { didSet { quizDevaAbfrage.viewModel = viewModel?.getViewModelForQuizDevaAbfrage() } }
    @IBOutlet weak var quizPanelView: QuizPanelView!                    { didSet { quizPanelView.viewModel   = viewModel?.getViewModelForPanel() } }
    @IBOutlet weak var devaAntwortenStack: DevaAntwortenStackView!      { didSet { devaAntwortenStack.viewModel = viewModel.getViewModelForDevaAntwortenStack() } }
    @IBOutlet weak var fortschrittsBalken: QuizFortschrittsbalkenView!  { didSet { fortschrittsBalken.viewModel = viewModel.getViewModelForFortschrittsbalken()}}
    
    var lastSize:CGSize?
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let safeAreaSize = view.safeAreaLayoutGuide.layoutFrame.size
        if lastSize != safeAreaSize{  viewModel.safeAreaSize.value = safeAreaSize }
        lastSize = safeAreaSize
    }
    
    @IBAction func zurueckButtonPressed(_ sender: UIButton) { viewModel.dismissToRoot?.value = Void() }
    func setAxis(iPadOrientation:IPadOrientation?){
        guard let iPadOrientation = iPadOrientation else {return}
        switch (iPadOrientation){
        case .portrait:                         mainStack?.axis              = .vertical
        default:                                mainStack?.axis              = .horizontal
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        (segue.destination.contentViewController as? MantrasVC)?.dismissToRoot = viewModel.dismissToRoot
    }
}



