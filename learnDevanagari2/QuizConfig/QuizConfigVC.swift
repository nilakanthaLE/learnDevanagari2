//
//  QuizConfigVC.swift
//  learnDevanagari2
//
//  Created by Matthias Pochmann on 08.11.17.
//  Copyright © 2017 Matthias Pochmann. All rights reserved.
//

import UIKit
import ReactiveSwift
let selectedColor = UIColor.green

class QuizConfigViewModel{
    //Model
    var quizConfigModel:QuizConfigModel     = QuizConfigModel()
    var iPadOrientation = (UIApplication.shared.delegate as? AppDelegate)?.iPadOrientation
    var freiesUebenAbfragenLabelText                = MutableProperty<String?>("")
    var lektionLabelText:MutableProperty<String?>   = MutableProperty(nil)
    var quizStartenButtonIsEnabled                  = MutableProperty(false)
    var quizZeichenSatzIstLeer                      = MutableProperty(Void())
    var lektionBackgroundColor                      = MutableProperty(orange)
    var freiesUebenBackgroundColor                  = MutableProperty(orange)
    init(){
        func toggleBackground(to selectedSetting:SelectedSetting?){
            guard let selectedSetting = selectedSetting else{
                lektionBackgroundColor.value        = orange
                freiesUebenBackgroundColor.value    = orange
                return
            }
            switch selectedSetting {
            case .FreiesUeben:
                freiesUebenBackgroundColor.value    = selectedColor
                lektionBackgroundColor.value        = orange
            case .Lektion:
                lektionBackgroundColor.value        = selectedColor
                freiesUebenBackgroundColor.value    = orange
            }
        }
        quizConfigModel.selectedSetting.producer.startWithValues() { toggleBackground(to: $0) }
        freiesUebenAbfragenLabelText    <~ quizConfigModel.freiesUebenQuizSetting.producer.map{ quizSetting in getText(for: .InAbfrage, in: quizSetting) }
        lektionLabelText                <~ quizConfigModel.aktuelleLektion.producer.map{$0?.title ?? "fehlt"}
        quizZeichenSatzIstLeer          <~ quizConfigModel.quizZeichenInAbfrageIstLeer
        quizStartenButtonIsEnabled      <~ quizConfigModel.canStartQuiz
    }
    
    func settingGewaehlt(setting:SelectedSetting){ quizConfigModel.selectedSetting.value     = setting }
    
    //ViewModels
    //QuizViewModel
    func getViewModelForQuizVC()                -> QuizViewModel                    { return QuizViewModel(quizModel:quizConfigModel.getQuizModel()) }
    //ZeichensatzAnzeigen
    func getViewModelForUebenZeichenInAbfrage() -> ZeichenInAbfrageViewModel        { return ZeichenInAbfrageViewModel(zeichenSatz: quizConfigModel.freiesUebenQuizZeichenSatz, editable: true)}
    func getViewModelForLektionsZeichenInAbfrage()  -> ZeichenInAbfrageViewModel    { return ZeichenInAbfrageViewModel(zeichenSatz: quizConfigModel.lektionsQuizZeichenSatz, editable: false)}
    //QuizAbfragenSettings
    func getViewModelForQuizAbfragenSetting()   -> QuizAbfragenSettingViewModel     { return QuizAbfragenSettingViewModel( quizSetting:quizConfigModel.freiesUebenQuizSetting) }
    func getViewModelForFreiesUebenAbfragen() -> AbfragenUndAnzeigenViewModel       { return AbfragenUndAnzeigenViewModel.init(quizSetting: quizConfigModel.freiesUebenQuizSetting, editable: true, settingModus: .InAbfrage)}
    func getViewModelForLektionsAbfragen() -> AbfragenUndAnzeigenViewModel          { return AbfragenUndAnzeigenViewModel.init(quizSetting: quizConfigModel.lektionsQuizSetting, editable: false, settingModus: .InAbfrage)}
    func getViewModelForLektionsAnzeigen() -> AbfragenUndAnzeigenViewModel          { return AbfragenUndAnzeigenViewModel.init(quizSetting: quizConfigModel.lektionsQuizSetting, editable: false, settingModus: .Anzeige)}
    //QuizModel für ZeichensatzKonfigurator (freies Üben)
    func getViewModelForConfigZeichensatz()         -> ConfigZeichensatzViewModel   { return ConfigZeichensatzViewModel(quizConfigModel: quizConfigModel) }
}

class QuizConfigVC: UIViewController {
    var viewModel:QuizConfigViewModel! = QuizConfigViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        lektionLabel.reactive.text                  <~ viewModel.lektionLabelText
        freiesUebenView.reactive.backgroundColor    <~ viewModel.freiesUebenBackgroundColor.producer
        lektionsView.reactive.backgroundColor       <~ viewModel.lektionBackgroundColor.producer
        quizStartButton.reactive.isEnabled          <~ viewModel.quizStartenButtonIsEnabled.producer
        
