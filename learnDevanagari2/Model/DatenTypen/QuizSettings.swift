//
//  QuizSettings.swift
//  learnDevanagari2
//
//  Created by Matthias Pochmann on 17.11.17.
//  Copyright © 2017 Matthias Pochmann. All rights reserved.
//

import Foundation

extension Array { func arrayByAppending(o: Element) -> [Element] { return self + [o] } }
extension Array {
    public init(count: Int, elementCreator: @autoclosure () -> Element) {
        self = (0 ..< count).map { _ in elementCreator() }
    }
}

struct QuizSetting:Equatable{
    static func ==(lhs: QuizSetting, rhs: QuizSetting) -> Bool {
        return lhs.dynamisiert == rhs.dynamisiert &&
        lhs.zeichenfeld == rhs.zeichenfeld &&
        lhs.textfeld == rhs.textfeld &&
        lhs.vokalOderKonsonant == rhs.vokalOderKonsonant &&
        lhs.vokalOderHalbvokal == rhs.vokalOderHalbvokal &&
        lhs.artikulation == rhs.artikulation &&
        lhs.konsonantTyp == rhs.konsonantTyp &&
        lhs.aspiration == rhs.aspiration &&
        lhs.stimmhaftigkeit == rhs.stimmhaftigkeit
    }
    
    
    
    var dynamisiert: Bool
    var zeichenfeld:ZeichenfeldModus
    var textfeld:PanelControlSetting
    var vokalOderKonsonant:PanelControlSetting
    var vokalOderHalbvokal:PanelControlSetting
    var artikulation:PanelControlSetting
    var konsonantTyp:PanelControlSetting
    var aspiration:PanelControlSetting
    var stimmhaftigkeit:PanelControlSetting
    var allePanelControls:[PanelControlSetting] { return [textfeld,vokalOderKonsonant,vokalOderHalbvokal,artikulation,konsonantTyp,aspiration,stimmhaftigkeit] }
    
    //helper
    //lektionsQuizSetting.filterNotIn(quizSetting:MainSetting)
    func filterNotIn(quizSetting:QuizSetting) -> QuizSetting{
        var ergebnis = QuizSetting()
        let filteredAbfragen    = Set(quizSetting.abfragen).intersection(Set(abfragen))
        let filteredAnzeigen    = (Set(quizSetting.anzeigen).union(Set(quizSetting.abfragen))).intersection(Set(anzeigen))
        let anzeigenUndAbfragen = filteredAbfragen.union(filteredAnzeigen)
        
        
        
        let versteckteControls  = Set(allePanelControls.map{$0.controlTyp}).filter{ !anzeigenUndAbfragen.contains($0)}
        for control in versteckteControls{
            ergebnis.getPanelControlSetting(for: control)?.modus = .Versteckt
        }
        for control in filteredAnzeigen{
            ergebnis.getPanelControlSetting(for: control)?.modus  = .NurAnzeige
        }
        for control in filteredAbfragen{
            ergebnis.getPanelControlSetting(for: control)?.modus = .InAbfrage
        }
        //in MainSetting steht Nachzeichnen
        //--> Lektion: NurAnzeige : NurAnzeige
        //--> Lektion: Nachzeichnen: Nachzeichnen
        //--> Lektion: etwas anderes: Nachzeichnen
        
        //in MainSetting steht Abfrage
        //--> Lektion: NurAnzeige : NurAnzeige
        //--> Lektion: Nachzeichnen: NurAnzeige
        //--> Lektion: Abfrage: Abfrage
        //--> Lektion: AbfrageUndNachzeichnen: Abfrage
        
        //in MainSetting steht AbfrageUndNachzeichnen
        //--> Lektion: NurAnzeige : NurAnzeige
        //--> Lektion: Nachzeichnen: Nachzeichnen
        //--> Lektion: Abfrage: Abfrage
        //--> Lektion: AbfrageUndNachzeichnen: AbfrageUndNachzeichnen
        switch quizSetting.zeichenfeld{
        case .NurAnzeige:   ergebnis.zeichenfeld = .NurAnzeige
        case .Nachzeichnen: ergebnis.zeichenfeld = zeichenfeld == .NurAnzeige ? .NurAnzeige : .Nachzeichnen
        case .InAbfrage:    ergebnis.zeichenfeld = zeichenfeld == .InAbfrage || quizSetting.zeichenfeld == .AbfrageUndNachzeichnen ?  .InAbfrage : .NurAnzeige
        case .AbfrageUndNachzeichnen: ergebnis.zeichenfeld = zeichenfeld
        }
        return ergebnis
    }
    var anzeigen:[ControlTyp]{
        return allePanelControls.filter{$0.modus == .NurAnzeige}.map{$0.controlTyp} 
    }
    var abfragen:[ControlTyp]{
        let zeichenfeldAbfrage      = (zeichenfeld == .InAbfrage || zeichenfeld == .AbfrageUndNachzeichnen) ? [ControlTyp.ZeichenfeldTyp] : [ControlTyp]()
        return allePanelControls.filter{$0.modus == .InAbfrage}.map{$0.controlTyp} + zeichenfeldAbfrage
    }
    var anzahlAbfragen:Int{
        let anzahlZeichenFeldAbfragen = zeichenfeld == .InAbfrage || zeichenfeld == .AbfrageUndNachzeichnen ? 1 : 0
        return allePanelControls.filter{$0.modus == .InAbfrage}.count + anzahlZeichenFeldAbfragen
    }
    
