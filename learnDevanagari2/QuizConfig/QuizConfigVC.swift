//
//  QuizConfigVC.swift
//  learnDevanagari2
//
//  Created by Matthias Pochmann on 08.11.17.
//  Copyright © 2017 Matthias Pochmann. All rights reserved.
//

import UIKit
import ReactiveSwift


class QuizConfigViewModel{
    var quizConfigModel:QuizConfigModel     = QuizConfigModel()
    
    var freiesUebenAbfragenLabelText        = MutableProperty<String?>("")
    
    var lektionLabelText:MutableProperty<String?> = MutableProperty(nil)
    
    init(){
        freiesUebenAbfragenLabelText    <~ quizConfigModel.freiesUebenQuizSetting.producer.map{ quizSetting in getText(for: .Abfrage, in: quizSetting) }
        lektionLabelText                <~ quizConfigModel.aktuelleLektion.producer.map{$0?.title ?? "fehlt"}
        quizZeichenSatzCount            <~ quizConfigModel.quizZeichenSatzCount.producer
    }
    
    var quizZeichenSatzCount = MutableProperty(0)
    
    func getViewModelForQuizConfig()            -> QuizViewModel                    { return QuizViewModel(quizModel:QuizModel(quizConfigModel: quizConfigModel)) }
    func getViewModelForFreiesUebenConfig()     -> QuizFreiesUebenConfigViewModel   { return QuizFreiesUebenConfigViewModel(quizConfigModel:quizConfigModel)}
}

class QuizConfigVC: UIViewController {
    var viewModel:QuizConfigViewModel! = QuizConfigViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        freiesUebenAbfragenLabel.reactive.text  <~ viewModel.freiesUebenAbfragenLabelText
        lektionLabel.reactive.text              <~ viewModel.lektionLabelText
        viewModel.quizZeichenSatzCount.producer.filter{$0 == 0}.start(){[weak self] _ in
            self?.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    @IBOutlet weak var freiesUebenAbfragenLabel: UILabel!
    @IBAction func freiesUebenConfigVerwendenPressed(_ sender: UIButton) {
        viewModel.quizConfigModel.useFreiesUebenSettings()
    }
    
    @IBOutlet weak var lektionLabel: UILabel!
    @IBAction func lektionVerwendenPressed(_ sender: UIButton) {
        viewModel.quizConfigModel.useLektionSetting()
    }
    
    @IBOutlet weak var gewaehlteEinstellungenLabel: UILabel!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        (segue.destination as? QuizVC)?.viewModel                   = viewModel.getViewModelForQuizConfig()
        (segue.destination as? QuizFreiesUebenConfigVC)?.viewModel  = viewModel.getViewModelForFreiesUebenConfig()
    }
}


func getText(for controlModus:PanelControlModus,in settings:QuizSetting?) -> String?{
    var reducedSettings = settings?.panelControls(for: controlModus)
    var panelText = reducedSettings?.enumerated().reduce("") { (result, setting) -> String in
        var new:String{ return (setting.element.konsonantTypModus?.controlName ?? setting.element.controlTyp.controlName ?? "") }
        var postfix:String { return setting.offset + 1 < reducedSettings?.count ?? 0 ? ", " : "" }
        return result + new + postfix
    }
    
    return panelText
}
