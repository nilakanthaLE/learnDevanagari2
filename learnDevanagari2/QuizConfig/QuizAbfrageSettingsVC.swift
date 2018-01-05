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
}



