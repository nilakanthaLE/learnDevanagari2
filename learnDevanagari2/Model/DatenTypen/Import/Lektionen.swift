//
//  Lektionen.swift
//  learnDevanagari2
//
//  Created by Matthias Pochmann on 16.11.17.
//  Copyright © 2017 Matthias Pochmann. All rights reserved.
//

import Foundation

func erstelleLektionen() -> [Lektion]
{
    let lektionen = Array.init(count: 25, elementCreator: Lektion())
    Array.init(repeating: Lektion(), count: 25)
    //quizSetting
    for lektion in lektionen               { lektion.quizSetting = QuizSetting() }
    
    //nummer
    for lektion in lektionen.enumerated()   { lektion.element.nummer = lektion.offset }
    
    
    //titles
    lektionen[0].title      = "1 Die ersten Zeichen";
    lektionen[1].title      = "2 Verschlußlaute";
    lektionen[2].title      = "3 weitere Vokale";
    lektionen[3].title      = "4 kombinierte Zeichen";
    lektionen[4].title      = "5 Ort der Artikulation";
    lektionen[5].title      = "6 lange Vokale";
    lektionen[6].title      = "7 typisch indisch I - retroflexe Laute";
    lektionen[7].title      = "8 Diphtonge";
    lektionen[8].title      = "9 Einführung Aspiration";
    lektionen[9].title     = "10 Aspiration erkennen";
    lektionen[10].title     = "11 typisch indisch II - der Vokal ऋ";
    lektionen[11].title     = "12 Einführung Stimmhaftigkeit";
    lektionen[12].title     = "13 Erkenne Stimmhaftigkeit I";
    lektionen[13].title     = "14 Erkenne Stimmhaftigkeit II";
    lektionen[14].title     = "15 Einführung Nasale";
    lektionen[15].title     = "16 Nasale erkennen";
    lektionen[16].title     = "17 Halbvokale";
    lektionen[17].title     = "18 Sibilanten";
    lektionen[18].title     = "19 Hauchlaut";
    lektionen[19].title     = "20 Anusvara, Visarga, Virama";
    lektionen[20].title     = "21 Nasal des Anusvara";
    lektionen[21].title     = "22 Ligaturen I";
    lektionen[22].title     = "23 Ligaturen II";
    lektionen[23].title     = "24 Ligaturen III";
    lektionen[24].title     = "25 Ligaturen IV";
 
    
    //Zeichenfeld
    lektionen[1-1].quizSetting?.zeichenfeld       = .Nachzeichnen
    lektionen[2-1].quizSetting?.zeichenfeld       = .Nachzeichnen
    lektionen[3-1].quizSetting?.zeichenfeld       = .Nachzeichnen
    lektionen[4-1].quizSetting?.zeichenfeld       = .AbfrageUndNachzeichnen
    lektionen[5-1].quizSetting?.zeichenfeld       = .AbfrageUndNachzeichnen
    lektionen[6-1].quizSetting?.zeichenfeld       = .AbfrageUndNachzeichnen
    lektionen[7-1].quizSetting?.zeichenfeld       = .AbfrageUndNachzeichnen
    lektionen[8-1].quizSetting?.zeichenfeld       = .AbfrageUndNachzeichnen
    lektionen[9-1].quizSetting?.zeichenfeld       = .AbfrageUndNachzeichnen
    lektionen[10-1].quizSetting?.zeichenfeld      = .AbfrageUndNachzeichnen
    lektionen[11-1].quizSetting?.zeichenfeld      = .AbfrageUndNachzeichnen
    lektionen[12-1].quizSetting?.zeichenfeld      = .AbfrageUndNachzeichnen
    lektionen[13-1].quizSetting?.zeichenfeld      = .AbfrageUndNachzeichnen
    lektionen[14-1].quizSetting?.zeichenfeld      = .AbfrageUndNachzeichnen
    lektionen[15-1].quizSetting?.zeichenfeld      = .AbfrageUndNachzeichnen
    lektionen[16-1].quizSetting?.zeichenfeld      = .AbfrageUndNachzeichnen
    lektionen[17-1].quizSetting?.zeichenfeld      = .AbfrageUndNachzeichnen
    lektionen[18-1].quizSetting?.zeichenfeld      = .AbfrageUndNachzeichnen
    lektionen[19-1].quizSetting?.zeichenfeld      = .AbfrageUndNachzeichnen
    lektionen[20-1].quizSetting?.zeichenfeld      = .NurAnzeige
    lektionen[21-1].quizSetting?.zeichenfeld      = .NurAnzeige
    lektionen[22-1].quizSetting?.zeichenfeld      = .AbfrageUndNachzeichnen
    lektionen[23-1].quizSetting?.zeichenfeld      = .AbfrageUndNachzeichnen
    lektionen[24-1].quizSetting?.zeichenfeld      = .AbfrageUndNachzeichnen
    lektionen[25-1].quizSetting?.zeichenfeld      = .AbfrageUndNachzeichnen


    //Vokal oder Konsonant
    lektionen[1-1].quizSetting?.vokalOderKonsonant    = .init(controlTyp: .VokalOderKonsonantTyp, modus: .NurAnzeige, konsonantTypModus: nil)
    lektionen[2-1].quizSetting?.vokalOderKonsonant    = .init(controlTyp: .VokalOderKonsonantTyp, modus: .InAbfrage, konsonantTypModus: nil)
    lektionen[3-1].quizSetting?.vokalOderKonsonant    = .init(controlTyp: .VokalOderKonsonantTyp, modus: .InAbfrage, konsonantTypModus: nil)
    lektionen[4-1].quizSetting?.vokalOderKonsonant    = .init(controlTyp: .VokalOderKonsonantTyp, modus: .InAbfrage, konsonantTypModus: nil)
    lektionen[5-1].quizSetting?.vokalOderKonsonant    = .init(controlTyp: .VokalOderKonsonantTyp, modus: .InAbfrage, konsonantTypModus: nil)
    lektionen[6-1].quizSetting?.vokalOderKonsonant    = .init(controlTyp: .VokalOderKonsonantTyp, modus: .InAbfrage, konsonantTypModus: nil)
    lektionen[7-1].quizSetting?.vokalOderKonsonant    = .init(controlTyp: .VokalOderKonsonantTyp, modus: .InAbfrage, konsonantTypModus: nil)
    lektionen[8-1].quizSetting?.vokalOderKonsonant    = .init(controlTyp: .VokalOderKonsonantTyp, modus: .InAbfrage, konsonantTypModus: nil)
    lektionen[9-1].quizSetting?.vokalOderKonsonant    = .init(controlTyp: .VokalOderKonsonantTyp, modus: .InAbfrage, konsonantTypModus: nil)
    lektionen[10-1].quizSetting?.vokalOderKonsonant    = .init(controlTyp: .VokalOderKonsonantTyp, modus: .InAbfrage, konsonantTypModus: nil)
    lektionen[11-1].quizSetting?.vokalOderKonsonant    = .init(controlTyp: .VokalOderKonsonantTyp, modus: .InAbfrage, konsonantTypModus: nil)
    lektionen[12-1].quizSetting?.vokalOderKonsonant    = .init(controlTyp: .VokalOderKonsonantTyp, modus: .InAbfrage, konsonantTypModus: nil)
    lektionen[13-1].quizSetting?.vokalOderKonsonant    = .init(controlTyp: .VokalOderKonsonantTyp, modus: .InAbfrage, konsonantTypModus: nil)
    lektionen[14-1].quizSetting?.vokalOderKonsonant    = .init(controlTyp: .VokalOderKonsonantTyp, modus: .InAbfrage, konsonantTypModus: nil)
    lektionen[15-1].quizSetting?.vokalOderKonsonant    = .init(controlTyp: .VokalOderKonsonantTyp, modus: .InAbfrage, konsonantTypModus: nil)
    lektionen[16-1].quizSetting?.vokalOderKonsonant    = .init(controlTyp: .VokalOderKonsonantTyp, modus: .InAbfrage, konsonantTypModus: nil)
    lektionen[17-1].quizSetting?.vokalOderKonsonant    = .init(controlTyp: .VokalOderKonsonantTyp, modus: .InAbfrage, konsonantTypModus: nil)
    lektionen[18-1].quizSetting?.vokalOderKonsonant    = .init(controlTyp: .VokalOderKonsonantTyp, modus: .InAbfrage, konsonantTypModus: nil)
    lektionen[19-1].quizSetting?.vokalOderKonsonant    = .init(controlTyp: .VokalOderKonsonantTyp, modus: .InAbfrage, konsonantTypModus: nil)
    lektionen[21-1].quizSetting?.vokalOderKonsonant    = .init(controlTyp: .VokalOderKonsonantTyp, modus: .Versteckt, konsonantTypModus: nil)
    lektionen[22-1].quizSetting?.vokalOderKonsonant    = .init(controlTyp: .VokalOderKonsonantTyp, modus: .Versteckt, konsonantTypModus: nil)
    lektionen[23-1].quizSetting?.vokalOderKonsonant    = .init(controlTyp: .VokalOderKonsonantTyp, modus: .Versteckt, konsonantTypModus: nil)
    lektionen[24-1].quizSetting?.vokalOderKonsonant    = .init(controlTyp: .VokalOderKonsonantTyp, modus: .Versteckt, konsonantTypModus: nil)
    lektionen[25-1].quizSetting?.vokalOderKonsonant    = .init(controlTyp: .VokalOderKonsonantTyp, modus: .Versteckt, konsonantTypModus: nil)
    
    //Textfeld
    lektionen[1-1].quizSetting?.textfeld                  = .init(controlTyp: .TextfeldTyp, modus: .NurAnzeige, konsonantTypModus: nil)
    lektionen[2-1].quizSetting?.textfeld                  = .init(controlTyp: .TextfeldTyp, modus: .NurAnzeige, konsonantTypModus: nil)
    lektionen[3-1].quizSetting?.textfeld                  = .init(controlTyp: .TextfeldTyp, modus: .InAbfrage, konsonantTypModus: nil)
    lektionen[4-1].quizSetting?.textfeld                  = .init(controlTyp: .TextfeldTyp, modus: .InAbfrage, konsonantTypModus: nil)
    lektionen[5-1].quizSetting?.textfeld                  = .init(controlTyp: .TextfeldTyp, modus: .InAbfrage, konsonantTypModus: nil)
    lektionen[6-1].quizSetting?.textfeld                  = .init(controlTyp: .TextfeldTyp, modus: .InAbfrage, konsonantTypModus: nil)
    lektionen[7-1].quizSetting?.textfeld                  = .init(controlTyp: .TextfeldTyp, modus: .InAbfrage, konsonantTypModus: nil)
    lektionen[8-1].quizSetting?.textfeld                  = .init(controlTyp: .TextfeldTyp, modus: .InAbfrage, konsonantTypModus: nil)
    lektionen[9-1].quizSetting?.textfeld                  = .init(controlTyp: .TextfeldTyp, modus: .InAbfrage, konsonantTypModus: nil)
    lektionen[10-1].quizSetting?.textfeld                  = .init(controlTyp: .TextfeldTyp, modus: .InAbfrage, konsonantTypModus: nil)
    lektionen[11-1].quizSetting?.textfeld                  = .init(controlTyp: .TextfeldTyp, modus: .InAbfrage, konsonantTypModus: nil)
    lektionen[12-1].quizSetting?.textfeld                  = .init(controlTyp: .TextfeldTyp, modus: .InAbfrage, konsonantTypModus: nil)
    lektionen[13-1].quizSetting?.textfeld                  = .init(controlTyp: .TextfeldTyp, modus: .InAbfrage, konsonantTypModus: nil)
    lektionen[14-1].quizSetting?.textfeld                  = .init(controlTyp: .TextfeldTyp, modus: .InAbfrage, konsonantTypModus: nil)
    lektionen[15-1].quizSetting?.textfeld                  = .init(controlTyp: .TextfeldTyp, modus: .InAbfrage, konsonantTypModus: nil)
    lektionen[16-1].quizSetting?.textfeld                  = .init(controlTyp: .TextfeldTyp, modus: .InAbfrage, konsonantTypModus: nil)
    lektionen[17-1].quizSetting?.textfeld                  = .init(controlTyp: .TextfeldTyp, modus: .InAbfrage, konsonantTypModus: nil)
    lektionen[18-1].quizSetting?.textfeld                  = .init(controlTyp: .TextfeldTyp, modus: .InAbfrage, konsonantTypModus: nil)
    lektionen[19-1].quizSetting?.textfeld                  = .init(controlTyp: .TextfeldTyp, modus: .InAbfrage, konsonantTypModus: nil)
    lektionen[20-1].quizSetting?.textfeld                  = .init(controlTyp: .TextfeldTyp, modus: .InAbfrage, konsonantTypModus: nil)
    lektionen[21-1].quizSetting?.textfeld                  = .init(controlTyp: .TextfeldTyp, modus: .InAbfrage, konsonantTypModus: nil)
    lektionen[22-1].quizSetting?.textfeld                  = .init(controlTyp: .TextfeldTyp, modus: .InAbfrage, konsonantTypModus: nil)
    lektionen[23-1].quizSetting?.textfeld                  = .init(controlTyp: .TextfeldTyp, modus: .InAbfrage, konsonantTypModus: nil)
    lektionen[24-1].quizSetting?.textfeld                  = .init(controlTyp: .TextfeldTyp, modus: .InAbfrage, konsonantTypModus: nil)
    lektionen[25-1].quizSetting?.textfeld                  = .init(controlTyp: .TextfeldTyp, modus: .InAbfrage, konsonantTypModus: nil)

    
    
    //Artikulation
    lektionen[1-1].quizSetting?.artikulation              = .init(controlTyp: .ArtikulationTyp, modus: .Versteckt, konsonantTypModus: nil)
    lektionen[2-1].quizSetting?.artikulation              = .init(controlTyp: .ArtikulationTyp, modus: .NurAnzeige, konsonantTypModus: nil)
    lektionen[3-1].quizSetting?.artikulation              = .init(controlTyp: .ArtikulationTyp, modus: .Versteckt, konsonantTypModus: nil)
    lektionen[4-1].quizSetting?.artikulation              = .init(controlTyp: .ArtikulationTyp, modus: .NurAnzeige, konsonantTypModus: nil)
    lektionen[5-1].quizSetting?.artikulation              = .init(controlTyp: .ArtikulationTyp, modus: .InAbfrage, konsonantTypModus: nil)
    lektionen[6-1].quizSetting?.artikulation              = .init(controlTyp: .ArtikulationTyp, modus: .InAbfrage, konsonantTypModus: nil)
    lektionen[7-1].quizSetting?.artikulation              = .init(controlTyp: .ArtikulationTyp, modus: .InAbfrage, konsonantTypModus: nil)
    lektionen[8-1].quizSetting?.artikulation              = .init(controlTyp: .ArtikulationTyp, modus: .InAbfrage, konsonantTypModus: nil)
    lektionen[9-1].quizSetting?.artikulation              = .init(controlTyp: .ArtikulationTyp, modus: .InAbfrage, konsonantTypModus: nil)
    lektionen[10-1].quizSetting?.artikulation             = .init(controlTyp: .ArtikulationTyp, modus: .InAbfrage, konsonantTypModus: nil)
    lektionen[11-1].quizSetting?.artikulation             = .init(controlTyp: .ArtikulationTyp, modus: .InAbfrage, konsonantTypModus: nil)
    lektionen[12-1].quizSetting?.artikulation             = .init(controlTyp: .ArtikulationTyp, modus: .InAbfrage, konsonantTypModus: nil)
    lektionen[13-1].quizSetting?.artikulation             = .init(controlTyp: .ArtikulationTyp, modus: .InAbfrage, konsonantTypModus: nil)
    lektionen[14-1].quizSetting?.artikulation             = .init(controlTyp: .ArtikulationTyp, modus: .InAbfrage, konsonantTypModus: nil)
    lektionen[15-1].quizSetting?.artikulation             = .init(controlTyp: .ArtikulationTyp, modus: .InAbfrage, konsonantTypModus: nil)
    lektionen[16-1].quizSetting?.artikulation             = .init(controlTyp: .ArtikulationTyp, modus: .InAbfrage, konsonantTypModus: nil)
    lektionen[17-1].quizSetting?.artikulation             = .init(controlTyp: .ArtikulationTyp, modus: .InAbfrage, konsonantTypModus: nil)
    lektionen[18-1].quizSetting?.artikulation             = .init(controlTyp: .ArtikulationTyp, modus: .InAbfrage, konsonantTypModus: nil)
    lektionen[19-1].quizSetting?.artikulation             = .init(controlTyp: .ArtikulationTyp, modus: .InAbfrage, konsonantTypModus: nil)
    lektionen[20-1].quizSetting?.artikulation             = .init(controlTyp: .ArtikulationTyp, modus: .InAbfrage, konsonantTypModus: nil)
    lektionen[21-1].quizSetting?.artikulation             = .init(controlTyp: .ArtikulationTyp, modus: .InAbfrage, konsonantTypModus: nil)
    lektionen[22-1].quizSetting?.artikulation             = .init(controlTyp: .ArtikulationTyp, modus: .Versteckt, konsonantTypModus: nil)
    lektionen[23-1].quizSetting?.artikulation             = .init(controlTyp: .ArtikulationTyp, modus: .Versteckt, konsonantTypModus: nil)
    lektionen[24-1].quizSetting?.artikulation             = .init(controlTyp: .ArtikulationTyp, modus: .Versteckt, konsonantTypModus: nil)
    lektionen[25-1].quizSetting?.artikulation             = .init(controlTyp: .ArtikulationTyp, modus: .Versteckt, konsonantTypModus: nil)

    
    
    
    
    
    
    //Aspiration
    lektionen[1-1].quizSetting?.aspiration        = .init(controlTyp: .AspirationTyp, modus: .Versteckt, konsonantTypModus: nil)
    lektionen[2-1].quizSetting?.aspiration        = .init(controlTyp: .AspirationTyp, modus: .Versteckt, konsonantTypModus: nil)
    lektionen[3-1].quizSetting?.aspiration        = .init(controlTyp: .AspirationTyp, modus: .Versteckt, konsonantTypModus: nil)
    lektionen[4-1].quizSetting?.aspiration        = .init(controlTyp: .AspirationTyp, modus: .Versteckt, konsonantTypModus: nil)
    lektionen[5-1].quizSetting?.aspiration        = .init(controlTyp: .AspirationTyp, modus: .Versteckt, konsonantTypModus: nil)
    lektionen[6-1].quizSetting?.aspiration        = .init(controlTyp: .AspirationTyp, modus: .Versteckt, konsonantTypModus: nil)
    lektionen[7-1].quizSetting?.aspiration        = .init(controlTyp: .AspirationTyp, modus: .Versteckt, konsonantTypModus: nil)
    lektionen[8-1].quizSetting?.aspiration        = .init(controlTyp: .AspirationTyp, modus: .Versteckt, konsonantTypModus: nil)
    lektionen[9-1].quizSetting?.aspiration        = .init(controlTyp: .AspirationTyp, modus: .NurAnzeige, konsonantTypModus: nil)
    lektionen[10-1].quizSetting?.aspiration       = .init(controlTyp: .AspirationTyp, modus: .InAbfrage, konsonantTypModus: nil)
    lektionen[11-1].quizSetting?.aspiration       = .init(controlTyp: .AspirationTyp, modus: .InAbfrage, konsonantTypModus: nil)
    lektionen[12-1].quizSetting?.aspiration       = .init(controlTyp: .AspirationTyp, modus: .InAbfrage, konsonantTypModus: nil)
    lektionen[13-1].quizSetting?.aspiration       = .init(controlTyp: .AspirationTyp, modus: .InAbfrage, konsonantTypModus: nil)
    lektionen[14-1].quizSetting?.aspiration       = .init(controlTyp: .AspirationTyp, modus: .InAbfrage, konsonantTypModus: nil)
    lektionen[15-1].quizSetting?.aspiration       = .init(controlTyp: .AspirationTyp, modus: .InAbfrage, konsonantTypModus: nil)
    lektionen[16-1].quizSetting?.aspiration       = .init(controlTyp: .AspirationTyp, modus: .InAbfrage, konsonantTypModus: nil)
    lektionen[17-1].quizSetting?.aspiration       = .init(controlTyp: .AspirationTyp, modus: .InAbfrage, konsonantTypModus: nil)
    lektionen[18-1].quizSetting?.aspiration       = .init(controlTyp: .AspirationTyp, modus: .InAbfrage, konsonantTypModus: nil)
    lektionen[19-1].quizSetting?.aspiration       = .init(controlTyp: .AspirationTyp, modus: .InAbfrage, konsonantTypModus: nil)
    lektionen[20-1].quizSetting?.aspiration       = .init(controlTyp: .AspirationTyp, modus: .InAbfrage, konsonantTypModus: nil)
    lektionen[21-1].quizSetting?.aspiration       = .init(controlTyp: .AspirationTyp, modus: .Versteckt, konsonantTypModus: nil)
    lektionen[22-1].quizSetting?.aspiration       = .init(controlTyp: .AspirationTyp, modus: .Versteckt, konsonantTypModus: nil)
    lektionen[23-1].quizSetting?.aspiration       = .init(controlTyp: .AspirationTyp, modus: .Versteckt, konsonantTypModus: nil)
    lektionen[24-1].quizSetting?.aspiration       = .init(controlTyp: .AspirationTyp, modus: .Versteckt, konsonantTypModus: nil)
    lektionen[25-1].quizSetting?.aspiration       = .init(controlTyp: .AspirationTyp, modus: .Versteckt, konsonantTypModus: nil)
    

    
    //Stimmhaftigkeit
    lektionen[1-1].quizSetting?.stimmhaftigkeit   = .init(controlTyp: .StimmhaftigkeitTyp, modus: .Versteckt, konsonantTypModus: nil)
    lektionen[2-1].quizSetting?.stimmhaftigkeit   = .init(controlTyp: .StimmhaftigkeitTyp, modus: .Versteckt, konsonantTypModus: nil)
    lektionen[3-1].quizSetting?.stimmhaftigkeit   = .init(controlTyp: .StimmhaftigkeitTyp, modus: .Versteckt, konsonantTypModus: nil)
    lektionen[4-1].quizSetting?.stimmhaftigkeit   = .init(controlTyp: .StimmhaftigkeitTyp, modus: .Versteckt, konsonantTypModus: nil)
    lektionen[5-1].quizSetting?.stimmhaftigkeit   = .init(controlTyp: .StimmhaftigkeitTyp, modus: .Versteckt, konsonantTypModus: nil)
    lektionen[6-1].quizSetting?.stimmhaftigkeit   = .init(controlTyp: .StimmhaftigkeitTyp, modus: .Versteckt, konsonantTypModus: nil)
    lektionen[7-1].quizSetting?.stimmhaftigkeit   = .init(controlTyp: .StimmhaftigkeitTyp, modus: .Versteckt, konsonantTypModus: nil)
    lektionen[8-1].quizSetting?.stimmhaftigkeit   = .init(controlTyp: .StimmhaftigkeitTyp, modus: .Versteckt, konsonantTypModus: nil)
    lektionen[9-1].quizSetting?.stimmhaftigkeit   = .init(controlTyp: .StimmhaftigkeitTyp, modus: .Versteckt, konsonantTypModus: nil)
    lektionen[10-1].quizSetting?.stimmhaftigkeit   = .init(controlTyp: .StimmhaftigkeitTyp, modus: .Versteckt, konsonantTypModus: nil)
    lektionen[11-1].quizSetting?.stimmhaftigkeit   = .init(controlTyp: .StimmhaftigkeitTyp, modus: .Versteckt, konsonantTypModus: nil)
    lektionen[12-1].quizSetting?.stimmhaftigkeit          = .init(controlTyp: .StimmhaftigkeitTyp, modus: .NurAnzeige, konsonantTypModus: nil)
    lektionen[13-1].quizSetting?.stimmhaftigkeit          = .init(controlTyp: .StimmhaftigkeitTyp, modus: .InAbfrage, konsonantTypModus: nil)
    lektionen[14-1].quizSetting?.stimmhaftigkeit          = .init(controlTyp: .StimmhaftigkeitTyp, modus: .InAbfrage, konsonantTypModus: nil)
    lektionen[15-1].quizSetting?.stimmhaftigkeit          = .init(controlTyp: .StimmhaftigkeitTyp, modus: .InAbfrage, konsonantTypModus: nil)
    lektionen[16-1].quizSetting?.stimmhaftigkeit          = .init(controlTyp: .StimmhaftigkeitTyp, modus: .InAbfrage, konsonantTypModus: nil)
    lektionen[17-1].quizSetting?.stimmhaftigkeit          = .init(controlTyp: .StimmhaftigkeitTyp, modus: .InAbfrage, konsonantTypModus: nil)
    lektionen[18-1].quizSetting?.stimmhaftigkeit          = .init(controlTyp: .StimmhaftigkeitTyp, modus: .InAbfrage, konsonantTypModus: nil)
    lektionen[19-1].quizSetting?.stimmhaftigkeit          = .init(controlTyp: .StimmhaftigkeitTyp, modus: .InAbfrage, konsonantTypModus: nil)
    lektionen[20-1].quizSetting?.stimmhaftigkeit          = .init(controlTyp: .StimmhaftigkeitTyp, modus: .InAbfrage, konsonantTypModus: nil)
    lektionen[21-1].quizSetting?.stimmhaftigkeit   = .init(controlTyp: .StimmhaftigkeitTyp, modus: .Versteckt, konsonantTypModus: nil)
    lektionen[22-1].quizSetting?.stimmhaftigkeit   = .init(controlTyp: .StimmhaftigkeitTyp, modus: .Versteckt, konsonantTypModus: nil)
    lektionen[23-1].quizSetting?.stimmhaftigkeit   = .init(controlTyp: .StimmhaftigkeitTyp, modus: .Versteckt, konsonantTypModus: nil)
    lektionen[24-1].quizSetting?.stimmhaftigkeit   = .init(controlTyp: .StimmhaftigkeitTyp, modus: .Versteckt, konsonantTypModus: nil)
    lektionen[25-1].quizSetting?.stimmhaftigkeit   = .init(controlTyp: .StimmhaftigkeitTyp, modus: .Versteckt, konsonantTypModus: nil)
    

    //Vokal oder Halbvokal
    lektionen[1-1].quizSetting?.vokalOderHalbvokal        = .init(controlTyp: .VokalOderHalbvokalTyp, modus: .Versteckt, konsonantTypModus: nil)
    lektionen[2-1].quizSetting?.vokalOderHalbvokal        = .init(controlTyp: .VokalOderHalbvokalTyp, modus: .Versteckt, konsonantTypModus: nil)
    lektionen[3-1].quizSetting?.vokalOderHalbvokal        = .init(controlTyp: .VokalOderHalbvokalTyp, modus: .Versteckt, konsonantTypModus: nil)
    lektionen[4-1].quizSetting?.vokalOderHalbvokal        = .init(controlTyp: .VokalOderHalbvokalTyp, modus: .Versteckt, konsonantTypModus: nil)
    lektionen[5-1].quizSetting?.vokalOderHalbvokal        = .init(controlTyp: .VokalOderHalbvokalTyp, modus: .Versteckt, konsonantTypModus: nil)
    lektionen[6-1].quizSetting?.vokalOderHalbvokal        = .init(controlTyp: .VokalOderHalbvokalTyp, modus: .Versteckt, konsonantTypModus: nil)
    lektionen[7-1].quizSetting?.vokalOderHalbvokal        = .init(controlTyp: .VokalOderHalbvokalTyp, modus: .Versteckt, konsonantTypModus: nil)
    lektionen[8-1].quizSetting?.vokalOderHalbvokal        = .init(controlTyp: .VokalOderHalbvokalTyp, modus: .Versteckt, konsonantTypModus: nil)
    lektionen[9-1].quizSetting?.vokalOderHalbvokal        = .init(controlTyp: .VokalOderHalbvokalTyp, modus: .Versteckt, konsonantTypModus: nil)
    lektionen[10-1].quizSetting?.vokalOderHalbvokal       = .init(controlTyp: .VokalOderHalbvokalTyp, modus: .Versteckt, konsonantTypModus: nil)
    lektionen[11-1].quizSetting?.vokalOderHalbvokal       = .init(controlTyp: .VokalOderHalbvokalTyp, modus: .Versteckt, konsonantTypModus: nil)
    lektionen[12-1].quizSetting?.vokalOderHalbvokal       = .init(controlTyp: .VokalOderHalbvokalTyp, modus: .Versteckt, konsonantTypModus: nil)
    lektionen[13-1].quizSetting?.vokalOderHalbvokal       = .init(controlTyp: .VokalOderHalbvokalTyp, modus: .Versteckt, konsonantTypModus: nil)
    lektionen[14-1].quizSetting?.vokalOderHalbvokal       = .init(controlTyp: .VokalOderHalbvokalTyp, modus: .Versteckt, konsonantTypModus: nil)
    lektionen[15-1].quizSetting?.vokalOderHalbvokal       = .init(controlTyp: .VokalOderHalbvokalTyp, modus: .Versteckt, konsonantTypModus: nil)
    lektionen[16-1].quizSetting?.vokalOderHalbvokal       = .init(controlTyp: .VokalOderHalbvokalTyp, modus: .Versteckt, konsonantTypModus: nil)
    lektionen[17-1].quizSetting?.vokalOderHalbvokal       = .init(controlTyp: .VokalOderHalbvokalTyp, modus: .InAbfrage, konsonantTypModus: nil) //nur anzeige?
    lektionen[18-1].quizSetting?.vokalOderHalbvokal       = .init(controlTyp: .VokalOderHalbvokalTyp, modus: .InAbfrage, konsonantTypModus: nil)
    lektionen[19-1].quizSetting?.vokalOderHalbvokal       = .init(controlTyp: .VokalOderHalbvokalTyp, modus: .InAbfrage, konsonantTypModus: nil)
    lektionen[20-1].quizSetting?.vokalOderHalbvokal       = .init(controlTyp: .VokalOderHalbvokalTyp, modus: .InAbfrage, konsonantTypModus: nil)
    lektionen[21-1].quizSetting?.vokalOderHalbvokal    = .init(controlTyp: .VokalOderHalbvokalTyp, modus: .Versteckt, konsonantTypModus: nil)
    lektionen[22-1].quizSetting?.vokalOderHalbvokal    = .init(controlTyp: .VokalOderHalbvokalTyp, modus: .Versteckt, konsonantTypModus: nil)
    lektionen[23-1].quizSetting?.vokalOderHalbvokal    = .init(controlTyp: .VokalOderHalbvokalTyp, modus: .Versteckt, konsonantTypModus: nil)
    lektionen[24-1].quizSetting?.vokalOderHalbvokal    = .init(controlTyp: .VokalOderHalbvokalTyp, modus: .Versteckt, konsonantTypModus: nil)
    lektionen[25-1].quizSetting?.vokalOderHalbvokal    = .init(controlTyp: .VokalOderHalbvokalTyp, modus: .Versteckt, konsonantTypModus: nil)
    
    
    //KonsonantTyp
    lektionen[1-1].quizSetting?.konsonantTyp = .init(controlTyp:.KonsonantTyp, modus: .Versteckt, konsonantTypModus: .Nasal)
    lektionen[2-1].quizSetting?.konsonantTyp = .init(controlTyp:.KonsonantTyp, modus: .Versteckt, konsonantTypModus: .Nasal)
    lektionen[3-1].quizSetting?.konsonantTyp = .init(controlTyp:.KonsonantTyp, modus: .Versteckt, konsonantTypModus: .Nasal)
    lektionen[4-1].quizSetting?.konsonantTyp = .init(controlTyp:.KonsonantTyp, modus: .Versteckt, konsonantTypModus: .Nasal)
    lektionen[5-1].quizSetting?.konsonantTyp = .init(controlTyp:.KonsonantTyp, modus: .Versteckt, konsonantTypModus: .Nasal)
    lektionen[6-1].quizSetting?.konsonantTyp = .init(controlTyp:.KonsonantTyp, modus: .Versteckt, konsonantTypModus: .Nasal)
    lektionen[7-1].quizSetting?.konsonantTyp = .init(controlTyp:.KonsonantTyp, modus: .Versteckt, konsonantTypModus: .Nasal)
    lektionen[8-1].quizSetting?.konsonantTyp = .init(controlTyp:.KonsonantTyp, modus: .Versteckt, konsonantTypModus: .Nasal)
    lektionen[9-1].quizSetting?.konsonantTyp = .init(controlTyp:.KonsonantTyp, modus: .Versteckt, konsonantTypModus: .Nasal)
    lektionen[10-1].quizSetting?.konsonantTyp = .init(controlTyp:.KonsonantTyp, modus: .Versteckt, konsonantTypModus: .Nasal)
    lektionen[11-1].quizSetting?.konsonantTyp = .init(controlTyp:.KonsonantTyp, modus: .Versteckt, konsonantTypModus: .Nasal)
    lektionen[12-1].quizSetting?.konsonantTyp = .init(controlTyp:.KonsonantTyp, modus: .Versteckt, konsonantTypModus: .Nasal)
    lektionen[13-1].quizSetting?.konsonantTyp = .init(controlTyp:.KonsonantTyp, modus: .Versteckt, konsonantTypModus: .Nasal)
    lektionen[14-1].quizSetting?.konsonantTyp = .init(controlTyp:.KonsonantTyp, modus: .Versteckt, konsonantTypModus: .Nasal)
    lektionen[15-1].quizSetting?.konsonantTyp                 = .init(controlTyp:.KonsonantTyp, modus: .NurAnzeige, konsonantTypModus: .Nasal)
    lektionen[16-1].quizSetting?.konsonantTyp                 = .init(controlTyp: .KonsonantTyp, modus: .InAbfrage, konsonantTypModus: .Nasal)
    lektionen[17-1].quizSetting?.konsonantTyp                 = .init(controlTyp: .KonsonantTyp, modus: .InAbfrage, konsonantTypModus: .Nasal)
    lektionen[18-1].quizSetting?.konsonantTyp                 = .init(controlTyp: .KonsonantTyp, modus: .InAbfrage, konsonantTypModus: .Sibilant)
    lektionen[19-1].quizSetting?.konsonantTyp                 = .init(controlTyp: .KonsonantTyp, modus: .InAbfrage, konsonantTypModus: .Hauchlaut)
    lektionen[20-1].quizSetting?.konsonantTyp                 = .init(controlTyp: .KonsonantTyp, modus: .InAbfrage, konsonantTypModus: .Hauchlaut)
    lektionen[21-1].quizSetting?.konsonantTyp = .init(controlTyp:.KonsonantTyp, modus: .Versteckt, konsonantTypModus: .Nasal)
    lektionen[22-1].quizSetting?.konsonantTyp = .init(controlTyp:.KonsonantTyp, modus: .Versteckt, konsonantTypModus: .Nasal)
    lektionen[23-1].quizSetting?.konsonantTyp = .init(controlTyp:.KonsonantTyp, modus: .Versteckt, konsonantTypModus: .Nasal)
    lektionen[24-1].quizSetting?.konsonantTyp = .init(controlTyp:.KonsonantTyp, modus: .Versteckt, konsonantTypModus: .Nasal)
    lektionen[25-1].quizSetting?.konsonantTyp = .init(controlTyp:.KonsonantTyp, modus: .Versteckt, konsonantTypModus: .Nasal)
    
    return lektionen
}
//    lektionen[20-1].quizSetting.anusVisPruefe = true;
//
//    lektionen[21-1].quizSetting.nasalDesAnusvaraPruefe = true;
//
//    lektionen[22-1].quizSetting.ligaturPruefe = true;
//    lektionen[23-1].quizSetting.ligaturPruefe = true;
//    lektionen[24-1].quizSetting.ligaturPruefe = true;
//    lektionen[25-1].quizSetting.ligaturPruefe = true;
//
//    self.alleLektionen = [[NSArray alloc]initWithObjects:lektionen[1],lektionen[2],lektionen[3],lektionen[4],lektionen[5],lektionen[6],lektionen[7],lektionen[8],lektionen[9],lektionen[10],lektionen[11],lektionen[12],lektionen[13],lektionen[14],lektionen[15],lektionen[16], lektionen[17], lektionen[18], lektionen[19],lektionen[20],lektionen[21],lektionen[22],lektionen[23],lektionen[24],lektionen[25],nil];
//    [self erstelleLektionenZeichensatz];
//
//    return self.alleLektionen;
//}