    var isNachZeichnen:Bool{
        return abfragen.count == 0
    }
    var isStufe3:Bool{
        return abfragen.count == allePanelControls.count + 1
    }
    
    func getPanelControlSetting(for controlTyp:ControlTyp?) -> PanelControlSetting?{
        guard let controlTyp = controlTyp else {return nil}
        switch controlTyp {
        case .ArtikulationTyp: return artikulation
        case .AspirationTyp: return aspiration
        case .KonsonantTyp: return konsonantTyp
        case .StimmhaftigkeitTyp: return stimmhaftigkeit
        case .TextfeldTyp: return textfeld
        case .VokalOderHalbvokalTyp: return vokalOderHalbvokal
        case .VokalOderKonsonantTyp: return vokalOderKonsonant
        case .ZeichenfeldTyp: return nil
        }
    }
    func panelControls(for panelControlModus:PanelControlModus) -> [PanelControlSetting]{
        return allePanelControls.reduce([PanelControlSetting]()) { (result, setting) -> [PanelControlSetting] in
            return setting.modus == panelControlModus ? result.arrayByAppending(o: setting) :  result
        }
    }
    mutating func setPanelControlsToNurAnzeige(){
        func setNurAnzeigeOderVersteckt( controlSetting: inout PanelControlSetting){
            controlSetting.modus = controlSetting.modus == .Versteckt ? .Versteckt : .NurAnzeige
        }
        setNurAnzeigeOderVersteckt(controlSetting: &self.textfeld)
        setNurAnzeigeOderVersteckt(controlSetting: &self.vokalOderKonsonant)
        setNurAnzeigeOderVersteckt(controlSetting: &self.vokalOderHalbvokal)
        setNurAnzeigeOderVersteckt(controlSetting: &self.artikulation)
        setNurAnzeigeOderVersteckt(controlSetting: &self.konsonantTyp)
        setNurAnzeigeOderVersteckt(controlSetting: &self.aspiration)
        setNurAnzeigeOderVersteckt(controlSetting: &self.stimmhaftigkeit)
    }
    
    
    //inits
    init(){
        self.dynamisiert                                = false
        self.zeichenfeld                                = .NurAnzeige
        self.textfeld                                   = PanelControlSetting(controlTyp: .TextfeldTyp, modus: .NurAnzeige, konsonantTypModus: nil)
        self.vokalOderKonsonant                         = PanelControlSetting(controlTyp: .VokalOderKonsonantTyp, modus: .Versteckt, konsonantTypModus: nil)
        self.vokalOderHalbvokal                         = PanelControlSetting(controlTyp: .VokalOderHalbvokalTyp, modus: .Versteckt, konsonantTypModus: nil)
        self.artikulation                               = PanelControlSetting(controlTyp: .ArtikulationTyp, modus: .Versteckt, konsonantTypModus: nil)
        self.konsonantTyp                               = PanelControlSetting(controlTyp: .KonsonantTyp, modus: .Versteckt, konsonantTypModus: .Nasal)
        self.aspiration                                 = PanelControlSetting(controlTyp: .AspirationTyp, modus: .Versteckt, konsonantTypModus: nil)
        self.stimmhaftigkeit                            = PanelControlSetting(controlTyp: .StimmhaftigkeitTyp, modus: .Versteckt, konsonantTypModus: nil)
    }
    static var stufeEinsSetting:QuizSetting {
        var setting = QuizSetting()
        setting.zeichenfeld     = .Nachzeichnen
        setting.textfeld.modus  = .InAbfrage
        return setting
    }
    
