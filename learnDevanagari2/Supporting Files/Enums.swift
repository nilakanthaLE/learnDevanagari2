//
//  Enums.swift
//  learnDevanagari2
//
//  Created by Matthias Pochmann on 22.01.18.
//  Copyright © 2018 Matthias Pochmann. All rights reserved.
//

import Foundation
import UIKit

//MARK: enums
enum AbfrageStufe               {case einfach,medium,voll}
enum SettingModus               { case InAbfrage, Anzeige}
enum IPadOrientation            { case portrait, landscape }
enum SelectedSetting            { case Lektion, FreiesUeben}
enum VokalOderKonsonant:String  { case Vokal        = "Vokal", Konsonant  = "Konsonant" }
enum VokalOderHalbvokal:String  { case Vokal        = "einf. Vokal", Halbvokal  = "Halbvokal" }
enum KonsonantTyp:String        { case Nasal        = "Nasal",Sibilant = "Sibilant",Hauchlaut = "Hauchlaut",EinfacherKonsonant = "einf. Konsonant" }
enum Aspiration:String          { case Aspiriert    = "aspiriert", NichtAspiriert = "n. aspiriert" }
enum Stimmhaftigkeit:String     { case Stimmhaft    = "stimmhaft", NichtStimmhaft = "n. stimmhaft" }
enum ZeichenAuswahlTyp:Int      { case Zufall = 0, SeltenGeuebt = 1,HauefigFalsch = 2 }
enum PruefenButtonZustand:String{ case Pruefen = "Eingabe prüfen", NaechstesZeichen   = "nächstes Zeichen", QuizBeenden = "Quiz beenden" }
enum ControlCurrentModus        { case Abfrage, Anzeige, ShowsPruefergebnis, Versteckt }
enum QuizZeichenStatus:Int      {
    case Ungesichtet = 1 , Correct = 0, FalschBeantwortet = 2, InUserAbfrage = 3
    func moveToIndex(anzahlElemente:Int) -> Int?{
        switch self{
        case .Correct:              return 0
        case .FalschBeantwortet:    return anzahlElemente - 1
        default:                    return nil
        }
    }
    var colorFortschrittsbalken : UIColor {
        switch self {
        case .Correct:              return .green
        case .FalschBeantwortet:    return UIColor.init(red: 1, green: 0, blue: 0, alpha: 0.5)
        case .Ungesichtet:          return UIColor(white: 1, alpha: 0.2)
        case .InUserAbfrage:        return UIColor(white: 0.5, alpha: 0.2)
        }
    }
}
enum Artikulation:String {
    case velar        = "velar", palatal = "palatal",retroflex = "retroflex" ,dental = "dental",labial = "labial"
    var nasalUmschrift:String?{
        switch self {
        case .velar:    return "ṅ"
        case .palatal:  return "ñ"
        case .retroflex:return "ṇ"
        case .dental:   return "n"
        case .labial:   return "m"
        }
    }
    static func cases() -> [Artikulation]{ return [.velar,.palatal,.retroflex,.dental,.labial] }
}
enum ZeichenfeldModus{
    case NurAnzeige, Nachzeichnen, InAbfrage , AbfrageUndNachzeichnen
    var string:String{
        switch self{
        case .NurAnzeige: return "NurAnzeige"
        case .Nachzeichnen: return "Nachzeichnen"
        case .InAbfrage: return "InAbfrage"
        case .AbfrageUndNachzeichnen: return "AbfrageUndNachzeichnen"
        }
    }
    static func get(for string:String?)->ZeichenfeldModus{
        guard let string = string else {return .NurAnzeige}
        switch string {
        case "NurAnzeige": return .NurAnzeige
        case "Nachzeichnen": return .Nachzeichnen
        case "InAbfrage": return .InAbfrage
        case "AbfrageUndNachzeichnen": return .AbfrageUndNachzeichnen
        default: return .NurAnzeige }
    }
}
enum PanelControlModus{
    case Versteckt, NurAnzeige, InAbfrage
    var string:String{
        switch self {
        case .InAbfrage:return "InAbfrage"
        case .Versteckt:return  "Versteckt"
        case .NurAnzeige:return "NurAnzeige"
        }
    }
    static func get(for string:String?)->PanelControlModus{
        guard let string = string else {return .Versteckt}
        switch string {
        case "InAbfrage": return .InAbfrage
        case "Versteckt": return .Versteckt
        case "NurAnzeige": return .NurAnzeige
        default: return .Versteckt }
    }
    var asControlCurrentModus:ControlCurrentModus{
        switch self{
        case .InAbfrage     :  return .Abfrage
        case .NurAnzeige    :  return .Anzeige
        case .Versteckt     :  return .Versteckt
        }
    }
}
enum KonsonantTypModus:Int{
    case Nasal,Sibilant,Hauchlaut
    var titleArray:[[String]]{
        switch self {
        case .Nasal:        return [[KonsonantTyp.EinfacherKonsonant.rawValue,KonsonantTyp.Nasal.rawValue]]
        case .Sibilant:     return [[KonsonantTyp.EinfacherKonsonant.rawValue,KonsonantTyp.Nasal.rawValue],[KonsonantTyp.Sibilant.rawValue]]
        case.Hauchlaut:     return [[KonsonantTyp.EinfacherKonsonant.rawValue,KonsonantTyp.Nasal.rawValue],[KonsonantTyp.Sibilant.rawValue,KonsonantTyp.Hauchlaut.rawValue]]
        }
    }
    var string:String?{
        switch self {
        case .Nasal:        return "Nasale"
        case .Sibilant:     return "NasaleSibilanten"
        case .Hauchlaut:    return "NasaleSibilantenHauchlaut"
        }
    }
    var controlName:String?{
        switch self {
        case .Nasal:        return "Nasale"
        case .Sibilant:     return "Nasale und Sibilanten"
        case .Hauchlaut:    return "Nasale, Sibilanten und Hauchlaut"
        }
    }
    static func get(for string:String?)->KonsonantTypModus{
        guard let string = string else {return .Nasal}
        switch string {
        case "Nasale": return .Nasal
        case "NasaleSibilanten": return .Sibilant
        case "NasaleSibilantenHauchlaut": return .Hauchlaut
        default: return .Nasal }
    }
}
enum ControlTyp:Int{
    case ZeichenfeldTyp = 0, TextfeldTyp = 1, VokalOderKonsonantTyp = 2, VokalOderHalbvokalTyp = 3, ArtikulationTyp = 4, KonsonantTyp = 5, AspirationTyp = 6, StimmhaftigkeitTyp = 7
    
