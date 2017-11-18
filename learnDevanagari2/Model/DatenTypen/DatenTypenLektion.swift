//
//  DatenTypenLektion.swift
//  learnDevanagari2
//
//  Created by Matthias Pochmann on 16.11.17.
//  Copyright © 2017 Matthias Pochmann. All rights reserved.
//

import Foundation

class Lektion{
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

