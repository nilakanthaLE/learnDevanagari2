//
//  ZeichenfeldView.swift
//  learnDevanagari2
//
//  Created by Matthias Pochmann on 29.01.18.
//  Copyright © 2018 Matthias Pochmann. All rights reserved.
//

import Foundation
import UIKit

//MARK: ZeichenfeldView
// ein Zeichenfeld auf dem der User zeichnen kann
// BasisKlasse für DevanagariZeichenfeldView
class ZeichenfeldView: NibLoadingView {
    override var nibName: String                        { return "ZeichenfeldView" }
    
    //MARK: IBOutlets
    @IBOutlet weak var imageView: UIImageView!          { didSet{ currentSize = bounds.size } }
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var nachZeichnenLabel: UILabel!
    
    //MARK: IBActions
    @IBAction func resetButtonPressed(_ sender: UIButton) { }
    @IBAction func okButtonPressed(_ sender: UIButton) { }
    
    //MARK: Drawing
    private let pinselBreite:CGFloat = 5.0
    private var currentPoint:CGPoint?
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {  currentPoint =  touches.first?.location(in: self) }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let _nextPoint = touches.first?.location(in: self)
        guard let image = self.imageView.image, let currentPoint = currentPoint, let nextPoint = _nextPoint else {return}
        self.imageView.image    = drawOnImage(startingImage: image, start: currentPoint, end: nextPoint)
        self.currentPoint       = nextPoint
    }
    
    //MARK: Größen Änderungen
    var currentSize:CGSize?         {
        didSet{
            backgroundColor = orange.changeBrightness(dif: -0.3)
            imageView.image = UIImage( size: bounds.size)
            nachZeichnenLabel.font = UIFont.boldSystemFont(ofSize: (bounds.size.height / 2))
        }
    }
    override func layoutSubviews()  {
        super.layoutSubviews()
        if currentSize != bounds.size   { currentSize = bounds.size }
    }
}


