//
//  QuizFreiesUebenConfigVC.swift
//  learnDevanagari2
//
//  Created by Matthias Pochmann on 08.11.17.
//  Copyright © 2017 Matthias Pochmann. All rights reserved.
//

import UIKit
import ReactiveSwift

class QuizFreiesUebenConfigViewModel{
    var quizConfigModel:QuizConfigModel
    
    var abfragen:MutableProperty<String?> = MutableProperty(nil)
    var angezeigte:MutableProperty<String?> = MutableProperty(nil)
    var versteckte:MutableProperty<String?> = MutableProperty(nil)
    
    init(quizConfigModel:QuizConfigModel) {
        self.quizConfigModel    = quizConfigModel
        
        self.quizConfigModel.freiesUebenQuizSetting.producer.start(){[weak self] settings in
            self?.abfragen.value    = getText(for: .Abfrage, in: settings.value)
            self?.angezeigte.value  = getText(for: .NurAnzeige, in: settings.value)
            self?.versteckte.value  = getText(for: .Versteckt, in: settings.value)
        }
    }
    func getViewModelForQuizAbfragenSetting()   -> QuizAbfragenSettingViewModel { return QuizAbfragenSettingViewModel( quizSetting:quizConfigModel.freiesUebenQuizSetting) }
}

class QuizFreiesUebenConfigVC: UIViewController {
    var viewModel:QuizFreiesUebenConfigViewModel!{
        didSet{
            if abfragenLabel != nil     { abfragenLabel.reactive.text <~ viewModel.abfragen }
            if anzeigenLabel != nil     { anzeigenLabel.reactive.text <~ viewModel.angezeigte }
            if versteckteLabel != nil   { versteckteLabel.reactive.text <~ viewModel.versteckte }
        }
    }
    
    @IBOutlet weak var abfragenLabel: UILabel!{didSet{if viewModel != nil   {abfragenLabel.reactive.text <~ viewModel.abfragen}}}
    @IBOutlet weak var anzeigenLabel: UILabel!{didSet{if viewModel != nil   {anzeigenLabel.reactive.text <~ viewModel.angezeigte}}}
    @IBOutlet weak var versteckteLabel: UILabel!{didSet{if viewModel != nil {versteckteLabel.reactive.text <~ viewModel.versteckte}}}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        (segue.destination as? QuizAbfragenSettingVC)?.viewModel = viewModel.getViewModelForQuizAbfragenSetting()
    }
}





