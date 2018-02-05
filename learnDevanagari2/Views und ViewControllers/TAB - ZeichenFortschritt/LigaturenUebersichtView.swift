//
//  LektionenUebersichtView.swift
//  learnDevanagari2
//
//  Created by Matthias Pochmann on 17.01.18.
//  Copyright © 2018 Matthias Pochmann. All rights reserved.
//

import Foundation
import UIKit

//MARK: - LigaturenUebersichtView
// zeigt den aktuellen Fortschritt der Ligaturen
class LigaturenUebersichtView:NibLoadingView{
    let scoreZeichen = MainSettings.get()?.angemeldeterUser?.ligaturenScoreZeichen ?? [ScoreZeichen]()
    @IBOutlet weak var stackView: UIStackView!
    
    func updateStackView(){
        for subview in stackView.arrangedSubviews {subview.removeFromSuperview()}
        let anzahlReihen            = Int(ceil(sqrt(Double(scoreZeichen.count))))
        var arbeitsArray            = scoreZeichen
        for _ in 0 ..< anzahlReihen{
            let addStack            = UIStackView.horizontalEquallyFilled()
            addStack.spacing        = stackView.spacing
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
}





