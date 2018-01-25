//
//  QuizSettings.swift
//  learnDevanagari2
//
//  Created by Matthias Pochmann on 17.11.17.
//  Copyright © 2017 Matthias Pochmann. All rights reserved.
//

import Foundation

//MARK:QuizSetting
// hat zwei Grundfunktionen
// 1) Settings für ein ganzen Quizdurchlauf (für die Generierung von QuizZeichenSätzen)
// 2) Settings für ein einzelnes QuizZeichen
struct QuizSetting:Equatable{
    var dynamisiert: Bool
    var zeichenfeld:ZeichenfeldModus
    var textfeld:PanelControlSetting
    var vokalOderKonsonant:PanelControlSetting
    var vokalOderHalbvokal:PanelControlSetting
    var artikulation:PanelControlSetting
    var konsonantTyp:PanelControlSetting
    var aspiration:PanelControlSetting
    var stimmhaftigkeit:PanelControlSetting
    var nasalDesAnusvaraPruefe      = false
    var anusvaraVisargaViramaPruefe = false
    var allePanelControls:[PanelControlSetting] { return [textfeld,vokalOderKonsonant,vokalOderHalbvokal,artikulation,konsonantTyp,aspiration,stimmhaftigkeit] }
    
    //MARK: Protocol Equatable
    static func ==(lhs: QuizSetting, rhs: QuizSetting) -> Bool {
        return lhs.dynamisiert == rhs.dynamisiert && lhs.zeichenfeld == rhs.zeichenfeld && lhs.textfeld == rhs.textfeld && lhs.vokalOderKonsonant == rhs.vokalOderKonsonant && lhs.vokalOderHalbvokal == rhs.vokalOderHalbvokal && lhs.artikulation == rhs.artikulation && lhs.konsonantTyp == rhs.konsonantTyp && lhs.aspiration == rhs.aspiration && lhs.stimmhaftigkeit == rhs.stimmhaftigkeit && lhs.nasalDesAnusvaraPruefe == rhs.nasalDesAnusvaraPruefe
    }
    
    //MARK: Filter für LektionsdurchlaufSetting -> gibt Setting für eine Lektion zurück
    // setzt Controls auf nurAnzeige/versteckt, falls sie in den globalen Settings für den Lektionsdurchlauf nicht auf Abfrage gesetzt sind
    func filterNotIn(quizSetting:QuizSetting) -> QuizSetting{
        var ergebnis = QuizSetting()
        
        // Sets für Abgefragte, angezeigte und versteckte Controls bestimmen
        let filteredAbfragen    = Set(quizSetting.abfragen).intersection(Set(abfragen))
        let filteredAnzeigen    = (Set(quizSetting.anzeigen).union(Set(quizSetting.abfragen))).intersection(Set(anzeigen))
        let anzeigenUndAbfragen = filteredAbfragen.union(filteredAnzeigen)
        let versteckteControls  = Set(allePanelControls.map{$0.controlTyp}).filter{ !anzeigenUndAbfragen.contains($0)}
        
        // Modus der Controls in den Sets auf versteckt, abfrage oder anzeige setzen
        for control in versteckteControls   { ergebnis.getPanelControlSetting(for: control)?.modus    = .Versteckt }
        for control in filteredAnzeigen     { ergebnis.getPanelControlSetting(for: control)?.modus    = .NurAnzeige }
        for control in filteredAbfragen     { ergebnis.getPanelControlSetting(for: control)?.modus    = .InAbfrage }
        
        // Zeichenfeld auf Anzeige, NachZeichnen, Abfrage bzw. AbfrageUndNachzeichnen setzen
        switch quizSetting.zeichenfeld{
        case .NurAnzeige:   ergebnis.zeichenfeld = .NurAnzeige
        case .Nachzeichnen: ergebnis.zeichenfeld = zeichenfeld == .NurAnzeige ? .NurAnzeige : .Nachzeichnen
        case .InAbfrage:    ergebnis.zeichenfeld = zeichenfeld == .InAbfrage || quizSetting.zeichenfeld == .AbfrageUndNachzeichnen ?  .InAbfrage : .NurAnzeige
        case .AbfrageUndNachzeichnen: ergebnis.zeichenfeld = zeichenfeld
        }
        return ergebnis
    }
    
    //MARK: calc Properties
    var abfragen:[ControlTyp]   {
        let zeichenfeldAbfrage      = (zeichenfeld == .InAbfrage || zeichenfeld == .AbfrageUndNachzeichnen) ? [ControlTyp.ZeichenfeldTyp] : [ControlTyp]()
        return allePanelControls.filter{$0.modus == .InAbfrage}.map{$0.controlTyp} + zeichenfeldAbfrage
    }
    var anzahlAbfragen:Int      { return abfragen.count }
    var anzeigen:[ControlTyp]   { return allePanelControls.filter{$0.modus == .NurAnzeige}.map{$0.controlTyp}  }
    var isNachZeichnen:Bool     { return abfragen.count == 0 }
    var isStufe3:Bool           { return abfragen.count == allePanelControls.count + 1 }
    
    
    //MARK: inits
    // init "leer"
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
    //init per dict (z.B. CoreData)
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
    //init für Stufe 1
    static var stufeEinsSetting:QuizSetting {
        var setting = QuizSetting()
        setting.zeichenfeld     = .Nachzeichnen
        setting.textfeld.modus  = .InAbfrage
        return setting
    }
    
