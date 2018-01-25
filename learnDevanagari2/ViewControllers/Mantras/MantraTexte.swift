//
//  MantraTexte.swift
//  learnDevanagari2
//
//  Created by Matthias Pochmann on 04.12.17.
//  Copyright © 2017 Matthias Pochmann. All rights reserved.
//

import Foundation
import UIKit



extension NSAttributedString{
    func colorChar(in range:NSRange,color:UIColor) -> NSAttributedString{
        let attributed = NSMutableAttributedString(attributedString: self)
        attributed.addAttribute(NSAttributedStringKey.foregroundColor, value: color, range: range)
        return attributed
    }

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
    
    
    subscript (i: Int) -> Character { return self[index(startIndex, offsetBy: i)] }
    
    subscript (i: Int) -> String { return String(self[i] as Character) }
    
    subscript (r: Range<Int>) -> String {
        let start = index(startIndex, offsetBy: r.lowerBound)
        let end = index(startIndex, offsetBy: r.upperBound)
        return String(self[Range(start ..< end)])
    }
}

var vokalZeichen:[String]{
    return ["ा","ी","े","ि","ो","ु","ू","ै","ौ","ृ","ॄ"]
}


let mantra0 = "ॐ नमः शिवाय"
let mantra1 = "अहं ब्राह्मास्मि"
let mantra2 = "तत्त्वमसि"
let mantra3 = "तत्त्वमसि"
let mantra4 = "ॐ नमो भगवते वासुदेवाय"
let mantra5 = "ॐ नमो नारायणाय"
let mantra6 = "ॐ गं गणपतये नमः"
let mantra7 = "ॐ ऐं ह्रीं क्लीं चामुण्डायै विच्चे"
let mantra8 = "सो ऽहम्"
let mantra9 = "ॐ मणिपद्मे हूँ"
let mantra10 = "हरे राम हरे राम राम राम हरे हरे\nहरे कृष्ण हरे कृष्ण कृष्ण कृष्ण हरे हरे"
let mantra11 = "त्रयम्बकं यजामहे सुगन्धिं पुष्टिवर्धनम्\nउर्वारुकमिव बन्धनान्मृत्योर्मुक्षीय मामृतात्"
let mantra12 = "राम रमेति रमेति रमो\nरामेति मनोरमे\nसहस्त्र नाम तातुल्यम\nराम नाम वरानने"
let mantra13 = "ॐ भूर्भुवः स्वः\nतत्सवितुर्वरेण्यं\nभर्गो देवस्य धीमहि\nधियो यो नः प्रचोदयात्"
let mantra14 = "ॐ\nहं\nयं\nरं\nवं\nलं"
let mantra15 = "सहस्रार\nआज्ञा\nविशुद्ध\nअनाहत\nमनिपूर\nस्वाधिष्ठान\nमूलाधार"





