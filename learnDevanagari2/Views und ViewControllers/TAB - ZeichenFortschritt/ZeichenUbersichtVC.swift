//
//  ZeichenUbersichtVC.swift
//  learnDevanagari2
//
//  Created by Matthias Pochmann on 29.11.17.
//  Copyright © 2017 Matthias Pochmann. All rights reserved.
//

import UIKit
import ReactiveSwift

class ZeichenUbersichtVC: UIViewController {
    var dismissToQuizConfigVC:MutableProperty<Void>?
    var zeichenButtonPressed = MutableProperty<UIView?>(nil)
    var titleForLigaturenButton:String { return !ligaturenUebersichtView.isHidden ? "Basiszeichen" : "Ligaturen" }
    
    //MARK: - IBOutlets
    @IBOutlet private weak var zeichenUebersichtView: ZeichenUebersichtView!        { didSet { zeichenUebersichtView.viewModel = ZeichenUebersichtViewModel(zeichenButtonPressed: zeichenButtonPressed) } }
    @IBOutlet private weak var rahmenView: UIView!                                  { didSet { setRahmen(for: rahmenView) } }
    @IBOutlet private weak var ligaturenUebersichtView: LigaturenUebersichtView!
    @IBOutlet private weak var weiterBarButton: UIBarButtonItem!

    //MARK: - IBActions
    @IBAction func weiterBarButtonPressed(_ sender: UIBarButtonItem)                { dismissToQuizConfigVC?.value = Void() }
    @IBAction func ligaturenButtonPressed(_ sender: UIBarButtonItem) {
        ligaturenUebersichtView.isHidden    = !ligaturenUebersichtView.isHidden
        zeichenUebersichtView.isHidden      = !zeichenUebersichtView.isHidden
        if !ligaturenUebersichtView.isHidden{ ligaturenUebersichtView.updateStackView() }
        sender.title = titleForLigaturenButton
    }
    
    //MARK: - ViewController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if dismissToQuizConfigVC == nil { navigationItem.rightBarButtonItem = nil }
        navigationItem.leftBarButtonItem?.title = titleForLigaturenButton
        //Action, wenn auf ein Zeichen gedrückt wird
        // zeigt popup mit abgeleiten Zeichen ( Grundzeichen + Vokale )
        zeichenButtonPressed.signal.observeValues{[weak self] zeichenDevaString in self?.performSegue(withIdentifier: "showSubZeichen", sender: zeichenDevaString) }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        zeichenUebersichtView.updateButtonData()
    }
    
    //MARK: - segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //popup mit abgeleiten Zeichen ( z.B.: Grundzeichen + Vokale )
        guard let button = sender as? UIButton, let subZeichenVC = segue.destination.contentViewController as? SubZeichenVC else {return}
        segue.destination.popoverPresentationController?.sourceRect =  zeichenUebersichtView.convert(button.frame, from: button.superview)
        subZeichenVC.preferredContentSize   = CGSize(width: button.frame.size.width * 4 , height: button.frame.size.width * 3) // 4 x 3 Button Größe
        subZeichenVC.subZeichen             = MainSettings.get()?.angemeldeterUser?.getScoreZeichen(for: button.currentTitle)?.grundZeichen ?? [ScoreZeichen]()
        subZeichenVC.view.backgroundColor   = UIColor(white: 0, alpha: 0.2)
    }
    
    //MARK: - helper
    private func setRahmen(for view:UIView){
        rahmenView.layer.borderWidth   = 2
        rahmenView.layer.borderColor   = UIColor.white.cgColor
        rahmenView.layer.cornerRadius  = 5
        rahmenView.backgroundColor      = UIColor.init(white: 0, alpha: 0.2)
    }
}

//MARK: - SubZeichenVC
//Popup für  abgeleiten Zeichen ( z.B.: Grundzeichen + Vokale )
class SubZeichenVC:UIViewController{
    var subZeichen = [ScoreZeichen]()
    @IBOutlet weak var stackView: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()
        var i = 0
        for stack in stackView.arrangedSubviews as? [UIStackView] ?? [UIStackView](){
            for _view in stack.arrangedSubviews{
                if  let label = _view as? UILabel{
                    let scoreZeichen = i < subZeichen.count ?  subZeichen[i] : nil
                    label.setStyle(for: scoreZeichen)
                    i += 1
                }
            }
        }
    }

}