        //wenn QuizZeichensatz leer ist, dann zurück aus Quiz
        viewModel.quizZeichenSatzIstLeer.signal.observeValues{[weak self] _ in self?.dismiss(animated: true, completion: nil) }
        viewModel.iPadOrientation?.producer.startWithValues{ [weak self] orientation in
            self?.mainStack.axis                = orientation == IPadOrientation.landscape ? .horizontal : .vertical
            self?.freiesUebenStack.axis         = orientation == IPadOrientation.landscape ? .vertical : .horizontal
            self?.lektionStack.axis             = orientation == IPadOrientation.landscape ? .vertical : .horizontal
            self?.lektionZeichenStack.axis      = orientation == IPadOrientation.landscape ? .horizontal : .vertical
            self?.freiesUebenzeichenStack.axis  = orientation == IPadOrientation.landscape ? .horizontal : .vertical
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.quizConfigModel.selectedSetting.value = nil
    }
    
    //Outlets
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
    @IBOutlet weak var lektionAbfragenView: AbfragenUndAnzeigenView!        { didSet{ lektionAbfragenView.viewModel = viewModel.getViewModelForLektionsAbfragen() } }
    @IBOutlet weak var lektionAnzeigenView: AbfragenUndAnzeigenView!        { didSet{ lektionAnzeigenView.viewModel = viewModel.getViewModelForLektionsAnzeigen() } }
    @IBOutlet weak var lektionsZeichenView: ZeichenInAbfrageView!           { didSet{ lektionsZeichenView.viewModel = viewModel.getViewModelForLektionsZeichenInAbfrage() } }
    @IBOutlet weak var uebenZeichenView: ZeichenInAbfrageView!              {
        didSet{
            uebenZeichenView.viewModel          = viewModel.getViewModelForUebenZeichenInAbfrage()
            uebenZeichenView.editButtonAction   = {[weak self] in self?.performSegue(withIdentifier: "showZeichenSatzConfig", sender: nil)}
        }
    }
    @IBOutlet weak var freiesUebenAbfragenView: AbfragenUndAnzeigenView!    {
        didSet{
            freiesUebenAbfragenView.viewModel           = viewModel.getViewModelForFreiesUebenAbfragen()
            freiesUebenAbfragenView.editButtonAction    = { [weak self] in self?.performSegue(withIdentifier: "showQuizAbfragenConfig", sender: nil) }
        }
    }
    //IBActions
    @IBAction func tapOnLektion(_ sender: UITapGestureRecognizer)                   { viewModel.settingGewaehlt(setting: .Lektion) }
    @IBAction func tapOnFreiesUeben(_ sender: UITapGestureRecognizer)               { viewModel.settingGewaehlt(setting: .FreiesUeben) }
    
    //Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        (segue.destination as? QuizVC)?.viewModel                           = viewModel.getViewModelForQuizVC()
//        (segue.destination as? QuizAbfragenSettingView)?.viewModel            = viewModel.getViewModelForQuizAbfragenSetting()
        (segue.destination as? ConfigZeichensatzVC)?.viewModel              = viewModel.getViewModelForConfigZeichensatz()
    }
    
    @IBAction func abmeldenAction(_ sender: UIBarButtonItem) {
        MainSettings.get()?.angemeldeterUser = nil
        try? managedContext.save()
        dismiss(animated: true, completion: nil)
    }
}


func getText(for controlModus:PanelControlModus,in settings:QuizSetting?) -> String?{
    var reducedSettings = settings?.panelControls(for: controlModus)
    var panelText       = reducedSettings?.enumerated().reduce("") { (result, setting) -> String in
        var new:String{ return (setting.element.konsonantTypModus?.controlName ?? setting.element.controlTyp.controlName ?? "") }
        var postfix:String { return setting.offset + 1 < reducedSettings?.count ?? 0 ? ", " : "" }
        return result + new + postfix
    }
    return panelText
}


extension UIApplication {
    var visibleViewController: UIViewController? {
        guard let rootViewController = keyWindow?.rootViewController else { return nil }
        return getVisibleViewController(rootViewController)
    }
    private func getVisibleViewController(_ rootViewController: UIViewController) -> UIViewController? {
        if let presentedViewController = rootViewController.presentedViewController { return getVisibleViewController(presentedViewController) }
        if let navigationController = rootViewController as? UINavigationController { return navigationController.visibleViewController }
        if let tabBarController = rootViewController as? UITabBarController         { return tabBarController.selectedViewController  }
        return rootViewController
    }
}