    //MARK: helper
    // liefert alle ControlSettings für den abgefragten Modus (versteckt, angezeigt oder abgefragt)
    func panelControls(for panelControlModus:PanelControlModus) -> [PanelControlSetting]{
        return allePanelControls.reduce([PanelControlSetting]()) { (result, setting) -> [PanelControlSetting] in return setting.modus == panelControlModus ? result.arrayByAppending(o: setting) :  result }
    }
    // setzt alle Abfragen auf NurAnzeige
    // Versteckte bleiben versteckt
    mutating func setPanelControlsToNurAnzeige(){
        func setNurAnzeigeOderVersteckt( controlSetting: inout PanelControlSetting)     { controlSetting.modus = controlSetting.modus == .Versteckt ? .Versteckt : .NurAnzeige }
        setNurAnzeigeOderVersteckt(controlSetting: &self.textfeld)
        setNurAnzeigeOderVersteckt(controlSetting: &self.vokalOderKonsonant)
        setNurAnzeigeOderVersteckt(controlSetting: &self.vokalOderHalbvokal)
        setNurAnzeigeOderVersteckt(controlSetting: &self.artikulation)
        setNurAnzeigeOderVersteckt(controlSetting: &self.konsonantTyp)
        setNurAnzeigeOderVersteckt(controlSetting: &self.aspiration)
        setNurAnzeigeOderVersteckt(controlSetting: &self.stimmhaftigkeit)
    }
    // filtert Abfragen heraus, die nicht zum VokalOderKonsonant-Typ passen
    // bsp.: keine Abfrage für VokalOderHalbvokalTyp, wenn das Zeichen ein Konsonant ist
    func fuerVokalOderKonsonantGefilterteAbfragen(for quizZeichen:QuizZeichen) -> [ControlTyp]{
        switch quizZeichen.zeichen.vokalOderKonsonant ?? ""{
        case VokalOderKonsonant.Konsonant.rawValue: return abfragen.filter{$0 != ControlTyp.VokalOderHalbvokalTyp}
        case VokalOderKonsonant.Vokal.rawValue:     return abfragen.filter{$0 != ControlTyp.ArtikulationTyp && $0 != ControlTyp.KonsonantTyp &&  $0 != ControlTyp.AspirationTyp && $0 != ControlTyp.StimmhaftigkeitTyp }
        default:                                    return [ControlTyp]()
        }
    }
    //holt PanelControlSetting für ein (Panel)Control
    func getPanelControlSetting(for controlTyp:ControlTyp?) -> PanelControlSetting?{
        guard let controlTyp = controlTyp else {return nil}
        switch controlTyp {
        case .ArtikulationTyp:          return artikulation
        case .AspirationTyp:            return aspiration
        case .KonsonantTyp:             return konsonantTyp
        case .StimmhaftigkeitTyp:       return stimmhaftigkeit
        case .TextfeldTyp:              return textfeld
        case .VokalOderHalbvokalTyp:    return vokalOderHalbvokal
        case .VokalOderKonsonantTyp:    return vokalOderKonsonant
        case .ZeichenfeldTyp:           return nil
        }
    }
    // dict für CoreData
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
    // erzeugt Kopie
    func copy() -> QuizSetting?         { return QuizSetting.init(dict: asDict) }
}


//MARK: PanelControlSetting
// Setting für ein einzelnes (Panel)Control
class PanelControlSetting:Hashable{
    var controlTyp:ControlTyp
    var modus:PanelControlModus
    var konsonantTypModus:KonsonantTypModus?
    
    //MARK: Protocol Hashable
    var hashValue: Int                                                          { return controlTyp.hashValue + modus.hashValue + (konsonantTypModus?.controlName?.hashValue ?? 0) }
    static func ==(lhs: PanelControlSetting, rhs: PanelControlSetting) -> Bool  { return lhs.controlTyp == rhs.controlTyp && lhs.modus == rhs.modus && lhs.konsonantTypModus == rhs.konsonantTypModus }
    
    
    //MARK: calc Properties
    var titleArray:[[String]]?                                                  { return konsonantTypModus != nil ? konsonantTypModus?.titleArray : controlTyp.titleArray }
    
    //MARK: init
    init(controlTyp: ControlTyp, modus: PanelControlModus   , konsonantTypModus: KonsonantTypModus?){
        self.controlTyp         = controlTyp
        self.modus              = modus
        self.konsonantTypModus  = konsonantTypModus
    }
}


