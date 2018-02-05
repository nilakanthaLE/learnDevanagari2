//
//  SettingsTabVC.swift
//  learnDevanagari2
//
//  Created by Matthias Pochmann on 08.12.17.
//  Copyright © 2017 Matthias Pochmann. All rights reserved.
//

import UIKit
import ReactiveSwift

//MARK: QuizAbfrageSettingsVC
class QuizAbfrageSettingsVC: UIViewController {
    // Settings ist standardmäßig das globale Setting für den Lektionsdurchlauf
    // wenn settings gesetzt wird, werden settings fürs freie Üben konfiguriert
    var isFreiesUebensetting    = false
    var settings                =  MutableProperty(QuizSetting.init(nsobject: MainSettings.get()?.angemeldeterUser?.lektionsQuizSettings))             { didSet{ isFreiesUebensetting = true } }
    
    //MARK: Outlets
    // das eigentliche Konfigurationsview
    @IBOutlet weak var quizAbfragenSettingsView: QuizAbfragenSettingView!
    
    //MARK: ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // wenn das globale Setting für den Lektionsdurchlauf konfiguriert wird,
        // wird settings observiert und Änderungen im angemeldeten Userobjekt gespeichert
        if !isFreiesUebensetting            { settings.signal.observeValues{ MainSettings.get()?.angemeldeterUser?.setMainSettings(settings: $0) } }
        // ViewModel für Konfigurationsview setzen -> MutableProperty setting wird übergeben
        quizAbfragenSettingsView.viewModel = QuizAbfragenSettingViewModel(quizSetting:settings,isFreiesUebensetting:isFreiesUebensetting)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // wenn das globale Setting für den Lektionsdurchlauf konfiguriert wird,
        // und damit die erste Lektion noch nicht begonnen wurde,
        // dann wird ein alertView präsentiert, der darauf hinweist, dass nur bis zum Start der ersten Lektion
        // das globale Setting des Lektionsquizzes verändert werden kann
        if !isFreiesUebensetting            { present(alertView, animated: true, completion: nil) }
    }
    
    //MARK: alertView
    var alertView:UIAlertController{
        let alertView = UIAlertController(title: "Abfragen für Lektionsquiz", message: alertMessage, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return alertView
    }
}

//MARK: alertText
// Text für den Fall, dass die Settings für den Lektionsdurchlauf gesetzt werden
// Nur vor der ersten Lektion steht der Tab für diese Einstellung zur Verfügung
// Dabei werden die Abfragen gewählt, die dann maximal während eines Lektionsquizdurchlaufs abgefragt werden
fileprivate var alertMessage = "Hier werden die Abfragen für das Lektionsquiz eingestellt.\nDiese beziehen sich auf alle Lektionen von der ersten bis zur letzten und können erst wieder nach Beendigung eines Durchlaufs geändert werden.\n\n Die Lektionstexte beziehen sich auf die dritte Stufe. D.h. es werden auch in den ersten beiden Stufen die Grundlagen bereits vorgestellt, jedoch im Quiz noch nicht abgefragt.\n\nEs bietet sich an, das Quiz zunächst in Stufe 1 oder 2 durchzuarbeiten und es danach ein zweites oder drittes Mal in einer schwierigeren Stufe zu wiederholen. Auf diese Weise ist die Übung nicht überfordernd und anderseits stellt sich insgesamt ein größerer Lerneffekt ein"
