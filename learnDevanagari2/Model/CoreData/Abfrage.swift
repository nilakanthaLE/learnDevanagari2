//
//  Abfrage.swift
//  learnDevanagari2
//
//  Created by Matthias Pochmann on 30.11.17.
//  Copyright © 2017 Matthias Pochmann. All rights reserved.
//
import Foundation
import CoreData


extension Abfrage{
    class func new(correct:Bool) -> Abfrage?{
        let abfrage =  NSEntityDescription.insertNewObject(forEntityName: "Abfrage", into: managedContext) as? Abfrage
        abfrage?.correct    = correct
        abfrage?.date       = Date()
        return abfrage
    }
}
