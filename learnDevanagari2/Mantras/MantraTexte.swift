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



//string2[0] = "त"
//    string2[1] = "त्त्व"
//    string2[2] = "म"
//    string2[3] = "सि"

//-(void)initi"वा"alisiereLabels{
//    [self in"य"itAudioplayer]
//
//
//    MyManager *sharedManager = [MyManager sharedManager]
//    //self.hidden=true
//    NSMutableArray *gesamtZeichensatz = [[NSMutableArray alloc]initWithArray:sharedManager.zeichenSatz]
//    [gesamtZeichensatz addObjectsFromArray:sharedManager.ligaturenSatz ]
//
//    self.alleZeichenLabels = [[NSMutableArray alloc]init]
//
//    //Label 0 ॐ नमः शिवाय
//    NSMutableArray *zeichenLabel0 = [[NSMutableArray alloc]init]
//    NSString *string0[9]
//    string0[0] = "ॐ"
//    string0[1] = " "
//    string0[2] = "न"
//    string0[3] = "म"
//    string0[4] = "ः"
//    string0[5] = " "
//    string0[6] = "शि"
//    string0[7] = "वा"
//    string0[8] = "य"
//    for (int i=0i<9i++)
//    {
//        for (int j=0j<[gesamtZeichensatz count]j++)
//        {
//            zeichen *jZeichen = [gesamtZeichensatz objectAtIndex:j]
//            if([string0[i] isEqualToString:jZeichen.zeichenDevanagari]){
//                [zeichenLabel0 addObject:jZeichen]
//            }
//        }
//    }
//    [self.alleZeichenLabels addObject:[[MyOuttroLabel alloc]initMyInit:zeichenLabel0]]
//
//    //frames der labels händisch setzen
//
//
//    //Label 1 अहं ब्राह्मास्मि
//    NSMutableArray *zeichenLabel1 = [[NSMutableArray alloc]init]
//    NSString *string1[9]
//    string1[0] = "अ"
//    string1[1] = "ह"
//    string1[2] = "ं"
//    string1[3] = " "
//    string1[4] = "ब्र"
//    string1[5] = "ह्म"
//    string1[6] = "ा"
//    string1[7] = "स्म"
//    string1[8] = "ि"
//    for (int i=0i<9i++)
//    {
//        for (int j=0j<[gesamtZeichensatz count]j++)
//        {
//            zeichen *jZeichen = [gesamtZeichensatz objectAtIndex:j]
//            if([string1[i] isEqualToString:jZeichen.zeichenDevanagari]){
//                [zeichenLabel1 addObject:jZeichen]
//            }
//        }
//    }
//    [self.alleZeichenLabels addObject:[[MyOuttroLabel alloc]initMyInit:zeichenLabel1]]
//
//
//
//
//    //Label 2 तत्त्वमसि
//    NSMutableArray *zeichenLabel2 = [[NSMutableArray alloc]init]
//    NSString *string2[4]
//    string2[0] = "त"
//    string2[1] = "त्त्व"
//    string2[2] = "म"
//    string2[3] = "सि"
//    for (int i=0i<4i++)
//    {
//        for (int j=0j<[gesamtZeichensatz count]j++)
//        {
//            zeichen *jZeichen = [gesamtZeichensatz objectAtIndex:j]
//            if([string2[i] isEqualToString:jZeichen.zeichenDevanagari]){
//                [zeichenLabel2 addObject:jZeichen]
//            }
//        }
//    }
//    [self.alleZeichenLabels addObject:[[MyOuttroLabel alloc]initMyInit:zeichenLabel2]]
//
//
//    //Label 3 ॐ नमो भगवते वासुदेवाय
//    NSMutableArray *zeichenLabel3 = [[NSMutableArray alloc]init]
//    NSString *string3[15]
//    string3[0] = "ॐ"
//    string3[1] = " "
//    string3[2] = "न"
//    string3[3] = "मो"
//    string3[4] = " "
//    string3[5] = "भ"
//    string3[6] = "ग"
//    string3[7] = "व"
//    string3[8] = "ते"
//    string3[9] = " "
//    string3[10] = "वा"
//    string3[11] = "सु"
//    string3[12] = "दे"
//    string3[13] = "वा"
//    string3[14] = "य"
//    for (int i=0i<15i++)
//    {
//        for (int j=0j<[gesamtZeichensatz count]j++)
//        {
//            zeichen *jZeichen = [gesamtZeichensatz objectAtIndex:j]
//            if([string3[i] isEqualToString:jZeichen.zeichenDevanagari]){
//                [zeichenLabel3 addObject:jZeichen]
//            }
//        }
//    }
//    [self.alleZeichenLabels addObject:[[MyOuttroLabel alloc]initMyInit:zeichenLabel3]]
//
//
//    //Label 4 ॐ नमो नारायणाय
//    NSMutableArray *zeichenLabel4 = [[NSMutableArray alloc]init]
//    NSString *string4[10]
//    string4[0] = "ॐ"
//    string4[1] = " "
//    string4[2] = "न"
//    string4[3] = "मो"
//    string4[4] = " "
//    string4[5] = "ना"
//    string4[6] = "रा"
//    string4[7] = "य"
//    string4[8] = "णा"
//    string4[9] = "य"
//    for (int i=0i<10i++)
//    {
//        for (int j=0j<[gesamtZeichensatz count]j++)
//        {
//            zeichen *jZeichen = [gesamtZeichensatz objectAtIndex:j]
//            if([string4[i] isEqualToString:jZeichen.zeichenDevanagari]){
//                [zeichenLabel4 addObject:jZeichen]
//            }
//        }
//    }
//    [self.alleZeichenLabels addObject:[[MyOuttroLabel alloc]initMyInit:zeichenLabel4]]
//
//
//
//
//    //Label 5 ॐ गं गणपतये नमः
//    NSMutableArray *zeichenLabel5 = [[NSMutableArray alloc]init]
//    NSString *string5[14]
//    string5[0] = "ॐ"
//    string5[1] = " "
//    string5[2] = "ग"
//    string5[3] = "ं"
//    string5[4] = " "
//    string5[5] = "ग"
//    string5[6] = "ण"
//    string5[7] = "प"
//    string5[8] = "त"
//    string5[9] = "ये"
//    string5[10] = " "
//    string5[11] = "न"
//    string5[12] = "म"
//    string5[13] = "ः"
//    for (int i=0i<14i++)
//    {
//        for (int j=0j<[gesamtZeichensatz count]j++)
//        {
//            zeichen *jZeichen = [gesamtZeichensatz objectAtIndex:j]
//            if([string5[i] isEqualToString:jZeichen.zeichenDevanagari]){
//                [zeichenLabel5 addObject:jZeichen]
//            }
//        }
//    }
//    [self.alleZeichenLabels addObject:[[MyOuttroLabel alloc]initMyInit:zeichenLabel5]]
//
//    //Label 5
//
//
//    //Label 6 ॐ ऐं ह्रीं क्लीं चामुण्डायै विच्चे
//    NSMutableArray *zeichenLabel6 = [[NSMutableArray alloc]init]
//    NSString *string6[22]
//    string6[0] = "ॐ"
//    string6[1] = " "
//    string6[2] = "ऐ"
//    string6[3] = "ं"
//    string6[4] = " "
//    string6[5] = "ह्र"
//    string6[6] = "ी"
//    string6[7] = "ं"
//    string6[8] = " "
//    string6[9] = "क्ल"
//    string6[10] = "ी"
//    string6[11] = "ं"
//    string6[12] = " "
//    string6[13] = "चा"
//    string6[14] = "मु"
//    string6[15] = "ण्ड"
//    string6[16] = "ा"
//    string6[17] = "यै"
//    string6[18] = " "
//    string6[19] = "वि"
//    string6[20] = "च्च"
//    string6[21] = "े"
//    for (int i=0i<22i++)
//    {
//        for (int j=0j<[gesamtZeichensatz count]j++)
//        {
//            zeichen *jZeichen = [gesamtZeichensatz objectAtIndex:j]
//            if([string6[i] isEqualToString:jZeichen.zeichenDevanagari]){
//                [zeichenLabel6 addObject:jZeichen]
//            }
//        }
//    }
//    [self.alleZeichenLabels addObject:[[MyOuttroLabel alloc]initMyInit:zeichenLabel6]]
//    //Label 6
//
//    //Label 7 सो ऽहम्
//    NSMutableArray *zeichenLabel7 = [[NSMutableArray alloc]init]
//    NSString *string7[6]
//    string7[0] = "सो"
//    string7[1] = "ऽ"
//    string7[2] = "ह"
//    string7[3] = "म"
//    string7[4] = "्"
//    for (int i=0i<6i++)
//    {
//        for (int j=0j<[gesamtZeichensatz count]j++)
//        {
//            zeichen *jZeichen = [gesamtZeichensatz objectAtIndex:j]
//            if([string7[i] isEqualToString:jZeichen.zeichenDevanagari]){
//                [zeichenLabel7 addObject:jZeichen]
//            }
//        }
//    }
//    [self.alleZeichenLabels addObject:[[MyOuttroLabel alloc]initMyInit:zeichenLabel7]]
//    //Label 7
//
//    //Label 8 ॐ मणिपद्मे हूँ
//    NSMutableArray *zeichenLabel8 = [[NSMutableArray alloc]init]
//    NSString *string8[10]
//    string8[0] = "ॐ"
//    string8[1] = " "
//    string8[2] = "म"
//    string8[3] = "णि"
//    string8[4] = "प"
//    string8[5] = "द्म"
//    string8[6] = "े"
//    string8[7] = " "
//    string8[8] = "हू"
//    string8[9] = "ँ"
//    for (int i=0i<10i++)
//    {
//        for (int j=0j<[gesamtZeichensatz count]j++)
//        {
//            zeichen *jZeichen = [gesamtZeichensatz objectAtIndex:j]
//            if([string8[i] isEqualToString:jZeichen.zeichenDevanagari]){
//                [zeichenLabel8 addObject:jZeichen]
//            }
//        }
//    }
//    [self.alleZeichenLabels addObject:[[MyOuttroLabel alloc]initMyInit:zeichenLabel8]]
//    //Label 8
//
//
//    //Label 9   हरे राम हरे राम राम राम हरे हरे
//    //          हरे कृष्ण हरे कृष्ण कृष्ण कृष्ण हरे हरे
//    NSMutableArray *zeichenLabel9 = [[NSMutableArray alloc]init]
//    NSString *string9[47]
//    string9[0] = "ह"
//    string9[1] = "रे"
//    string9[2] = " "
//    string9[3] = "रा"
//    string9[4] = "म"
//    string9[5] = " "
//    string9[6] = "ह"
//    string9[7] = "रे"
//    string9[8] = " "
//    string9[9] = "रा"
//    string9[10] = "म"
//    string9[11] = " "
//    string9[12] = "रा"
//    string9[13] = "म"
//    string9[14] = " "
//    string9[15] = "रा"
//    string9[16] = "म"
//    string9[17] = " "
//    string9[18] = "ह"
//    string9[19] = "रे"
//    string9[20] = " "
//    string9[21] = "ह"
//    string9[22] = "रे"
//    string9[23] = "\n"
//    string9[24] = "ह"
//    string9[25] = "रे"
//    string9[26] = " "
//    string9[27] = "कृ"
//    string9[28] = "ष्ण"
//    string9[29] = " "
//    string9[30] = "ह"
//    string9[31] = "रे"
//    string9[32] = " "
//    string9[33] = "कृ"
//    string9[34] = "ष्ण"
//    string9[35] = " "
//    string9[36] = "कृ"
//    string9[37] = "ष्ण"
//    string9[38] = " "
//    string9[39] = "कृ"
//    string9[40] = "ष्ण"
//    string9[41] = " "
//    string9[42] = "ह"
//    string9[43] = "रे"
//    string9[44] = " "
//    string9[45] = "ह"
//    string9[46] = "रे"
//    for (int i=0i<47i++)
//    {
//        for (int j=0j<[gesamtZeichensatz count]j++)
//        {
//            zeichen *jZeichen = [gesamtZeichensatz objectAtIndex:j]
//            if([string9[i] isEqualToString:jZeichen.zeichenDevanagari]){
//                [zeichenLabel9 addObject:jZeichen]
//            }
//        }
//    }
//    [self.alleZeichenLabels addObject:[[MyOuttroLabel alloc]initMyInit:zeichenLabel9]]
//    //Label 9
//
//
//    //Label 10      त्रयम्बकं यजामहे सुगन्धिं पुष्टिवर्धनम् |
//    //              उर्वारुकमिव बन्धनान्मृत्योर्मुक्षीय मामृतात् ||
//    NSMutableArray *zeichenLabel10 = [[NSMutableArray alloc]init]
//    NSString *string10[54]
//    string10[0] = "त्र"
//    string10[1] = "य"
//    string10[2] = "म्ब"
//    string10[3] = "क"
//    string10[4] = "ं"
//    string10[5] = " "
//    string10[6] = "य"
//    string10[7] = "जा"
//    string10[8] = "म"
//    string10[9] = "हे"
//    string10[10] = " "
//    string10[11] = "सु"
//    string10[12] = "ग"
//    string10[13] = "न्ध"
//    string10[14] = "ि"
//    string10[15] = "ं"
//    string10[16] = " "
//    string10[17] = "पु"
//    string10[18] = "ष्ट"
//    string10[19] = "ि"
//    string10[20] = "व"
//    string10[21] = "र्ध"
//    string10[22] = "न"
//    string10[23] = "म"
//    string10[24] = "्"
//    string10[25] = "\n"
//    string10[26] = "उ"
//    string10[27] = "र्व"
//    string10[28] = "ा"
//    string10[29] = "रु"
//    string10[30] = "क"
//    string10[31] = "मि"
//    string10[32] = "व"
//    string10[33] = " "
//    string10[34] = "ब"
//    string10[35] = "न्ध"
//    string10[36] = "ना"
//    string10[37] = "न"
//    string10[38] = "्"
//    string10[39] = " "
//    string10[40] = "मृ"
//    string10[41] = "त्य"
//    string10[42] = "ो"
//    string10[43] = "र्म"
//    string10[44] = "ु"
//    string10[45] = "क्ष"
//    string10[46] = "ी"
//    string10[47] = "य"
//    string10[48] = " "
//    string10[49] = "मा"
//    string10[50] = "मृ"
//    string10[51] = "ता"
//    string10[52] = "त"
//    string10[53] = "्"
//    for (int i=0i<54i++)
//    {
//        for (int j=0j<[gesamtZeichensatz count]j++)
//        {
//            zeichen *jZeichen = [gesamtZeichensatz objectAtIndex:j]
//            if([string10[i] isEqualToString:jZeichen.zeichenDevanagari]){
//                [zeichenLabel10 addObject:jZeichen]
//            }
//        }
//    }
//    [self.alleZeichenLabels addObject:[[MyOuttroLabel alloc]initMyInit:zeichenLabel10]]
//    //Label 10
//
//    //Label 11      राम रमेति रमेति रमो
//    //              रामेति मनोरमे
//    //              सहस्त्र नाम तातुल्यम
//    //              राम नाम वरानने
//    NSMutableArray *zeichenLabel11 = [[NSMutableArray alloc]init]
//    NSString *string11[45]
//    string11[0] = "रा"
//    string11[1] = "म"
//    string11[2] = " "
//    string11[3] = "र"
//    string11[4] = "मे"
//    string11[5] = "ति"
//    string11[6] = " "
//    string11[7] = "र"
//    string11[8] = "मे"
//    string11[9] = "ति"
//    string11[10] = " "
//    string11[11] = "र"
//    string11[12] = "मो"
//    string11[13] = "\n"
//    string11[14] = "रा"
//    string11[15] = "मे"
//    string11[16] = "ति"
//    string11[17] = " "
//    string11[18] = "म"
//    string11[19] = "नो"
//    string11[20] = "र"
//    string11[21] = "मे"
//    string11[22] = "\n"
//    string11[23] = "स"
//    string11[24] = "ह"
//    string11[25] = "स्त्र"
//    string11[26] = " "
//    string11[27] = "ना"
//    string11[28] = "म"
//    string11[29] = " "
//    string11[30] = "ता"
//    string11[31] = "तु"
//    string11[32] = "ल्य"
//    string11[33] = "म"
//    string11[34] = "\n"
//    string11[35] = "रा"
//    string11[36] = "म"
//    string11[37] = " "
//    string11[38] = "ना"
//    string11[39] = "म"
//    string11[40] = " "
//    string11[41] = "व"
//    string11[42] = "रा"
//    string11[43] = "न"
//    string11[44] = "ने"
//    for (int i=0i<45i++)
//    {
//        for (int j=0j<[gesamtZeichensatz count]j++)
//        {
//            zeichen *jZeichen = [gesamtZeichensatz objectAtIndex:j]
//            if([string11[i] isEqualToString:jZeichen.zeichenDevanagari]){
//                [zeichenLabel11 addObject:jZeichen]
//            }
//        }
//    }
//    [self.alleZeichenLabels addObject:[[MyOuttroLabel alloc]initMyInit:zeichenLabel11]]
//    //Label 11
//
//    //Label 12      ॐ भूर्भुवः स्वः ।
//    //              तत्सवितुर्वरेण्यं ।
//    //              भर्गो देवस्य धीमहि ।
//    //              धियो यो नः प्रचोदयात् ॥
//    NSMutableArray *zeichenLabel12 = [[NSMutableArray alloc]init]
//    NSString *string12[46]
//    string12[0] = "ॐ"
//    string12[1] = " "
//    string12[2] = "भू"
//    string12[3] = "र्भ"
//    string12[4] = "ु"
//    string12[5] = "व"
//    string12[6] = "ः"
//    string12[7] = " "
//    string12[8] = "स्व"
//    string12[9] = "ः"
//    string12[10] = "\n"
//    string12[11] = "त"
//    string12[12] = "त्स"
//    string12[13] = "वि"
//    string12[14] = "तु"
//    string12[15] = "र्व"
//    string12[16] = "रे"
//    string12[17] = "ण्य"
//    string12[18] = "ं"
//    string12[19] = "\n"
//    string12[20] = "भ"
//    string12[21] = "र्ग"
//    string12[22] = "ो"
//    string12[23] = " "
//    string12[24] = "दे"
//    string12[25] = "व"
//    string12[26] = "स्य"
//    string12[27] = " "
//    string12[28] = "धी"
//    string12[29] = "म"
//    string12[30] = "हि"
//    string12[31] = "\n"
//    string12[32] = "धि"
//    string12[33] = "यो"
//    string12[34] = " "
//    string12[35] = "यो"
//    string12[36] = " "
//    string12[37] = "न"
//    string12[38] = "ः"
//    string12[39] = " "
//    string12[40] = "प्र"
//    string12[41] = "चो"
//    string12[42] = "द"
//    string12[43] = "या"
//    string12[44] = "त"
//    string12[45] = "्"
//    for (int i=0i<46i++)
//    {
//        for (int j=0j<[gesamtZeichensatz count]j++)
//        {
//            zeichen *jZeichen = [gesamtZeichensatz objectAtIndex:j]
//            if([string12[i] isEqualToString:jZeichen.zeichenDevanagari]){
//                [zeichenLabel12 addObject:jZeichen]
//            }
//        }
//    }
//    [self.alleZeichenLabels addObject:[[MyOuttroLabel alloc]initMyInit:zeichenLabel12]]
//    //Label 12
//
//
//    //Label 13      बीज
//    NSMutableArray *zeichenLabel13 = [[NSMutableArray alloc]init]
//    NSString *string13[16]
//    string13[0] = "ॐ"
//    string13[1] = "\n"
//    string13[2] = "ह"
//    string13[3] = "ं"
//    string13[4] = "\n"
//    string13[5] = "य"
//    string13[6] = "ं"
//    string13[7] = "\n"
//    string13[8] = "र"
//    string13[9] = "ं"
//    string13[10] = "\n"
//    string13[11] = "व"
//    string13[12] = "ं"
//    string13[13] = "\n"
//    string13[14] = "ल"
//    string13[15] = "ं"
//    for (int i=0i<16i++)
//    {
//        for (int j=0j<[gesamtZeichensatz count]j++)
//        {
//            zeichen *jZeichen = [gesamtZeichensatz objectAtIndex:j]
//            if([string13[i] isEqualToString:jZeichen.zeichenDevanagari]){
//                [zeichenLabel13 addObject:jZeichen]
//            }
//        }
//    }
//    [self.alleZeichenLabels addObject:[[MyOuttroLabel alloc]initMyInit:zeichenLabel13]]
//    //Label 13
//
//    //Label 14      चक्र
//    NSMutableArray *zeichenLabel14 = [[NSMutableArray alloc]init]
//    NSString *string14[36]
//    string14[0] = "स"
//    string14[1] = "ह"
//    string14[2] = "स्र"
//    string14[3] = "ा"
//    string14[4] = "र"
//    string14[5] = "\n"
//    string14[6] = "आ"
//    string14[7] = "ज्ञ"
//    string14[8] = "ा"
//    string14[9] = "\n"
//    string14[10] = "वि"
//    string14[11] = "शु"
//    string14[12] = "द्ध"
//    string14[13] = "\n"
//    string14[14] = "अ"
//    string14[15] = "ना"
//    string14[16] = "ह"
//    string14[17] = "त"
//    string14[18] = "\n"
//    string14[19] = "म"
//    string14[20] = "नि"
//    string14[21] = "पू"
//    string14[22] = "र"
//    string14[23] = "\n"
//    string14[24] = "स्व"
//    string14[25] = "ा"
//    string14[26] = "धि"
//    string14[27] = "ष्ठ"
//    string14[28] = "ा"
//    string14[29] = "न"
//    string14[30] = "\n"
//    string14[31] = "मू"
//    string14[32] = "ला"
//    string14[33] = "धा"
//    string14[34] = "र"

