//
//  StackLabelView.swift
//  learnDevanagari2
//
//  Created by Matthias Pochmann on 28.11.17.
//  Copyright © 2017 Matthias Pochmann. All rights reserved.
//

import Foundation
import UIKit
import ReactiveSwift
import ReactiveCocoa

class StackLabelViewModel{
    var labelText = MutableProperty<String?>(nil)
    init(labelText:String?){ self.labelText.value = labelText }
}

class StackLabelView:NibLoadingView{
    var viewModel:StackLabelViewModel!{
        didSet{
            label.reactive.text <~ viewModel.labelText.producer
        }
    }
    @IBOutlet private weak var label: UILabel!
}
