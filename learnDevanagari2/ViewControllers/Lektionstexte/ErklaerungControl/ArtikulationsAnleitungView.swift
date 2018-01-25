//
//  ArtikulationsAnleitungView.swift
//  learnDevanagari2
//
//  Created by Matthias Pochmann on 28.11.17.
//  Copyright © 2017 Matthias Pochmann. All rights reserved.
//

import Foundation
import UIKit

class ArtikulationsAnleitungViewModel{
    var imageName:String
    var labelText:String
    init(artikulationAnleitungViewData:ArtikulationAnleitungViewData){
        imageName   = artikulationAnleitungViewData.imageName
        labelText   = artikulationAnleitungViewData.text
    }
}

class ArtikulationsAnleitungView:NibLoadingView{
    var viewModel: ArtikulationsAnleitungViewModel!{
        didSet{
            imageView.image = UIImage(named: viewModel.imageName)
            stackLabelView.viewModel = StackLabelViewModel(labelText: viewModel.labelText)
            
        }
    }
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var stackLabelView: StackLabelView!
    
}
