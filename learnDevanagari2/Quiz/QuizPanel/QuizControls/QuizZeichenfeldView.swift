//
//  QuizZeichenfeldView.swift
//  learnDevanagari2
//
//  Created by Matthias Pochmann on 06.11.17.
//  Copyright © 2017 Matthias Pochmann. All rights reserved.
//

import UIKit
import TesseractOCR
import ReactiveSwift









class QuizZeichenfeldViewModel{
    var quizModel:QuizModel
    var showsZeichenFeld:MutableProperty<Bool>
    init(quizModel:QuizModel, showsZeichenFeld    : MutableProperty<Bool>) {
        self.quizModel          = quizModel
        self.showsZeichenFeld   = showsZeichenFeld
        self.quizModel.userEingabe.devanagari           <~ erkanntesZeichen
        self.quizModel.userEingabeDevaErkannteZeichen   <~ erkannteZeichen
        nachZeichnenLabelText <~ self.quizModel.currentQuizZeichen.producer.map { $0?.quizSetting.zeichenfeld == .Nachzeichnen ? $0?.zeichen.devanagari : nil }
        quizModel.currentQuizZeichen.producer.startWithValues                   { [weak self] quizZeichen in self?.useTesseract = quizZeichen?.quizSetting.zeichenfeld != .Nachzeichnen }
        charWhiteList <~ quizModel.zeichenSatz.map{$0.map{$0.devanagari ?? nil} .filter{$0 != nil} .reduce("") {$0 + $1!} }
    }
    var userEingabePrüfen       = MutableProperty(false)
    var erkannteZeichen         = MutableProperty([String]())
    var erkanntesZeichen        = MutableProperty<String?>(nil)
    var nachZeichnenLabelText   = MutableProperty<String?>(nil)
    var backGroundColor         = MutableProperty(colorForDefault)
    var useTesseract = false
    
    var charWhiteList           = MutableProperty("")
    
}
class QuizZeichenfeldView: ZeichenfeldView,G8TesseractDelegate {
    
    var viewModel : QuizZeichenfeldViewModel!{
        didSet{
            isUserInteractionEnabled = true
            tesseract = G8Tesseract(language: "san", engineMode: G8OCREngineMode.tesseractOnly)
            tesseract?.delegate = self
            tesseract?.pageSegmentationMode = .singleWord
            nachZeichnenLabel.reactive.text <~ viewModel.nachZeichnenLabelText.producer
            
        }
    }
    
    
    
    override func resetButtonPressed(_ sender: UIButton)    { currentSize = bounds.size }
    override func okButtonPressed(_ sender: UIButton)       {
        if viewModel.useTesseract{
            ocr(for: imageView.image)
        }
        viewModel.showsZeichenFeld.value = false
    }
    
    private var tesseract: G8Tesseract?
    private func ocr(for image:UIImage?){
        guard let image = image else {return}
        tesseract?.image = image
        tesseract?.charWhitelist = viewModel.charWhiteList.value
        tesseract?.recognize()
        print(viewModel.charWhiteList.value)
        func getCharArray() -> [String]{
            let anfangsArray = tesseract?.characterChoices as? [[G8RecognizedBlock]]
            var ergebnis = Set<String>()
            _ = anfangsArray.map   { (block)  in
                block.map{ (_block) in
                    let sorted = _block.sorted{$0.confidence > $1.confidence}
                    _ = sorted.map{ (__block)  in
                        ergebnis.insert(__block.text)
                    }
                }
            }
            print(Array(ergebnis.filter{$0 != " "}))
            return Array(ergebnis.filter{$0 != " "})
        }
        let charArray = getCharArray()
        
        viewModel.erkannteZeichen.value     = charArray
        viewModel.erkanntesZeichen.value    = charArray.first
    }
}

class ZeichenfeldView: NibLoadingView {
    override var nibName: String{ return "ZeichenfeldView" }
    @IBOutlet weak var imageView: UIImageView!          { didSet{ currentSize = bounds.size } }
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var nachZeichnenLabel: UILabel!
    
    @IBAction func resetButtonPressed(_ sender: UIButton) { }
    @IBAction func okButtonPressed(_ sender: UIButton) { }
    
    
    //MARK: Drawing
    let pinselBreite:CGFloat = 5.0
    var currentPoint:CGPoint?
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {  currentPoint =  touches.first?.location(in: self) }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let _nextPoint = touches.first?.location(in: self)
        guard let image = self.imageView.image, let currentPoint = currentPoint, let nextPoint = _nextPoint else {return}
        self.imageView.image    = drawOnImage(startingImage: image, start: currentPoint, end: nextPoint)
        self.currentPoint       = nextPoint
    }
    
    //MARK: GrößenÄnderungen
    var currentSize:CGSize?         { didSet{
        var hue:CGFloat = 0
        var saturation:CGFloat = 0
        var brightness:CGFloat = 0
        var alpha : CGFloat = 0
        orange.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        backgroundColor = UIColor(hue: hue, saturation: saturation, brightness: brightness-0.3, alpha: alpha)
        
        imageView.image = UIImage(color: UIColor(white: 0, alpha: 0.3), size: bounds.size)
        }
    }
    override func layoutSubviews()  {
        super.layoutSubviews()
        if currentSize != bounds.size{
            currentSize = bounds.size
            nachZeichnenLabel.font = UIFont.boldSystemFont(ofSize: (bounds.size.height / 2))
        }
    }
}



func drawOnImage(startingImage: UIImage, start:CGPoint,end:CGPoint) -> UIImage? {

    let brush:CGFloat = 28.0;
    
    // Create a context of the starting image size and set it as the current one
    UIGraphicsBeginImageContext(startingImage.size)
    
    // Draw the starting image in the current context as background
    startingImage.draw(at: CGPoint.zero)
    
    // Get the current context
    let context = UIGraphicsGetCurrentContext()!
    
    // Draw a red line
    context.setLineWidth(brush)
    context.setStrokeColor(UIColor.white.cgColor)
    context.setLineCap(.round)
    context.move(to: start)
    context.addLine(to: end)
    context.strokePath()

    // Save the context as a new UIImage
    let myImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    // Return modified image
    return myImage
}


public extension UIImage {
    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 1.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}