    // für CoreData
    var asDict:[String:String]{
        var dict: [String:String] = [:]
        dict["zeichenfeld"]             = zeichenfeld.string
        dict["textfeld"]                = textfeld.modus.string
        dict["vokalOderKonsonant"]      = vokalOderKonsonant.modus.string
        dict["vokalOderHalbvokal"]      = vokalOderHalbvokal.modus.string
        dict["artikulation"]            = artikulation.modus.string
        dict["konsonantTyp"]            = konsonantTyp.modus.string
        dict["aspiration"]              = aspiration.modus.string
        dict["stimmhaftigkeit"]         = stimmhaftigkeit.modus.string
        dict["konsonantTypModus"]       = konsonantTyp.konsonantTypModus?.string
        return dict
    }
    init?(dict:[String:String]?){
        guard let dict = dict else { return nil }
         
        self.dynamisiert                                = false
        self.zeichenfeld                                = ZeichenfeldModus.get(for: dict["zeichenfeld"])
        self.textfeld                                   = PanelControlSetting(controlTyp: .TextfeldTyp, modus:PanelControlModus.get(for: dict["textfeld"]), konsonantTypModus: nil)
        self.vokalOderKonsonant                         = PanelControlSetting(controlTyp: .VokalOderKonsonantTyp, modus: PanelControlModus.get(for: dict["vokalOderKonsonant"]), konsonantTypModus: nil)
        self.vokalOderHalbvokal                         = PanelControlSetting(controlTyp: .VokalOderHalbvokalTyp, modus: PanelControlModus.get(for: dict["vokalOderHalbvokal"]), konsonantTypModus: nil)
        self.artikulation                               = PanelControlSetting(controlTyp: .ArtikulationTyp, modus: PanelControlModus.get(for: dict["artikulation"]), konsonantTypModus: nil)
        self.konsonantTyp                               = PanelControlSetting(controlTyp: .KonsonantTyp, modus: PanelControlModus.get(for: dict["konsonantTyp"]), konsonantTypModus: KonsonantTypModus.get(for: dict["konsonantTypModus"]))
        self.aspiration                                 = PanelControlSetting(controlTyp: .AspirationTyp, modus: PanelControlModus.get(for: dict["aspiration"]), konsonantTypModus: nil)
        self.stimmhaftigkeit                            = PanelControlSetting(controlTyp: .StimmhaftigkeitTyp, modus: PanelControlModus.get(for: dict["stimmhaftigkeit"]), konsonantTypModus: nil)
    }
    func copy() -> QuizSetting?{
        return QuizSetting.init(dict: asDict)
    }
}



class PanelControlSetting:Hashable{
    var hashValue: Int{
        return controlTyp.hashValue + modus.hashValue + (konsonantTypModus?.controlName?.hashValue ?? 0)
    }
    
    static func ==(lhs: PanelControlSetting, rhs: PanelControlSetting) -> Bool {
        return lhs.controlTyp == rhs.controlTyp &&
        lhs.modus == rhs.modus &&
        lhs.konsonantTypModus == rhs.konsonantTypModus
    }
    
    
    var controlTyp:ControlTyp
    var modus:PanelControlModus
    var konsonantTypModus:KonsonantTypModus?
    var titleArray:[[String]]?{ return konsonantTypModus != nil ? konsonantTypModus?.titleArray : controlTyp.titleArray }
    
    init(controlTyp: ControlTyp, modus: PanelControlModus   , konsonantTypModus: KonsonantTypModus?){
        self.controlTyp         = controlTyp
        self.modus              = modus
        self.konsonantTypModus  = konsonantTypModus
    }
}

//MARK: enums
enum IPadOrientation{ case portrait, landscape }
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
    case ZeichenfeldTyp = 0
    case TextfeldTyp = 1
    case VokalOderKonsonantTyp = 2
    case VokalOderHalbvokalTyp = 3
    case ArtikulationTyp = 4
    case KonsonantTyp = 5
    case AspirationTyp = 6
    case StimmhaftigkeitTyp = 7
    
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
            case .VokalOderKonsonantTyp:   return (0,rawValue)
            case .VokalOderHalbvokalTyp:   return (0,rawValue)
            case .KonsonantTyp:         return (0,rawValue)
            case .TextfeldTyp:             return (0,rawValue)
            case .ArtikulationTyp:         return (0,rawValue)
            case .AspirationTyp:           return (0,rawValue)
            case .StimmhaftigkeitTyp:      return (0,rawValue)
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
