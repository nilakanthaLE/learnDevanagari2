//
//  ZeichenSatz.swift
//  learnDevanagari2
//
//  Created by Matthias Pochmann on 13.11.17.
//  Copyright © 2017 Matthias Pochmann. All rights reserved.
//

import Foundation
import UIKit
//
//  zeichensatz.m
//  learnDevanagari
//
//  Created by Matthias Pochmann on 15.12.14.
//  Copyright (c) 2014 Matthias Pochmann. All rights reserved.
//

//globals
let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext





func erstelleZeichensatz() -> [Zeichen] {
    //Lektion 1
    let अ = Zeichen()
    अ.devanagari            = "अ"
    अ.umschrift             = "a"
    अ.vokalOderKonsonant    = VokalOderKonsonant.Vokal.rawValue
    अ.vokalOderHalbvokal    = VokalOderHalbvokal.Vokal.rawValue
    अ.grundZeichen          = "अ"
    अ.lektion               = 0
    
    
    let इ = Zeichen()
    इ.ID = 2
    इ.devanagari = "इ"
    इ.umschrift = "i"
    इ.vokalOderKonsonant = VokalOderKonsonant.Vokal.rawValue
    इ.lektion = 0
    इ.vokalOderHalbvokal = VokalOderHalbvokal.Vokal.rawValue
    इ.grundZeichen = "इ"
    
    
    let उ = Zeichen()
    उ.ID = 3
    उ.devanagari = "उ"
    उ.umschrift = "u"
    उ.vokalOderKonsonant = VokalOderKonsonant.Vokal.rawValue
    उ.lektion = 0
    उ.vokalOderHalbvokal = VokalOderHalbvokal.Vokal.rawValue
    उ.grundZeichen = "उ"
    
    
    //Lektion 2
    let क = Zeichen()
    क.ID = 1
    क.devanagari = "क"
    क.umschrift = "ka"
    क.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    क.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    क.artikulation = Artikulation.velar.rawValue
    क.aspiration = Aspiration.NichtAspiriert.rawValue
    क.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    क.lektion = 1
    क.grundZeichen = "क"
    
    let प = Zeichen()
    प.ID = 1
    प.devanagari = "प"
    प.umschrift = "pa"
    प.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    प.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    प.artikulation = Artikulation.labial.rawValue
    प.aspiration = Aspiration.NichtAspiriert.rawValue
    प.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    प.lektion = 1
    प.grundZeichen = "प"
    
    //Lektion 3
    let ए = Zeichen()
    ए.ID = 1
    ए.devanagari = "ए"
    ए.umschrift = "e"
    ए.vokalOderKonsonant = VokalOderKonsonant.Vokal.rawValue
    ए.lektion = 2
    ए.vokalOderHalbvokal = VokalOderHalbvokal.Vokal.rawValue
    ए.grundZeichen = "ए"
    
    let ओ = Zeichen()
    ओ.ID = 1
    ओ.devanagari = "ओ"
    ओ.umschrift = "o"
    ओ.vokalOderKonsonant = VokalOderKonsonant.Vokal.rawValue
    ओ.lektion = 2
    ओ.vokalOderHalbvokal = VokalOderHalbvokal.Vokal.rawValue
    ओ.grundZeichen = "ओ"
    
    //Lektion 4
    let कि = Zeichen()
    कि.ID = 1
    कि.devanagari = "कि"
    कि.umschrift = "ki"
    कि.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    कि.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    कि.artikulation = Artikulation.velar.rawValue
    कि.aspiration = Aspiration.NichtAspiriert.rawValue
    कि.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    कि.lektion = 3
    कि.grundZeichen = "क"
    
    let कु = Zeichen()
    कु.ID = 1
    कु.devanagari = "कु"
    कु.umschrift = "ku"
    कु.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    कु.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    कु.artikulation = Artikulation.velar.rawValue
    कु.aspiration = Aspiration.NichtAspiriert.rawValue
    कु.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    कु.lektion = 3
    कु.grundZeichen = "क"
    
    let के = Zeichen()
    के.ID = 1
    के.devanagari = "के"
    के.umschrift = "ke"
    के.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    के.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    के.artikulation = Artikulation.velar.rawValue
    के.aspiration = Aspiration.NichtAspiriert.rawValue
    के.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    के.lektion = 3
    के.grundZeichen = "क"
    
    let को = Zeichen()
    को.ID = 1
    को.devanagari = "को"
    को.umschrift = "ko"
    को.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    को.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    को.artikulation = Artikulation.velar.rawValue
    को.aspiration = Aspiration.NichtAspiriert.rawValue
    को.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    को.lektion = 3
    को.grundZeichen = "क"
    
    let पि = Zeichen()
    पि.ID = 1
    पि.devanagari = "पि"
    पि.umschrift = "pi"
    पि.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    पि.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    पि.artikulation = Artikulation.labial.rawValue
    पि.aspiration = Aspiration.NichtAspiriert.rawValue
    पि.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    पि.lektion = 3
    पि.grundZeichen = "प"
    
    let पु = Zeichen()
    पु.ID = 1
    पु.devanagari = "पु"
    पु.umschrift = "pu"
    पु.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    पु.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    पु.artikulation = Artikulation.labial.rawValue
    पु.aspiration = Aspiration.NichtAspiriert.rawValue
    पु.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    पु.lektion = 3
    पु.grundZeichen = "प"
    
    let पे = Zeichen()
    पे.ID = 1
    पे.devanagari = "पे"
    पे.umschrift = "pe"
    पे.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    पे.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    पे.artikulation = Artikulation.labial.rawValue
    पे.aspiration = Aspiration.NichtAspiriert.rawValue
    पे.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    पे.lektion = 3
    पे.grundZeichen = "प"
    
    let पो = Zeichen()
    पो.ID = 1
    पो.devanagari = "पो"
    पो.umschrift = "po"
    पो.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    पो.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    पो.artikulation = Artikulation.labial.rawValue
    पो.aspiration = Aspiration.NichtAspiriert.rawValue
    पो.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    पो.lektion = 3
    पो.grundZeichen = "प"
    
    //Lektion 5
    let त = Zeichen()
    त.ID = 1
    त.devanagari = "त"
    त.umschrift = "ta"
    त.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    त.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    त.artikulation = Artikulation.dental.rawValue
    त.aspiration = Aspiration.NichtAspiriert.rawValue
    त.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    त.lektion = 4
    त.grundZeichen = "त"
    
    let च = Zeichen()
    च.ID = 1
    च.devanagari = "च"
    च.umschrift = "ca"
    च.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    च.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    च.artikulation = Artikulation.palatal.rawValue
    च.aspiration = Aspiration.NichtAspiriert.rawValue
    च.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    च.lektion = 4
    च.grundZeichen = "च"
    
    let ति = Zeichen()
    ति.ID = 1
    ति.devanagari = "ति"
    ति.umschrift = "ti"
    ति.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    ति.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    ति.artikulation = Artikulation.dental.rawValue
    ति.aspiration = Aspiration.NichtAspiriert.rawValue
    ति.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    ति.lektion = 4
    ति.grundZeichen = "त"
    
    let तु = Zeichen()
    तु.ID = 1
    तु.devanagari = "तु"
    तु.umschrift = "tu"
    तु.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    तु.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    तु.artikulation = Artikulation.dental.rawValue
    तु.aspiration = Aspiration.NichtAspiriert.rawValue
    तु.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    तु.lektion = 4
    तु.grundZeichen = "त"
    
    let ते = Zeichen()
    ते.ID = 1
    ते.devanagari = "ते"
    ते.umschrift = "te"
    ते.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    ते.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    ते.artikulation = Artikulation.dental.rawValue
    ते.aspiration = Aspiration.NichtAspiriert.rawValue
    ते.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    ते.lektion = 4
    ते.grundZeichen = "त"
    
    let तो = Zeichen()
    तो.ID = 1
    तो.devanagari = "तो"
    तो.umschrift = "to"
    तो.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    तो.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    तो.artikulation = Artikulation.dental.rawValue
    तो.aspiration = Aspiration.NichtAspiriert.rawValue
    तो.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    तो.lektion = 4
    तो.grundZeichen = "त"
    
    let चि = Zeichen()
    चि.ID = 1
    चि.devanagari = "चि"
    चि.umschrift = "ci"
    चि.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    चि.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    चि.artikulation = Artikulation.palatal.rawValue
    चि.aspiration = Aspiration.NichtAspiriert.rawValue
    चि.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    चि.lektion = 4
    चि.grundZeichen = "च"
    
    let चु = Zeichen()
    चु.ID = 1
    चु.devanagari = "चु"
    चु.umschrift = "cu"
    चु.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    चु.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    चु.artikulation = Artikulation.palatal.rawValue
    चु.aspiration = Aspiration.NichtAspiriert.rawValue
    चु.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    चु.lektion = 4
    चु.grundZeichen = "च"
    
    let चे = Zeichen()
    चे.ID = 1
    चे.devanagari = "चे"
    चे.umschrift = "ce"
    चे.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    चे.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    चे.artikulation = Artikulation.palatal.rawValue
    चे.aspiration = Aspiration.NichtAspiriert.rawValue
    चे.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    चे.lektion = 4
    चे.grundZeichen = "च"
    
    let चो = Zeichen()
    चो.ID = 1
    चो.devanagari = "चो"
    चो.umschrift = "co"
    चो.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    चो.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    चो.artikulation = Artikulation.palatal.rawValue
    चो.aspiration = Aspiration.NichtAspiriert.rawValue
    चो.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    चो.lektion = 4
    चो.grundZeichen = "च"
    
    //Lektion 6
    let आ = Zeichen()
    आ.ID = 1
    आ.devanagari = "आ"
    आ.umschrift = "ā"
    आ.vokalOderKonsonant = VokalOderKonsonant.Vokal.rawValue
    आ.lektion = 5
    आ.vokalOderHalbvokal = VokalOderHalbvokal.Vokal.rawValue
    आ.grundZeichen = "अ"
    
    let ई = Zeichen()
    ई.ID = 1
    ई.devanagari = "ई"
    ई.umschrift = "ī"
    ई.vokalOderKonsonant = VokalOderKonsonant.Vokal.rawValue
    ई.lektion = 5
    ई.vokalOderHalbvokal = VokalOderHalbvokal.Vokal.rawValue
    ई.grundZeichen = "इ"
    
    let ऊ = Zeichen()
    ऊ.ID = 1
    ऊ.devanagari = "ऊ"
    ऊ.umschrift = "ū"
    ऊ.vokalOderKonsonant = VokalOderKonsonant.Vokal.rawValue
    ऊ.lektion = 5
    ऊ.vokalOderHalbvokal = VokalOderHalbvokal.Vokal.rawValue
    ऊ.grundZeichen = "उ"
    
    let का = Zeichen()
    का.ID = 1
    का.devanagari = "का"
    का.umschrift = "kā"
    का.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    का.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    का.artikulation = Artikulation.velar.rawValue
    का.aspiration = Aspiration.NichtAspiriert.rawValue
    का.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    का.lektion = 5
    का.grundZeichen = "क"
    
    let की = Zeichen()
    की.ID = 1
    की.devanagari = "की"
    की.umschrift = "kī"
    की.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    की.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    की.artikulation = Artikulation.velar.rawValue
    की.aspiration = Aspiration.NichtAspiriert.rawValue
    की.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    की.lektion = 5
    की.grundZeichen = "क"
    
    let कू = Zeichen()
    कू.ID = 1
    कू.devanagari = "कू"
    कू.umschrift = "kū"
    कू.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    कू.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    कू.artikulation = Artikulation.velar.rawValue
    कू.aspiration = Aspiration.NichtAspiriert.rawValue
    कू.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    कू.lektion = 5
    कू.grundZeichen = "क"
    
    let चा = Zeichen()
    चा.ID = 1
    चा.devanagari = "चा"
    चा.umschrift = "cā"
    चा.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    चा.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    चा.artikulation = Artikulation.palatal.rawValue
    चा.aspiration = Aspiration.NichtAspiriert.rawValue
    चा.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    चा.lektion = 5
    चा.grundZeichen = "च"
    
    let ची = Zeichen()
    ची.ID = 1
    ची.devanagari = "ची"
    ची.umschrift = "cī"
    ची.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    ची.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    ची.artikulation = Artikulation.palatal.rawValue
    ची.aspiration = Aspiration.NichtAspiriert.rawValue
    ची.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    ची.lektion = 5
    ची.grundZeichen = "च"
    
    let चू = Zeichen()
    चू.ID = 1
    चू.devanagari = "चू"
    चू.umschrift = "cū"
    चू.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    चू.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    चू.artikulation = Artikulation.palatal.rawValue
    चू.aspiration = Aspiration.NichtAspiriert.rawValue
    चू.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    चू.lektion = 5
    चू.grundZeichen = "च"
    
    let ता = Zeichen()
    ता.ID = 1
    ता.devanagari = "ता"
    ता.umschrift = "tā"
    ता.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    ता.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    ता.artikulation = Artikulation.dental.rawValue
    ता.aspiration = Aspiration.NichtAspiriert.rawValue
    ता.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    ता.lektion = 5
    ता.grundZeichen = "त"
    
    let ती = Zeichen()
    ती.ID = 1
    ती.devanagari = "ती"
    ती.umschrift = "tī"
    ती.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    ती.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    ती.artikulation = Artikulation.dental.rawValue
    ती.aspiration = Aspiration.NichtAspiriert.rawValue
    ती.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    ती.lektion = 5
    ती.grundZeichen = "त"
    
    let तू = Zeichen()
    तू.ID = 1
    तू.devanagari = "तू"
    तू.umschrift = "tū"
    तू.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    तू.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    तू.artikulation = Artikulation.dental.rawValue
    तू.aspiration = Aspiration.NichtAspiriert.rawValue
    तू.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    तू.lektion = 5
    तू.grundZeichen = "त"
    
    let पा = Zeichen()
    पा.ID = 1
    पा.devanagari = "पा"
    पा.umschrift = "pā"
    पा.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    पा.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    पा.artikulation = Artikulation.labial.rawValue
    पा.aspiration = Aspiration.NichtAspiriert.rawValue
    पा.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    पा.lektion = 5
    पा.grundZeichen = "प"
    
    let पी = Zeichen()
    पी.ID = 1
    पी.devanagari = "पी"
    पी.umschrift = "pī"
    पी.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    पी.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    पी.artikulation = Artikulation.labial.rawValue
    पी.aspiration = Aspiration.NichtAspiriert.rawValue
    पी.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    पी.lektion = 5
    पी.grundZeichen = "प"
    
    let पू = Zeichen()
    पू.ID = 1
    पू.devanagari = "पू"
    पू.umschrift = "pū"
    पू.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    पू.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    पू.artikulation = Artikulation.labial.rawValue
    पू.aspiration = Aspiration.NichtAspiriert.rawValue
    पू.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    पू.lektion = 5
    पू.grundZeichen = "प"
    
    //Lektion 7
    let ट = Zeichen()
    ट.ID = 1
    ट.devanagari = "ट"
    ट.umschrift = "ṭa"
    ट.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    ट.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    ट.artikulation = Artikulation.retroflex.rawValue
    ट.aspiration = Aspiration.NichtAspiriert.rawValue
    ट.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    ट.lektion = 6
    ट.grundZeichen = "ट"
    
    let टि = Zeichen()
    टि.ID = 1
    टि.devanagari = "टि"
    टि.umschrift = "ṭi"
    टि.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    टि.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    टि.artikulation = Artikulation.retroflex.rawValue
    टि.aspiration = Aspiration.NichtAspiriert.rawValue
    टि.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    टि.lektion = 6
    टि.grundZeichen = "ट"
    
    let टु = Zeichen()
    टु.ID = 1
    टु.devanagari = "टु"
    टु.umschrift = "ṭu"
    टु.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    टु.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    टु.artikulation = Artikulation.retroflex.rawValue
    टु.aspiration = Aspiration.NichtAspiriert.rawValue
    टु.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    टु.lektion = 6
    टु.grundZeichen = "ट"
    
    let टे = Zeichen()
    टे.ID = 1
    टे.devanagari = "टे"
    टे.umschrift = "ṭe"
    टे.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    टे.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    टे.artikulation = Artikulation.retroflex.rawValue
    टे.aspiration = Aspiration.NichtAspiriert.rawValue
    टे.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    टे.lektion = 6
    टे.grundZeichen = "ट"
    
    let टो = Zeichen()
    टो.ID = 1
    टो.devanagari = "टो"
    टो.umschrift = "ṭo"
    टो.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    टो.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    टो.artikulation = Artikulation.retroflex.rawValue
    टो.aspiration = Aspiration.NichtAspiriert.rawValue
    टो.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    टो.lektion = 6
    टो.grundZeichen = "ट"
    
    let टा = Zeichen()
    टा.ID = 1
    टा.devanagari = "टा"
    टा.umschrift = "ṭā"
    टा.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    टा.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    टा.artikulation = Artikulation.retroflex.rawValue
    टा.aspiration = Aspiration.NichtAspiriert.rawValue
    टा.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    टा.lektion = 6
    टा.grundZeichen = "ट"
    
    let टी = Zeichen()
    टी.ID = 2
    टी.devanagari = "टी"
    टी.umschrift = "ṭī"
    टी.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    टी.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    टी.artikulation = Artikulation.retroflex.rawValue
    टी.aspiration = Aspiration.NichtAspiriert.rawValue
    टी.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    टी.lektion = 6
    टी.grundZeichen = "ट"
    
    let टू = Zeichen()
    टू.ID = 1
    टू.devanagari = "टू"
    टू.umschrift = "ṭū"
    टू.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    टू.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    टू.artikulation = Artikulation.retroflex.rawValue
    टू.aspiration = Aspiration.NichtAspiriert.rawValue
    टू.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    टू.lektion = 6
    टू.grundZeichen = "ट"
    
    //Lektion 8
    
    let औ = Zeichen()
    औ.ID = 1
    औ.devanagari = "औ"
    औ.umschrift = "au"
    औ.vokalOderKonsonant = VokalOderKonsonant.Vokal.rawValue
    औ.lektion = 7
    औ.vokalOderHalbvokal = VokalOderHalbvokal.Vokal.rawValue
    औ.grundZeichen = "ओ"
    
    let ऐ = Zeichen()
    ऐ.ID = 1
    ऐ.devanagari = "ऐ"
    ऐ.umschrift = "ai"
    ऐ.vokalOderKonsonant = VokalOderKonsonant.Vokal.rawValue
    ऐ.lektion = 7
    ऐ.vokalOderHalbvokal = VokalOderHalbvokal.Vokal.rawValue
    ऐ.grundZeichen = "ए"
    
    let कौ = Zeichen()
    कौ.ID = 1
    कौ.devanagari = "कौ"
    कौ.umschrift = "kau"
    कौ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    कौ.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    कौ.artikulation = Artikulation.velar.rawValue
    कौ.aspiration = Aspiration.NichtAspiriert.rawValue
    कौ.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    कौ.lektion = 7
    कौ.grundZeichen = "क"
    
    let कै = Zeichen()
    कै.ID = 1
    कै.devanagari = "कै"
    कै.umschrift = "kai"
    कै.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    कै.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    कै.artikulation = Artikulation.velar.rawValue
    कै.aspiration = Aspiration.NichtAspiriert.rawValue
    कै.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    कै.lektion = 7
    कै.grundZeichen = "क"
    
    let चौ = Zeichen()
    चौ.ID = 1
    चौ.devanagari = "चौ"
    चौ.umschrift = "cau"
    चौ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    चौ.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    चौ.artikulation = Artikulation.palatal.rawValue
    चौ.aspiration = Aspiration.NichtAspiriert.rawValue
    चौ.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    चौ.lektion = 7
    चौ.grundZeichen = "च"
    
    let चै = Zeichen()
    चै.ID = 1
    चै.devanagari = "चै"
    चै.umschrift = "cai"
    चै.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    चै.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    चै.artikulation = Artikulation.palatal.rawValue
    चै.aspiration = Aspiration.NichtAspiriert.rawValue
    चै.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    चै.lektion = 7
    चै.grundZeichen = "च"
    
    let टौ = Zeichen()
    टौ.ID = 1
    टौ.devanagari = "टौ"
    टौ.umschrift = "ṭau"
    टौ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    टौ.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    टौ.artikulation = Artikulation.retroflex.rawValue
    टौ.aspiration = Aspiration.NichtAspiriert.rawValue
    टौ.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    टौ.lektion = 7
    टौ.grundZeichen = "ट"
    
    let टै = Zeichen()
    टै.ID = 1
    टै.devanagari = "टै"
    टै.umschrift = "ṭai"
    टै.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    टै.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    टै.artikulation = Artikulation.retroflex.rawValue
    टै.aspiration = Aspiration.NichtAspiriert.rawValue
    टै.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    टै.lektion = 7
    टै.grundZeichen = "ट"
    
    let तौ = Zeichen()
    तौ.ID = 1
    तौ.devanagari = "तौ"
    तौ.umschrift = "tau"
    तौ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    तौ.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    तौ.artikulation = Artikulation.dental.rawValue
    तौ.aspiration = Aspiration.NichtAspiriert.rawValue
    तौ.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    तौ.lektion = 7
    तौ.grundZeichen = "त"
    
    let तै = Zeichen()
    तै.ID = 1
    तै.devanagari = "तै"
    तै.umschrift = "tai"
    तै.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    तै.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    तै.artikulation = Artikulation.dental.rawValue
    तै.aspiration = Aspiration.NichtAspiriert.rawValue
    तै.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    तै.lektion = 7
    तै.grundZeichen = "त"
    
    let पौ = Zeichen()
    पौ.ID = 1
    पौ.devanagari = "पौ"
    पौ.umschrift = "pau"
    पौ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    पौ.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    पौ.artikulation = Artikulation.labial.rawValue
    पौ.aspiration = Aspiration.NichtAspiriert.rawValue
    पौ.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    पौ.lektion = 7
    पौ.grundZeichen = "प"
    
    let पै = Zeichen()
    पै.ID = 1
    पै.devanagari = "पै"
    पै.umschrift = "pai"
    पै.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    पै.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    पै.artikulation = Artikulation.labial.rawValue
    पै.aspiration = Aspiration.NichtAspiriert.rawValue
    पै.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    पै.lektion = 7
    पै.grundZeichen = "प"
    
    //Lektion 9
    let ख = Zeichen()
    ख.ID = 1
    ख.devanagari = "ख"
    ख.umschrift = "kha"
    ख.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    ख.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    ख.artikulation = Artikulation.velar.rawValue
    ख.aspiration = Aspiration.Aspiriert.rawValue
    ख.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    ख.lektion = 8
    ख.grundZeichen = "ख"
    
    let छ = Zeichen()
    छ.ID = 1
    छ.devanagari = "छ"
    छ.umschrift = "cha"
    छ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    छ.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    छ.artikulation = Artikulation.palatal.rawValue
    छ.aspiration = Aspiration.Aspiriert.rawValue
    छ.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    छ.lektion = 8
    छ.grundZeichen = "छ"
    
    let ठ = Zeichen()
    ठ.ID = 1
    ठ.devanagari = "ठ"
    ठ.umschrift = "ṭha"
    ठ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    ठ.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    ठ.artikulation = Artikulation.retroflex.rawValue
    ठ.aspiration = Aspiration.Aspiriert.rawValue
    ठ.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    ठ.lektion = 8
    ठ.grundZeichen = "ठ"
    
    let थ = Zeichen()
    थ.ID = 1
    थ.devanagari = "थ"
    थ.umschrift = "tha"
    थ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    थ.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    थ.artikulation = Artikulation.dental.rawValue
    थ.aspiration = Aspiration.Aspiriert.rawValue
    थ.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    थ.lektion = 8
    थ.grundZeichen = "थ"
    
    let फ = Zeichen()
    फ.ID = 1
    फ.devanagari = "फ"
    फ.umschrift = "pha"
    फ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    फ.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    फ.artikulation = Artikulation.labial.rawValue
    फ.aspiration = Aspiration.Aspiriert.rawValue
    फ.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    फ.lektion = 8
    फ.grundZeichen = "फ"
    
    //Lektion 10
    let खि = Zeichen()
    खि.ID = 1
    खि.devanagari = "खि"
    खि.umschrift = "khi"
    खि.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    खि.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    खि.artikulation = Artikulation.velar.rawValue
    खि.aspiration = Aspiration.Aspiriert.rawValue
    खि.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    खि.lektion = 9
    खि.grundZeichen = "ख"
    
    let खु = Zeichen()
    खु.ID = 1
    खु.devanagari = "खु"
    खु.umschrift = "khu"
    खु.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    खु.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    खु.artikulation = Artikulation.velar.rawValue
    खु.aspiration = Aspiration.Aspiriert.rawValue
    खु.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    खु.lektion = 9
    खु.grundZeichen = "ख"
    
    let खे = Zeichen()
    खे.ID = 1
    खे.devanagari = "खे"
    खे.umschrift = "khe"
    खे.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    खे.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    खे.artikulation = Artikulation.velar.rawValue
    खे.aspiration = Aspiration.Aspiriert.rawValue
    खे.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    खे.lektion = 9
    खे.grundZeichen = "ख"
    
    let खो = Zeichen()
    खो.ID = 1
    खो.devanagari = "खो"
    खो.umschrift = "kho"
    खो.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    खो.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    खो.artikulation = Artikulation.velar.rawValue
    खो.aspiration = Aspiration.Aspiriert.rawValue
    खो.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    खो.lektion = 9
    खो.grundZeichen = "ख"
    
    let खा = Zeichen()
    खा.ID = 1
    खा.devanagari = "खा"
    खा.umschrift = "khā"
    खा.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    खा.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    खा.artikulation = Artikulation.velar.rawValue
    खा.aspiration = Aspiration.Aspiriert.rawValue
    खा.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    खा.lektion = 9
    खा.grundZeichen = "ख"
    
    let खी = Zeichen()
    खी.ID = 1
    खी.devanagari = "खी"
    खी.umschrift = "khī"
    खी.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    खी.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    खी.artikulation = Artikulation.velar.rawValue
    खी.aspiration = Aspiration.Aspiriert.rawValue
    खी.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    खी.lektion = 9
    खी.grundZeichen = "ख"
    
    let खू = Zeichen()
    खू.ID = 1
    खू.devanagari = "खू"
    खू.umschrift = "khū"
    खू.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    खू.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    खू.artikulation = Artikulation.velar.rawValue
    खू.aspiration = Aspiration.Aspiriert.rawValue
    खू.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    खू.lektion = 9
    खू.grundZeichen = "ख"
    
    let खौ = Zeichen()
    खौ.ID = 1
    खौ.devanagari = "खौ"
    खौ.umschrift = "khau"
    खौ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    खौ.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    खौ.artikulation = Artikulation.velar.rawValue
    खौ.aspiration = Aspiration.Aspiriert.rawValue
    खौ.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    खौ.lektion = 9
    खौ.grundZeichen = "ख"
    
    let खै = Zeichen()
    खै.ID = 1
    खै.devanagari = "खै"
    खै.umschrift = "khai"
    खै.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    खै.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    खै.artikulation = Artikulation.velar.rawValue
    खै.aspiration = Aspiration.Aspiriert.rawValue
    खै.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    खै.lektion = 9
    खै.grundZeichen = "ख"
    
    let छि = Zeichen()
    छि.ID = 1
    छि.devanagari = "छि"
    छि.umschrift = "chi"
    छि.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    छि.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    छि.artikulation = Artikulation.palatal.rawValue
    छि.aspiration = Aspiration.Aspiriert.rawValue
    छि.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    छि.lektion = 9
    छि.grundZeichen = "छ"
    
    let छु = Zeichen()
    छु.ID = 1
    छु.devanagari = "छु"
    छु.umschrift = "chu"
    छु.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    छु.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    छु.artikulation = Artikulation.palatal.rawValue
    छु.aspiration = Aspiration.Aspiriert.rawValue
    छु.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    छु.lektion = 9
    छु.grundZeichen = "छ"
    
    let छे = Zeichen()
    छे.ID = 1
    छे.devanagari = "छे"
    छे.umschrift = "che"
    छे.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    छे.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    छे.artikulation = Artikulation.palatal.rawValue
    छे.aspiration = Aspiration.Aspiriert.rawValue
    छे.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    छे.lektion = 9
    छे.grundZeichen = "छ"
    
    let छो = Zeichen()
    छो.ID = 1
    छो.devanagari = "छो"
    छो.umschrift = "cho"
    छो.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    छो.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    छो.artikulation = Artikulation.palatal.rawValue
    छो.aspiration = Aspiration.Aspiriert.rawValue
    छो.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    छो.lektion = 9
    छो.grundZeichen = "छ"
    
    let छा = Zeichen()
    छा.ID = 1
    छा.devanagari = "छा"
    छा.umschrift = "chā"
    छा.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    छा.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    छा.artikulation = Artikulation.palatal.rawValue
    छा.aspiration = Aspiration.Aspiriert.rawValue
    छा.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    छा.lektion = 9
    छा.grundZeichen = "छ"
    
    let छी = Zeichen()
    छी.ID = 1
    छी.devanagari = "छी"
    छी.umschrift = "chī"
    छी.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    छी.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    छी.artikulation = Artikulation.palatal.rawValue
    छी.aspiration = Aspiration.Aspiriert.rawValue
    छी.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    छी.lektion = 9
    छी.grundZeichen = "छ"
    
    let छू = Zeichen()
    छू.ID = 1
    छू.devanagari = "छू"
    छू.umschrift = "chū"
    छू.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    छू.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    छू.artikulation = Artikulation.palatal.rawValue
    छू.aspiration = Aspiration.Aspiriert.rawValue
    छू.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    छू.lektion = 9
    छू.grundZeichen = "छ"
    
    let छौ = Zeichen()
    छौ.ID = 1
    छौ.devanagari = "छौ"
    छौ.umschrift = "chau"
    छौ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    छौ.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    छौ.artikulation = Artikulation.palatal.rawValue
    छौ.aspiration = Aspiration.Aspiriert.rawValue
    छौ.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    छौ.lektion = 9
    छौ.grundZeichen = "छ"
    
    let छै = Zeichen()
    छै.ID = 1
    छै.devanagari = "छै"
    छै.umschrift = "chai"
    छै.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    छै.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    छै.artikulation = Artikulation.palatal.rawValue
    छै.aspiration = Aspiration.Aspiriert.rawValue
    छै.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    छै.lektion = 9
    छै.grundZeichen = "छ"
    
    let ठि = Zeichen()
    ठि.ID = 1
    ठि.devanagari = "ठि"
    ठि.umschrift = "ṭhi"
    ठि.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    ठि.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    ठि.artikulation = Artikulation.retroflex.rawValue
    ठि.aspiration = Aspiration.Aspiriert.rawValue
    ठि.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    ठि.lektion = 9
    ठि.grundZeichen = "ठ"
    
    let ठु = Zeichen()
    ठु.ID = 1
    ठु.devanagari = "ठु"
    ठु.umschrift = "ṭhu"
    ठु.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    ठु.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    ठु.artikulation = Artikulation.retroflex.rawValue
    ठु.aspiration = Aspiration.Aspiriert.rawValue
    ठु.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    ठु.lektion = 9
    ठु.grundZeichen = "ठ"
    
    let ठे = Zeichen()
    ठे.ID = 1
    ठे.devanagari = "ठे"
    ठे.umschrift = "ṭhe"
    ठे.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    ठे.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    ठे.artikulation = Artikulation.retroflex.rawValue
    ठे.aspiration = Aspiration.Aspiriert.rawValue
    ठे.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    ठे.lektion = 9
    ठे.grundZeichen = "ठ"
    
    let ठो = Zeichen()
    ठो.ID = 1
    ठो.devanagari = "ठो"
    ठो.umschrift = "ṭho"
    ठो.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    ठो.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    ठो.artikulation = Artikulation.retroflex.rawValue
    ठो.aspiration = Aspiration.Aspiriert.rawValue
    ठो.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    ठो.lektion = 9
    ठो.grundZeichen = "ठ"
    
    let ठा = Zeichen()
    ठा.ID = 1
    ठा.devanagari = "ठा"
    ठा.umschrift = "ṭhā"
    ठा.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    ठा.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    ठा.artikulation = Artikulation.retroflex.rawValue
    ठा.aspiration = Aspiration.Aspiriert.rawValue
    ठा.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    ठा.lektion = 9
    ठा.grundZeichen = "ठ"
    
    let ठी = Zeichen()
    ठी.ID = 1
    ठी.devanagari = "ठी"
    ठी.umschrift = "ṭhī"
    ठी.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    ठी.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    ठी.artikulation = Artikulation.retroflex.rawValue
    ठी.aspiration = Aspiration.Aspiriert.rawValue
    ठी.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    ठी.lektion = 9
    ठी.grundZeichen = "ठ"
    
    let ठू = Zeichen()
    ठू.ID = 1
    ठू.devanagari = "ठू"
    ठू.umschrift = "ṭhū"
    ठू.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    ठू.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    ठू.artikulation = Artikulation.retroflex.rawValue
    ठू.aspiration = Aspiration.Aspiriert.rawValue
    ठू.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    ठू.lektion = 9
    ठू.grundZeichen = "ठ"
    
    let ठौ = Zeichen()
    ठौ.ID = 1
    ठौ.devanagari = "ठौ"
    ठौ.umschrift = "ṭhau"
    ठौ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    ठौ.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    ठौ.artikulation = Artikulation.retroflex.rawValue
    ठौ.aspiration = Aspiration.Aspiriert.rawValue
    ठौ.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    ठौ.lektion = 9
    ठौ.grundZeichen = "ठ"
    
    let ठै = Zeichen()
    ठै.ID = 1
    ठै.devanagari = "ठै"
    ठै.umschrift = "ṭhai"
    ठै.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    ठै.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    ठै.artikulation = Artikulation.retroflex.rawValue
    ठै.aspiration = Aspiration.Aspiriert.rawValue
    ठै.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    ठै.lektion = 9
    ठै.grundZeichen = "ठ"
    
    let थि = Zeichen()
    थि.ID = 1
    थि.devanagari = "थि"
    थि.umschrift = "thi"
    थि.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    थि.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    थि.artikulation = Artikulation.dental.rawValue
    थि.aspiration = Aspiration.Aspiriert.rawValue
    थि.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    थि.lektion = 9
    थि.grundZeichen = "थ"
    
    let थु = Zeichen()
    थु.ID = 1
    थु.devanagari = "थु"
    थु.umschrift = "thu"
    थु.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    थु.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    थु.artikulation = Artikulation.dental.rawValue
    थु.aspiration = Aspiration.Aspiriert.rawValue
    थु.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    थु.lektion = 9
    थु.grundZeichen = "थ"
    
    let थे = Zeichen()
    थे.ID = 1
    थे.devanagari = "थे"
    थे.umschrift = "the"
    थे.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    थे.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    थे.artikulation = Artikulation.dental.rawValue
    थे.aspiration = Aspiration.Aspiriert.rawValue
    थे.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    थे.lektion = 9
    थे.grundZeichen = "थ"
    
    let थो = Zeichen()
    थो.ID = 1
    थो.devanagari = "थो"
    थो.umschrift = "tho"
    थो.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    थो.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    थो.artikulation = Artikulation.dental.rawValue
    थो.aspiration = Aspiration.Aspiriert.rawValue
    थो.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    थो.lektion = 9
    थो.grundZeichen = "थ"
    
    let था = Zeichen()
    था.ID = 2
    था.devanagari = "था"
    था.umschrift = "thā"
    था.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    था.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    था.artikulation = Artikulation.dental.rawValue
    था.aspiration = Aspiration.Aspiriert.rawValue
    था.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    था.lektion = 9
    था.grundZeichen = "थ"
    
    let थी = Zeichen()
    थी.ID = 2
    थी.devanagari = "थी"
    थी.umschrift = "thī"
    थी.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    थी.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    थी.artikulation = Artikulation.dental.rawValue
    थी.aspiration = Aspiration.Aspiriert.rawValue
    थी.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    थी.lektion = 9
    थी.grundZeichen = "थ"
    
    let थू = Zeichen()
    थू.ID = 1
    थू.devanagari = "थू"
    थू.umschrift = "thū"
    थू.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    थू.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    थू.artikulation = Artikulation.dental.rawValue
    थू.aspiration = Aspiration.Aspiriert.rawValue
    थू.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    थू.lektion = 9
    थू.grundZeichen = "थ"
    
    let थौ = Zeichen()
    थौ.ID = 1
    थौ.devanagari = "थौ"
    थौ.umschrift = "thau"
    थौ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    थौ.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    थौ.artikulation = Artikulation.dental.rawValue
    थौ.aspiration = Aspiration.Aspiriert.rawValue
    थौ.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    थौ.lektion = 9
    थौ.grundZeichen = "थ"
    
    let थै = Zeichen()
    थै.ID = 1
    थै.devanagari = "थै"
    थै.umschrift = "thai"
    थै.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    थै.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    थै.artikulation = Artikulation.dental.rawValue
    थै.aspiration = Aspiration.Aspiriert.rawValue
    थै.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    थै.lektion = 9
    थै.grundZeichen = "थ"
    
    let फि = Zeichen()
    फि.ID = 1
    फि.devanagari = "फि"
    फि.umschrift = "phi"
    फि.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    फि.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    फि.artikulation = Artikulation.labial.rawValue
    फि.aspiration = Aspiration.Aspiriert.rawValue
    फि.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    फि.lektion = 9
    फि.grundZeichen = "फ"
    
    let फु = Zeichen()
    फु.ID = 1
    फु.devanagari = "फु"
    फु.umschrift = "phu"
    फु.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    फु.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    फु.artikulation = Artikulation.labial.rawValue
    फु.aspiration = Aspiration.Aspiriert.rawValue
    फु.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    फु.lektion = 9
    फु.grundZeichen = "फ"
    
    let फे = Zeichen()
    फे.ID = 1
    फे.devanagari = "फे"
    फे.umschrift = "phe"
    फे.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    फे.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    फे.artikulation = Artikulation.labial.rawValue
    फे.aspiration = Aspiration.Aspiriert.rawValue
    फे.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    फे.lektion = 9
    फे.grundZeichen = "फ"
    
    let फो = Zeichen()
    फो.ID = 1
    फो.devanagari = "फो"
    फो.umschrift = "pho"
    फो.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    फो.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    फो.artikulation = Artikulation.labial.rawValue
    फो.aspiration = Aspiration.Aspiriert.rawValue
    फो.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    फो.lektion = 9
    फो.grundZeichen = "फ"
    
    let फा = Zeichen()
    फा.ID = 1
    फा.devanagari = "फा"
    फा.umschrift = "phā"
    फा.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    फा.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    फा.artikulation = Artikulation.labial.rawValue
    फा.aspiration = Aspiration.Aspiriert.rawValue
    फा.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    फा.lektion = 9
    फा.grundZeichen = "फ"
    
    let फी = Zeichen()
    फी.ID = 1
    फी.devanagari = "फी"
    फी.umschrift = "phī"
    फी.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    फी.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    फी.artikulation = Artikulation.labial.rawValue
    फी.aspiration = Aspiration.Aspiriert.rawValue
    फी.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    फी.lektion = 9
    फी.grundZeichen = "फ"
    
    let फू = Zeichen()
    फू.ID = 1
    फू.devanagari = "फू"
    फू.umschrift = "phū"
    फू.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    फू.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    फू.artikulation = Artikulation.labial.rawValue
    फू.aspiration = Aspiration.Aspiriert.rawValue
    फू.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    फू.lektion = 9
    फू.grundZeichen = "फ"
    
    let फौ = Zeichen()
    फौ.ID = 1
    फौ.devanagari = "फौ"
    फौ.umschrift = "phau"
    फौ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    फौ.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    फौ.artikulation = Artikulation.labial.rawValue
    फौ.aspiration = Aspiration.Aspiriert.rawValue
    फौ.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    फौ.lektion = 9
    फौ.grundZeichen = "फ"
    
    let फै = Zeichen()
    फै.ID = 1
    फै.devanagari = "फै"
    फै.umschrift = "phai"
    फै.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    फै.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    फै.artikulation = Artikulation.labial.rawValue
    फै.aspiration = Aspiration.Aspiriert.rawValue
    फै.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    फै.lektion = 9
    फै.grundZeichen = "फ"
    
    //Lektion 11
    let ऋ = Zeichen()
    ऋ.ID = 1
    ऋ.devanagari = "ऋ"
    ऋ.umschrift = "ṛ"
    ऋ.vokalOderKonsonant = VokalOderKonsonant.Vokal.rawValue
    ऋ.lektion = 10
    ऋ.vokalOderHalbvokal = VokalOderHalbvokal.Vokal.rawValue
    ऋ.grundZeichen = "ऋ"
    
    let ॠ = Zeichen()
    ॠ.ID = 1
    ॠ.devanagari = "ॠ"
    ॠ.umschrift = "ṝ"
    ॠ.vokalOderKonsonant = VokalOderKonsonant.Vokal.rawValue
    ॠ.lektion = 10
    ॠ.vokalOderHalbvokal = VokalOderHalbvokal.Vokal.rawValue
    ॠ.grundZeichen = "ऋ"
    
    let कृ = Zeichen()
    कृ.ID = 1
    कृ.devanagari = "कृ"
    कृ.umschrift = "kṛ"
    कृ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    कृ.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    कृ.artikulation = Artikulation.velar.rawValue
    कृ.aspiration = Aspiration.NichtAspiriert.rawValue
    कृ.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    कृ.lektion = 10
    कृ.grundZeichen = "क"
    
    let कॄ = Zeichen()
    कॄ.ID = 1
    कॄ.devanagari = "कॄ"
    कॄ.umschrift = "kṝ"
    कॄ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    कॄ.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    कॄ.artikulation = Artikulation.velar.rawValue
    कॄ.aspiration = Aspiration.NichtAspiriert.rawValue
    कॄ.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    कॄ.lektion = 10
    कॄ.grundZeichen = "क"
    
    let चृ = Zeichen()
    चृ.ID = 1
    चृ.devanagari = "चृ"
    चृ.umschrift = "cṛ"
    चृ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    चृ.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    चृ.artikulation = Artikulation.palatal.rawValue
    चृ.aspiration = Aspiration.NichtAspiriert.rawValue
    चृ.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    चृ.lektion = 10
    चृ.grundZeichen = "च"
    
    let चॄ = Zeichen()
    चॄ.ID = 1
    चॄ.devanagari = "चॄ"
    चॄ.umschrift = "cṝ"
    चॄ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    चॄ.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    चॄ.artikulation = Artikulation.palatal.rawValue
    चॄ.aspiration = Aspiration.NichtAspiriert.rawValue
    चॄ.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    चॄ.lektion = 10
    चॄ.grundZeichen = "च"
    
    let टृ = Zeichen()
    टृ.ID = 1
    टृ.devanagari = "टृ"
    टृ.umschrift = "ṭṛ"
    टृ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    टृ.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    टृ.artikulation = Artikulation.retroflex.rawValue
    टृ.aspiration = Aspiration.NichtAspiriert.rawValue
    टृ.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    टृ.lektion = 10
    टृ.grundZeichen = "ट"
    
    let टॄ = Zeichen()
    टॄ.ID = 1
    टॄ.devanagari = "टॄ"
    टॄ.umschrift = "ṭṝ"
    टॄ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    टॄ.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    टॄ.artikulation = Artikulation.retroflex.rawValue
    टॄ.aspiration = Aspiration.NichtAspiriert.rawValue
    टॄ.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    टॄ.lektion = 10
    टॄ.grundZeichen = "ट"
    
    let तृ = Zeichen()
    तृ.ID = 1
    तृ.devanagari = "तृ"
    तृ.umschrift = "tṛ"
    तृ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    तृ.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    तृ.artikulation = Artikulation.dental.rawValue
    तृ.aspiration = Aspiration.NichtAspiriert.rawValue
    तृ.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    तृ.lektion = 10
    तृ.grundZeichen = "त"
    
    let तॄ = Zeichen()
    तॄ.ID = 1
    तॄ.devanagari = "तॄ"
    तॄ.umschrift = "tṝ"
    तॄ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    तॄ.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    तॄ.artikulation = Artikulation.dental.rawValue
    तॄ.aspiration = Aspiration.NichtAspiriert.rawValue
    तॄ.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    तॄ.lektion = 10
    तॄ.grundZeichen = "त"
    
    let खृ = Zeichen()
    खृ.ID = 1
    खृ.devanagari = "खृ"
    खृ.umschrift = "khṛ"
    खृ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    खृ.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    खृ.artikulation = Artikulation.velar.rawValue
    खृ.aspiration = Aspiration.Aspiriert.rawValue
    खृ.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    खृ.lektion = 10
    खृ.grundZeichen = "ख"
    
    let खॄ = Zeichen()
    खॄ.ID = 1
    खॄ.devanagari = "खॄ"
    खॄ.umschrift = "khṝ"
    खॄ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    खॄ.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    खॄ.artikulation = Artikulation.velar.rawValue
    खॄ.aspiration = Aspiration.Aspiriert.rawValue
    खॄ.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    खॄ.lektion = 10
    खॄ.grundZeichen = "ख"
    
    let छृ = Zeichen()
    छृ.ID = 1
    छृ.devanagari = "छृ"
    छृ.umschrift = "chṛ"
    छृ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    छृ.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    छृ.artikulation = Artikulation.palatal.rawValue
    छृ.aspiration = Aspiration.Aspiriert.rawValue
    छृ.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    छृ.lektion = 10
    छृ.grundZeichen = "छ"
    
    let छॄ = Zeichen()
    छॄ.ID = 1
    छॄ.devanagari = "छॄ"
    छॄ.umschrift = "chṝ"
    छॄ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    छॄ.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    छॄ.artikulation = Artikulation.palatal.rawValue
    छॄ.aspiration = Aspiration.Aspiriert.rawValue
    छॄ.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    छॄ.lektion = 10
    छॄ.grundZeichen = "छ"
    
    let ठृ = Zeichen()
    ठृ.ID = 1
    ठृ.devanagari = "ठृ"
    ठृ.umschrift = "ṭhṛ"
    ठृ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    ठृ.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    ठृ.artikulation = Artikulation.retroflex.rawValue
    ठृ.aspiration = Aspiration.Aspiriert.rawValue
    ठृ.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    ठृ.lektion = 10
    ठृ.grundZeichen = "ठ"
    
    let ठॄ = Zeichen()
    ठॄ.ID = 1
    ठॄ.devanagari = "ठॄ"
    ठॄ.umschrift = "ṭhṝ"
    ठॄ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    ठॄ.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    ठॄ.artikulation = Artikulation.retroflex.rawValue
    ठॄ.aspiration = Aspiration.Aspiriert.rawValue
    ठॄ.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    ठॄ.lektion = 10
    ठॄ.grundZeichen = "ठ"
    
    let थृ = Zeichen()
    थृ.ID = 1
    थृ.devanagari = "थृ"
    थृ.umschrift = "thṛ"
    थृ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    थृ.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    थृ.artikulation = Artikulation.dental.rawValue
    थृ.aspiration = Aspiration.Aspiriert.rawValue
    थृ.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    थृ.lektion = 10
    थृ.grundZeichen = "थ"
    
    let थॄ = Zeichen()
    थॄ.ID = 1
    थॄ.devanagari = "थॄ"
    थॄ.umschrift = "thṝ"
    थॄ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    थॄ.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    थॄ.artikulation = Artikulation.dental.rawValue
    थॄ.aspiration = Aspiration.Aspiriert.rawValue
    थॄ.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    थॄ.lektion = 10
    थॄ.grundZeichen = "थ"
    
    let पृ = Zeichen()
    पृ.ID = 1
    पृ.devanagari = "पृ"
    पृ.umschrift = "pṛ"
    पृ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    पृ.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    पृ.artikulation = Artikulation.labial.rawValue
    पृ.aspiration = Aspiration.NichtAspiriert.rawValue
    पृ.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    पृ.lektion = 10
    पृ.grundZeichen = "प"
    
    let पॄ = Zeichen()
    पॄ.ID = 1
    पॄ.devanagari = "पॄ"
    पॄ.umschrift = "pṝ"
    पॄ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    पॄ.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    पॄ.artikulation = Artikulation.labial.rawValue
    पॄ.aspiration = Aspiration.NichtAspiriert.rawValue
    पॄ.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    पॄ.lektion = 10
    पॄ.grundZeichen = "प"
    
    let फृ = Zeichen()
    फृ.ID = 1
    फृ.devanagari = "फृ"
    फृ.umschrift = "phṛ"
    फृ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    फृ.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    फृ.artikulation = Artikulation.labial.rawValue
    फृ.aspiration = Aspiration.Aspiriert.rawValue
    फृ.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    फृ.lektion = 10
    फृ.grundZeichen = "फ"
    
    let फॄ = Zeichen()
    फॄ.ID = 1
    फॄ.devanagari = "फॄ"
    फॄ.umschrift = "phṝ"
    फॄ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    फॄ.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    फॄ.artikulation = Artikulation.labial.rawValue
    फॄ.aspiration = Aspiration.Aspiriert.rawValue
    फॄ.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    फॄ.lektion = 10
    फॄ.grundZeichen = "फ"
    
    //Lektion 12
    
    let ग = Zeichen()
    ग.ID = 1
    ग.devanagari = "ग"
    ग.umschrift = "ga"
    ग.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    ग.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    ग.artikulation = Artikulation.velar.rawValue
    ग.aspiration = Aspiration.NichtAspiriert.rawValue
    ग.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    ग.lektion = 11
    ग.grundZeichen = "ग"
    
    let ज = Zeichen()
    ज.ID = 1
    ज.devanagari = "ज"
    ज.umschrift = "ja"
    ज.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    ज.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    ज.artikulation = Artikulation.palatal.rawValue
    ज.aspiration = Aspiration.NichtAspiriert.rawValue
    ज.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    ज.lektion = 11
    ज.grundZeichen = "ज"
    
    
    
    let ब = Zeichen()
    ब.ID = 1
    ब.devanagari = "ब"
    ब.umschrift = "ba"
    ब.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    ब.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    ब.artikulation = Artikulation.labial.rawValue
    ब.aspiration = Aspiration.NichtAspiriert.rawValue
    ब.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    ब.lektion = 11
    ब.grundZeichen = "ब"
    
    let घ = Zeichen()
    घ.ID = 1
    घ.devanagari = "घ"
    घ.umschrift = "gha"
    घ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    घ.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    घ.artikulation = Artikulation.velar.rawValue
    घ.aspiration = Aspiration.Aspiriert.rawValue
    घ.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    घ.lektion = 11
    घ.grundZeichen = "घ"
    
    let झ = Zeichen()
    झ.ID = 1
    झ.devanagari = "झ"
    झ.umschrift = "jha"
    झ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    झ.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    झ.artikulation = Artikulation.palatal.rawValue
    झ.aspiration = Aspiration.Aspiriert.rawValue
    झ.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    झ.lektion = 11
    झ.grundZeichen = "झ"
    
    
    
    let भ = Zeichen()
    भ.ID = 1
    भ.devanagari = "भ"
    भ.umschrift = "bha"
    भ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    भ.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    भ.artikulation = Artikulation.labial.rawValue
    भ.aspiration = Aspiration.Aspiriert.rawValue
    भ.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    भ.lektion = 11
    भ.grundZeichen = "भ"
    
    //Lektion 13
    
    let गा = Zeichen()
    गा.ID = 1
    गा.devanagari = "गा"
    गा.umschrift = "gā"
    गा.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    गा.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    गा.artikulation = Artikulation.velar.rawValue
    गा.aspiration = Aspiration.NichtAspiriert.rawValue
    गा.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    गा.lektion = 12
    गा.grundZeichen = "ग"
    
    let गि = Zeichen()
    गि.ID = 1
    गि.devanagari = "गि"
    गि.umschrift = "gi"
    गि.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    गि.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    गि.artikulation = Artikulation.velar.rawValue
    गि.aspiration = Aspiration.NichtAspiriert.rawValue
    गि.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    गि.lektion = 12
    गि.grundZeichen = "ग"
    
    let गी = Zeichen()
    गी.ID = 1
    गी.devanagari = "गी"
    गी.umschrift = "gī"
    गी.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    गी.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    गी.artikulation = Artikulation.velar.rawValue
    गी.aspiration = Aspiration.NichtAspiriert.rawValue
    गी.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    गी.lektion = 12
    गी.grundZeichen = "ग"
    
    let गु = Zeichen()
    गु.ID = 1
    गु.devanagari = "गु"
    गु.umschrift = "gu"
    गु.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    गु.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    गु.artikulation = Artikulation.velar.rawValue
    गु.aspiration = Aspiration.NichtAspiriert.rawValue
    गु.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    गु.lektion = 12
    गु.grundZeichen = "ग"
    
    let गू = Zeichen()
    गू.ID = 1
    गू.devanagari = "गू"
    गू.umschrift = "gū"
    गू.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    गू.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    गू.artikulation = Artikulation.velar.rawValue
    गू.aspiration = Aspiration.NichtAspiriert.rawValue
    गू.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    गू.lektion = 12
    गू.grundZeichen = "ग"
    
    let गे = Zeichen()
    गे.ID = 1
    गे.devanagari = "गे"
    गे.umschrift = "ge"
    गे.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    गे.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    गे.artikulation = Artikulation.velar.rawValue
    गे.aspiration = Aspiration.NichtAspiriert.rawValue
    गे.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    गे.lektion = 12
    गे.grundZeichen = "ग"
    
    let गै = Zeichen()
    गै.ID = 1
    गै.devanagari = "गै"
    गै.umschrift = "gai"
    गै.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    गै.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    गै.artikulation = Artikulation.velar.rawValue
    गै.aspiration = Aspiration.NichtAspiriert.rawValue
    गै.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    गै.lektion = 12
    गै.grundZeichen = "ग"
    
    let गो = Zeichen()
    गो.ID = 1
    गो.devanagari = "गो"
    गो.umschrift = "go"
    गो.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    गो.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    गो.artikulation = Artikulation.velar.rawValue
    गो.aspiration = Aspiration.NichtAspiriert.rawValue
    गो.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    गो.lektion = 12
    गो.grundZeichen = "ग"
    
    let गौ = Zeichen()
    गौ.ID = 1
    गौ.devanagari = "गौ"
    गौ.umschrift = "gau"
    गौ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    गौ.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    गौ.artikulation = Artikulation.velar.rawValue
    गौ.aspiration = Aspiration.NichtAspiriert.rawValue
    गौ.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    गौ.lektion = 12
    गौ.grundZeichen = "ग"
    
    let जा = Zeichen()
    जा.ID = 1
    जा.devanagari = "जा"
    जा.umschrift = "jā"
    जा.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    जा.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    जा.artikulation = Artikulation.palatal.rawValue
    जा.aspiration = Aspiration.NichtAspiriert.rawValue
    जा.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    जा.lektion = 12
    जा.grundZeichen = "ज"
    
    let जि = Zeichen()
    जि.ID = 1
    जि.devanagari = "जि"
    जि.umschrift = "ji"
    जि.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    जि.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    जि.artikulation = Artikulation.palatal.rawValue
    जि.aspiration = Aspiration.NichtAspiriert.rawValue
    जि.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    जि.lektion = 12
    जि.grundZeichen = "ज"
    
    let जी = Zeichen()
    जी.ID = 1
    जी.devanagari = "जी"
    जी.umschrift = "jī"
    जी.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    जी.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    जी.artikulation = Artikulation.palatal.rawValue
    जी.aspiration = Aspiration.NichtAspiriert.rawValue
    जी.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    जी.lektion = 12
    जी.grundZeichen = "ज"
    
    let जु = Zeichen()
    जु.ID = 1
    जु.devanagari = "जु"
    जु.umschrift = "ju"
    जु.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    जु.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    जु.artikulation = Artikulation.palatal.rawValue
    जु.aspiration = Aspiration.NichtAspiriert.rawValue
    जु.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    जु.lektion = 12
    जु.grundZeichen = "ज"
    
    let जू = Zeichen()
    जू.ID = 1
    जू.devanagari = "जू"
    जू.umschrift = "jū"
    जू.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    जू.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    जू.artikulation = Artikulation.palatal.rawValue
    जू.aspiration = Aspiration.NichtAspiriert.rawValue
    जू.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    जू.lektion = 12
    जू.grundZeichen = "ज"
    
    let जे = Zeichen()
    जे.ID = 1
    जे.devanagari = "जे"
    जे.umschrift = "je"
    जे.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    जे.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    जे.artikulation = Artikulation.palatal.rawValue
    जे.aspiration = Aspiration.NichtAspiriert.rawValue
    जे.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    जे.lektion = 12
    जे.grundZeichen = "ज"
    
    let जै = Zeichen()
    जै.ID = 1
    जै.devanagari = "जै"
    जै.umschrift = "jai"
    जै.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    जै.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    जै.artikulation = Artikulation.palatal.rawValue
    जै.aspiration = Aspiration.NichtAspiriert.rawValue
    जै.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    जै.lektion = 12
    जै.grundZeichen = "ज"
    
    let जो = Zeichen()
    जो.ID = 1
    जो.devanagari = "जो"
    जो.umschrift = "jo"
    जो.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    जो.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    जो.artikulation = Artikulation.palatal.rawValue
    जो.aspiration = Aspiration.NichtAspiriert.rawValue
    जो.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    जो.lektion = 12
    जो.grundZeichen = "ज"
    
    let जौ = Zeichen()
    जौ.ID = 1
    जौ.devanagari = "जौ"
    जौ.umschrift = "jau"
    जौ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    जौ.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    जौ.artikulation = Artikulation.palatal.rawValue
    जौ.aspiration = Aspiration.NichtAspiriert.rawValue
    जौ.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    जौ.lektion = 12
    जौ.grundZeichen = "ज"
    
    let बा = Zeichen()
    बा.ID = 1
    बा.devanagari = "बा"
    बा.umschrift = "bā"
    बा.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    बा.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    बा.artikulation = Artikulation.labial.rawValue
    बा.aspiration = Aspiration.NichtAspiriert.rawValue
    बा.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    बा.lektion = 12
    बा.grundZeichen = "ब"
    
    let बि = Zeichen()
    बि.ID = 1
    बि.devanagari = "बि"
    बि.umschrift = "bi"
    बि.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    बि.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    बि.artikulation = Artikulation.labial.rawValue
    बि.aspiration = Aspiration.NichtAspiriert.rawValue
    बि.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    बि.lektion = 12
    बि.grundZeichen = "ब"
    
    let बी = Zeichen()
    बी.ID = 1
    बी.devanagari = "बी"
    बी.umschrift = "bī"
    बी.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    बी.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    बी.artikulation = Artikulation.labial.rawValue
    बी.aspiration = Aspiration.NichtAspiriert.rawValue
    बी.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    बी.lektion = 12
    बी.grundZeichen = "ब"
    
    let बु = Zeichen()
    बु.ID = 1
    बु.devanagari = "बु"
    बु.umschrift = "bu"
    बु.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    बु.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    बु.artikulation = Artikulation.labial.rawValue
    बु.aspiration = Aspiration.NichtAspiriert.rawValue
    बु.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    बु.lektion = 12
    बु.grundZeichen = "ब"
    
    let बू = Zeichen()
    बू.ID = 1
    बू.devanagari = "बू"
    बू.umschrift = "bū"
    बू.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    बू.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    बू.artikulation = Artikulation.labial.rawValue
    बू.aspiration = Aspiration.NichtAspiriert.rawValue
    बू.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    बू.lektion = 12
    बू.grundZeichen = "ब"
    
    let बे = Zeichen()
    बे.ID = 1
    बे.devanagari = "बे"
    बे.umschrift = "be"
    बे.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    बे.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    बे.artikulation = Artikulation.labial.rawValue
    बे.aspiration = Aspiration.NichtAspiriert.rawValue
    बे.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    बे.lektion = 12
    बे.grundZeichen = "ब"
    
    let बै = Zeichen()
    बै.ID = 1
    बै.devanagari = "बै"
    बै.umschrift = "bai"
    बै.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    बै.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    बै.artikulation = Artikulation.labial.rawValue
    बै.aspiration = Aspiration.NichtAspiriert.rawValue
    बै.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    बै.lektion = 12
    बै.grundZeichen = "ब"
    
    let बो = Zeichen()
    बो.ID = 1
    बो.devanagari = "बो"
    बो.umschrift = "bo"
    बो.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    बो.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    बो.artikulation = Artikulation.labial.rawValue
    बो.aspiration = Aspiration.NichtAspiriert.rawValue
    बो.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    बो.lektion = 12
    बो.grundZeichen = "ब"
    
    let बौ = Zeichen()
    बौ.ID = 1
    बौ.devanagari = "बौ"
    बौ.umschrift = "bau"
    बौ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    बौ.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    बौ.artikulation = Artikulation.labial.rawValue
    बौ.aspiration = Aspiration.NichtAspiriert.rawValue
    बौ.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    बौ.lektion = 12
    बौ.grundZeichen = "ब"
    
    let घा = Zeichen()
    घा.ID = 1
    घा.devanagari = "घा"
    घा.umschrift = "ghā"
    घा.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    घा.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    घा.artikulation = Artikulation.velar.rawValue
    घा.aspiration = Aspiration.Aspiriert.rawValue
    घा.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    घा.lektion = 12
    घा.grundZeichen = "घ"
    
    let घि = Zeichen()
    घि.ID = 1
    घि.devanagari = "घि"
    घि.umschrift = "ghi"
    घि.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    घि.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    घि.artikulation = Artikulation.velar.rawValue
    घि.aspiration = Aspiration.Aspiriert.rawValue
    घि.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    घि.lektion = 12
    घि.grundZeichen = "घ"
    
    let घी = Zeichen()
    घी.ID = 1
    घी.devanagari = "घी"
    घी.umschrift = "ghī"
    घी.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    घी.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    घी.artikulation = Artikulation.velar.rawValue
    घी.aspiration = Aspiration.Aspiriert.rawValue
    घी.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    घी.lektion = 12
    घी.grundZeichen = "घ"
    
    let घु = Zeichen()
    घु.ID = 1
    घु.devanagari = "घु"
    घु.umschrift = "ghu"
    घु.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    घु.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    घु.artikulation = Artikulation.velar.rawValue
    घु.aspiration = Aspiration.Aspiriert.rawValue
    घु.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    घु.lektion = 12
    घु.grundZeichen = "घ"
    
    let घू = Zeichen()
    घू.ID = 1
    घू.devanagari = "घू"
    घू.umschrift = "ghū"
    घू.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    घू.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    घू.artikulation = Artikulation.velar.rawValue
    घू.aspiration = Aspiration.Aspiriert.rawValue
    घू.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    घू.lektion = 12
    घू.grundZeichen = "घ"
    
    let घे = Zeichen()
    घे.ID = 1
    घे.devanagari = "घे"
    घे.umschrift = "ghe"
    घे.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    घे.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    घे.artikulation = Artikulation.velar.rawValue
    घे.aspiration = Aspiration.Aspiriert.rawValue
    घे.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    घे.lektion = 12
    घे.grundZeichen = "घ"
    
    let घै = Zeichen()
    घै.ID = 1
    घै.devanagari = "घै"
    घै.umschrift = "ghai"
    घै.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    घै.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    घै.artikulation = Artikulation.velar.rawValue
    घै.aspiration = Aspiration.Aspiriert.rawValue
    घै.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    घै.lektion = 12
    घै.grundZeichen = "घ"
    
    let घो = Zeichen()
    घो.ID = 1
    घो.devanagari = "घो"
    घो.umschrift = "gho"
    घो.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    घो.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    घो.artikulation = Artikulation.velar.rawValue
    घो.aspiration = Aspiration.Aspiriert.rawValue
    घो.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    घो.lektion = 12
    घो.grundZeichen = "घ"
    
    let घौ = Zeichen()
    घौ.ID = 1
    घौ.devanagari = "घौ"
    घौ.umschrift = "ghau"
    घौ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    घौ.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    घौ.artikulation = Artikulation.velar.rawValue
    घौ.aspiration = Aspiration.Aspiriert.rawValue
    घौ.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    घौ.lektion = 12
    घौ.grundZeichen = "घ"
    
    let झा = Zeichen()
    झा.ID = 1
    झा.devanagari = "झा"
    झा.umschrift = "jhā"
    झा.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    झा.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    झा.artikulation = Artikulation.palatal.rawValue
    झा.aspiration = Aspiration.Aspiriert.rawValue
    झा.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    झा.lektion = 12
    झा.grundZeichen = "झ"
    
    let झि = Zeichen()
    झि.ID = 1
    झि.devanagari = "झि"
    झि.umschrift = "jhi"
    झि.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    झि.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    झि.artikulation = Artikulation.palatal.rawValue
    झि.aspiration = Aspiration.Aspiriert.rawValue
    झि.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    झि.lektion = 12
    झि.grundZeichen = "झ"
    
    let झी = Zeichen()
    झी.ID = 1
    झी.devanagari = "झी"
    झी.umschrift = "jhī"
    झी.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    झी.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    झी.artikulation = Artikulation.palatal.rawValue
    झी.aspiration = Aspiration.Aspiriert.rawValue
    झी.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    झी.lektion = 12
    झी.grundZeichen = "झ"
    
    let झु = Zeichen()
    झु.ID = 1
    झु.devanagari = "झु"
    झु.umschrift = "jhu"
    झु.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    झु.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    झु.artikulation = Artikulation.palatal.rawValue
    झु.aspiration = Aspiration.Aspiriert.rawValue
    झु.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    झु.lektion = 12
    झु.grundZeichen = "झ"
    
    let झू = Zeichen()
    झू.ID = 1
    झू.devanagari = "झू"
    झू.umschrift = "jhū"
    झू.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    झू.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    झू.artikulation = Artikulation.palatal.rawValue
    झू.aspiration = Aspiration.Aspiriert.rawValue
    झू.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    झू.lektion = 12
    झू.grundZeichen = "झ"
    
    let झे = Zeichen()
    झे.ID = 1
    झे.devanagari = "झे"
    झे.umschrift = "jhe"
    झे.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    झे.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    झे.artikulation = Artikulation.palatal.rawValue
    झे.aspiration = Aspiration.Aspiriert.rawValue
    झे.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    झे.lektion = 12
    झे.grundZeichen = "झ"
    
    let झै = Zeichen()
    झै.ID = 1
    झै.devanagari = "झै"
    झै.umschrift = "jhai"
    झै.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    झै.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    झै.artikulation = Artikulation.palatal.rawValue
    झै.aspiration = Aspiration.Aspiriert.rawValue
    झै.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    झै.lektion = 12
    झै.grundZeichen = "झ"
    
    let झो = Zeichen()
    झो.ID = 1
    झो.devanagari = "झो"
    झो.umschrift = "jho"
    झो.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    झो.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    झो.artikulation = Artikulation.palatal.rawValue
    झो.aspiration = Aspiration.Aspiriert.rawValue
    झो.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    झो.lektion = 12
    झो.grundZeichen = "झ"
    
    let झौ = Zeichen()
    झौ.ID = 1
    झौ.devanagari = "झौ"
    झौ.umschrift = "jhau"
    झौ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    झौ.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    झौ.artikulation = Artikulation.palatal.rawValue
    झौ.aspiration = Aspiration.Aspiriert.rawValue
    झौ.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    झौ.lektion = 12
    झौ.grundZeichen = "झ"
    
    let भा = Zeichen()
    भा.ID = 1
    भा.devanagari = "भा"
    भा.umschrift = "bhā"
    भा.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    भा.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    भा.artikulation = Artikulation.labial.rawValue
    भा.aspiration = Aspiration.Aspiriert.rawValue
    भा.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    भा.lektion = 12
    भा.grundZeichen = "भ"
    
    let भि = Zeichen()
    भि.ID = 1
    भि.devanagari = "भि"
    भि.umschrift = "bhi"
    भि.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    भि.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    भि.artikulation = Artikulation.labial.rawValue
    भि.aspiration = Aspiration.Aspiriert.rawValue
    भि.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    भि.lektion = 12
    भि.grundZeichen = "भ"
    
    let भी = Zeichen()
    भी.ID = 1
    भी.devanagari = "भी"
    भी.umschrift = "bhī"
    भी.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    भी.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    भी.artikulation = Artikulation.labial.rawValue
    भी.aspiration = Aspiration.Aspiriert.rawValue
    भी.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    भी.lektion = 12
    भी.grundZeichen = "भ"
    
    let भु = Zeichen()
    भु.ID = 1
    भु.devanagari = "भु"
    भु.umschrift = "bhu"
    भु.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    भु.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    भु.artikulation = Artikulation.labial.rawValue
    भु.aspiration = Aspiration.Aspiriert.rawValue
    भु.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    भु.lektion = 12
    भु.grundZeichen = "भ"
    
    let भू = Zeichen()
    भू.ID = 1
    भू.devanagari = "भू"
    भू.umschrift = "bhū"
    भू.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    भू.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    भू.artikulation = Artikulation.labial.rawValue
    भू.aspiration = Aspiration.Aspiriert.rawValue
    भू.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    भू.lektion = 12
    भू.grundZeichen = "भ"
    
    let भे = Zeichen()
    भे.ID = 1
    भे.devanagari = "भे"
    भे.umschrift = "bhe"
    भे.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    भे.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    भे.artikulation = Artikulation.labial.rawValue
    भे.aspiration = Aspiration.Aspiriert.rawValue
    भे.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    भे.lektion = 12
    भे.grundZeichen = "भ"
    
    let भै = Zeichen()
    भै.ID = 1
    भै.devanagari = "भै"
    भै.umschrift = "bhai"
    भै.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    भै.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    भै.artikulation = Artikulation.labial.rawValue
    भै.aspiration = Aspiration.Aspiriert.rawValue
    भै.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    भै.lektion = 12
    भै.grundZeichen = "भ"
    
    let भो = Zeichen()
    भो.ID = 1
    भो.devanagari = "भो"
    भो.umschrift = "bho"
    भो.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    भो.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    भो.artikulation = Artikulation.labial.rawValue
    भो.aspiration = Aspiration.Aspiriert.rawValue
    भो.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    भो.lektion = 12
    भो.grundZeichen = "भ"
    
    let भौ = Zeichen()
    भौ.ID = 1
    भौ.devanagari = "भौ"
    भौ.umschrift = "bhau"
    भौ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    भौ.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    भौ.artikulation = Artikulation.labial.rawValue
    भौ.aspiration = Aspiration.Aspiriert.rawValue
    भौ.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    भौ.lektion = 12
    भौ.grundZeichen = "भ"
    
    
    let गृ = Zeichen()
    गृ.ID = 1
    गृ.devanagari = "गृ"
    गृ.umschrift = "gṛ"
    गृ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    गृ.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    गृ.artikulation = Artikulation.velar.rawValue
    गृ.aspiration = Aspiration.NichtAspiriert.rawValue
    गृ.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    गृ.lektion = 12
    गृ.grundZeichen = "ग"
    
    let जृ = Zeichen()
    जृ.ID = 1
    जृ.devanagari = "जृ"
    जृ.umschrift = "jṛ"
    जृ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    जृ.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    जृ.artikulation = Artikulation.palatal.rawValue
    जृ.aspiration = Aspiration.NichtAspiriert.rawValue
    जृ.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    जृ.lektion = 12
    जृ.grundZeichen = "ज"
    
    
    
    let बृ = Zeichen()
    बृ.ID = 1
    बृ.devanagari = "बृ"
    बृ.umschrift = "bṛ"
    बृ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    बृ.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    बृ.artikulation = Artikulation.labial.rawValue
    बृ.aspiration = Aspiration.NichtAspiriert.rawValue
    बृ.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    बृ.lektion = 12
    बृ.grundZeichen = "ब"
    
    
    let घृ = Zeichen()
    घृ.ID = 1
    घृ.devanagari = "घृ"
    घृ.umschrift = "ghṛ"
    घृ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    घृ.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    घृ.artikulation = Artikulation.velar.rawValue
    घृ.aspiration = Aspiration.Aspiriert.rawValue
    घृ.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    घृ.lektion = 12
    घृ.grundZeichen = "घ"
    
    let झृ = Zeichen()
    झृ.ID = 1
    झृ.devanagari = "झृ"
    झृ.umschrift = "jhṛ"
    झृ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    झृ.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    झृ.artikulation = Artikulation.palatal.rawValue
    झृ.aspiration = Aspiration.Aspiriert.rawValue
    झृ.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    झृ.lektion = 12
    झृ.grundZeichen = "झ"
    
    let भृ = Zeichen()
    भृ.ID = 1
    भृ.devanagari = "भृ"
    भृ.umschrift = "bhṛ"
    भृ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    भृ.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    भृ.artikulation = Artikulation.labial.rawValue
    भृ.aspiration = Aspiration.Aspiriert.rawValue
    भृ.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    भृ.lektion = 12
    भृ.grundZeichen = "भ"
    
    let गॄ = Zeichen()
    गॄ.ID = 1
    गॄ.devanagari = "गॄ"
    गॄ.umschrift = "gṝ"
    गॄ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    गॄ.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    गॄ.artikulation = Artikulation.velar.rawValue
    गॄ.aspiration = Aspiration.NichtAspiriert.rawValue
    गॄ.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    गॄ.lektion = 12
    गॄ.grundZeichen = "ग"
    
    let जॄ = Zeichen()
    जॄ.ID = 1
    जॄ.devanagari = "जॄ"
    जॄ.umschrift = "jṝ"
    जॄ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    जॄ.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    जॄ.artikulation = Artikulation.palatal.rawValue
    जॄ.aspiration = Aspiration.NichtAspiriert.rawValue
    जॄ.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    जॄ.lektion = 12
    जॄ.grundZeichen = "ज"
    
    
    
    let बॄ = Zeichen()
    बॄ.ID = 1
    बॄ.devanagari = "बॄ"
    बॄ.umschrift = "bṝ"
    बॄ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    बॄ.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    बॄ.artikulation = Artikulation.labial.rawValue
    बॄ.aspiration = Aspiration.NichtAspiriert.rawValue
    बॄ.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    बॄ.lektion = 12
    बॄ.grundZeichen = "ब"
    
    let घॄ = Zeichen()
    घॄ.ID = 1
    घॄ.devanagari = "घॄ"
    घॄ.umschrift = "ghṝ"
    घॄ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    घॄ.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    घॄ.artikulation = Artikulation.velar.rawValue
    घॄ.aspiration = Aspiration.Aspiriert.rawValue
    घॄ.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    घॄ.lektion = 12
    घॄ.grundZeichen = "घ"
    
    let झॄ = Zeichen()
    झॄ.ID = 1
    झॄ.devanagari = "झॄ"
    झॄ.umschrift = "jhṝ"
    झॄ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    झॄ.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    झॄ.artikulation = Artikulation.palatal.rawValue
    झॄ.aspiration = Aspiration.Aspiriert.rawValue
    झॄ.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    झॄ.lektion = 12
    झॄ.grundZeichen = "झ"
    
    let भॄ = Zeichen()
    भॄ.ID = 1
    भॄ.devanagari = "भॄ"
    भॄ.umschrift = "bhṝ"
    भॄ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    भॄ.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    भॄ.artikulation = Artikulation.labial.rawValue
    भॄ.aspiration = Aspiration.Aspiriert.rawValue
    भॄ.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    भॄ.lektion = 12
    भॄ.grundZeichen = "भ"
    
    
    
    //nächste Lektion
    
    let ड = Zeichen()
    ड.ID = 1
    ड.devanagari = "ड"
    ड.umschrift = "ḍa"
    ड.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    ड.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    ड.artikulation = Artikulation.retroflex.rawValue
    ड.aspiration = Aspiration.NichtAspiriert.rawValue
    ड.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    ड.lektion = 13
    ड.grundZeichen = "ड"
    
    let ढ = Zeichen()
    ढ.ID = 1
    ढ.devanagari = "ढ"
    ढ.umschrift = "ḍha"
    ढ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    ढ.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    ढ.artikulation = Artikulation.retroflex.rawValue
    ढ.aspiration = Aspiration.Aspiriert.rawValue
    ढ.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    ढ.lektion = 13
    ढ.grundZeichen = "ढ"
    
    let ध = Zeichen()
    ध.ID = 1
    ध.devanagari = "ध"
    ध.umschrift = "dha"
    ध.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    ध.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    ध.artikulation = Artikulation.dental.rawValue
    ध.aspiration = Aspiration.Aspiriert.rawValue
    ध.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    ध.lektion = 13
    ध.grundZeichen = "ध"
    
    let द = Zeichen()
    द.ID = 1
    द.devanagari = "द"
    द.umschrift = "da"
    द.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    द.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    द.artikulation = Artikulation.dental.rawValue
    द.aspiration = Aspiration.NichtAspiriert.rawValue
    द.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    द.lektion = 13
    द.grundZeichen = "द"
    
    let डा = Zeichen()
    डा.ID = 1
    डा.devanagari = "डा"
    डा.umschrift = "ḍā"
    डा.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    डा.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    डा.artikulation = Artikulation.retroflex.rawValue
    डा.aspiration = Aspiration.NichtAspiriert.rawValue
    डा.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    डा.lektion = 13
    डा.grundZeichen = "ड"
    
    let डि = Zeichen()
    डि.ID = 1
    डि.devanagari = "डि"
    डि.umschrift = "ḍi"
    डि.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    डि.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    डि.artikulation = Artikulation.retroflex.rawValue
    डि.aspiration = Aspiration.NichtAspiriert.rawValue
    डि.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    डि.lektion = 13
    डि.grundZeichen = "ड"
    
    let डी = Zeichen()
    डी.ID = 1
    डी.devanagari = "डी"
    डी.umschrift = "ḍī"
    डी.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    डी.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    डी.artikulation = Artikulation.retroflex.rawValue
    डी.aspiration = Aspiration.NichtAspiriert.rawValue
    डी.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    डी.lektion = 13
    डी.grundZeichen = "ड"
    
    let डु = Zeichen()
    डु.ID = 1
    डु.devanagari = "डु"
    डु.umschrift = "ḍu"
    डु.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    डु.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    डु.artikulation = Artikulation.retroflex.rawValue
    डु.aspiration = Aspiration.NichtAspiriert.rawValue
    डु.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    डु.lektion = 13
    डु.grundZeichen = "ड"
    
    let डू = Zeichen()
    डू.ID = 1
    डू.devanagari = "डू"
    डू.umschrift = "ḍū"
    डू.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    डू.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    डू.artikulation = Artikulation.retroflex.rawValue
    डू.aspiration = Aspiration.NichtAspiriert.rawValue
    डू.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    डू.lektion = 13
    डू.grundZeichen = "ड"
    
    let डे = Zeichen()
    डे.ID = 1
    डे.devanagari = "डे"
    डे.umschrift = "ḍe"
    डे.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    डे.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    डे.artikulation = Artikulation.retroflex.rawValue
    डे.aspiration = Aspiration.NichtAspiriert.rawValue
    डे.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    डे.lektion = 13
    डे.grundZeichen = "ड"
    
    let डै = Zeichen()
    डै.ID = 1
    डै.devanagari = "डै"
    डै.umschrift = "ḍai"
    डै.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    डै.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    डै.artikulation = Artikulation.retroflex.rawValue
    डै.aspiration = Aspiration.NichtAspiriert.rawValue
    डै.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    डै.lektion = 13
    डै.grundZeichen = "ड"
    
    let डो = Zeichen()
    डो.ID = 1
    डो.devanagari = "डो"
    डो.umschrift = "ḍo"
    डो.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    डो.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    डो.artikulation = Artikulation.retroflex.rawValue
    डो.aspiration = Aspiration.NichtAspiriert.rawValue
    डो.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    डो.lektion = 13
    डो.grundZeichen = "ड"
    
    let डौ = Zeichen()
    डौ.ID = 1
    डौ.devanagari = "डौ"
    डौ.umschrift = "ḍau"
    डौ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    डौ.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    डौ.artikulation = Artikulation.retroflex.rawValue
    डौ.aspiration = Aspiration.NichtAspiriert.rawValue
    डौ.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    डौ.lektion = 13
    डौ.grundZeichen = "ड"
    
    let दा = Zeichen()
    दा.ID = 1
    दा.devanagari = "दा"
    दा.umschrift = "dā"
    दा.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    दा.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    दा.artikulation = Artikulation.dental.rawValue
    दा.aspiration = Aspiration.NichtAspiriert.rawValue
    दा.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    दा.lektion = 13
    दा.grundZeichen = "द"
    
    let दि = Zeichen()
    दि.ID = 1
    दि.devanagari = "दि"
    दि.umschrift = "di"
    दि.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    दि.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    दि.artikulation = Artikulation.dental.rawValue
    दि.aspiration = Aspiration.NichtAspiriert.rawValue
    दि.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    दि.lektion = 13
    दि.grundZeichen = "द"
    
    let दी = Zeichen()
    दी.ID = 1
    दी.devanagari = "दी"
    दी.umschrift = "dī"
    दी.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    दी.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    दी.artikulation = Artikulation.dental.rawValue
    दी.aspiration = Aspiration.NichtAspiriert.rawValue
    दी.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    दी.lektion = 13
    दी.grundZeichen = "द"
    
    let दु = Zeichen()
    दु.ID = 1
    दु.devanagari = "दु"
    दु.umschrift = "du"
    दु.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    दु.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    दु.artikulation = Artikulation.dental.rawValue
    दु.aspiration = Aspiration.NichtAspiriert.rawValue
    दु.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    दु.lektion = 13
    दु.grundZeichen = "द"
    
    let दू = Zeichen()
    दू.ID = 1
    दू.devanagari = "दू"
    दू.umschrift = "dū"
    दू.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    दू.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    दू.artikulation = Artikulation.dental.rawValue
    दू.aspiration = Aspiration.NichtAspiriert.rawValue
    दू.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    दू.lektion = 13
    दू.grundZeichen = "द"
    
    let दे = Zeichen()
    दे.ID = 1
    दे.devanagari = "दे"
    दे.umschrift = "de"
    दे.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    दे.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    दे.artikulation = Artikulation.dental.rawValue
    दे.aspiration = Aspiration.NichtAspiriert.rawValue
    दे.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    दे.lektion = 13
    दे.grundZeichen = "द"
    
    let दै = Zeichen()
    दै.ID = 1
    दै.devanagari = "दै"
    दै.umschrift = "dai"
    दै.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    दै.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    दै.artikulation = Artikulation.dental.rawValue
    दै.aspiration = Aspiration.NichtAspiriert.rawValue
    दै.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    दै.lektion = 13
    दै.grundZeichen = "द"
    
    let दो = Zeichen()
    दो.ID = 1
    दो.devanagari = "दो"
    दो.umschrift = "do"
    दो.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    दो.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    दो.artikulation = Artikulation.dental.rawValue
    दो.aspiration = Aspiration.NichtAspiriert.rawValue
    दो.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    दो.lektion = 13
    दो.grundZeichen = "द"
    
    let दौ = Zeichen()
    दौ.ID = 1
    दौ.devanagari = "दौ"
    दौ.umschrift = "dau"
    दौ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    दौ.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    दौ.artikulation = Artikulation.dental.rawValue
    दौ.aspiration = Aspiration.NichtAspiriert.rawValue
    दौ.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    दौ.lektion = 13
    दौ.grundZeichen = "द"
    
    
    let ढा = Zeichen()
    ढा.ID = 1
    ढा.devanagari = "ढा"
    ढा.umschrift = "ḍhā"
    ढा.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    ढा.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    ढा.artikulation = Artikulation.retroflex.rawValue
    ढा.aspiration = Aspiration.Aspiriert.rawValue
    ढा.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    ढा.lektion = 13
    ढा.grundZeichen = "ढ"
    
    let ढि = Zeichen()
    ढि.ID = 1
    ढि.devanagari = "ढि"
    ढि.umschrift = "ḍhi"
    ढि.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    ढि.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    ढि.artikulation = Artikulation.retroflex.rawValue
    ढि.aspiration = Aspiration.Aspiriert.rawValue
    ढि.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    ढि.lektion = 13
    ढि.grundZeichen = "ढ"
    
    let ढी = Zeichen()
    ढी.ID = 1
    ढी.devanagari = "ढी"
    ढी.umschrift = "ḍhī"
    ढी.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    ढी.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    ढी.artikulation = Artikulation.retroflex.rawValue
    ढी.aspiration = Aspiration.Aspiriert.rawValue
    ढी.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    ढी.lektion = 13
    ढी.grundZeichen = "ढ"
    
    let ढु = Zeichen()
    ढु.ID = 1
    ढु.devanagari = "ढु"
    ढु.umschrift = "ḍhu"
    ढु.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    ढु.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    ढु.artikulation = Artikulation.retroflex.rawValue
    ढु.aspiration = Aspiration.Aspiriert.rawValue
    ढु.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    ढु.lektion = 13
    ढु.grundZeichen = "ढ"
    
    let ढू = Zeichen()
    ढू.ID = 1
    ढू.devanagari = "ढू"
    ढू.umschrift = "ḍhū"
    ढू.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    ढू.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    ढू.artikulation = Artikulation.retroflex.rawValue
    ढू.aspiration = Aspiration.Aspiriert.rawValue
    ढू.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    ढू.lektion = 13
    ढू.grundZeichen = "ढ"
    
    let ढे = Zeichen()
    ढे.ID = 1
    ढे.devanagari = "ढे"
    ढे.umschrift = "ḍhe"
    ढे.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    ढे.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    ढे.artikulation = Artikulation.retroflex.rawValue
    ढे.aspiration = Aspiration.Aspiriert.rawValue
    ढे.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    ढे.lektion = 13
    ढे.grundZeichen = "ढ"
    
    let ढै = Zeichen()
    ढै.ID = 1
    ढै.devanagari = "ढै"
    ढै.umschrift = "ḍhai"
    ढै.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    ढै.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    ढै.artikulation = Artikulation.retroflex.rawValue
    ढै.aspiration = Aspiration.Aspiriert.rawValue
    ढै.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    ढै.lektion = 13
    ढै.grundZeichen = "ढ"
    
    let ढो = Zeichen()
    ढो.ID = 1
    ढो.devanagari = "ढो"
    ढो.umschrift = "ḍho"
    ढो.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    ढो.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    ढो.artikulation = Artikulation.retroflex.rawValue
    ढो.aspiration = Aspiration.Aspiriert.rawValue
    ढो.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    ढो.lektion = 13
    ढो.grundZeichen = "ढ"
    
    let ढौ = Zeichen()
    ढौ.ID = 1
    ढौ.devanagari = "ढौ"
    ढौ.umschrift = "ḍhau"
    ढौ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    ढौ.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    ढौ.artikulation = Artikulation.retroflex.rawValue
    ढौ.aspiration = Aspiration.Aspiriert.rawValue
    ढौ.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    ढौ.lektion = 13
    ढौ.grundZeichen = "ढ"
    
    let धा = Zeichen()
    धा.ID = 1
    धा.devanagari = "धा"
    धा.umschrift = "dhā"
    धा.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    धा.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    धा.artikulation = Artikulation.dental.rawValue
    धा.aspiration = Aspiration.Aspiriert.rawValue
    धा.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    धा.lektion = 13
    धा.grundZeichen = "ध"
    
    let धि = Zeichen()
    धि.ID = 1
    धि.devanagari = "धि"
    धि.umschrift = "dhi"
    धि.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    धि.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    धि.artikulation = Artikulation.dental.rawValue
    धि.aspiration = Aspiration.Aspiriert.rawValue
    धि.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    धि.lektion = 13
    धि.grundZeichen = "ध"
    
    let धी = Zeichen()
    धी.ID = 1
    धी.devanagari = "धी"
    धी.umschrift = "dhī"
    धी.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    धी.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    धी.artikulation = Artikulation.dental.rawValue
    धी.aspiration = Aspiration.Aspiriert.rawValue
    धी.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    धी.lektion = 13
    धी.grundZeichen = "ध"
    
    let धु = Zeichen()
    धु.ID = 1
    धु.devanagari = "धु"
    धु.umschrift = "dhu"
    धु.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    धु.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    धु.artikulation = Artikulation.dental.rawValue
    धु.aspiration = Aspiration.Aspiriert.rawValue
    धु.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    धु.lektion = 13
    धु.grundZeichen = "ध"
    
    let धू = Zeichen()
    धू.ID = 1
    धू.devanagari = "धू"
    धू.umschrift = "dhū"
    धू.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    धू.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    धू.artikulation = Artikulation.dental.rawValue
    धू.aspiration = Aspiration.Aspiriert.rawValue
    धू.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    धू.lektion = 13
    धू.grundZeichen = "ध"
    
    let धे = Zeichen()
    धे.ID = 1
    धे.devanagari = "धे"
    धे.umschrift = "dhe"
    धे.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    धे.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    धे.artikulation = Artikulation.dental.rawValue
    धे.aspiration = Aspiration.Aspiriert.rawValue
    धे.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    धे.lektion = 13
    धे.grundZeichen = "ध"
    
    let धै = Zeichen()
    धै.ID = 1
    धै.devanagari = "धै"
    धै.umschrift = "dhai"
    धै.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    धै.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    धै.artikulation = Artikulation.dental.rawValue
    धै.aspiration = Aspiration.Aspiriert.rawValue
    धै.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    धै.lektion = 13
    धै.grundZeichen = "ध"
    
    let धो = Zeichen()
    धो.ID = 1
    धो.devanagari = "धो"
    धो.umschrift = "dho"
    धो.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    धो.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    धो.artikulation = Artikulation.dental.rawValue
    धो.aspiration = Aspiration.Aspiriert.rawValue
    धो.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    धो.lektion = 13
    धो.grundZeichen = "ध"
    
    let धौ = Zeichen()
    धौ.ID = 1
    धौ.devanagari = "धौ"
    धौ.umschrift = "dhau"
    धौ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    धौ.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    धौ.artikulation = Artikulation.dental.rawValue
    धौ.aspiration = Aspiration.Aspiriert.rawValue
    धौ.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    धौ.lektion = 13
    धौ.grundZeichen = "ध"
    
    let डृ = Zeichen()
    डृ.ID = 1
    डृ.devanagari = "डृ"
    डृ.umschrift = "ḍṛ"
    डृ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    डृ.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    डृ.artikulation = Artikulation.retroflex.rawValue
    डृ.aspiration = Aspiration.NichtAspiriert.rawValue
    डृ.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    डृ.lektion = 13
    डृ.grundZeichen = "ड"
    
    let दृ = Zeichen()
    दृ.ID = 1
    दृ.devanagari = "दृ"
    दृ.umschrift = "dṛ"
    दृ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    दृ.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    दृ.artikulation = Artikulation.dental.rawValue
    दृ.aspiration = Aspiration.NichtAspiriert.rawValue
    दृ.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    दृ.lektion = 13
    दृ.grundZeichen = "द"
    
    let ढृ = Zeichen()
    ढृ.ID = 1
    ढृ.devanagari = "ढृ"
    ढृ.umschrift = "ḍhṛ"
    ढृ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    ढृ.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    ढृ.artikulation = Artikulation.retroflex.rawValue
    ढृ.aspiration = Aspiration.Aspiriert.rawValue
    ढृ.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    ढृ.lektion = 13
    ढृ.grundZeichen = "ढ"
    
    let धृ = Zeichen()
    धृ.ID = 1
    धृ.devanagari = "धृ"
    धृ.umschrift = "dhṛ"
    धृ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    धृ.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    धृ.artikulation = Artikulation.dental.rawValue
    धृ.aspiration = Aspiration.Aspiriert.rawValue
    धृ.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    धृ.lektion = 13
    धृ.grundZeichen = "ध"
    
    let डॄ = Zeichen()
    डॄ.ID = 1
    डॄ.devanagari = "डॄ"
    डॄ.umschrift = "ḍṝ"
    डॄ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    डॄ.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    डॄ.artikulation = Artikulation.retroflex.rawValue
    डॄ.aspiration = Aspiration.NichtAspiriert.rawValue
    डॄ.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    डॄ.lektion = 13
    डॄ.grundZeichen = "ड"
    
    let दॄ = Zeichen()
    दॄ.ID = 1
    दॄ.devanagari = "दॄ"
    दॄ.umschrift = "dṝ"
    दॄ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    दॄ.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    दॄ.artikulation = Artikulation.dental.rawValue
    दॄ.aspiration = Aspiration.NichtAspiriert.rawValue
    दॄ.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    दॄ.lektion = 13
    दॄ.grundZeichen = "द"
    
    let ढॄ = Zeichen()
    ढॄ.ID = 1
    ढॄ.devanagari = "ढॄ"
    ढॄ.umschrift = "ḍhṝ"
    ढॄ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    ढॄ.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    ढॄ.artikulation = Artikulation.retroflex.rawValue
    ढॄ.aspiration = Aspiration.Aspiriert.rawValue
    ढॄ.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    ढॄ.lektion = 13
    ढॄ.grundZeichen = "ढ"
    
    let धॄ = Zeichen()
    धॄ.ID = 1
    धॄ.devanagari = "धॄ"
    धॄ.umschrift = "dhṝ"
    धॄ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    धॄ.konsonantTyp = KonsonantTyp.EinfacherKonsonant.rawValue
    धॄ.artikulation = Artikulation.dental.rawValue
    धॄ.aspiration = Aspiration.Aspiriert.rawValue
    धॄ.stimmhaftigkeit = Stimmhaftigkeit.Stimmhaft.rawValue
    धॄ.lektion = 13
    धॄ.grundZeichen = "ध"
    
    /////////
    
    
    
    //Lektion 15
    
    let ङ = Zeichen()
    ङ.ID = 1
    ङ.devanagari = "ङ"
    ङ.umschrift = "ṅa"
    ङ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    ङ.konsonantTyp = KonsonantTyp.Nasal.rawValue
    ङ.artikulation = Artikulation.velar.rawValue
    ङ.aspiration = Aspiration.NichtAspiriert.rawValue
    ङ.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    ङ.lektion = 14
    ङ.grundZeichen = "ङ"
    
    let ञ = Zeichen()
    ञ.ID = 1
    ञ.devanagari = "ञ"
    ञ.umschrift = "ña"
    ञ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    ञ.konsonantTyp = KonsonantTyp.Nasal.rawValue
    ञ.artikulation = Artikulation.palatal.rawValue
    ञ.aspiration = Aspiration.NichtAspiriert.rawValue
    ञ.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    ञ.lektion = 14
    ञ.grundZeichen = "ञ"
    
    let ण = Zeichen()
    ण.ID = 1
    ण.devanagari = "ण"
    ण.umschrift = "ṇa"
    ण.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    ण.konsonantTyp = KonsonantTyp.Nasal.rawValue
    ण.artikulation = Artikulation.retroflex.rawValue
    ण.aspiration = Aspiration.NichtAspiriert.rawValue
    ण.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    ण.lektion = 14
    ण.grundZeichen = "ण"
    
    let न = Zeichen()
    न.ID = 1
    न.devanagari = "न"
    न.umschrift = "na"
    न.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    न.konsonantTyp = KonsonantTyp.Nasal.rawValue
    न.artikulation = Artikulation.dental.rawValue
    न.aspiration = Aspiration.NichtAspiriert.rawValue
    न.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    न.lektion = 14
    न.grundZeichen = "न"
    
    let म = Zeichen()
    म.ID = 1
    म.devanagari = "म"
    म.umschrift = "ma"
    म.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    म.konsonantTyp = KonsonantTyp.Nasal.rawValue
    म.artikulation = Artikulation.labial.rawValue
    म.aspiration = Aspiration.NichtAspiriert.rawValue
    म.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    म.lektion = 14
    म.grundZeichen = "म"
    
    //Lektion 15
    let ङि = Zeichen()
    ङि.ID = 1
    ङि.devanagari = "ङि"
    ङि.umschrift = "ṅi"
    ङि.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    ङि.konsonantTyp = KonsonantTyp.Nasal.rawValue
    ङि.artikulation = Artikulation.velar.rawValue
    ङि.aspiration = Aspiration.NichtAspiriert.rawValue
    ङि.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    ङि.lektion = 15
    ङि.grundZeichen = "ङ"
    
    let ङी = Zeichen()
    ङी.ID = 1
    ङी.devanagari = "ङी"
    ङी.umschrift = "ṅī"
    ङी.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    ङी.konsonantTyp = KonsonantTyp.Nasal.rawValue
    ङी.artikulation = Artikulation.velar.rawValue
    ङी.aspiration = Aspiration.NichtAspiriert.rawValue
    ङी.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    ङी.lektion = 15
    ङी.grundZeichen = "ङ"
    
    let ङा = Zeichen()
    ङा.ID = 1
    ङा.devanagari = "ङा"
    ङा.umschrift = "ṅā"
    ङा.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    ङा.konsonantTyp = KonsonantTyp.Nasal.rawValue
    ङा.artikulation = Artikulation.velar.rawValue
    ङा.aspiration = Aspiration.NichtAspiriert.rawValue
    ङा.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    ङा.lektion = 15
    ङा.grundZeichen = "ङ"
    
    let ङु = Zeichen()
    ङु.ID = 1
    ङु.devanagari = "ङु"
    ङु.umschrift = "ṅu"
    ङु.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    ङु.konsonantTyp = KonsonantTyp.Nasal.rawValue
    ङु.artikulation = Artikulation.velar.rawValue
    ङु.aspiration = Aspiration.NichtAspiriert.rawValue
    ङु.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    ङु.lektion = 15
    ङु.grundZeichen = "ङ"
    
    let ङू = Zeichen()
    ङू.ID = 1
    ङू.devanagari = "ङू"
    ङू.umschrift = "ṅū"
    ङू.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    ङू.konsonantTyp = KonsonantTyp.Nasal.rawValue
    ङू.artikulation = Artikulation.velar.rawValue
    ङू.aspiration = Aspiration.NichtAspiriert.rawValue
    ङू.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    ङू.lektion = 15
    ङू.grundZeichen = "ङ"
    
    let ङे = Zeichen()
    ङे.ID = 1
    ङे.devanagari = "ङे"
    ङे.umschrift = "ṅe"
    ङे.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    ङे.konsonantTyp = KonsonantTyp.Nasal.rawValue
    ङे.artikulation = Artikulation.velar.rawValue
    ङे.aspiration = Aspiration.NichtAspiriert.rawValue
    ङे.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    ङे.lektion = 15
    ङे.grundZeichen = "ङ"
    
    let ङै = Zeichen()
    ङै.ID = 1
    ङै.devanagari = "ङै"
    ङै.umschrift = "ṅai"
    ङै.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    ङै.konsonantTyp = KonsonantTyp.Nasal.rawValue
    ङै.artikulation = Artikulation.velar.rawValue
    ङै.aspiration = Aspiration.NichtAspiriert.rawValue
    ङै.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    ङै.lektion = 15
    ङै.grundZeichen = "ङ"
    
    let ङो = Zeichen()
    ङो.ID = 1
    ङो.devanagari = "ङो"
    ङो.umschrift = "ṅo"
    ङो.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    ङो.konsonantTyp = KonsonantTyp.Nasal.rawValue
    ङो.artikulation = Artikulation.velar.rawValue
    ङो.aspiration = Aspiration.NichtAspiriert.rawValue
    ङो.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    ङो.lektion = 15
    ङो.grundZeichen = "ङ"
    
    let ङौ = Zeichen()
    ङौ.ID = 1
    ङौ.devanagari = "ङौ"
    ङौ.umschrift = "ṅau"
    ङौ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    ङौ.konsonantTyp = KonsonantTyp.Nasal.rawValue
    ङौ.artikulation = Artikulation.velar.rawValue
    ङौ.aspiration = Aspiration.NichtAspiriert.rawValue
    ङौ.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    ङौ.lektion = 15
    ङौ.grundZeichen = "ङ"
    
    let ञा = Zeichen()
    ञा.ID = 1
    ञा.devanagari = "ञा"
    ञा.umschrift = "ñā"
    ञा.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    ञा.konsonantTyp = KonsonantTyp.Nasal.rawValue
    ञा.artikulation = Artikulation.palatal.rawValue
    ञा.aspiration = Aspiration.NichtAspiriert.rawValue
    ञा.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    ञा.lektion = 15
    ञा.grundZeichen = "ञ"
    
    let ञि = Zeichen()
    ञि.ID = 1
    ञि.devanagari = "ञि"
    ञि.umschrift = "ñi"
    ञि.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    ञि.konsonantTyp = KonsonantTyp.Nasal.rawValue
    ञि.artikulation = Artikulation.palatal.rawValue
    ञि.aspiration = Aspiration.NichtAspiriert.rawValue
    ञि.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    ञि.lektion = 15
    ञि.grundZeichen = "ञ"
    
    let ञी = Zeichen()
    ञी.ID = 1
    ञी.devanagari = "ञी"
    ञी.umschrift = "ñī"
    ञी.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    ञी.konsonantTyp = KonsonantTyp.Nasal.rawValue
    ञी.artikulation = Artikulation.palatal.rawValue
    ञी.aspiration = Aspiration.NichtAspiriert.rawValue
    ञी.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    ञी.lektion = 15
    ञी.grundZeichen = "ञ"
    
    let ञु = Zeichen()
    ञु.ID = 1
    ञु.devanagari = "ञु"
    ञु.umschrift = "ñu"
    ञु.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    ञु.konsonantTyp = KonsonantTyp.Nasal.rawValue
    ञु.artikulation = Artikulation.palatal.rawValue
    ञु.aspiration = Aspiration.NichtAspiriert.rawValue
    ञु.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    ञु.lektion = 15
    ञु.grundZeichen = "ञ"
    
    let ञू = Zeichen()
    ञू.ID = 1
    ञू.devanagari = "ञू"
    ञू.umschrift = "ñū"
    ञू.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    ञू.konsonantTyp = KonsonantTyp.Nasal.rawValue
    ञू.artikulation = Artikulation.palatal.rawValue
    ञू.aspiration = Aspiration.NichtAspiriert.rawValue
    ञू.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    ञू.lektion = 15
    ञू.grundZeichen = "ञ"
    
    let ञे = Zeichen()
    ञे.ID = 1
    ञे.devanagari = "ञे"
    ञे.umschrift = "ñe"
    ञे.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    ञे.konsonantTyp = KonsonantTyp.Nasal.rawValue
    ञे.artikulation = Artikulation.palatal.rawValue
    ञे.aspiration = Aspiration.NichtAspiriert.rawValue
    ञे.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    ञे.lektion = 15
    ञे.grundZeichen = "ञ"
    
    let ञै = Zeichen()
    ञै.ID = 1
    ञै.devanagari = "ञै"
    ञै.umschrift = "ñai"
    ञै.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    ञै.konsonantTyp = KonsonantTyp.Nasal.rawValue
    ञै.artikulation = Artikulation.palatal.rawValue
    ञै.aspiration = Aspiration.NichtAspiriert.rawValue
    ञै.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    ञै.lektion = 15
    ञै.grundZeichen = "ञ"
    
    let ञो = Zeichen()
    ञो.ID = 1
    ञो.devanagari = "ञो"
    ञो.umschrift = "ño"
    ञो.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    ञो.konsonantTyp = KonsonantTyp.Nasal.rawValue
    ञो.artikulation = Artikulation.palatal.rawValue
    ञो.aspiration = Aspiration.NichtAspiriert.rawValue
    ञो.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    ञो.lektion = 15
    ञो.grundZeichen = "ञ"
    
    let ञौ = Zeichen()
    ञौ.ID = 1
    ञौ.devanagari = "ञौ"
    ञौ.umschrift = "ñau"
    ञौ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    ञौ.konsonantTyp = KonsonantTyp.Nasal.rawValue
    ञौ.artikulation = Artikulation.palatal.rawValue
    ञौ.aspiration = Aspiration.NichtAspiriert.rawValue
    ञौ.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    ञौ.lektion = 15
    ञौ.grundZeichen = "ञ"
    
    let णा = Zeichen()
    णा.ID = 1
    णा.devanagari = "णा"
    णा.umschrift = "ṇā"
    णा.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    णा.konsonantTyp = KonsonantTyp.Nasal.rawValue
    णा.artikulation = Artikulation.retroflex.rawValue
    णा.aspiration = Aspiration.NichtAspiriert.rawValue
    णा.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    णा.lektion = 15
    णा.grundZeichen = "ण"
    
    let णि = Zeichen()
    णि.ID = 1
    णि.devanagari = "णि"
    णि.umschrift = "ṇi"
    णि.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    णि.konsonantTyp = KonsonantTyp.Nasal.rawValue
    णि.artikulation = Artikulation.retroflex.rawValue
    णि.aspiration = Aspiration.NichtAspiriert.rawValue
    णि.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    णि.lektion = 15
    णि.grundZeichen = "ण"
    
    let णी = Zeichen()
    णी.ID = 1
    णी.devanagari = "णी"
    णी.umschrift = "ṇī"
    णी.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    णी.konsonantTyp = KonsonantTyp.Nasal.rawValue
    णी.artikulation = Artikulation.retroflex.rawValue
    णी.aspiration = Aspiration.NichtAspiriert.rawValue
    णी.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    णी.lektion = 15
    णी.grundZeichen = "ण"
    
    let णु = Zeichen()
    णु.ID = 1
    णु.devanagari = "णु"
    णु.umschrift = "ṇu"
    णु.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    णु.konsonantTyp = KonsonantTyp.Nasal.rawValue
    णु.artikulation = Artikulation.retroflex.rawValue
    णु.aspiration = Aspiration.NichtAspiriert.rawValue
    णु.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    णु.lektion = 15
    णु.grundZeichen = "ण"
    
    let णू = Zeichen()
    णू.ID = 1
    णू.devanagari = "णू"
    णू.umschrift = "ṇū"
    णू.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    णू.konsonantTyp = KonsonantTyp.Nasal.rawValue
    णू.artikulation = Artikulation.retroflex.rawValue
    णू.aspiration = Aspiration.NichtAspiriert.rawValue
    णू.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    णू.lektion = 15
    णू.grundZeichen = "ण"
    
    let णे = Zeichen()
    णे.ID = 1
    णे.devanagari = "णे"
    णे.umschrift = "ṇe"
    णे.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    णे.konsonantTyp = KonsonantTyp.Nasal.rawValue
    णे.artikulation = Artikulation.retroflex.rawValue
    णे.aspiration = Aspiration.NichtAspiriert.rawValue
    णे.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    णे.lektion = 15
    णे.grundZeichen = "ण"
    
    let णै = Zeichen()
    णै.ID = 1
    णै.devanagari = "णै"
    णै.umschrift = "ṇai"
    णै.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    णै.konsonantTyp = KonsonantTyp.Nasal.rawValue
    णै.artikulation = Artikulation.retroflex.rawValue
    णै.aspiration = Aspiration.NichtAspiriert.rawValue
    णै.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    णै.lektion = 15
    णै.grundZeichen = "ण"
    
    let णो = Zeichen()
    णो.ID = 1
    णो.devanagari = "णो"
    णो.umschrift = "ṇo"
    णो.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    णो.konsonantTyp = KonsonantTyp.Nasal.rawValue
    णो.artikulation = Artikulation.retroflex.rawValue
    णो.aspiration = Aspiration.NichtAspiriert.rawValue
    णो.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    णो.lektion = 15
    णो.grundZeichen = "ण"
    
    let णौ = Zeichen()
    णौ.ID = 1
    णौ.devanagari = "णौ"
    णौ.umschrift = "ṇau"
    णौ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    णौ.konsonantTyp = KonsonantTyp.Nasal.rawValue
    णौ.artikulation = Artikulation.retroflex.rawValue
    णौ.aspiration = Aspiration.NichtAspiriert.rawValue
    णौ.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    णौ.lektion = 15
    णौ.grundZeichen = "ण"
    
    
    let ना = Zeichen()
    ना.ID = 1
    ना.devanagari = "ना"
    ना.umschrift = "nā"
    ना.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    ना.konsonantTyp = KonsonantTyp.Nasal.rawValue
    ना.artikulation = Artikulation.dental.rawValue
    ना.aspiration = Aspiration.NichtAspiriert.rawValue
    ना.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    ना.lektion = 15
    ना.grundZeichen = "न"
    
    let नि = Zeichen()
    नि.ID = 1
    नि.devanagari = "नि"
    नि.umschrift = "ni"
    नि.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    नि.konsonantTyp = KonsonantTyp.Nasal.rawValue
    नि.artikulation = Artikulation.dental.rawValue
    नि.aspiration = Aspiration.NichtAspiriert.rawValue
    नि.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    नि.lektion = 15
    नि.grundZeichen = "न"
    
    let नी = Zeichen()
    नी.ID = 1
    नी.devanagari = "नी"
    नी.umschrift = "nī"
    नी.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    नी.konsonantTyp = KonsonantTyp.Nasal.rawValue
    नी.artikulation = Artikulation.dental.rawValue
    नी.aspiration = Aspiration.NichtAspiriert.rawValue
    नी.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    नी.lektion = 15
    नी.grundZeichen = "न"
    
    let नु = Zeichen()
    नु.ID = 1
    नु.devanagari = "नु"
    नु.umschrift = "nu"
    नु.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    नु.konsonantTyp = KonsonantTyp.Nasal.rawValue
    नु.artikulation = Artikulation.dental.rawValue
    नु.aspiration = Aspiration.NichtAspiriert.rawValue
    नु.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    नु.lektion = 15
    नु.grundZeichen = "न"
    
    let नू = Zeichen()
    नू.ID = 1
    नू.devanagari = "नू"
    नू.umschrift = "nū"
    नू.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    नू.konsonantTyp = KonsonantTyp.Nasal.rawValue
    नू.artikulation = Artikulation.dental.rawValue
    नू.aspiration = Aspiration.NichtAspiriert.rawValue
    नू.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    नू.lektion = 15
    नू.grundZeichen = "न"
    
    let ने = Zeichen()
    ने.ID = 1
    ने.devanagari = "ने"
    ने.umschrift = "ne"
    ने.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    ने.konsonantTyp = KonsonantTyp.Nasal.rawValue
    ने.artikulation = Artikulation.dental.rawValue
    ने.aspiration = Aspiration.NichtAspiriert.rawValue
    ने.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    ने.lektion = 15
    ने.grundZeichen = "न"
    
    let नै = Zeichen()
    नै.ID = 1
    नै.devanagari = "नै"
    नै.umschrift = "nai"
    नै.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    नै.konsonantTyp = KonsonantTyp.Nasal.rawValue
    नै.artikulation = Artikulation.dental.rawValue
    नै.aspiration = Aspiration.NichtAspiriert.rawValue
    नै.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    नै.lektion = 15
    नै.grundZeichen = "न"
    
    let नो = Zeichen()
    नो.ID = 1
    नो.devanagari = "नो"
    नो.umschrift = "no"
    नो.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    नो.konsonantTyp = KonsonantTyp.Nasal.rawValue
    नो.artikulation = Artikulation.dental.rawValue
    नो.aspiration = Aspiration.NichtAspiriert.rawValue
    नो.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    नो.lektion = 15
    नो.grundZeichen = "न"
    
    let नौ = Zeichen()
    नौ.ID = 1
    नौ.devanagari = "नौ"
    नौ.umschrift = "nau"
    नौ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    नौ.konsonantTyp = KonsonantTyp.Nasal.rawValue
    नौ.artikulation = Artikulation.dental.rawValue
    नौ.aspiration = Aspiration.NichtAspiriert.rawValue
    नौ.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    नौ.lektion = 15
    नौ.grundZeichen = "न"
    
    let मा = Zeichen()
    मा.ID = 1
    मा.devanagari = "मा"
    मा.umschrift = "mā"
    मा.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    मा.konsonantTyp = KonsonantTyp.Nasal.rawValue
    मा.artikulation = Artikulation.labial.rawValue
    मा.aspiration = Aspiration.NichtAspiriert.rawValue
    मा.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    मा.lektion = 15
    मा.grundZeichen = "म"
    
    let मि = Zeichen()
    मि.ID = 1
    मि.devanagari = "मि"
    मि.umschrift = "mi"
    मि.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    मि.konsonantTyp = KonsonantTyp.Nasal.rawValue
    मि.artikulation = Artikulation.labial.rawValue
    मि.aspiration = Aspiration.NichtAspiriert.rawValue
    मि.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    मि.lektion = 15
    मि.grundZeichen = "म"
    
    let मी = Zeichen()
    मी.ID = 1
    मी.devanagari = "मी"
    मी.umschrift = "mī"
    मी.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    मी.konsonantTyp = KonsonantTyp.Nasal.rawValue
    मी.artikulation = Artikulation.labial.rawValue
    मी.aspiration = Aspiration.NichtAspiriert.rawValue
    मी.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    मी.lektion = 15
    मी.grundZeichen = "म"
    
    let मु = Zeichen()
    मु.ID = 1
    मु.devanagari = "मु"
    मु.umschrift = "mu"
    मु.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    मु.konsonantTyp = KonsonantTyp.Nasal.rawValue
    मु.artikulation = Artikulation.labial.rawValue
    मु.aspiration = Aspiration.NichtAspiriert.rawValue
    मु.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    मु.lektion = 15
    मु.grundZeichen = "म"
    
    let मू = Zeichen()
    मू.ID = 1
    मू.devanagari = "मू"
    मू.umschrift = "mū"
    मू.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    मू.konsonantTyp = KonsonantTyp.Nasal.rawValue
    मू.artikulation = Artikulation.labial.rawValue
    मू.aspiration = Aspiration.NichtAspiriert.rawValue
    मू.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    मू.lektion = 15
    मू.grundZeichen = "म"
    
    let मे = Zeichen()
    मे.ID = 1
    मे.devanagari = "मे"
    मे.umschrift = "me"
    मे.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    मे.konsonantTyp = KonsonantTyp.Nasal.rawValue
    मे.artikulation = Artikulation.labial.rawValue
    मे.aspiration = Aspiration.NichtAspiriert.rawValue
    मे.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    मे.lektion = 15
    मे.grundZeichen = "म"
    
    let मै = Zeichen()
    मै.ID = 1
    मै.devanagari = "मै"
    मै.umschrift = "mai"
    मै.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    मै.konsonantTyp = KonsonantTyp.Nasal.rawValue
    मै.artikulation = Artikulation.labial.rawValue
    मै.aspiration = Aspiration.NichtAspiriert.rawValue
    मै.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    मै.lektion = 15
    मै.grundZeichen = "म"
    
    let मो = Zeichen()
    मो.ID = 1
    मो.devanagari = "मो"
    मो.umschrift = "mo"
    मो.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    मो.konsonantTyp = KonsonantTyp.Nasal.rawValue
    मो.artikulation = Artikulation.labial.rawValue
    मो.aspiration = Aspiration.NichtAspiriert.rawValue
    मो.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    मो.lektion = 15
    मो.grundZeichen = "म"
    
    let मौ = Zeichen()
    मौ.ID = 1
    मौ.devanagari = "मौ"
    मौ.umschrift = "mau"
    मौ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    मौ.konsonantTyp = KonsonantTyp.Nasal.rawValue
    मौ.artikulation = Artikulation.labial.rawValue
    मौ.aspiration = Aspiration.NichtAspiriert.rawValue
    मौ.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    मौ.lektion = 15
    मौ.grundZeichen = "म"
    
    let ङृ = Zeichen()
    ङृ.ID = 1
    ङृ.devanagari = "ङृ"
    ङृ.umschrift = "ṅṛ"
    ङृ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    ङृ.konsonantTyp = KonsonantTyp.Nasal.rawValue
    ङृ.artikulation = Artikulation.velar.rawValue
    ङृ.aspiration = Aspiration.NichtAspiriert.rawValue
    ङृ.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    ङृ.lektion = 15
    ङृ.grundZeichen = "ङ"
    
    let ञृ = Zeichen()
    ञृ.ID = 1
    ञृ.devanagari = "ञृ"
    ञृ.umschrift = "ñṛ"
    ञृ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    ञृ.konsonantTyp = KonsonantTyp.Nasal.rawValue
    ञृ.artikulation = Artikulation.palatal.rawValue
    ञृ.aspiration = Aspiration.NichtAspiriert.rawValue
    ञृ.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    ञृ.lektion = 15
    ञृ.grundZeichen = "ञ"
    
    let णृ = Zeichen()
    णृ.ID = 1
    णृ.devanagari = "णृ"
    णृ.umschrift = "ṇṛ"
    णृ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    णृ.konsonantTyp = KonsonantTyp.Nasal.rawValue
    णृ.artikulation = Artikulation.retroflex.rawValue
    णृ.aspiration = Aspiration.NichtAspiriert.rawValue
    णृ.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    णृ.lektion = 15
    णृ.grundZeichen = "ण"
    
    let नृ = Zeichen()
    नृ.ID = 1
    नृ.devanagari = "नृ"
    नृ.umschrift = "nṛ"
    नृ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    नृ.konsonantTyp = KonsonantTyp.Nasal.rawValue
    नृ.artikulation = Artikulation.dental.rawValue
    नृ.aspiration = Aspiration.NichtAspiriert.rawValue
    नृ.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    नृ.lektion = 15
    नृ.grundZeichen = "न"
    
    let मृ = Zeichen()
    मृ.ID = 1
    मृ.devanagari = "मृ"
    मृ.umschrift = "mṛ"
    मृ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    मृ.konsonantTyp = KonsonantTyp.Nasal.rawValue
    मृ.artikulation = Artikulation.labial.rawValue
    मृ.aspiration = Aspiration.NichtAspiriert.rawValue
    मृ.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    मृ.lektion = 15
    मृ.grundZeichen = "म"
    
    let ङॄ = Zeichen()
    ङॄ.ID = 1
    ङॄ.devanagari = "ङॄ"
    ङॄ.umschrift = "ṅṝ"
    ङॄ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    ङॄ.konsonantTyp = KonsonantTyp.Nasal.rawValue
    ङॄ.artikulation = Artikulation.velar.rawValue
    ङॄ.aspiration = Aspiration.NichtAspiriert.rawValue
    ङॄ.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    ङॄ.lektion = 15
    ङॄ.grundZeichen = "ङ"
    
    let ञॄ = Zeichen()
    ञॄ.ID = 1
    ञॄ.devanagari = "ञॄ"
    ञॄ.umschrift = "ñṝ"
    ञॄ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    ञॄ.konsonantTyp = KonsonantTyp.Nasal.rawValue
    ञॄ.artikulation = Artikulation.palatal.rawValue
    ञॄ.aspiration = Aspiration.NichtAspiriert.rawValue
    ञॄ.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    ञॄ.lektion = 15
    ञॄ.grundZeichen = "ञ"
    
    let णॄ = Zeichen()
    णॄ.ID = 1
    णॄ.devanagari = "णॄ"
    णॄ.umschrift = "ṇṝ"
    णॄ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    णॄ.konsonantTyp = KonsonantTyp.Nasal.rawValue
    णॄ.artikulation = Artikulation.retroflex.rawValue
    णॄ.aspiration = Aspiration.NichtAspiriert.rawValue
    णॄ.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    णॄ.lektion = 15
    णॄ.grundZeichen = "ण"
    
    let नॄ = Zeichen()
    नॄ.ID = 1
    नॄ.devanagari = "नॄ"
    नॄ.umschrift = "nṝ"
    नॄ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    नॄ.konsonantTyp = KonsonantTyp.Nasal.rawValue
    नॄ.artikulation = Artikulation.dental.rawValue
    नॄ.aspiration = Aspiration.NichtAspiriert.rawValue
    नॄ.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    नॄ.lektion = 15
    नॄ.grundZeichen = "न"
    
    let मॄ = Zeichen()
    मॄ.ID = 1
    मॄ.devanagari = "मॄ"
    मॄ.umschrift = "mṝ"
    मॄ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    मॄ.konsonantTyp = KonsonantTyp.Nasal.rawValue
    मॄ.artikulation = Artikulation.labial.rawValue
    मॄ.aspiration = Aspiration.NichtAspiriert.rawValue
    मॄ.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    मॄ.lektion = 15
    मॄ.grundZeichen = "म"
    
    //Lektion 16
    let य = Zeichen()
    य.ID = 1
    य.devanagari = "य"
    य.umschrift = "ya"
    य.vokalOderKonsonant = VokalOderKonsonant.Vokal.rawValue
    य.aspiration = Aspiration.NichtAspiriert.rawValue
    य.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    य.lektion = 16
    य.vokalOderHalbvokal = VokalOderHalbvokal.Halbvokal.rawValue
    य.grundZeichen = "य"
    
    let र = Zeichen()
    र.ID = 1
    र.devanagari = "र"
    र.umschrift = "ra"
    र.vokalOderKonsonant = VokalOderKonsonant.Vokal.rawValue
    
    र.aspiration = Aspiration.NichtAspiriert.rawValue
    र.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    र.lektion = 16
    र.vokalOderHalbvokal = VokalOderHalbvokal.Halbvokal.rawValue
    र.grundZeichen = "र"
    
    let व = Zeichen()
    व.ID = 1
    व.devanagari = "व"
    व.umschrift = "va"
    व.vokalOderKonsonant = VokalOderKonsonant.Vokal.rawValue
    व.artikulation = nil
    व.aspiration = Aspiration.NichtAspiriert.rawValue
    व.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    व.lektion = 16
    व.vokalOderHalbvokal = VokalOderHalbvokal.Halbvokal.rawValue
    व.grundZeichen = "व"
    
    let ल = Zeichen()
    ल.ID = 1
    ल.devanagari = "ल"
    ल.umschrift = "la"
    ल.vokalOderKonsonant = VokalOderKonsonant.Vokal.rawValue
    ल.artikulation = nil
    ल.aspiration = Aspiration.NichtAspiriert.rawValue
    ल.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    ल.lektion = 16
    ल.vokalOderHalbvokal = VokalOderHalbvokal.Halbvokal.rawValue
    ल.grundZeichen = "ल"
    
    let यि = Zeichen()
    यि.ID = 1
    यि.devanagari = "यि"
    यि.umschrift = "yi"
    यि.vokalOderKonsonant = VokalOderKonsonant.Vokal.rawValue
    यि.artikulation = nil
    यि.aspiration = Aspiration.NichtAspiriert.rawValue
    यि.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    यि.lektion = 16
    यि.vokalOderHalbvokal = VokalOderHalbvokal.Halbvokal.rawValue
    यि.grundZeichen = "य"
    
    let यी = Zeichen()
    यी.ID = 1
    यी.devanagari = "यी"
    यी.umschrift = "yī"
    यी.vokalOderKonsonant = VokalOderKonsonant.Vokal.rawValue
    यी.artikulation = nil
    यी.aspiration = Aspiration.NichtAspiriert.rawValue
    यी.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    यी.lektion = 16
    यी.vokalOderHalbvokal = VokalOderHalbvokal.Halbvokal.rawValue
    यी.grundZeichen = "य"
    
    let या = Zeichen()
    या.ID = 1
    या.devanagari = "या"
    या.umschrift = "yā"
    या.vokalOderKonsonant = VokalOderKonsonant.Vokal.rawValue
    या.artikulation = nil
    या.aspiration = Aspiration.NichtAspiriert.rawValue
    या.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    या.vokalOderHalbvokal = VokalOderHalbvokal.Halbvokal.rawValue
    या.lektion = 16
    या.grundZeichen = "य"
    
    let यु = Zeichen()
    यु.ID = 1
    यु.devanagari = "यु"
    यु.umschrift = "yu"
    यु.vokalOderKonsonant = VokalOderKonsonant.Vokal.rawValue
    यु.artikulation = nil
    यु.aspiration = Aspiration.NichtAspiriert.rawValue
    यु.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    यु.lektion = 16
    यु.vokalOderHalbvokal = VokalOderHalbvokal.Halbvokal.rawValue
    यु.grundZeichen = "य"
    
    let यू = Zeichen()
    यू.ID = 1
    यू.devanagari = "यू"
    यू.umschrift = "yū"
    यू.vokalOderKonsonant = VokalOderKonsonant.Vokal.rawValue
    यू.artikulation = nil
    यू.aspiration = Aspiration.NichtAspiriert.rawValue
    यू.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    यू.lektion = 16
    यू.vokalOderHalbvokal = VokalOderHalbvokal.Halbvokal.rawValue
    यू.grundZeichen = "य"
    
    let ये = Zeichen()
    ये.ID = 1
    ये.devanagari = "ये"
    ये.umschrift = "ye"
    ये.vokalOderKonsonant = VokalOderKonsonant.Vokal.rawValue
    ये.artikulation = nil
    ये.aspiration = Aspiration.NichtAspiriert.rawValue
    ये.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    ये.lektion = 16
    ये.vokalOderHalbvokal = VokalOderHalbvokal.Halbvokal.rawValue
    ये.grundZeichen = "य"
    
    let यै = Zeichen()
    यै.ID = 1
    यै.devanagari = "यै"
    यै.umschrift = "yai"
    यै.vokalOderKonsonant = VokalOderKonsonant.Vokal.rawValue
    यै.artikulation = nil
    यै.aspiration = Aspiration.NichtAspiriert.rawValue
    यै.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    यै.vokalOderHalbvokal = VokalOderHalbvokal.Halbvokal.rawValue
    यै.lektion = 16
    यै.grundZeichen = "य"
    
    let यो = Zeichen()
    यो.ID = 1
    यो.devanagari = "यो"
    यो.umschrift = "yo"
    यो.vokalOderKonsonant = VokalOderKonsonant.Vokal.rawValue
    यो.artikulation = nil
    यो.aspiration = Aspiration.NichtAspiriert.rawValue
    यो.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    यो.lektion = 16
    यो.vokalOderHalbvokal = VokalOderHalbvokal.Halbvokal.rawValue
    यो.grundZeichen = "य"
    
    let यौ = Zeichen()
    यौ.ID = 1
    यौ.devanagari = "यौ"
    यौ.umschrift = "yau"
    यौ.vokalOderKonsonant = VokalOderKonsonant.Vokal.rawValue
    यौ.artikulation = nil
    यौ.aspiration = Aspiration.NichtAspiriert.rawValue
    यौ.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    यौ.lektion = 16
    यौ.vokalOderHalbvokal = VokalOderHalbvokal.Halbvokal.rawValue
    यौ.grundZeichen = "य"
    
    let रा = Zeichen()
    रा.ID = 1
    रा.devanagari = "रा"
    रा.umschrift = "rā"
    रा.vokalOderKonsonant = VokalOderKonsonant.Vokal.rawValue
    रा.artikulation = nil
    रा.aspiration = Aspiration.NichtAspiriert.rawValue
    रा.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    रा.lektion = 16
    रा.vokalOderHalbvokal = VokalOderHalbvokal.Halbvokal.rawValue
    रा.grundZeichen = "र"
    
    let रि = Zeichen()
    रि.ID = 1
    रि.devanagari = "रि"
    रि.umschrift = "ri"
    रि.vokalOderKonsonant = VokalOderKonsonant.Vokal.rawValue
    रि.artikulation = nil
    रि.aspiration = Aspiration.NichtAspiriert.rawValue
    रि.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    रि.lektion = 16
    रि.vokalOderHalbvokal = VokalOderHalbvokal.Halbvokal.rawValue
    रि.grundZeichen = "र"
    
    let री = Zeichen()
    री.ID = 1
    री.devanagari = "री"
    री.umschrift = "rī"
    री.vokalOderKonsonant = VokalOderKonsonant.Vokal.rawValue
    री.artikulation = nil
    री.aspiration = Aspiration.NichtAspiriert.rawValue
    री.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    री.lektion = 16
    री.vokalOderHalbvokal = VokalOderHalbvokal.Halbvokal.rawValue
    री.grundZeichen = "र"
    
    let रु = Zeichen()
    रु.ID = 1
    रु.devanagari = "रु"
    रु.umschrift = "ru"
    रु.vokalOderKonsonant = VokalOderKonsonant.Vokal.rawValue
    रु.artikulation = nil
    रु.aspiration = Aspiration.NichtAspiriert.rawValue
    रु.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    रु.lektion = 16
    रु.vokalOderHalbvokal = VokalOderHalbvokal.Halbvokal.rawValue
    रु.grundZeichen = "र"
    
    let रू = Zeichen()
    रू.ID = 1
    रू.devanagari = "रू"
    रू.umschrift = "rū"
    रू.vokalOderKonsonant = VokalOderKonsonant.Vokal.rawValue
    रू.artikulation = nil
    रू.aspiration = Aspiration.NichtAspiriert.rawValue
    रू.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    रू.lektion = 16
    रू.vokalOderHalbvokal = VokalOderHalbvokal.Halbvokal.rawValue
    रू.grundZeichen = "र"
    
    let रे = Zeichen()
    रे.ID = 1
    रे.devanagari = "रे"
    रे.umschrift = "re"
    रे.vokalOderKonsonant = VokalOderKonsonant.Vokal.rawValue
    रे.artikulation = nil
    रे.aspiration = Aspiration.NichtAspiriert.rawValue
    रे.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    रे.lektion = 16
    रे.vokalOderHalbvokal = VokalOderHalbvokal.Halbvokal.rawValue
    रे.grundZeichen = "र"
    
    let रै = Zeichen()
    रै.ID = 1
    रै.devanagari = "रै"
    रै.umschrift = "rai"
    रै.vokalOderKonsonant = VokalOderKonsonant.Vokal.rawValue
    रै.artikulation = nil
    रै.aspiration = Aspiration.NichtAspiriert.rawValue
    रै.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    रै.lektion = 16
    रै.vokalOderHalbvokal = VokalOderHalbvokal.Halbvokal.rawValue
    रै.grundZeichen = "र"
    
    let रो = Zeichen()
    रो.ID = 1
    रो.devanagari = "रो"
    रो.umschrift = "ro"
    रो.vokalOderKonsonant = VokalOderKonsonant.Vokal.rawValue
    रो.artikulation = nil
    रो.aspiration = Aspiration.NichtAspiriert.rawValue
    रो.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    रो.lektion = 16
    रो.vokalOderHalbvokal = VokalOderHalbvokal.Halbvokal.rawValue
    रो.grundZeichen = "र"
    
    let रौ = Zeichen()
    रौ.ID = 1
    रौ.devanagari = "रौ"
    रौ.umschrift = "rau"
    रौ.vokalOderKonsonant = VokalOderKonsonant.Vokal.rawValue
    रौ.artikulation = nil
    रौ.aspiration = Aspiration.NichtAspiriert.rawValue
    रौ.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    रौ.lektion = 16
    रौ.vokalOderHalbvokal = VokalOderHalbvokal.Halbvokal.rawValue
    रौ.grundZeichen = "र"
    
    let वा = Zeichen()
    वा.ID = 1
    वा.devanagari = "वा"
    वा.umschrift = "vā"
    वा.vokalOderKonsonant = VokalOderKonsonant.Vokal.rawValue
    वा.artikulation = nil
    वा.aspiration = Aspiration.NichtAspiriert.rawValue
    वा.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    वा.lektion = 16
    वा.vokalOderHalbvokal = VokalOderHalbvokal.Halbvokal.rawValue
    वा.grundZeichen = "व"
    
    let वि = Zeichen()
    वि.ID = 1
    वि.devanagari = "वि"
    वि.umschrift = "vi"
    वि.vokalOderKonsonant = VokalOderKonsonant.Vokal.rawValue
    वि.artikulation = nil
    वि.aspiration = Aspiration.NichtAspiriert.rawValue
    वि.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    वि.lektion = 16
    वि.vokalOderHalbvokal = VokalOderHalbvokal.Halbvokal.rawValue
    वि.grundZeichen = "व"
    
    let वी = Zeichen()
    वी.ID = 1
    वी.devanagari = "वी"
    वी.umschrift = "vī"
    वी.vokalOderKonsonant = VokalOderKonsonant.Vokal.rawValue
    वी.artikulation = nil
    वी.aspiration = Aspiration.NichtAspiriert.rawValue
    वी.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    वी.lektion = 16
    वी.vokalOderHalbvokal = VokalOderHalbvokal.Halbvokal.rawValue
    वी.grundZeichen = "व"
    
    let वु = Zeichen()
    वु.ID = 1
    वु.devanagari = "वु"
    वु.umschrift = "vu"
    वु.vokalOderKonsonant = VokalOderKonsonant.Vokal.rawValue
    वु.artikulation = nil
    वु.aspiration = Aspiration.NichtAspiriert.rawValue
    वु.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    वु.lektion = 16
    वु.vokalOderHalbvokal = VokalOderHalbvokal.Halbvokal.rawValue
    वु.grundZeichen = "व"
    
    let वू = Zeichen()
    वू.ID = 1
    वू.devanagari = "वू"
    वू.umschrift = "vū"
    वू.vokalOderKonsonant = VokalOderKonsonant.Vokal.rawValue
    वू.artikulation = nil
    वू.aspiration = Aspiration.NichtAspiriert.rawValue
    वू.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    वू.lektion = 16
    वू.vokalOderHalbvokal = VokalOderHalbvokal.Halbvokal.rawValue
    वू.grundZeichen = "व"
    
    let वे = Zeichen()
    वे.ID = 1
    वे.devanagari = "वे"
    वे.umschrift = "ve"
    वे.vokalOderKonsonant = VokalOderKonsonant.Vokal.rawValue
    वे.artikulation = nil
    वे.aspiration = Aspiration.NichtAspiriert.rawValue
    वे.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    वे.lektion = 16
    वे.vokalOderHalbvokal = VokalOderHalbvokal.Halbvokal.rawValue
    वे.grundZeichen = "व"
    
    let वै = Zeichen()
    वै.ID = 1
    वै.devanagari = "वै"
    वै.umschrift = "vai"
    वै.vokalOderKonsonant = VokalOderKonsonant.Vokal.rawValue
    वै.artikulation = nil
    वै.aspiration = Aspiration.NichtAspiriert.rawValue
    वै.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    वै.lektion = 16
    वै.vokalOderHalbvokal = VokalOderHalbvokal.Halbvokal.rawValue
    वै.grundZeichen = "व"
    
    let वो = Zeichen()
    वो.ID = 1
    वो.devanagari = "वो"
    वो.umschrift = "vo"
    वो.vokalOderKonsonant = VokalOderKonsonant.Vokal.rawValue
    वो.artikulation = nil
    वो.aspiration = Aspiration.NichtAspiriert.rawValue
    वो.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    वो.lektion = 16
    वो.vokalOderHalbvokal = VokalOderHalbvokal.Halbvokal.rawValue
    वो.grundZeichen = "व"
    
    let वौ = Zeichen()
    वौ.ID = 1
    वौ.devanagari = "वौ"
    वौ.umschrift = "vau"
    वौ.vokalOderKonsonant = VokalOderKonsonant.Vokal.rawValue
    वौ.artikulation = nil
    वौ.aspiration = Aspiration.NichtAspiriert.rawValue
    वौ.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    वौ.lektion = 16
    वौ.vokalOderHalbvokal = VokalOderHalbvokal.Halbvokal.rawValue
    वौ.grundZeichen = "व"
    
    
    let ला = Zeichen()
    ला.ID = 1
    ला.devanagari = "ला"
    ला.umschrift = "lā"
    ला.vokalOderKonsonant = VokalOderKonsonant.Vokal.rawValue
    ला.artikulation = nil
    ला.aspiration = Aspiration.NichtAspiriert.rawValue
    ला.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    ला.lektion = 16
    ला.vokalOderHalbvokal = VokalOderHalbvokal.Halbvokal.rawValue
    ला.grundZeichen = "ल"
    
    let लि = Zeichen()
    लि.ID = 1
    लि.devanagari = "लि"
    लि.umschrift = "li"
    लि.vokalOderKonsonant = VokalOderKonsonant.Vokal.rawValue
    लि.artikulation = nil
    लि.aspiration = Aspiration.NichtAspiriert.rawValue
    लि.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    लि.lektion = 16
    लि.vokalOderHalbvokal = VokalOderHalbvokal.Halbvokal.rawValue
    लि.grundZeichen = "ल"
    
    let ली = Zeichen()
    ली.ID = 1
    ली.devanagari = "ली"
    ली.umschrift = "lī"
    ली.vokalOderKonsonant = VokalOderKonsonant.Vokal.rawValue
    ली.artikulation = nil
    ली.aspiration = Aspiration.NichtAspiriert.rawValue
    ली.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    ली.lektion = 16
    ली.vokalOderHalbvokal = VokalOderHalbvokal.Halbvokal.rawValue
    ली.grundZeichen = "ल"
    
    let लु = Zeichen()
    लु.ID = 1
    लु.devanagari = "लु"
    लु.umschrift = "lu"
    लु.vokalOderKonsonant = VokalOderKonsonant.Vokal.rawValue
    लु.artikulation = nil
    लु.aspiration = Aspiration.NichtAspiriert.rawValue
    लु.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    लु.lektion = 16
    लु.vokalOderHalbvokal = VokalOderHalbvokal.Halbvokal.rawValue
    लु.grundZeichen = "ल"
    
    let लू = Zeichen()
    लू.ID = 1
    लू.devanagari = "लू"
    लू.umschrift = "lū"
    लू.vokalOderKonsonant = VokalOderKonsonant.Vokal.rawValue
    लू.artikulation = nil
    लू.aspiration = Aspiration.NichtAspiriert.rawValue
    लू.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    लू.lektion = 16
    लू.vokalOderHalbvokal = VokalOderHalbvokal.Halbvokal.rawValue
    लू.grundZeichen = "ल"
    
    let ले = Zeichen()
    ले.ID = 1
    ले.devanagari = "ले"
    ले.umschrift = "le"
    ले.vokalOderKonsonant = VokalOderKonsonant.Vokal.rawValue
    ले.artikulation = nil
    ले.aspiration = Aspiration.NichtAspiriert.rawValue
    ले.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    ले.lektion = 16
    ले.vokalOderHalbvokal = VokalOderHalbvokal.Halbvokal.rawValue
    ले.grundZeichen = "ल"
    
    let लै = Zeichen()
    लै.ID = 1
    लै.devanagari = "लै"
    लै.umschrift = "lai"
    लै.vokalOderKonsonant = VokalOderKonsonant.Vokal.rawValue
    लै.artikulation = nil
    लै.aspiration = Aspiration.NichtAspiriert.rawValue
    लै.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    लै.lektion = 16
    लै.vokalOderHalbvokal = VokalOderHalbvokal.Halbvokal.rawValue
    लै.grundZeichen = "ल"
    
    let लो = Zeichen()
    लो.ID = 1
    लो.devanagari = "लो"
    लो.umschrift = "lo"
    लो.vokalOderKonsonant = VokalOderKonsonant.Vokal.rawValue
    लो.artikulation = nil
    लो.aspiration = Aspiration.NichtAspiriert.rawValue
    लो.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    लो.lektion = 16
    लो.vokalOderHalbvokal = VokalOderHalbvokal.Halbvokal.rawValue
    लो.grundZeichen = "ल"
    
    let लौ = Zeichen()
    लौ.ID = 1
    लौ.devanagari = "लौ"
    लौ.umschrift = "lau"
    लौ.vokalOderKonsonant = VokalOderKonsonant.Vokal.rawValue
    लौ.artikulation = nil
    लौ.aspiration = Aspiration.NichtAspiriert.rawValue
    लौ.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    लौ.lektion = 16
    लौ.vokalOderHalbvokal = VokalOderHalbvokal.Halbvokal.rawValue
    लौ.grundZeichen = "ल"
    
    let यृ = Zeichen()
    यृ.ID = 1
    यृ.devanagari = "यृ"
    यृ.umschrift = "yṛ"
    यृ.vokalOderKonsonant = VokalOderKonsonant.Vokal.rawValue
    यृ.artikulation = Artikulation.velar.rawValue
    यृ.aspiration = Aspiration.NichtAspiriert.rawValue
    यृ.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    यृ.lektion = 16
    यृ.vokalOderHalbvokal = VokalOderHalbvokal.Halbvokal.rawValue
    यृ.grundZeichen = "य"
    
    let लृ = Zeichen()
    लृ.ID = 1
    लृ.devanagari = "लृ"
    लृ.umschrift = "lṛ"
    लृ.vokalOderKonsonant = VokalOderKonsonant.Vokal.rawValue
    लृ.artikulation = Artikulation.palatal.rawValue
    लृ.aspiration = Aspiration.NichtAspiriert.rawValue
    लृ.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    लृ.lektion = 16
    लृ.vokalOderHalbvokal = VokalOderHalbvokal.Halbvokal.rawValue
    लृ.grundZeichen = "ल"
    
    let वृ = Zeichen()
    वृ.ID = 1
    वृ.devanagari = "वृ"
    वृ.umschrift = "vṛ"
    वृ.vokalOderKonsonant = VokalOderKonsonant.Vokal.rawValue
    वृ.artikulation = nil
    वृ.aspiration = Aspiration.NichtAspiriert.rawValue
    वृ.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    वृ.lektion = 16
    वृ.vokalOderHalbvokal = VokalOderHalbvokal.Halbvokal.rawValue
    वृ.grundZeichen = "व"
    
    let रृ = Zeichen()
    रृ.ID = 1
    रृ.devanagari = "रृ"
    रृ.umschrift = "rṛ"
    रृ.vokalOderKonsonant = VokalOderKonsonant.Vokal.rawValue
    रृ.artikulation = nil
    रृ.aspiration = Aspiration.NichtAspiriert.rawValue
    रृ.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    रृ.lektion = 16
    रृ.vokalOderHalbvokal = VokalOderHalbvokal.Halbvokal.rawValue
    रृ.grundZeichen = "र"
    
    let यॄ = Zeichen()
    यॄ.ID = 1
    यॄ.devanagari = "यॄ"
    यॄ.umschrift = "yṝ"
    यॄ.vokalOderKonsonant = VokalOderKonsonant.Vokal.rawValue
    यॄ.artikulation = nil
    यॄ.aspiration = Aspiration.NichtAspiriert.rawValue
    यॄ.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    यॄ.lektion = 16
    यॄ.vokalOderHalbvokal = VokalOderHalbvokal.Halbvokal.rawValue
    यॄ.grundZeichen = "य"
    
    let रॄ = Zeichen()
    रॄ.ID = 1
    रॄ.devanagari = "रॄ"
    रॄ.umschrift = "rṝ"
    रॄ.vokalOderKonsonant = VokalOderKonsonant.Vokal.rawValue
    रॄ.artikulation = nil
    रॄ.aspiration = Aspiration.NichtAspiriert.rawValue
    रॄ.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    रॄ.lektion = 16
    रॄ.vokalOderHalbvokal = VokalOderHalbvokal.Halbvokal.rawValue
    रॄ.grundZeichen = "र"
    
    let वॄ = Zeichen()
    वॄ.ID = 1
    वॄ.devanagari = "वॄ"
    वॄ.umschrift = "vṝ"
    वॄ.vokalOderKonsonant = VokalOderKonsonant.Vokal.rawValue
    वॄ.artikulation = nil
    वॄ.aspiration = Aspiration.NichtAspiriert.rawValue
    वॄ.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    वॄ.lektion = 16
    वॄ.vokalOderHalbvokal = VokalOderHalbvokal.Halbvokal.rawValue
    वॄ.grundZeichen = "व"
    
    let लॄ = Zeichen()
    लॄ.ID = 1
    लॄ.devanagari = "लॄ"
    लॄ.umschrift = "lṝ"
    लॄ.vokalOderKonsonant = VokalOderKonsonant.Vokal.rawValue
    लॄ.artikulation = nil
    लॄ.aspiration = Aspiration.NichtAspiriert.rawValue
    लॄ.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    लॄ.lektion = 16
    लॄ.vokalOderHalbvokal = VokalOderHalbvokal.Halbvokal.rawValue
    लॄ.grundZeichen = "ल"
    
    //Lektion 17
    let स = Zeichen()
    स.ID = 1
    स.devanagari = "स"
    स.umschrift = "sa"
    स.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    स.konsonantTyp = KonsonantTyp.Sibilant.rawValue //Sibilant
    स.artikulation = nil
    स.aspiration = Aspiration.NichtAspiriert.rawValue
    स.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    स.lektion = 17
    स.grundZeichen = "स"
    
    let श = Zeichen()
    श.ID = 1
    श.devanagari = "श"
    श.umschrift = "śa"
    श.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    श.konsonantTyp = KonsonantTyp.Sibilant.rawValue //Sibilant
    श.artikulation = nil
    श.aspiration = Aspiration.NichtAspiriert.rawValue
    श.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    श.lektion = 17
    श.grundZeichen = "श"
    
    let ष = Zeichen()
    ष.ID = 1
    ष.devanagari = "ष"
    ष.umschrift = "ṣa"
    ष.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    ष.konsonantTyp = KonsonantTyp.Sibilant.rawValue //Sibilant
    ष.artikulation = nil
    ष.aspiration = Aspiration.NichtAspiriert.rawValue
    ष.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    ष.lektion = 17
    ष.grundZeichen = "ष"
    
    let सि = Zeichen()
    सि.ID = 1
    सि.devanagari = "सि"
    सि.umschrift = "si"
    सि.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    सि.konsonantTyp = KonsonantTyp.Sibilant.rawValue //Sibilant
    सि.artikulation = nil
    सि.aspiration = Aspiration.NichtAspiriert.rawValue
    सि.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    सि.lektion = 17
    सि.grundZeichen = "स"
    
    let सी = Zeichen()
    सी.ID = 1
    सी.devanagari = "सी"
    सी.umschrift = "sī"
    सी.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    सी.konsonantTyp = KonsonantTyp.Sibilant.rawValue //Sibilant
    सी.artikulation = nil
    सी.aspiration = Aspiration.NichtAspiriert.rawValue
    सी.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    सी.lektion = 17
    सी.grundZeichen = "स"
    
    let सा = Zeichen()
    सा.ID = 1
    सा.devanagari = "सा"
    सा.umschrift = "sā"
    सा.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    सा.konsonantTyp = KonsonantTyp.Sibilant.rawValue //Sibilant
    सा.artikulation = nil
    सा.aspiration = Aspiration.NichtAspiriert.rawValue
    सा.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    सा.lektion = 17
    सा.grundZeichen = "स"
    
    let सु = Zeichen()
    सु.ID = 1
    सु.devanagari = "सु"
    सु.umschrift = "su"
    सु.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    सु.konsonantTyp = KonsonantTyp.Sibilant.rawValue
    सु.artikulation = nil
    सु.aspiration = Aspiration.NichtAspiriert.rawValue
    सु.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    सु.lektion = 17
    सु.grundZeichen = "स"
    
    let सू = Zeichen()
    सू.ID = 1
    सू.devanagari = "सू"
    सू.umschrift = "sū"
    सू.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    सू.konsonantTyp = KonsonantTyp.Sibilant.rawValue //Sibilant
    सू.artikulation = nil
    सू.aspiration = Aspiration.NichtAspiriert.rawValue
    सू.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    सू.lektion = 17
    सू.grundZeichen = "स"
    
    let से = Zeichen()
    से.ID = 1
    से.devanagari = "से"
    से.umschrift = "se"
    से.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    से.konsonantTyp = KonsonantTyp.Sibilant.rawValue //Sibilant
    से.artikulation = nil
    से.aspiration = Aspiration.NichtAspiriert.rawValue
    से.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    से.lektion = 17
    से.grundZeichen = "स"
    
    let सै = Zeichen()
    सै.ID = 1
    सै.devanagari = "सै"
    सै.umschrift = "sai"
    सै.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    सै.konsonantTyp = KonsonantTyp.Sibilant.rawValue //Sibilant
    सै.artikulation = nil
    सै.aspiration = Aspiration.NichtAspiriert.rawValue
    सै.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    सै.lektion = 17
    सै.grundZeichen = "स"
    
    let सो = Zeichen()
    सो.ID = 1
    सो.devanagari = "सो"
    सो.umschrift = "so"
    सो.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    सो.konsonantTyp = KonsonantTyp.Sibilant.rawValue //Sibilant
    सो.artikulation = nil
    सो.aspiration = Aspiration.NichtAspiriert.rawValue
    सो.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    सो.lektion = 17
    सो.grundZeichen = "स"
    
    let सौ = Zeichen()
    सौ.ID = 1
    सौ.devanagari = "सौ"
    सौ.umschrift = "sau"
    सौ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    सौ.konsonantTyp = KonsonantTyp.Sibilant.rawValue //Sibilant
    सौ.artikulation = nil
    सौ.aspiration = Aspiration.NichtAspiriert.rawValue
    सौ.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    सौ.lektion = 17
    सौ.grundZeichen = "स"
    
    let शा = Zeichen()
    शा.ID = 1
    शा.devanagari = "शा"
    शा.umschrift = "śā"
    शा.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    शा.konsonantTyp = KonsonantTyp.Sibilant.rawValue //Sibilant
    शा.artikulation = nil
    शा.aspiration = Aspiration.NichtAspiriert.rawValue
    शा.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    शा.lektion = 17
    शा.grundZeichen = "श"
    
    let शि = Zeichen()
    शि.ID = 1
    शि.devanagari = "शि"
    शि.umschrift = "śi"
    शि.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    शि.konsonantTyp = KonsonantTyp.Sibilant.rawValue //Sibilant
    शि.artikulation = nil
    शि.aspiration = Aspiration.NichtAspiriert.rawValue
    शि.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    शि.lektion = 17
    शि.grundZeichen = "श"
    
    let शी = Zeichen()
    शी.ID = 1
    शी.devanagari = "शी"
    शी.umschrift = "śī"
    शी.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    शी.konsonantTyp = KonsonantTyp.Sibilant.rawValue //Sibilant
    शी.artikulation = nil
    शी.aspiration = Aspiration.NichtAspiriert.rawValue
    शी.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    शी.lektion = 17
    शी.grundZeichen = "श"
    
    let शु = Zeichen()
    शु.ID = 1
    शु.devanagari = "शु"
    शु.umschrift = "śu"
    शु.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    शु.konsonantTyp = KonsonantTyp.Sibilant.rawValue //Sibilant
    शु.artikulation = nil
    शु.aspiration = Aspiration.NichtAspiriert.rawValue
    शु.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    शु.lektion = 17
    शु.grundZeichen = "श"
    
    let शू = Zeichen()
    शू.ID = 1
    शू.devanagari = "शू"
    शू.umschrift = "śū"
    शू.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    शू.konsonantTyp = KonsonantTyp.Sibilant.rawValue //Sibilant
    शू.artikulation = nil
    शू.aspiration = Aspiration.NichtAspiriert.rawValue
    शू.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    शू.lektion = 17
    शू.grundZeichen = "श"
    
    let शे = Zeichen()
    शे.ID = 1
    शे.devanagari = "शे"
    शे.umschrift = "śe"
    शे.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    शे.konsonantTyp = KonsonantTyp.Sibilant.rawValue //Sibilant
    शे.artikulation = nil
    शे.aspiration = Aspiration.NichtAspiriert.rawValue
    शे.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    शे.lektion = 17
    शे.grundZeichen = "श"
    
    let शै = Zeichen()
    शै.ID = 1
    शै.devanagari = "शै"
    शै.umschrift = "śai"
    शै.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    शै.konsonantTyp = KonsonantTyp.Sibilant.rawValue //Sibilant
    शै.artikulation = nil
    शै.aspiration = Aspiration.NichtAspiriert.rawValue
    शै.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    शै.lektion = 17
    शै.grundZeichen = "श"
    
    let शो = Zeichen()
    शो.ID = 1
    शो.devanagari = "शो"
    शो.umschrift = "śo"
    शो.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    शो.konsonantTyp = KonsonantTyp.Sibilant.rawValue //Sibilant
    शो.artikulation = nil
    शो.aspiration = Aspiration.NichtAspiriert.rawValue
    शो.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    शो.lektion = 17
    शो.grundZeichen = "श"
    
    let शौ = Zeichen()
    शौ.ID = 1
    शौ.devanagari = "शौ"
    शौ.umschrift = "śau"
    शौ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    शौ.konsonantTyp = KonsonantTyp.Sibilant.rawValue //Sibilant
    शौ.artikulation = nil
    शौ.aspiration = Aspiration.NichtAspiriert.rawValue
    शौ.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    शौ.lektion = 17
    शौ.grundZeichen = "श"
    
    let षा = Zeichen()
    षा.ID = 1
    षा.devanagari = "षा"
    षा.umschrift = "ṣā"
    षा.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    षा.konsonantTyp = KonsonantTyp.Sibilant.rawValue //Sibilant
    षा.artikulation = nil
    षा.aspiration = Aspiration.NichtAspiriert.rawValue
    षा.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    षा.lektion = 17
    षा.grundZeichen = "ष"
    
    let षि = Zeichen()
    षि.ID = 1
    षि.devanagari = "षि"
    षि.umschrift = "ṣi"
    षि.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    षि.konsonantTyp = KonsonantTyp.Sibilant.rawValue //Sibilant
    षि.artikulation = nil
    षि.aspiration = Aspiration.NichtAspiriert.rawValue
    षि.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    षि.lektion = 17
    षि.grundZeichen = "ष"
    
    let षी = Zeichen()
    षी.ID = 1
    षी.devanagari = "षी"
    षी.umschrift = "ṣī"
    षी.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    षी.konsonantTyp = KonsonantTyp.Sibilant.rawValue //Sibilant
    षी.artikulation = nil
    षी.aspiration = Aspiration.NichtAspiriert.rawValue
    षी.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    षी.lektion = 17
    षी.grundZeichen = "ष"
    
    let षु = Zeichen()
    षु.ID = 1
    षु.devanagari = "षु"
    षु.umschrift = "ṣu"
    षु.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    षु.konsonantTyp = KonsonantTyp.Sibilant.rawValue //Sibilant
    षु.artikulation = nil
    षु.aspiration = Aspiration.NichtAspiriert.rawValue
    षु.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    षु.lektion = 17
    षु.grundZeichen = "ष"
    
    let षू = Zeichen()
    षू.ID = 1
    षू.devanagari = "षू"
    षू.umschrift = "ṣū"
    षू.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    षू.konsonantTyp = KonsonantTyp.Sibilant.rawValue //Sibilant
    षू.artikulation = nil
    षू.aspiration = Aspiration.NichtAspiriert.rawValue
    षू.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    षू.lektion = 17
    षू.grundZeichen = "ष"
    
    let षे = Zeichen()
    षे.ID = 1
    षे.devanagari = "षे"
    षे.umschrift = "ṣe"
    षे.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    षे.konsonantTyp = KonsonantTyp.Sibilant.rawValue //Sibilant
    षे.artikulation = nil
    षे.aspiration = Aspiration.NichtAspiriert.rawValue
    षे.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    षे.lektion = 17
    षे.grundZeichen = "ष"
    
    let षै = Zeichen()
    षै.ID = 1
    षै.devanagari = "षै"
    षै.umschrift = "ṣai"
    षै.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    षै.konsonantTyp = KonsonantTyp.Sibilant.rawValue //Sibilant
    षै.artikulation = nil
    षै.aspiration = Aspiration.NichtAspiriert.rawValue
    षै.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    षै.lektion = 17
    षै.grundZeichen = "ष"
    
    let षो = Zeichen()
    षो.ID = 1
    षो.devanagari = "षो"
    षो.umschrift = "ṣo"
    षो.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    षो.konsonantTyp = KonsonantTyp.Sibilant.rawValue //Sibilant
    षो.artikulation = nil
    षो.aspiration = Aspiration.NichtAspiriert.rawValue
    षो.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    षो.lektion = 17
    षो.grundZeichen = "ष"
    
    let षौ = Zeichen()
    षौ.ID = 1
    षौ.devanagari = "षौ"
    षौ.umschrift = "ṣau"
    षौ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    षौ.konsonantTyp = KonsonantTyp.Sibilant.rawValue //Sibilant
    षौ.artikulation = nil
    षौ.aspiration = Aspiration.NichtAspiriert.rawValue
    षौ.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    षौ.lektion = 17
    षौ.grundZeichen = "ष"
    
    
    let सृ = Zeichen()
    सृ.ID = 1
    सृ.devanagari = "सृ"
    सृ.umschrift = "sṛ"
    सृ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    सृ.konsonantTyp = KonsonantTyp.Sibilant.rawValue //Sibilant
    सृ.artikulation = nil
    सृ.aspiration = Aspiration.NichtAspiriert.rawValue
    सृ.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    सृ.lektion = 17
    सृ.grundZeichen = "स"
    
    
    let षृ = Zeichen()
    षृ.ID = 1
    षृ.devanagari = "षृ"
    षृ.umschrift = "ṣṛ"
    षृ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    षृ.konsonantTyp = KonsonantTyp.Sibilant.rawValue //Sibilant
    षृ.artikulation = nil
    षृ.aspiration = Aspiration.NichtAspiriert.rawValue
    षृ.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    षृ.lektion = 17
    षृ.grundZeichen = "ष"
    
    let शृ = Zeichen()
    शृ.ID = 1
    शृ.devanagari = "शृ"
    शृ.umschrift = "śṛ"
    शृ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    शृ.konsonantTyp = KonsonantTyp.Sibilant.rawValue //Sibilant
    शृ.artikulation = nil
    शृ.aspiration = Aspiration.NichtAspiriert.rawValue
    शृ.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    शृ.lektion = 17
    शृ.grundZeichen = "श"
    
    let सॄ = Zeichen()
    सॄ.ID = 1
    सॄ.devanagari = "सॄ"
    सॄ.umschrift = "sṝ"
    सॄ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    सॄ.konsonantTyp = KonsonantTyp.Sibilant.rawValue //Sibilant
    सॄ.artikulation = nil
    सॄ.aspiration = Aspiration.NichtAspiriert.rawValue
    सॄ.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    सॄ.lektion = 17
    सॄ.grundZeichen = "स"
    
    let शॄ = Zeichen()
    शॄ.ID = 1
    शॄ.devanagari = "शॄ"
    शॄ.umschrift = "śṝ"
    शॄ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    शॄ.konsonantTyp = KonsonantTyp.Sibilant.rawValue //Sibilant
    शॄ.artikulation = nil
    शॄ.aspiration = Aspiration.NichtAspiriert.rawValue
    शॄ.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    शॄ.lektion = 17
    शॄ.grundZeichen = "श"
    
    let षॄ = Zeichen()
    षॄ.ID = 1
    षॄ.devanagari = "षॄ"
    षॄ.umschrift = "ṣṝ"
    षॄ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    षॄ.konsonantTyp = KonsonantTyp.Sibilant.rawValue //Sibilant
    षॄ.artikulation = nil
    षॄ.aspiration = Aspiration.NichtAspiriert.rawValue
    षॄ.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    षॄ.lektion = 17
    षॄ.grundZeichen = "ष"
    
    //Lektion 18
    let ह = Zeichen()
    ह.ID = 1
    ह.devanagari = "ह"
    ह.umschrift = "ha"
    ह.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    ह.konsonantTyp = KonsonantTyp.Hauchlaut.rawValue//Hauchlaut
    ह.artikulation = nil
    ह.aspiration = Aspiration.NichtAspiriert.rawValue
    ह.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    ह.lektion = 18
    ह.grundZeichen = "ह"
    
    let हि = Zeichen()
    हि.ID = 1
    हि.devanagari = "हि"
    हि.umschrift = "hi"
    हि.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    हि.konsonantTyp = KonsonantTyp.Hauchlaut.rawValue //Hauchlaut
    हि.artikulation = nil
    हि.aspiration = Aspiration.NichtAspiriert.rawValue
    हि.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    हि.lektion = 18
    हि.grundZeichen = "ह"
    
    let ही = Zeichen()
    ही.ID = 1
    ही.devanagari = "ही"
    ही.umschrift = "hī"
    ही.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    ही.konsonantTyp = KonsonantTyp.Hauchlaut.rawValue //Hauchlaut
    ही.artikulation = nil
    ही.aspiration = Aspiration.NichtAspiriert.rawValue
    ही.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    ही.lektion = 18
    ही.grundZeichen = "ह"
    
    let हा = Zeichen()
    हा.ID = 1
    हा.devanagari = "हा"
    हा.umschrift = "hā"
    हा.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    हा.konsonantTyp = KonsonantTyp.Hauchlaut.rawValue //Hauchlaut
    हा.artikulation = nil
    हा.aspiration = Aspiration.NichtAspiriert.rawValue
    हा.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    हा.lektion = 18
    हा.grundZeichen = "ह"
    
    let हु = Zeichen()
    हु.ID = 1
    हु.devanagari = "हु"
    हु.umschrift = "hu"
    हु.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    हु.konsonantTyp = KonsonantTyp.Hauchlaut.rawValue //Hauchlaut
    हु.artikulation = nil
    हु.aspiration = Aspiration.NichtAspiriert.rawValue
    हु.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    हु.lektion = 18
    हु.grundZeichen = "ह"
    
    let हू = Zeichen()
    हू.ID = 1
    हू.devanagari = "हू"
    हू.umschrift = "hū"
    हू.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    हू.konsonantTyp = KonsonantTyp.Hauchlaut.rawValue //Hauchlaut
    हू.artikulation = nil
    हू.aspiration = Aspiration.NichtAspiriert.rawValue
    हू.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    हू.lektion = 18
    हू.grundZeichen = "ह"
    
    let हे = Zeichen()
    हे.ID = 1
    हे.devanagari = "हे"
    हे.umschrift = "he"
    हे.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    हे.konsonantTyp = KonsonantTyp.Hauchlaut.rawValue //Hauchlaut
    हे.artikulation = nil
    हे.aspiration = Aspiration.NichtAspiriert.rawValue
    हे.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    हे.lektion = 18
    हे.grundZeichen = "ह"
    
    let है = Zeichen()
    है.ID = 1
    है.devanagari = "है"
    है.umschrift = "hai"
    है.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    है.konsonantTyp = KonsonantTyp.Hauchlaut.rawValue //Hauchlaut
    है.artikulation = nil
    है.aspiration = Aspiration.NichtAspiriert.rawValue
    है.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    है.lektion = 18
    है.grundZeichen = "ह"
    
    let हो = Zeichen()
    हो.ID = 1
    हो.devanagari = "हो"
    हो.umschrift = "ho"
    हो.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    हो.konsonantTyp = KonsonantTyp.Hauchlaut.rawValue //Hauchlaut
    हो.artikulation = nil
    हो.aspiration = Aspiration.NichtAspiriert.rawValue
    हो.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    हो.lektion = 18
    हो.grundZeichen = "ह"
    
    let हौ = Zeichen()
    हौ.ID = 1
    हौ.devanagari = "हौ"
    हौ.umschrift = "hau"
    हौ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    हौ.konsonantTyp = KonsonantTyp.Hauchlaut.rawValue //Hauchlaut
    हौ.artikulation = nil
    हौ.aspiration = Aspiration.NichtAspiriert.rawValue
    हौ.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    हौ.lektion = 18
    हौ.grundZeichen = "ह"
    
    let हृ = Zeichen()
    हृ.ID = 1
    हृ.devanagari = "हृ"
    हृ.umschrift = "hṛ"
    हृ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    हृ.konsonantTyp = KonsonantTyp.Hauchlaut.rawValue //Hauchlaut
    हृ.artikulation = nil
    हृ.aspiration = Aspiration.NichtAspiriert.rawValue
    हृ.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    हृ.lektion = 18
    हृ.grundZeichen = "ह"
    
    let हॄ = Zeichen()
    हॄ.ID = 1
    हॄ.devanagari = "हॄ"
    हॄ.umschrift = "hṝ"
    हॄ.vokalOderKonsonant = VokalOderKonsonant.Konsonant.rawValue
    हॄ.konsonantTyp = KonsonantTyp.Hauchlaut.rawValue //Hauchlaut
    हॄ.artikulation = nil
    हॄ.aspiration = Aspiration.NichtAspiriert.rawValue
    हॄ.stimmhaftigkeit = Stimmhaftigkeit.NichtStimmhaft.rawValue
    हॄ.lektion = 18
    हॄ.grundZeichen = "ह"
    
    
    
    
    
    let zeichensatz = [
            अ,इ,उ,                               //1
            क,प,                                //2
            ए,ओ,                                //3
            कि,कु,के,को,पि,पु,पे,पो,                  //4
            त,च,ति,तु,ते,तो,चि,चु,चे,चो,               //5
            आ,ई,ऊ,का,की,कू,चा,ची,चू,ता,ती,तू,पा,पी,पू,  //6
            ट,टि,टु,टे,टो,टा,टी,टू,                     //7
            औ,ऐ,कौ,कै,चौ,चै,टौ,टै,तौ,तै,पौ,पै,          //8
            ख,छ,ठ,थ,फ,                          //9
    
            खा,खि,खी,खु,खू,खे,खै,खो,खौ,
            छा,छि,छी,छु,छू,छे,छै,छो,छौ,
            ठा,ठि,ठी,ठु,ठू,ठे,ठै,ठो,ठौ,
            था,थि,थी,थु,थू,थे,थै,थो,थौ,
            फा,फि,फी,फु,फू,फे,फै,फो,फौ,             //10
    
            ऋ,ॠ,कृ,खृ,चृ,छृ,टृ,ठृ,तृ,थृ,पृ,फृ,
            कॄ,खॄ,चॄ,छॄ,टॄ,ठॄ,तॄ,थॄ,पॄ,फॄ,               //11
    
            ग,घ,ज,झ,ब,भ,                        //12
    
            गा,गि,गी,गु,गू,गे,गै,गो,गौ,गृ,गॄ,
            जा,जि,जी,जु,जू,जे,जै,जो,जौ,जृ,जॄ,
            बा,बि,बी,बु,बू,बे,बै,बो,बौ,बृ,बॄ,
            घा,घि,घी,घु,घू,घे,घै,घो,घौ,घृ,घॄ,
            झा,झि,झी,झु,झू,झे,झै,झो,झौ,झृ,झॄ,
            भा,भि,भी,भु,भू,भे,भै,भो,भौ,भृ,भॄ,           //13
    
            ड,ढ,द,ध,
            डा,डि,डी,डु,डू,डे,डै,डो,डौ,डृ,डॄ,
            दा,दि,दी,दु,दू,दे,दै,दो,दौ,दृ,दॄ,
            ढा,ढि,ढी,ढु,ढू,ढे,ढै,ढो,ढौ,ढृ,ढॄ,
            धा,धि,धी,धु,धू,धे,धै,धो,धौ,धृ,धॄ,           //14
    
    
            ङ,ञ,ण,न,म,                          //15
    
            ङि,ङी,ङा,ङु,ङू,ङे,ङै,ङो,ङौ,
            ञा,ञि,ञी,ञु,ञू,ञे,ञै,ञो,ञौ,
            णा,णि,णी,णु,णू,णे,णै,णो,णौ,
            ना,नि,नी,नु,नू,ने,नै,नो,नौ,
            मा,मि,मी,मु,मू,मे,मै,मो,मौ,
            ङृ,ञृ,णृ,नृ,मृ,
            ङॄ,ञॄ,णॄ,नॄ,मॄ,                          //16
    
            य,या,यि,यी,यु,यू,ये,यै,यो,यौ,यृ,यॄ,
            र,रा,रि,री,रु,रू,रे,रै,रो,रौ,रृ,रॄ,
            व,वा,वि,वी,वु,वू,वे,वै,वो,वौ,वृ,वॄ,
            ल,ला,लि,ली,लु,लू,ले,लै,लो,लौ,लृ,लॄ,        //17
    
    
            स,सा,सि,सी,सु,सू,से,सै,सो,सौ,सृ,सॄ,
            श,शा,शि,शी,शु,शू,शे,शै,शो,शौ,शृ,शॄ,
            ष,षा,षि,षी,षु,षू,षे,षै,षो,षौ,षृ,षॄ,             //18
    
            ह,हा,हि,ही,हु,हू,हे,है,हो,हौ,हृ,हॄ,              //19
            ]


    let न्द = Zeichen()
    न्द.devanagari = "न्द"
    न्द.umschrift = "nd"
    न्द.lektion = 21
    
    let न्म = Zeichen()
    न्म.devanagari = "न्म"
    न्म.umschrift = "nm"
    न्म.lektion = 21
    
    let न्ध = Zeichen()
    न्ध.devanagari = "न्ध"
    न्ध.umschrift = "ndh"
    न्ध.lektion = 21
    
    let न्त = Zeichen()
    न्त.devanagari = "न्त"
    न्त.umschrift = "nt"
    न्त.lektion = 21
    
    let त्य = Zeichen()
    त्य.devanagari = "त्य"
    त्य.umschrift = "ty"
    त्य.lektion = 21
    
    let प्त = Zeichen()
    प्त.devanagari = "प्त"
    प्त.umschrift = "pt"
    प्त.lektion = 21
    
    let प्स = Zeichen()
    प्स.devanagari = "प्स"
    प्स.umschrift = "ps"
    प्स.lektion = 21
    
    let न्न = Zeichen()
    न्न.devanagari = "न्न"
    न्न.umschrift = "nn"
    न्न.lektion = 21
    
    let ब्द = Zeichen()
    ब्द.devanagari = "ब्द"
    ब्द.umschrift = "bd"
    ब्द.lektion = 21
    
    let स्य = Zeichen()
    स्य.devanagari = "स्य"
    स्य.umschrift = "sy"
    स्य.lektion = 21
    
    let स्त = Zeichen()
    स्त.devanagari = "स्त"
    स्त.umschrift = "st"
    स्त.lektion = 21
    
    let स्प = Zeichen()
    स्प.devanagari = "स्प"
    स्प.umschrift = "sp"
    स्प.lektion = 21
    
    let स्व = Zeichen()
    स्व.devanagari = "स्व"
    स्व.umschrift = "sv"
    स्व.lektion = 21
    
    let स्न = Zeichen()
    स्न.devanagari = "स्न"
    स्न.umschrift = "sn"
    स्न.lektion = 21
    
    let ज्य = Zeichen()
    ज्य.devanagari = "ज्य"
    ज्य.umschrift = "jy"
    ज्य.lektion = 21
    
    let श्य = Zeichen()
    श्य.devanagari = "श्य"
    श्य.umschrift = "śy"
    श्य.lektion = 21
    
    let व्य = Zeichen()
    व्य.devanagari = "व्य"
    व्य.umschrift = "vy"
    व्य.lektion = 21
    
    let ल्य = Zeichen()
    ल्य.devanagari = "ल्य"
    ल्य.umschrift = "ly"
    ल्य.lektion = 21
    
    let म्ब = Zeichen()
    म्ब.devanagari = "म्ब"
    म्ब.umschrift = "mb"
    म्ब.lektion = 21
    
    let ष्त = Zeichen()
    ष्त.devanagari = "ष्त"
    ष्त.umschrift = "ṣt"
    ष्त.lektion = 21
    
    let य्य = Zeichen()
    य्य.devanagari = "य्य"
    य्य.umschrift = "yy"
    य्य.lektion = 21
    
    let क्थ = Zeichen()
    क्थ.devanagari = "क्थ"
    क्थ.umschrift = "kth"
    क्थ.lektion = 21
    
    let क्ख = Zeichen()
    क्ख.devanagari = "क्ख"
    क्ख.umschrift = "kkh"
    क्ख.lektion = 21
    
    
    //////////////////////////////
    //Lektion 21
    let श्च = Zeichen()
    श्च.devanagari = "श्च"
    श्च.umschrift = "śc"
    श्च.lektion = 22
    
    let श्र = Zeichen()
    श्र.devanagari = "श्र"
    श्र.umschrift = "śr"
    श्र.lektion = 22
    
    let श्न = Zeichen()
    श्न.devanagari = "श्न"
    श्न.umschrift = "śn"
    श्न.lektion = 22
    
    let ग्द = Zeichen()
    ग्द.devanagari = "ग्द"
    ग्द.umschrift = "gd"
    ग्द.lektion = 22
    
    let ग्ध = Zeichen()
    ग्ध.devanagari = "ग्ध"
    ग्ध.umschrift = "gdh"
    ग्ध.lektion = 22
    
    let प्र = Zeichen()
    प्र.devanagari = "प्र"
    प्र.umschrift = "pr"
    प्र.lektion = 22
    
    let त्र = Zeichen()
    त्र.devanagari = "त्र"
    त्र.umschrift = "tr"
    त्र.lektion = 22
    
    let र्ग = Zeichen()
    र्ग.devanagari = "र्ग"
    र्ग.umschrift = "rg"
    र्ग.lektion = 22
    
    let र्क = Zeichen()
    र्क.devanagari = "र्क"
    र्क.umschrift = "rk"
    र्क.lektion = 22
    
    let र्न्द = Zeichen()
    र्न्द.devanagari = "र्न्द"
    र्न्द.umschrift = "rnd"
    र्न्द.lektion = 22
    
    let र्ध = Zeichen()
    र्ध.devanagari = "र्ध"
    र्ध.umschrift = "rdh"
    र्ध.lektion = 22
    
    let र्भ = Zeichen()
    र्भ.devanagari = "र्भ"
    र्भ.umschrift = "rbh"
    र्भ.lektion = 22
    
    let र्ब = Zeichen()
    र्ब.devanagari = "र्ब"
    र्ब.umschrift = "rb"
    र्ब.lektion = 22
    
    let र्न = Zeichen()
    र्न.devanagari = "र्न"
    र्न.umschrift = "rn"
    र्न.lektion = 22
    
    let क्र = Zeichen()
    क्र.devanagari = "क्र"
    क्र.umschrift = "kr"
    क्र.lektion = 22
    
    let स्र = Zeichen()
    स्र.devanagari = "स्र"
    स्र.umschrift = "sr"
    स्र.lektion = 22
    
    let ह्र = Zeichen()
    ह्र.devanagari = "ह्र"
    ह्र.umschrift = "hr"
    ह्र.lektion = 22
    
    let न्त्र = Zeichen()
    न्त्र.devanagari = "न्त्र"
    न्त्र.umschrift = "ntr"
    न्त्र.lektion = 22
    
    let त्त = Zeichen()
    त्त.devanagari = "त्त"
    त्त.umschrift = "tt"
    त्त.lektion = 22
    
    let ष्ट = Zeichen()
    ष्ट.devanagari = "ष्ट"
    ष्ट.umschrift = "ṣṭ"
    ष्ट.lektion = 22
    
    let ष्ठ = Zeichen()
    ष्ठ.devanagari = "ष्ठ"
    ष्ठ.umschrift = "ṣṭh"
    ष्ठ.lektion = 22
    
    let क्त = Zeichen()
    क्त.devanagari = "क्त"
    क्त.umschrift = "kt"
    क्त.lektion = 22
    //////////////////////////////
    //Lektion 21
    
    let ज्ञ = Zeichen()
    ज्ञ.devanagari = "ज्ञ"
    ज्ञ.umschrift = "jñ"
    ज्ञ.lektion = 23
    
    let क्ष = Zeichen()
    क्ष.devanagari = "क्ष"
    क्ष.umschrift = "kṣ"
    क्ष.lektion = 23
    
    let क्ष्म = Zeichen()
    क्ष्म.devanagari = "क्ष्म"
    क्ष्म.umschrift = "kṣm"
    क्ष्म.lektion = 23
    
    let क्ष्म्य = Zeichen()
    क्ष्म्य.devanagari = "क्ष्म्य"
    क्ष्म्य.umschrift = "kṣmy"
    क्ष्म्य.lektion = 23
    
    let ह्म = Zeichen()
    ह्म.devanagari = "ह्म"
    ह्म.umschrift = "hm"
    ह्म.lektion = 23
    
    
    let ह्य = Zeichen()
    ह्य.devanagari = "ह्य"
    ह्य.umschrift = "hy"
    ह्य.lektion = 23
    
    let ह्व = Zeichen()
    ह्व.devanagari = "ह्व"
    ह्व.umschrift = "hv"
    ह्व.lektion = 23
    
    let ह्न = Zeichen()
    ह्न.devanagari = "ह्न"
    ह्न.umschrift = "hn"
    ह्न.lektion = 23
    
    let ह्ण = Zeichen()
    ह्ण.devanagari = "ह्ण"
    ह्ण.umschrift = "hṇ"
    ह्ण.lektion = 23
    
    let द्व = Zeichen()
    द्व.devanagari = "द्व"
    द्व.umschrift = "dv"
    द्व.lektion = 23
    
    let द्ध = Zeichen()
    द्ध.devanagari = "द्ध"
    द्ध.umschrift = "ddh"
    द्ध.lektion = 23
    
    let द्म = Zeichen()
    द्म.devanagari = "द्म"
    द्म.umschrift = "dm"
    द्म.lektion = 23
    
    let द्य = Zeichen()
    द्य.devanagari = "द्य"
    द्य.umschrift = "dy"
    द्य.lektion = 23
    
    let द्ग = Zeichen()
    द्ग.devanagari = "द्ग"
    द्ग.umschrift = "dg"
    द्ग.lektion = 23
    
    let द्भ = Zeichen()
    द्भ.devanagari = "द्भ"
    द्भ.umschrift = "dbh"
    द्भ.lektion = 23
    
    let द्ब = Zeichen()
    द्ब.devanagari = "द्ब"
    द्ब.umschrift = "db"
    द्ब.lektion = 23
    
    let ञ्च = Zeichen()
    ञ्च.devanagari = "ञ्च"
    ञ्च.umschrift = "ñc"
    ञ्च.lektion = 23
    
    let ञ्ज = Zeichen()
    ञ्ज.devanagari = "ञ्ज"
    ञ्ज.umschrift = "ñj"
    ञ्ज.lektion = 23
    
    let च्च = Zeichen()
    च्च.devanagari = "च्च"
    च्च.umschrift = "cc"
    च्च.lektion = 23
    
    let क्क = Zeichen()
    क्क.devanagari = "क्क"
    क्क.umschrift = "kk"
    क्क.lektion = 23
    
    let ष्ण = Zeichen()
    ष्ण.devanagari = "ष्ण"
    ष्ण.umschrift = "ṣṇ"
    ष्ण.lektion = 23
    
    let ण्य = Zeichen()
    ण्य.devanagari = "ण्य"
    ण्य.umschrift = "ṇy"
    ण्य.lektion = 23
    
    //Lektion 24 (25)
    let ॐ = Zeichen()
    ॐ.devanagari = "ॐ"
    ॐ.umschrift = "om"
    ॐ.lektion = 24
    
    let ब्र = Zeichen()
    ब्र.devanagari = "ब्र"
    ब्र.umschrift = "br"
    ब्र.lektion = 24
    
    let स्म = Zeichen()
    स्म.devanagari = "स्म"
    स्म.umschrift = "sm"
    स्म.lektion = 24
    
    let त्त्व = Zeichen()
    त्त्व.devanagari = "त्त्व"
    त्त्व.umschrift = "ttv"
    त्त्व.lektion = 24
    
    let क्ल = Zeichen()
    क्ल.devanagari = "क्ल"
    क्ल.umschrift = "kl"
    क्ल.lektion = 24
    
    let ण्ड = Zeichen()
    ण्ड.devanagari = "ण्ड"
    ण्ड.umschrift = "ṇḍ"
    ण्ड.lektion = 24
    
    let rva = Zeichen()
    rva.devanagari = "र्व"
    rva.umschrift = "rv"
    rva.lektion = 24
    
    let rma = Zeichen()
    rma.devanagari = "र्म"
    rma.umschrift = "rm"
    rma.lektion = 24
    
    let स्त्र = Zeichen()
    स्त्र.devanagari = "स्त्र"
    स्त्र.umschrift = "str"
    स्त्र.lektion = 24
    
    
    let त्स = Zeichen()
    त्स.devanagari = "त्स"
    त्स.umschrift = "ts"
    त्स.lektion = 24
    
    //sonderzeichen
    let leerZeichen = Zeichen()
    leerZeichen.devanagari = " "
    leerZeichen.lektion = 1000
    
    let visarga = Zeichen()
    visarga.devanagari = "ः"
    visarga.lektion = 1000
    
    let anusvara = Zeichen()
    anusvara.devanagari = "ं"
    anusvara.lektion = 1000
    
    let ऽ = Zeichen()
    ऽ.devanagari = "ऽ"
    ऽ.lektion = 1000
    
    let virama = Zeichen()
    virama.devanagari = "्"
    virama.lektion = 1000
    
    let candrabindu = Zeichen()
    candrabindu.devanagari = "ँ"
    candrabindu.lektion = 1000
    
    let linebreak = Zeichen()
    linebreak.devanagari = "\n"
    linebreak.lektion = 1000
    
    
    //vokalZeichen als "Anhang"
    let iKurz = Zeichen()
    iKurz.devanagari = "ि"
    iKurz.lektion = 1000
    
    let uKurz = Zeichen()
    uKurz.devanagari = "ु"
    uKurz.lektion = 1000
    
    let aLang = Zeichen()
    aLang.devanagari = "ा"
    aLang.lektion = 1000
    
    let iLang = Zeichen()
    iLang.devanagari = "ी"
    iLang.lektion = 1000
    
    let uLang = Zeichen()
    uLang.devanagari = "ू"
    uLang.lektion = 1000
    
    let e = Zeichen()
    e.devanagari = "े"
    e.lektion = 1000
    
    let o = Zeichen()
    o.devanagari = "ो"
    o.lektion = 1000
    
    let ai = Zeichen()
    ai.devanagari = "ै"
    ai.lektion = 1000
    
    let au = Zeichen()
    au.devanagari = "ौ"
    au.lektion = 1000
    
    let ri = Zeichen()
    ri.devanagari = "ृ"
    ri.lektion = 1000
    
    let rI = Zeichen()
    rI.devanagari = "ॄ"
    rI.lektion = 1000
    
    
    
    
    let ligaturen =  [ न्द, न्म, न्ध, न्त, त्य, प्त, प्स, न्न, ब्द, स्य ,स्त ,स्प ,स्व ,स्न,ज्य, श्य, व्य,ल्य,म्ब ,ष्त ,य्य ,क्थ, क्ख,
                       श्च, श्र, श्न, ग्द, ग्ध, प्र, त्र, र्ग ,र्क ,र्न्द ,र्ध,र्भ,र्ब,र्न,क्र,स्र,ह्र,न्त्र,त्त,ष्ट,ष्ठ,क्त,
                       ज्ञ , क्ष, क्ष्म्य, ह्म, ह्य, ह्न, ह्ण, द्व, द्ध,द्म, द्य, द्ग, द्भ, द्ब, ञ्च, ञ्ज, च्च, क्क, ष्ण, ण्य,
                       ॐ,
                       ब्र,स्म,त्त्व,क्ल,ण्ड,rva,rma,स्त्र,त्स,
                       leerZeichen,visarga, anusvara,ऽ,virama,candrabindu,linebreak,
                       iKurz,uKurz,aLang,iLang,uLang,e,o,ai,au,ri,rI,
                       ]
    
    
    let alleZeichen = zeichensatz + ligaturen
    
    return alleZeichen
    
//        labialAnusvara.artikulation = Artikulation.labial.rawValue
//        labialAnusvara.devanagari = "म्"
//        labialAnusvara.umschrift = "m"
//
//        dentalAnusvara.artikulation = Artikulation.dental.rawValue
//        dentalAnusvara.devanagari = "न्"
//        dentalAnusvara.umschrift = "n"
//
//        retroflexAnusvara.artikulation = Artikulation.retroflex.rawValue
//        retroflexAnusvara.devanagari = "ण"
//        retroflexAnusvara.umschrift = "ṇ"
//
//        palatalAnusvara.artikulation = Artikulation.palatal.rawValue
//        palatalAnusvara.devanagari = "ञ"
//        palatalAnusvara.umschrift = "ñ"
//
//        velarAnusvara.artikulation = Artikulation.velar.rawValue
//        velarAnusvara.devanagari = "ङ"
//        velarAnusvara.umschrift = "ṅ"
//
//        NSMutableArray *arrayAnusvara   = [[NSMutableArray alloc]initWithObjects:labialAnusvara,dentalAnusvara,retroflexAnusvara,palatalAnusvara,velarAnusvara, nil]
//
//        return arrayAnusvara
    
}

