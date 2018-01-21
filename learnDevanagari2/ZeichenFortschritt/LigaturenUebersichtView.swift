//
//  LektionenUebersichtView.swift
//  learnDevanagari2
//
//  Created by Matthias Pochmann on 17.01.18.
//  Copyright © 2018 Matthias Pochmann. All rights reserved.
//

import Foundation
import UIKit

class LigaturenUebersichtView:NibLoadingView{
    let scoreZeichen = MainSettings.get()?.angemeldeterUser?.ligaturenScoreZeichen ?? [ScoreZeichen]()
    @IBOutlet weak var stackView: UIStackView!
    
    func updateStackView(){
        for subview in stackView.arrangedSubviews {subview.removeFromSuperview()}
        let anzahlReihen            = Int(ceil(sqrt(Double(scoreZeichen.count))))
        var arbeitsArray            = scoreZeichen
        for _ in 0 ..< anzahlReihen{
            
            var hStack:UIStackView{
                let stack = UIStackView()
                stack.axis              = .horizontal
                stack.distribution      = .fillEqually
                stack.spacing           = stackView.spacing
                return stack
            }
            let addStack = hStack
            stackView.addArrangedSubview(addStack)
            for _ in 0 ..< anzahlReihen{
                let iScoreZeichen : ScoreZeichen? = {
                    guard arbeitsArray.count > 0 else {return nil}
                    return arbeitsArray.removeFirst()
                }()
                let label = UILabel()
                label.setStyle(for: iScoreZeichen)
                addStack.addArrangedSubview(label)
            }
        }
    }
    private func set(label:UILabel, for scoreZeichen:ScoreZeichen?){
        
    }
}

extension UILabel{
    func setStyle(for scoreZeichen:ScoreZeichen?){
        ZeichenUebersichtView.setStyle(for: self, score: scoreZeichen?.gesamtScore ?? 0)
        text          =  (scoreZeichen?.gesamtScore ?? 0) > 0 ? scoreZeichen?.devaString : nil
        textAlignment = .center
    }
}



