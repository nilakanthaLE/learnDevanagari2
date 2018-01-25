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
    var dismissToRoot:MutableProperty<Void>?
    var zeichenButtonPressed = MutableProperty<UIView?>(nil)
    
    @IBOutlet private weak var zeichenUebersichtView: ZeichenUebersichtView!{ didSet{ zeichenUebersichtView.viewModel = ZeichenUebersichtViewModel(zeichenButtonPressed: zeichenButtonPressed)  } }
    
    var titleForLigaturenButton:String{
        if !ligaturenUebersichtView.isHidden{ return "Basiszeichen" }
        return "Ligaturen"
    }
    @IBAction func ligaturenButtonPressed(_ sender: UIBarButtonItem) {
        ligaturenUebersichtView.isHidden    = !ligaturenUebersichtView.isHidden
        zeichenUebersichtView.isHidden      = !zeichenUebersichtView.isHidden
        if !ligaturenUebersichtView.isHidden{ ligaturenUebersichtView.updateStackView()}
        sender.title = titleForLigaturenButton
    }
    @IBOutlet weak var ligaturenUebersichtView: LigaturenUebersichtView!
    @IBOutlet weak var weiterBarButton: UIBarButtonItem!
    @IBOutlet private weak var rahmenView: UIView!{
        didSet{
            rahmenView.layer.borderWidth   = 2
            rahmenView.layer.borderColor   = UIColor.white.cgColor
            rahmenView.layer.cornerRadius  = 5
            rahmenView.backgroundColor      = UIColor.init(white: 0, alpha: 0.2)
        }
    }
    @IBAction func weiterBarButtonPressed(_ sender: UIBarButtonItem) {
        dismissToRoot?.value = Void()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if dismissToRoot == nil     { navigationItem.rightBarButtonItem = nil }
        zeichenButtonPressed.signal.observeValues{[weak self] zeichenDevaString in
            self?.performSegue(withIdentifier: "showSubZeichen", sender: zeichenDevaString)
        }
        navigationItem.leftBarButtonItem?.title = titleForLigaturenButton
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        zeichenUebersichtView.updateButtonData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let button = sender as? UIButton, let subZeichenVC = segue.destination.contentViewController as? SubZeichenVC else {return}
        segue.destination.popoverPresentationController?.sourceRect =  zeichenUebersichtView.convert(button.frame, from: button.superview)
        let iWidthHeight = button.frame.size.width
        subZeichenVC.preferredContentSize = CGSize(width: iWidthHeight * 4, height: iWidthHeight * 3)

        subZeichenVC.subZeichen = MainSettings.get()?.angemeldeterUser?.getScoreZeichen(for: button.currentTitle)?.grundZeichen ?? [ScoreZeichen]()
        subZeichenVC.view.backgroundColor = UIColor(white: 0, alpha: 0.2)
    }
}

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