func sonderZeichenFuerBar() -> [(suchString:String,angezeigt:String)]{
    var ergebnis = [(suchString:String,angezeigt:String)]()
    ergebnis.append((suchString: "आ", angezeigt: "ā"))
    ergebnis.append((suchString: "ा", angezeigt: "ā"))
    
    ergebnis.append((suchString: "ई", angezeigt: "ī"))
    ergebnis.append((suchString: "ी", angezeigt: "ī"))
    
    ergebnis.append((suchString: "ऊ", angezeigt: "ū"))
    ergebnis.append((suchString: "ू", angezeigt: "ū"))
    
    ergebnis.append((suchString: "ऋ", angezeigt: "ṛ"))
    ergebnis.append((suchString: "ृ", angezeigt: "ṛ"))
    
    ergebnis.append((suchString: "ॠ", angezeigt: "ṝ"))
    ergebnis.append((suchString: "ॄ", angezeigt: "ṝ"))
    
    ergebnis.append((suchString: "ठ", angezeigt: "ṭ"))
    ergebnis.append((suchString: "ट", angezeigt: "ṭ"))
    
    ergebnis.append((suchString: "ड", angezeigt: "ḍ"))
    ergebnis.append((suchString: "ढ", angezeigt: "ḍ"))
    
    ergebnis.append((suchString: "ङ", angezeigt: "ṅ"))
    
    ergebnis.append((suchString: "ञ", angezeigt: "ñ"))
    
    ergebnis.append((suchString: "ण", angezeigt: "ṇ"))
    
    ergebnis.append((suchString: "श", angezeigt: "ś"))
    
    ergebnis.append((suchString: "ष", angezeigt: "ṣ"))
    
    ergebnis.append((suchString: "ं", angezeigt: "ṃ"))
    
    ergebnis.append((suchString: "ः", angezeigt: "ḥ"))
    
    return ergebnis
}