    static func getBy(name:String)  -> ControlTyp{
        switch name {
        case "Vokal oder Konsonant":    return .VokalOderKonsonantTyp
        case "Vokal oder Halbvokal":    return .VokalOderHalbvokalTyp
        case "KonsonantTyp":            return .KonsonantTyp
        case "Textfeld":                return .TextfeldTyp
        case "Artikulation":            return .ArtikulationTyp
        case "Aspiration":              return .AspirationTyp
        case "Stimmhaftigkeit":         return .StimmhaftigkeitTyp
        case "Zeichenfeld":             return .ZeichenfeldTyp
        default: return .TextfeldTyp
        }
    }
    
    var controlName:String?{
        switch self {
        case .VokalOderKonsonantTyp:   return "Vokal oder Konsonant"
        case .VokalOderHalbvokalTyp:   return "Vokal oder Halbvokal"
        case .KonsonantTyp:            return "KonsonantTyp"
        case .TextfeldTyp:             return "Textfeld"
        case .ArtikulationTyp:         return "Artikulation"
        case .AspirationTyp:           return "Aspiration"
        case .StimmhaftigkeitTyp:      return "Stimmhaftigkeit"
        case .ZeichenfeldTyp:          return "Zeichenfeld"
        }
    }
    static var alleTypen:[ControlTyp]{
        return [ .VokalOderKonsonantTyp, .VokalOderHalbvokalTyp, .KonsonantTyp, .TextfeldTyp, .ArtikulationTyp, .AspirationTyp, .StimmhaftigkeitTyp, .ZeichenfeldTyp ]
    }
    var titleArray:[[String]]?{
        switch self {
        case .VokalOderKonsonantTyp:   return [[VokalOderKonsonant.Vokal.rawValue,VokalOderKonsonant.Konsonant.rawValue]]
        case .VokalOderHalbvokalTyp:   return [[VokalOderHalbvokal.Vokal.rawValue,VokalOderHalbvokal.Halbvokal.rawValue]]
        case .AspirationTyp :          return [[Aspiration.Aspiriert.rawValue, Aspiration.NichtAspiriert.rawValue]]
        case .StimmhaftigkeitTyp:      return [[Stimmhaftigkeit.Stimmhaft.rawValue, Stimmhaftigkeit.NichtStimmhaft.rawValue]]
        default: return nil
        }
    }
    func placeInArray(for orientation:IPadOrientation) -> (column:Int,row:Int)?{
        switch orientation {
        case .landscape:
            switch self {
            case .VokalOderKonsonantTyp:    return (0,rawValue)
            case .VokalOderHalbvokalTyp:    return (0,rawValue)
            case .KonsonantTyp:             return (0,rawValue)
            case .TextfeldTyp:              return (0,rawValue)
            case .ArtikulationTyp:          return (0,rawValue)
            case .AspirationTyp:            return (0,rawValue)
            case .StimmhaftigkeitTyp:       return (0,rawValue)
            default: return nil
            }
        case .portrait:
            switch self {
            case .VokalOderKonsonantTyp:   return (0,0)
            case .VokalOderHalbvokalTyp:   return (0,1)
            case .KonsonantTyp:         return (0,1)
            case .TextfeldTyp:             return (1,0)
            case .ArtikulationTyp:         return (1,1)
            case .AspirationTyp:           return (2,0)
            case .StimmhaftigkeitTyp:      return (2,1)
            default: return nil
            }
        }
    }
}
enum AbfrageTyp{
    case nachzeichnen,umschrift,vokalOderKonsonant,artikulation,devaSchreiben,konsonantenTyp,aspiration,stimmhaftigkeit,vokalOderHalbVokal
    
    var controlTyp:ControlTyp{
        switch self {
        case .nachzeichnen:         return .ZeichenfeldTyp
        case .umschrift:            return .TextfeldTyp
        case .vokalOderKonsonant:   return .VokalOderKonsonantTyp
        case .artikulation:         return .ArtikulationTyp
        case .devaSchreiben:        return .ZeichenfeldTyp
        case .konsonantenTyp:       return .KonsonantTyp
        case .aspiration:           return .AspirationTyp
        case .stimmhaftigkeit:      return .StimmhaftigkeitTyp
        case .vokalOderHalbVokal:   return .VokalOderHalbvokalTyp
        }
    }
    func isEnabled(for bekannteControls:Set<ControlTyp>) -> Bool{
        guard self != .nachzeichnen else { return true}
        return bekannteControls.contains(self.controlTyp)
    }
}
