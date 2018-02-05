//
//  NasaleAnleitungView.swift
//  learnDevanagari2
//
//  Created by Matthias Pochmann on 18.01.18.
//  Copyright © 2018 Matthias Pochmann. All rights reserved.
//

import Foundation
import UIKit


//MARK:NasaleAnleitungViewModel
// der View für die Veranschaulichung der Nasale
// enthält Bild und Text
class NasaleAnleitungViewModel{
    var labelText:String
    init(labelText:String){ self.labelText   = labelText }
}
class NasaleAnleitungView:NibLoadingView{
    var viewModel: NasaleAnleitungViewModel!{
        didSet{
            stackLabelView.viewModel = StackLabelViewModel(labelText: viewModel.labelText) 
        }
    }
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var stackLabelView: StackLabelView!
}
