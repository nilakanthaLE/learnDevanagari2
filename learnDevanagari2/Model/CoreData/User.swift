//
//  User.swift
//  learnDevanagari2
//
//  Created by Matthias Pochmann on 08.12.17.
//  Copyright © 2017 Matthias Pochmann. All rights reserved.
//

import Foundation
import CoreData

extension User{
    class func neu() -> User?{
        let user = NSEntityDescription.insertNewObject(forEntityName: "User", into: managedContext) as? User
        for zeichen in erstelleZeichensatz(){
            if let scoreZeichen = ScoreZeichen.getOrCreate(devaString: zeichen.devanagari){
                user?.addToScoreZeichen(scoreZeichen)
            }
        }
        user?.lektionsQuizSettings = QuizSetting().asDict as NSObject
        try? managedContext.save()
        return user
    }
    static func getAll() -> [User]{
        let request = NSFetchRequest<User>.init(entityName: "User")
        return (try? managedContext.fetch(request)) ?? [User]()
    }
    func delete(){
        managedObjectContext?.delete(self)
        try? managedContext.save()
    }
}



extension MainSettings{
    class func get() -> MainSettings?{
        let request = NSFetchRequest<MainSettings>.init(entityName: "MainSettings")
        if let settings = (try? managedContext.fetch(request))?.first   { return settings }
        return NSEntityDescription.insertNewObject(forEntityName: "MainSettings", into: managedContext) as? MainSettings
    }
}