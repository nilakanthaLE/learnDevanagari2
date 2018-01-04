//
//  DatenTypenLektion.swift
//  learnDevanagari2
//
//  Created by Matthias Pochmann on 16.11.17.
//  Copyright © 2017 Matthias Pochmann. All rights reserved.
//

import Foundation

class Lektion:Hashable{
    var hashValue: Int{
        return (title ?? "").hashValue + (nummer ?? 0).hashValue
    }
    
    static func ==(lhs: Lektion, rhs: Lektion) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    var zeichenSatzBisAktuell:[Zeichen]{ return erstelleZeichensatz().filter{$0.lektion ?? 1000 <= nummer ?? -1} }
    static func zeichenSatz(fuer lektionen:[Lektion]) -> [Zeichen]{ return erstelleZeichensatz().filter{lektionen.map{$0.nummer ?? 1000}.contains($0.lektion ?? -1000)} }
    
    var quizSetting:QuizSetting?
    var title:String?
    var nummer:Int?
    init(setting:QuizSetting,title:String,nummer:Int) {
        self.quizSetting    = setting
        self.title          = title
        self.nummer         = nummer
    }
    init() {
        self.quizSetting    = nil
        self.title          = nil
        self.nummer         = nil
    }
}

