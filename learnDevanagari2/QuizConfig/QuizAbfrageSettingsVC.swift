//
//  SettingsTabVC.swift
//  learnDevanagari2
//
//  Created by Matthias Pochmann on 08.12.17.
//  Copyright © 2017 Matthias Pochmann. All rights reserved.
//

import UIKit
import ReactiveSwift

class QuizAbfrageSettingsVC: UIViewController {
    var isFreiesUebensetting = false
    var settings =  MutableProperty(QuizSetting.init(dict: MainSettings.get()?.angemeldeterUser?.lektionsQuizSettings as? [String:String])){ didSet{ isFreiesUebensetting = true } }
    @IBOutlet weak var quizAbfragenSettingsView: QuizAbfragenSettingView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if !isFreiesUebensetting{
            settings.signal.observeValues{settings in
                MainSettings.get()?.angemeldeterUser?.lektionsQuizSettings = settings?.asDict as NSObject?
                try? managedContext.save()
            }
        }
        quizAbfragenSettingsView.viewModel = QuizAbfragenSettingViewModel(quizSetting:settings,isFreiesUebensetting:isFreiesUebensetting)
    }
    
    var alertMessage = "Hier werden die Abfragen für das Lektionsquiz eingestellt.\nDiese beziehen sich auf alle Lektionen von der ersten bis zur letzten und können erst wieder nach Beendigung eines Durchlaufs geändert werden.\n\n Die Lektionstexte beziehen sich auf die dritte Stufe. D.h. es werden auch in den ersten beiden Stufen die Grundlagen bereits vorgestellt, jedoch im Quiz noch nicht abgefragt.\n\nEs bietet sich an, das Quiz zunächst in Stufe 1 oder 2 durchzuarbeiten und es danach ein zweites oder drittes Mal in einer schwierigeren Stufe zu wiederholen. Auf diese Weise ist die Übung nicht überfordernd und anderseits stellt sich insgesamt ein größerer Lerneffekt ein"
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !isFreiesUebensetting{
            let alertView = UIAlertController(title: "Abfragen für Lektionsquiz", message: alertMessage, preferredStyle: .alert)
            alertView.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alertView, animated: true, completion: nil)
        }
    }
}



