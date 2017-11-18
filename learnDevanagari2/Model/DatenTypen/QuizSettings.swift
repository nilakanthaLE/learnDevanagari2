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

struct QuizSetting{
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
    var abfragen:[ControlTyp]{
        let zeichenfeldAbfrage      = (zeichenfeld == .Abfrage || zeichenfeld == .AbfrageUndNachzeichnen) ? [ControlTyp.ZeichenfeldTyp] : [ControlTyp]()
        return allePanelControls.filter{$0.modus == .Abfrage}.map{$0.controlTyp} + zeichenfeldAbfrage
    }
    var anzahlAbfragen:Int{
        let anzahlZeichenFeldAbfragen = zeichenfeld == .Abfrage || zeichenfeld == .AbfrageUndNachzeichnen ? 1 : 0
        return allePanelControls.filter{$0.modus == .Abfrage}.count + anzahlZeichenFeldAbfragen
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
            print("control\(controlSetting.controlTyp) --> modus:\(controlSetting.modus)")
            controlSetting.modus = controlSetting.modus == .Versteckt ? .Versteckt : .NurAnzeige
            print("control\(controlSetting.controlTyp) --> modus:\(controlSetting.modus)")
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
        self.vokalOderKonsonant                         = PanelControlSetting(controlTyp: .VokalOderKonsonantTyp, modus: .NurAnzeige, konsonantTypModus: nil)
        self.vokalOderHalbvokal                         = PanelControlSetting(controlTyp: .VokalOderHalbvokalTyp, modus: .NurAnzeige, konsonantTypModus: nil)
        self.artikulation                               = PanelControlSetting(controlTyp: .ArtikulationTyp, modus: .NurAnzeige, konsonantTypModus: nil)
        self.konsonantTyp                               = PanelControlSetting(controlTyp: .KonsonantTyp, modus: .NurAnzeige, konsonantTypModus: .Hauchlaut)
        self.aspiration                                 = PanelControlSetting(controlTyp: .AspirationTyp, modus: .NurAnzeige, konsonantTypModus: nil)
        self.stimmhaftigkeit                            = PanelControlSetting(controlTyp: .StimmhaftigkeitTyp, modus: .NurAnzeige, konsonantTypModus: nil)
    }
    
    
}



struct PanelControlSetting{
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
enum ZeichenfeldModus{ case NurAnzeige, Nachzeichnen, Abfrage , AbfrageUndNachzeichnen }
enum PanelControlModus{ case Versteckt, NurAnzeige, Abfrage }
enum KonsonantTypModus:Int{
    case Nasal,Sibilant,Hauchlaut
    var titleArray:[[String]]{
        switch self {
        case .Nasal:        return [[KonsonantTyp.EinfacherKonsonant.rawValue,KonsonantTyp.Nasal.rawValue]]
        case .Sibilant:     return [[KonsonantTyp.EinfacherKonsonant.rawValue,KonsonantTyp.Nasal.rawValue],[KonsonantTyp.Sibilant.rawValue]]
        case.Hauchlaut:     return [[KonsonantTyp.EinfacherKonsonant.rawValue,KonsonantTyp.Nasal.rawValue],[KonsonantTyp.Sibilant.rawValue,KonsonantTyp.Hauchlaut.rawValue]]
        }
    }
    var controlName:String?{
        switch self {
        case .Nasal:        return "Nasale"
        case .Sibilant:     return "Nasale und Sibilanten"
        case .Hauchlaut:    return "Nasale, Sibilanten und Hauchlaut"
        }
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
