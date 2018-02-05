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
    var quizConfigModel:QuizConfigModel             = QuizConfigModel()
    var lektionLabelText:MutableProperty<String?>   = MutableProperty(nil)
    var quizStartenButtonIsEnabled                  = MutableProperty(false)
    var lektionBackgroundColor                      = MutableProperty(orange)
    var freiesUebenBackgroundColor                  = MutableProperty(orange)
    var settingsTabIsEnabled                        = MutableProperty(false)
    var dismissToQuizConfigVC                       = MutableProperty(Void())
    var segueIdentifier                             = MutableProperty(String())
    
    init(){
        // je nachdem welche QuizArt (Lektion /Freies Üben) der User wählt, ändert sich die Hintergrundfarbe (wird grün, falls gewählt)
        freiesUebenBackgroundColor      <~ quizConfigModel.selectedSetting.map                  { $0 == SelectedSetting.FreiesUeben ? selectedColor : orange }
        lektionBackgroundColor          <~ quizConfigModel.selectedSetting.map                  { $0 == SelectedSetting.Lektion ? selectedColor : orange }
        // der Titel der aktuellen Lektion
        lektionLabelText                <~ quizConfigModel.aktuelleLektion.producer.map         { Lektion.getTitle(lektionsNummer: $0)}
        // ein Quiz kann nur gestartet werden, wenn es ein QuizZeichensatz und Abfragen gibt
        quizStartenButtonIsEnabled      <~ quizConfigModel.canStartQuiz
        // Die globalen Settings für einen Lektionsdurchlauf lassen sich nur initital, d.h. vor dem Start der ersten Lektion verändern
        settingsTabIsEnabled            <~ quizConfigModel.aktuelleLektion.map                  {$0 == 0}
    }
    
    //setzt den Identifier für QuizStartSegue
    func setIdentifierForQuizStartSegue()                                           { segueIdentifier.value = quizConfigModel.selectedSetting.value == .Lektion ? "GoToLektionsTexte" : "goToQuiz" }
    
    //MARK: helper
    // wird ausgeführt, wenn der User eine Quizart auswählt (Lektion /Freies Üben)
    func settingGewaehlt(setting:SelectedSetting)                                   { quizConfigModel.selectedSetting.value     = setting }
    
    //MARK: ViewModels
    //QuizViewModel
    func getViewModelForQuizVC()                -> QuizViewModel                    { return QuizViewModel(quizModel:quizConfigModel.getQuizModel()) }
    //ZeichensatzAnzeigen
    func getViewModelForUebenZeichenInAbfrage() -> AbfrageZeichenViewModel        { return AbfrageZeichenViewModel(zeichenSatz: quizConfigModel.freiesUebenQuizZeichenSatz, editable: true, currentQuizZeichenStatusHasChanged: quizConfigModel.currentQuizZeichenStatusHasChanged,segueIdentifier:segueIdentifier)}
    func getViewModelForLektionsZeichenInAbfrage()  -> AbfrageZeichenViewModel    { return AbfrageZeichenViewModel(zeichenSatz: quizConfigModel.lektionsQuizZeichenSatz, editable: false, currentQuizZeichenStatusHasChanged: quizConfigModel.currentQuizZeichenStatusHasChanged,segueIdentifier:nil)}
    //QuizAbfragenSettings
    func getViewModelForFreiesUebenAbfragen() -> AbfragenUndAnzeigenViewModel       { return AbfragenUndAnzeigenViewModel.init(quizSetting: quizConfigModel.freiesUebenQuizSetting, editable: true, settingModus: .InAbfrage,segueIdentifier: segueIdentifier)}
    func getViewModelForLektionsAbfragen() -> AbfragenUndAnzeigenViewModel          { return AbfragenUndAnzeigenViewModel.init(quizSetting: quizConfigModel.lektionsQuizSetting, editable: false, settingModus: .InAbfrage)}
    func getViewModelForLektionsAnzeigen() -> AbfragenUndAnzeigenViewModel          { return AbfragenUndAnzeigenViewModel.init(quizSetting: quizConfigModel.lektionsQuizSetting, editable: false, settingModus: .Anzeige)}
    //QuizModel für ZeichensatzKonfigurator (freies Üben)
    func getViewModelForConfigZeichensatz()         -> ConfigZeichensatzViewModel   { return ConfigZeichensatzViewModel(quizConfigModel: quizConfigModel) }
}



class QuizConfigVC: UIViewController {
    var viewModel:QuizConfigViewModel! = QuizConfigViewModel()
    var settingsTab:UITabBarItem!   {  return tabBarController?.tabBar.items?.filter{$0.title == "Settings"}.first }
    
    //MARK: ViewControlleer LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setzt aktuellen Lektionstitel und
        // Hintergrundfarbe der gewählten QuizArt (Lektionsquiz /Freies Üben)
        lektionLabel.reactive.text                  <~ viewModel.lektionLabelText
        freiesUebenView.reactive.backgroundColor    <~ viewModel.freiesUebenBackgroundColor.producer
        lektionsView.reactive.backgroundColor       <~ viewModel.lektionBackgroundColor.producer
        
        // schaltet den Button zum starten des Quiz an oder aus
        quizStartButton.reactive.isEnabled          <~ viewModel.quizStartenButtonIsEnabled.producer
        
