//
//  ZeichenUbersichtVC.swift
//  learnDevanagari2
//
//  Created by Matthias Pochmann on 29.11.17.
//  Copyright © 2017 Matthias Pochmann. All rights reserved.
//

import UIKit

class ZeichenUbersichtVC: UIViewController {


    @IBOutlet private weak var zeichenUebersichtView: ZeichenUebersichtView!{ didSet{ zeichenUebersichtView.viewModel = ZeichenUebersichtViewModel()  } }
    
    @IBOutlet private weak var rahmenView: UIView!{
        didSet{
            rahmenView.layer.borderWidth   = 2
            rahmenView.layer.borderColor   = UIColor.white.cgColor
            rahmenView.layer.cornerRadius  = 5
            rahmenView.backgroundColor      = UIColor.init(white: 0, alpha: 0.2)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        zeichenUebersichtView.updateButtonData()
    }
}
