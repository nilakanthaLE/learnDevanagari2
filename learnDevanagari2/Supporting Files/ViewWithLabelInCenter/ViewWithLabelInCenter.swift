//
//  ViewWithLabelInCenter.swift
//  learnDevanagari2
//
//  Created by Matthias Pochmann on 25.01.18.
//  Copyright © 2018 Matthias Pochmann. All rights reserved.
//

import Foundation
import UIKit

class ViewWithLabelInCenter:NibLoadingView{
    @IBOutlet weak var label: UILabel!{
        didSet{
            label.backgroundColor     = .clear
            layer.borderColor = UIColor.black.cgColor
            layer.borderWidth = 0.25
        }
    }
    convenience init(title:String = String(),color:UIColor = .clear,frame:CGRect = CGRect.zero) {
        self.init(frame: frame)
        label.text              = title
        backgroundColor         = color
    }
}