        //der SettingsTab steht nur vor der 1.Lektion zur Verfügung
        settingsTab.reactive.isEnabled <~ viewModel.settingsTabIsEnabled.producer
        
        //Signal, um nach Ende einer Lektion,
        // bei Anzeige des Zeichenfortschritts und Mantrafortschritts
        // zurück zu diesem VC zu kommen
        viewModel.dismissToQuizConfigVC.signal.observeValues {[weak self] _ in  self?.dismiss(animated: true, completion: nil) }

        // passt die Ausrichtung der Stackviews an,
        // wenn sich die Orientierung des Geräts verändert
        iPadOrientation?.producer.startWithValues{ [weak self] orientation in
            self?.mainStack.axis                = orientation == IPadOrientation.landscape ? .horizontal : .vertical
            self?.lektionZeichenStack.axis      = orientation == IPadOrientation.landscape ? .horizontal : .vertical
            self?.freiesUebenzeichenStack.axis  = orientation == IPadOrientation.landscape ? .horizontal : .vertical
            self?.freiesUebenStack.axis         = orientation == IPadOrientation.landscape ? .vertical : .horizontal
            self?.lektionStack.axis             = orientation == IPadOrientation.landscape ? .vertical : .horizontal
        }
        
        //Signale für die Useraktion : <Quiz Starten Button wurde gedrückt>
        quizStartButton.reactive.controlEvents(.touchUpInside).signal.observeValues{[weak self] _ in self?.viewModel.setIdentifierForQuizStartSegue()}
        //segue Identifier wird gesetzt
        viewModel.segueIdentifier.signal.observeValues{[weak self] identifier in self?.performSegue(withIdentifier: identifier, sender: nil)}
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // bei Erscheinen des ViewControllers wird die Userwahl
        // für die QuizArt (Lektionsquiz /Freies Üben) zurückgesetzt
        viewModel.quizConfigModel.selectedSetting.value = nil
        //wenn die aktuelle Lektion die erste ist und QuizSetting erscheint,
        // dann wird der User aufgefordert die globalen Abfrageeinstellungen (Schwierigkeitsgrad) für den nächsten Lektionsdurchlauf zu wählen
        if viewModel.settingsTabIsEnabled.value,let settingsTab = settingsTab{ tabBarController?.selectedIndex = tabBarController?.tabBar.items?.index(of: settingsTab) ?? 0 }
    }
    
    //MARK: Outlets
    @IBOutlet weak var mainStack: UIStackView!
    @IBOutlet weak var lektionStack: UIStackView!
    @IBOutlet weak var freiesUebenStack: UIStackView!
    @IBOutlet weak var lektionZeichenStack: UIStackView!
    @IBOutlet weak var freiesUebenzeichenStack: UIStackView!
    @IBOutlet weak var freiesUebenView: UIView!
    @IBOutlet weak var lektionsView: UIView!
    @IBOutlet weak var quizStartButton: UIButton!
    @IBOutlet weak var quizAbbrechenButton: UIButton!
    @IBOutlet weak var lektionLabel: UILabel!
    @IBOutlet weak var lektionAbfragenView: AbfragenUndAnzeigenView!        { didSet{ lektionAbfragenView.viewModel     = viewModel.getViewModelForLektionsAbfragen() } }
    @IBOutlet weak var lektionAnzeigenView: AbfragenUndAnzeigenView!        { didSet{ lektionAnzeigenView.viewModel     = viewModel.getViewModelForLektionsAnzeigen() } }
    @IBOutlet weak var lektionsZeichenView: ZeichenImQuadratView!           { didSet{ lektionsZeichenView.viewModel     = viewModel.getViewModelForLektionsZeichenInAbfrage() } }
    @IBOutlet weak var uebenZeichenView: ZeichenImQuadratView!              { didSet{ uebenZeichenView.viewModel        = viewModel.getViewModelForUebenZeichenInAbfrage() } }
    @IBOutlet weak var freiesUebenAbfragenView: AbfragenUndAnzeigenView!    { didSet{ freiesUebenAbfragenView.viewModel = viewModel.getViewModelForFreiesUebenAbfragen() } }
    
    //MARK: IBActions
    @IBAction func tapOnLektion(_ sender: UITapGestureRecognizer)           { viewModel.settingGewaehlt(setting: .Lektion) }
    @IBAction func tapOnFreiesUeben(_ sender: UITapGestureRecognizer)       { viewModel.settingGewaehlt(setting: .FreiesUeben) }
    @IBAction func abmeldenAction(_ sender: UIBarButtonItem) {
        MainSettings.get()?.userAbmelden()
        dismiss(animated: true, completion: nil)
    }
    
    //Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        (segue.destination.contentViewController as? QuizVC)?.viewModel                             = viewModel.getViewModelForQuizVC()
        (segue.destination.contentViewController as? ConfigZeichensatzVC)?.viewModel                = viewModel.getViewModelForConfigZeichensatz()
        (segue.destination.contentViewController as? QuizAbfrageSettingsVC)?.settings               = viewModel.quizConfigModel.freiesUebenQuizSetting
        (segue.destination.contentViewController as? LektionstextVC)?.quizViewModel                 = viewModel.getViewModelForQuizVC()
        (segue.destination.contentViewController as? LektionstextVC)?.quizViewModel?.dismissToQuizConfigVC  = viewModel.dismissToQuizConfigVC
    }
    
    
}






