//
//  MainModel.swift
//  learnDevanagari2
//
//  Created by Matthias Pochmann on 08.11.17.
//  Copyright © 2017 Matthias Pochmann. All rights reserved.
//

import Foundation
import ReactiveSwift




class QuizConfigModel{
    let lektionen = erstelleLektionen()
    var aktuelleLektion:MutableProperty<Lektion?>
    
    var gewaehltesQuizSetting:MutableProperty<QuizSetting?>     = MutableProperty(nil)
    var freiesUebenQuizSetting:MutableProperty<QuizSetting>     = MutableProperty(QuizSetting())
    
    
    var gewaehlterZeichensatz:MutableProperty<[Zeichen]>        = MutableProperty([Zeichen]())
    
    func useFreiesUebenSettings(){
        gewaehltesQuizSetting.value = freiesUebenQuizSetting.value
    }
    func useLektionSetting(){
        gewaehltesQuizSetting.value = aktuelleLektion.value?.quizSetting
        gewaehlterZeichensatz.value = erstelleZeichensatz().filter{$0.lektion ?? 1000 < aktuelleLektion.value?.nummer ?? 0 }
    }
    var quizZeichenSatzCount = MutableProperty(0)
    
    init(){
        
        aktuelleLektion = MutableProperty(lektionen[0])
        aktuelleLektion <~ quizZeichenSatzCount.signal.filter{$0 == 0}.map{[weak self] _ -> Lektion? in self?.lektionen[self?.aktuelleLektion.value?.nummer ?? 0] }
    }
}




class TESTUNG:UIViewController{
//    var mainModel:MainModel! = (UIApplication.shared.delegate as! AppDelegate).mainModel
    
    @IBOutlet weak var stack: UIStackView!
    
    override func viewDidLayoutSubviews() {
        
        let safeAreaSize = view.safeAreaLayoutGuide.layoutFrame.size
        if lastSize != safeAreaSize{
            stack.axis = safeAreaSize.width > safeAreaSize.height ? .horizontal : .vertical
        }
        lastSize = safeAreaSize
    }
    
    
    var lastSize:CGSize?

}