//-(NSMutableArray *)erstelleAnusvaras{
//    anusvara *labialAnusvara        =   [[anusvara alloc] init]
//    anusvara *dentalAnusvara        =   [[anusvara alloc] init]
//    anusvara *retroflexAnusvara     =   [[anusvara alloc] init]
//    anusvara *palatalAnusvara       =   [[anusvara alloc] init]
//    anusvara *velarAnusvara         =   [[anusvara alloc] init]
//
//
//
//    labialAnusvara.artikulation = Artikulation.labial.rawValue
//    labialAnusvara.devanagari = "म्"
//    labialAnusvara.umschrift = "m"
//
//    dentalAnusvara.artikulation = Artikulation.dental.rawValue
//    dentalAnusvara.devanagari = "न्"
//    dentalAnusvara.umschrift = "n"
//
//    retroflexAnusvara.artikulation = Artikulation.retroflex.rawValue
//    retroflexAnusvara.devanagari = "ण"
//    retroflexAnusvara.umschrift = "ṇ"
//
//    palatalAnusvara.artikulation = Artikulation.palatal.rawValue
//    palatalAnusvara.devanagari = "ञ"
//    palatalAnusvara.umschrift = "ñ"
//
//    velarAnusvara.artikulation = Artikulation.velar.rawValue
//    velarAnusvara.devanagari = "ङ"
//    velarAnusvara.umschrift = "ṅ"
//
//    NSMutableArray *arrayAnusvara   = [[NSMutableArray alloc]initWithObjects:labialAnusvara,dentalAnusvara,retroflexAnusvara,palatalAnusvara,velarAnusvara, nil]
//
//    return arrayAnusvara
//}
//
//
//
//@end

