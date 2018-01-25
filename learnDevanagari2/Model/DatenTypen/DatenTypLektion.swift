//
//  DatenTypenLektion.swift
//  learnDevanagari2
//
//  Created by Matthias Pochmann on 16.11.17.
//  Copyright © 2017 Matthias Pochmann. All rights reserved.
//

import Foundation

class Lektion:Hashable{
    var quizSetting:QuizSetting?
    var title:String?
    var nummer:Int?
    
    //MARK: Protocol Hashable
    var hashValue: Int{ return (title ?? "").hashValue + (nummer ?? 0).hashValue }
    static func ==(lhs: Lektion, rhs: Lektion) -> Bool { return lhs.hashValue == rhs.hashValue }
    
    
    //MARK: calc Properties (Zeichensätze)
    var zeichenSatzBisAktuell:[Zeichen]                             { return Singleton.sharedInstance.zeichenSatz.filter{$0.lektion ?? 1000 <= nummer ?? -1} }
    static func zeichenSatz(fuer lektionen:[Lektion]) -> [Zeichen]  { return Singleton.sharedInstance.zeichenSatz.filter{lektionen.map{$0.nummer ?? 1000}.contains($0.lektion ?? -1000)} }
    
    //MARK: init
    init(setting:QuizSetting?,title:String?,nummer:Int?) {
        self.quizSetting    = setting
        self.title          = title
        self.nummer         = nummer
    }
    
    //MARK: helper
    static func getTitle(lektionsNummer:Int) -> String?{ return Singleton.sharedInstance.lektionen[lektionsNummer].title }
}

