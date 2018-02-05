//
//  Extensions.swift
//  learnDevanagari2
//
//  Created by Matthias Pochmann on 22.01.18.
//  Copyright © 2018 Matthias Pochmann. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    var contentViewController:UIViewController {
        if let navCon = self as? UINavigationController{ return navCon.visibleViewController ?? navCon
        }else{ return self  }
    }
}

extension NSMutableAttributedString{
    func colorCharacters(in range:NSRange,color:UIColor) -> NSAttributedString{
        addAttribute(NSAttributedStringKey.foregroundColor, value: color, range: range)
        return self
    }
}

extension NSAttributedString{
    func colorChar(in range:NSRange,color:UIColor) -> NSAttributedString{
        let attributed = NSMutableAttributedString(attributedString: self)
        attributed.addAttribute(NSAttributedStringKey.foregroundColor, value: color, range: range)
        return attributed
    }
    var asMutableAttrStrg:NSMutableAttributedString{ return NSMutableAttributedString(attributedString: self) }
}

extension String {
    func ranges(of substring: String) -> [NSRange]{
        let endIndex = self.endIndex
        var ranges = [NSRange]()
        enumerateSubstrings(in: startIndex..<endIndex, options: .byComposedCharacterSequences) {
            (_substring, substringRange, _, _) in
            if substring == _substring {
                ranges.append(NSRange(substringRange, in: self))
            }
        }
        return ranges
    }
    
    static func getRanges(for zeichen:[String]?,attrStrings:[NSAttributedString]) -> [[NSRange]]{
        guard let zeichen = zeichen else {return [[NSRange]]()}
        return attrStrings.map{labelText in zeichen.map { labelText.string.ranges(of: $0)}.flatMap { $0 } }
    }
    
    subscript (i: Int) -> Character { return self[index(startIndex, offsetBy: i)] }
    
    subscript (i: Int) -> String { return String(self[i] as Character) }
    
    subscript (r: Range<Int>) -> String {
        let start = index(startIndex, offsetBy: r.lowerBound)
        let end = index(startIndex, offsetBy: r.upperBound)
        return String(self[Range(start ..< end)])
    }
}

extension Date{ func isGreaterThanDate(dateToCompare:Date) -> Bool { return self.compare(dateToCompare) == .orderedDescending } }

extension UIButton{
    convenience init(title:String?){
        self.init()
        setTitle(title, for: .normal)
    }
}
extension UIImage {
    public convenience init?(size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 1.0)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}
extension UIColor{
    func changeBrightness(dif:CGFloat) -> UIColor{
        var hue:CGFloat = 0
        var saturation:CGFloat = 0
        var brightness:CGFloat = 0
        var alpha : CGFloat = 0
        self.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        return UIColor(hue: hue, saturation: saturation, brightness: brightness+dif, alpha: alpha)
    }
}
extension Array {
    // Randomizes the order of an array's elements
    mutating func shuffle() {
        for _ in 0..<count {
            sort { (_,_) in arc4random() < arc4random() }
        }
    }
    
    func arrayByAppending(o: Element) -> [Element] { return self + [o] }
    
    public init(count: Int, elementCreator: @autoclosure () -> Element) {
        self = (0 ..< count).map { _ in elementCreator() }
    }
}

extension String{
    func newRemoveLast() -> String{
        var start = self
        start.removeLast()
        return start
    }
}

extension UIApplication {
    var visibleViewController: UIViewController? {
        guard let rootViewController = keyWindow?.rootViewController else { return nil }
        return getVisibleViewController(rootViewController)
    }
    private func getVisibleViewController(_ rootViewController: UIViewController) -> UIViewController? {
        if let presentedViewController = rootViewController.presentedViewController { return getVisibleViewController(presentedViewController) }
        if let navigationController = rootViewController as? UINavigationController { return navigationController.visibleViewController }
        if let tabBarController = rootViewController as? UITabBarController         { return tabBarController.selectedViewController  }
        return rootViewController
    }
}

extension UIStackView{
    
    static func horizontalEquallyFilled() -> UIStackView{
        let hStack              = UIStackView()
        hStack.axis             = .horizontal
        hStack.distribution     = .fillEqually
        return hStack
    }
    
    static func verticalFilled() -> UIStackView{
        let stack              = UIStackView()
        stack.axis             = .vertical
        stack.distribution     = .fill
        return stack
    }
    
    func addArrangedSubviewAndReturn<T:UIView> (view:T) -> T{
        addArrangedSubview(view)
        return view
    }
}
extension UILabel{
    func setStyle(for scoreZeichen:ScoreZeichen?){
        self.setStyle(for:scoreZeichen?.gesamtScore ?? 0)
        text          =  (scoreZeichen?.gesamtScore ?? 0) > 0 ? scoreZeichen?.devaString : nil
        textAlignment = .center
    }
}

extension UIView{
    func setStyle(for score:Double){
        let isHidden    = score == 0
        let button      = self as? UIButton
        button?.setTitleColor(isHidden ? .clear : .white, for: .normal)
        button?.titleLabel?.font    = UIFont.systemFont(ofSize: 30)
        self.layer.borderColor      = UIColor.white.cgColor
        self.layer.borderWidth      = isHidden ? 0 : 1
        self.backgroundColor        = berechneFarbe(score: score)
    }
}
