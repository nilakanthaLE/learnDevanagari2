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
    var quizModel : QuizModel
    var iPadOrientation = (UIApplication.shared.delegate as? AppDelegate)?.iPadOrientation
    var zeilenHoehe:MutableProperty<CGFloat> = MutableProperty(30.0)
    init (quizModel:QuizModel){
        self.quizModel          = quizModel
        self.quizModel.zeilenHoehe  <~ zeilenHoehe
        zeilenHoehe                 <~ safeAreaSize.producer.map{[weak self] safeAreaSize in self?.getZeilenHoehe(for: self?.iPadOrientation?.value, safeAreaSize: safeAreaSize) ?? 0}
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
}

class QuizVC: UIViewController {
    var viewModel:QuizViewModel!    { didSet{ viewModel.iPadOrientation?.producer.startWithValues{[weak self] orientation in self?.setAxis(iPadOrientation: orientation) } } }
    
    @IBOutlet weak var mainStack: UIStackView!                      { didSet { setAxis(iPadOrientation:viewModel?.iPadOrientation?.value) } }
    @IBOutlet weak var quizDevaAbfrage: QuizDevaAbfrageView!        { didSet { quizDevaAbfrage.viewModel = viewModel?.getViewModelForQuizDevaAbfrage() } }
    @IBOutlet weak var quizPanelView: QuizPanelView!                { didSet { quizPanelView.viewModel   = viewModel?.getViewModelForPanel() } }
    @IBOutlet weak var devaAntwortenStack: DevaAntwortenStackView!  { didSet { devaAntwortenStack.viewModel = viewModel.getViewModelForDevaAntwortenStack() } }
    
    var lastSize:CGSize?
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let safeAreaSize = view.safeAreaLayoutGuide.layoutFrame.size
        if lastSize != safeAreaSize{  viewModel.safeAreaSize.value = safeAreaSize }
        lastSize = safeAreaSize
    }
    
    func setAxis(iPadOrientation:IPadOrientation?){
        guard let iPadOrientation = iPadOrientation else {return}
        switch (iPadOrientation){
        case .portrait:                         mainStack?.axis              = .vertical
        default:                                mainStack?.axis              = .horizontal
        }
    }
}



