//
//  SharedManager.swift
//  learnDevanagari2
//
//  Created by Matthias Pochmann on 22.01.18.
//  Copyright © 2018 Matthias Pochmann. All rights reserved.
//

import Foundation
class Singleton {
    // Can't init is singleton
    private init() { }
    static let sharedInstance   = Singleton()
    let zeichenSatz             = erstelleZeichensatz()
    let lektionen               = erstelleLektionen()
}
