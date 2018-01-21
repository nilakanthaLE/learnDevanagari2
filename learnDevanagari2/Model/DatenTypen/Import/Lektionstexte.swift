//
//  Lektionstexte.swift
//  learnDevanagari2
//
//  Created by Matthias Pochmann on 27.11.17.
//  Copyright © 2017 Matthias Pochmann. All rights reserved.
//

import Foundation

struct LektionsText{
    var erklaerung:String
    var erklaerung2:String?
    var neueZeichen:String
    var aufgaben:String
    var neueZeichenIPhone:String
    var aufgabenIPhone:String
    var zusatzAufgaben:String?
    var zusatzAufgabenIPhone:String?
    var mitArtikulationAnleitungViews   = false
    var mitNasaleAnleitungViews         = false
    init (erklaerung: String, neueZeichen: String, aufgaben: String, neueZeichenIPhone: String, aufgabenIPhone: String){
        self.init(erklaerung: erklaerung, neueZeichen: neueZeichen, aufgaben: aufgaben, neueZeichenIPhone: neueZeichenIPhone, aufgabenIPhone: aufgabenIPhone, zusatzAufgaben: nil, zusatzAufgabenIPhone: nil,erklaerung2: nil)
    }
    init (erklaerung: String, neueZeichen: String, aufgaben: String, neueZeichenIPhone: String, aufgabenIPhone: String, zusatzAufgaben: String?, zusatzAufgabenIPhone: String?){
        self.init(erklaerung: erklaerung, neueZeichen: neueZeichen, aufgaben: aufgaben, neueZeichenIPhone: neueZeichenIPhone, aufgabenIPhone: aufgabenIPhone, zusatzAufgaben: zusatzAufgaben , zusatzAufgabenIPhone: zusatzAufgabenIPhone,erklaerung2: nil)
    }
    
    init(erklaerung: String, neueZeichen: String, aufgaben: String, neueZeichenIPhone: String, aufgabenIPhone: String, zusatzAufgaben: String?, zusatzAufgabenIPhone: String?,erklaerung2:String?){
        self.erklaerung             = erklaerung
        self.neueZeichen            = neueZeichen
        self.aufgaben               = aufgaben
        self.neueZeichenIPhone      = neueZeichenIPhone
        self.aufgabenIPhone         = aufgabenIPhone
        self.zusatzAufgaben         = zusatzAufgaben
        self.zusatzAufgabenIPhone   = zusatzAufgabenIPhone
        self.erklaerung2            = erklaerung2
    }
    var anzahlErklaerungsSeiten:Int{
        return 1 + (erklaerung2 != nil ? 1 : 0) + (mitArtikulationAnleitungViews ? 5 : 0) + (mitNasaleAnleitungViews ? 1 : 0)
    }
}

func getTexteFuerLektionen() -> [LektionsText]{
    var ergebnis = [LektionsText]()
    //Intros
    //Lektion1
    var erklaerung         = "In der ersten Lektion lernen wir drei Vokale 'a,i und u' kennen.\n\nअ=a \t इ=i \t उ=u\n\nVokale entstehen, indem die Stimmbänder beim Ausatmen auf Grund eines ununterbrochenen Luftstroms in Schwingung versetzt werden. \n\nDabei dient der Mund- und Rachenraum als Klangkörper. Durch Änderung der Stellung von Zunge und Mund entstehen die unterschiedliche Klänge."
    var neueZeichen        = "neue Zeichen:\n\n\nअ\t=\ta\t\t(kurz)\n\nइ\t=\ti\t\t(kurz)\n\nउ\t=\tu\t\t(kurz)"
    var aufgaben           = "Aufgabe:\n\n\n1) zeichne die Zeichen nach"
    var neueZeichenIPhone         = "अ\t=\ta\t\t(kurz)\n\nइ\t=\ti\t\t(kurz)\n\nउ\t=\tu\t\t(kurz)"
    var aufgabenIPhone            = "1) zeichne die Zeichen nach"
    ergebnis.append(LektionsText(erklaerung: erklaerung, neueZeichen: neueZeichen, aufgaben: aufgaben, neueZeichenIPhone: neueZeichenIPhone, aufgabenIPhone: aufgabenIPhone))
    
    
    //Lektion2
    erklaerung         = "Verschlußlaute (Konsonanten) entstehen durch das plötzliche Öffnen eines Verschlußes im Mund- und Rachenraum.\n\nDer Laut 'pa' entsteht zum Beispiel dadurch, dass die Lippen zunächst verschlossen sind und die Luft nicht entweichen kann. Dabei steigt der Druck im Mund und -Rachenraum an. Werden die Lippen nun plötzlich geöffnet, so entsteht ein Ton - in diesem Fall der Laut 'pa'.\n\nNeben 'pa' lernen wir in dieser Lektion den Laut 'ka' kennen. Dieser entsteht durch das Öffnen eines Verschlußes im Rachen, genauer am Gaumensegel(velum)."
    neueZeichen        = "neue Zeichen:\n\n\nप\t=\tpa\t(Lippen)\n(Deutsch: 'P'latz)\n\nक\t=\tka\t(Gaumensegel,Velum)\n(Deutsch:'k'lar)"
    aufgaben           = "Aufgaben:\n\n\n1) zeichne die Zeichen nach\n\n2) unterscheide zwischen Vokalen und Konsonanten"
    neueZeichenIPhone         = "प\t=\tpa\t(Lippen)\n(Deutsch: 'P'latz)\n\nक\t=\tka\t(Gaumensegel,Velum)\n(Deutsch:'k'lar)"
    aufgabenIPhone            = "1) zeichne die Zeichen nach\n\n2) unterscheide zwischen Vokalen und Konsonanten"
    ergebnis.append(LektionsText(erklaerung: erklaerung, neueZeichen: neueZeichen, aufgaben: aufgaben, neueZeichenIPhone: neueZeichenIPhone, aufgabenIPhone: aufgabenIPhone))
    
    //Lektion3
    erklaerung         = "In dieser Lektion lernen wir zwei weitere Vokale 'e und o' kennen. \n\nए=e \t ओ=o \n\nIm Gegensatz zu den bereits bekannten Vokalen 'a,i und u' werden 'e und o' lang, d.h. etwa doppelt so lang, ausgesprochen."
    neueZeichen        = "neue Zeichen:\n\n\nए\t=\te\t\t(langer Vokal)\n\nओ\t=\to\t\t(langer Vokal)"
    aufgaben           = "Aufgaben:\n\n\n1) zeichne die Zeichen nach\n\n2) unterscheide zwischen Vokalen und Konsonanten\n\n3) gib die Umschrift an"
    neueZeichenIPhone         = "ए\t=\te\t\t(langer Vokal)\n\nओ\t=\to\t\t(langer Vokal)"
    aufgabenIPhone            = "1) zeichne die Zeichen nach\n\n2) unterscheide zwischen Vokalen und Konsonanten\n\n3) gib die Umschrift an"
    ergebnis.append(LektionsText(erklaerung: erklaerung, neueZeichen: neueZeichen, aufgaben: aufgaben, neueZeichenIPhone: neueZeichenIPhone, aufgabenIPhone: aufgabenIPhone))
    
    //Lektion4
    erklaerung         = "Das Zeichen eines jeden Konsonanten entspricht immer einer ganzen Silbe. In seiner Grundform hängt ihm ein kurzes 'a' an.\n\nBeispiel: क = ka - nicht 'k'\n\nIn dieser Lektion lernen wir die ersten Vokalzeichen kennen, die den Grundzeichen 'anhängen' können. Durch diese Vokalzeichen werden Silben mit anderen Vokalen als 'a' gebildet.\n\nWollen wir zum Beispiel 'ki' schreiben, so wird an das क das Zeichen ि 'angehangen'. Auf diese Weise ensteht das neue Zeichen कि = ki."
    neueZeichen        = "neue Zeichen:\n\n\nक\t=\tka\t(kein Vokalzeichen)\nकि\t=\tki\t(Vokalzeichen ि)\nकु\t=\tku\t(Vokalzeichen ु)\nके\t=\tke\t(Vokalzeichen े)\nको\t=\tko\t(Vokalzeichen ो)"
    aufgaben           = "Aufgaben:\n\n\n1) zeichne die Zeichen nach\n2) unterscheide zwischen Vokalen und Konsonanten\n3) gib die Umschrift an\n4) erinnere und zeichne die Devanagari-Zeichen"
    neueZeichenIPhone         = "क\t=\tka\t(kein Vokalzeichen)\nकि\t=\tki\t(Vokalzeichen ि)\nकु\t=\tku\t(Vokalzeichen ु)\nके\t=\tke\t(Vokalzeichen े)\nको\t=\tko\t(Vokalzeichen ो)"
    aufgabenIPhone            = "1) zeichne die Zeichen nach\n2) unterscheide zwischen Vokalen und Konsonanten\n3) gib die Umschrift an\n4) erinnere und zeichne die Devanagari-Zeichen"
    ergebnis.append(LektionsText(erklaerung: erklaerung, neueZeichen: neueZeichen, aufgaben: aufgaben, neueZeichenIPhone: neueZeichenIPhone, aufgabenIPhone: aufgabenIPhone))
    
    //Lektion5
    erklaerung         =  "Wie wir bereits erfahren haben, entstehen Verschlusslaute durch das plötzliche Öffnen eines Verschlusses im Mund- und Rachenraum.\n\nIn dieser Lektion lernen wir die Bezeichnung der ersten vier Regionen kennen, in denen die Sanskrit Laute gebildet werden"
    neueZeichen        = "neue Zeichen:\n\nक\t=\tka\t\t(velar)\n\nच\t=\tca\t\t(palatal)\n(≈Deutsch:Deu'tsch'land)\n\nत\t=\tta\t\t(dental)\n(≈Deutsch:'T'ransport)\n\nप\t=\tpa\t\t(labial)"
    aufgaben           = "Aufgaben:\n\n1) zeichne die Zeichen nach\n2) unterscheide zwischen Vokalen und Konsonanten\n3) gib die Umschrift an\n4) erinnere und zeichne die Devanagari-Zeichen\n5) bestimme den Ort der Artikulation"
    neueZeichenIPhone         = "क\t=\tka\t\t(velar)\n\nच\t=\tca\t\t(palatal)\n(≈Deutsch:Deu'tsch'land)\n\nत\t=\tta\t\t(dental)\n(≈Deutsch:'T'ransport)\n\nप\t=\tpa\t\t(labial)"
    aufgabenIPhone            = "1) zeichne die Zeichen nach\n2) unterscheide zwischen Vokalen und Konsonanten\n3) gib die Umschrift an\n4) erinnere und zeichne die Devanagari-Zeichen\n5) bestimme den Ort der Artikulation"
    var lektionsText = LektionsText(erklaerung: erklaerung, neueZeichen: neueZeichen, aufgaben: aufgaben, neueZeichenIPhone: neueZeichenIPhone, aufgabenIPhone: aufgabenIPhone)
    lektionsText.mitArtikulationAnleitungViews = true
    ergebnis.append(lektionsText)
    
    //Lektion6
    erklaerung         =  "Im Gegensatz zur lateinischen Schrift unterscheidet Devanagari eindeutig zwischen kurz und lang ausgesprochenen Vokalen.\n\nWir kennen bereits die Vokale ए und ओ, die lang gesprochen werden und अ, इ und उ, die kurz gesprochen werden.\n\nIn dieser Lektion lernen wir das lange ā, das lange ī und das lange ū kennen.\n\nLange Vokale spricht man etwa doppelt so lang aus, wie kurze."
    neueZeichen        = "neue Zeichen:\n\nआ\t=\tā\nई\t=\tī\nऊ\t=\tū\n\nzugehörige Vokalzeichen:\n\nका\t=\tkā\t\t(Vokalzeichen ा)\nकी\t=\tkī\t\t(Vokalzeichen ी)\nकू\t=\tkū\t\t(Vokalzeichen ू)"
    aufgaben           = "Aufgaben:\n\n1) zeichne die Zeichen nach\n2) unterscheide zwischen Vokalen und Konsonanten\n3) gib die Umschrift an\n4) erinnere und zeichne die Devanagari-Zeichen\n5) bestimme den Ort der Artikulation"
    neueZeichenIPhone         = "आ\t=\tā\nई\t=\tī\nऊ\t=\tū\n\nzugehörige Vokalzeichen:\n\nका\t=\tkā\t\t(Vokalzeichen ा)\nकी\t=\tkī\t\t(Vokalzeichen ी)\nकू\t=\tkū\t\t(Vokalzeichen ू)"
    aufgabenIPhone            = "1) zeichne die Zeichen nach\n2) unterscheide zwischen Vokalen und Konsonanten\n3) gib die Umschrift an\n4) erinnere und zeichne die Devanagari-Zeichen\n5) bestimme den Ort der Artikulation"
    ergebnis.append(LektionsText(erklaerung: erklaerung, neueZeichen: neueZeichen, aufgaben: aufgaben, neueZeichenIPhone: neueZeichenIPhone, aufgabenIPhone: aufgabenIPhone))
    
    //Lektion7
    erklaerung         =   "Für das europäische Sprachgefühl äußerst gewöhnungsbedürftig ist die Unterscheidung der ‚ta‘ Laute in ein dentales ‚ta‘ und ein retroflexes ‚ṭa‘.\n\nUmschrift: ṭ mit Punkt darunter.\n\nMit den retroflexen Lauten lernen wir den fünften und letzten ‚Ort der Artikulation‘ kennen."
    neueZeichen        = "neues Zeichen:\n\nट\t=\tṭa\n(Amer.E.: hur't'ing)"
    aufgaben           = "Aufgaben:\n\n1) zeichne die Zeichen nach\n2) unterscheide zwischen Vokalen und Konsonanten\n3) gib die Umschrift an\n4) erinnere und zeichne die Devanagari-Zeichen\n5) bestimme den Ort der Artikulation"
    neueZeichenIPhone         = "ट\t=\tṭa\n(Amer.E.: hur't'ing)"
    aufgabenIPhone            = "1) zeichne die Zeichen nach\n2) unterscheide zwischen Vokalen und Konsonanten\n3) gib die Umschrift an\n4) erinnere und zeichne die Devanagari-Zeichen\n5) bestimme den Ort der Artikulation"
    ergebnis.append(LektionsText(erklaerung: erklaerung, neueZeichen: neueZeichen, aufgaben: aufgaben, neueZeichenIPhone: neueZeichenIPhone, aufgabenIPhone: aufgabenIPhone))
    
    //Lektion8
    erklaerung         =   "Diphtonge kennen wir auch im Deutschen. Dabei handelt es sich um die 'Doppellaute' au, ei und eu.\n\nDiphtonge entstehen, indem zwei Vokale gleichzeitig, beziehungsweise direkt ineinander übergehend, ausgesprochen werden.\n\nSanskrit kennt die Diphtonge 'ai' und 'au'. Diphtonge gehören zu den Vokalen"
    neueZeichen        = "neue Zeichen:\n\nऐ\t=\tai\nऔ\t=\tau\n\nzugehörige Vokalzeichen:\n\nकै\t=\tkai\t\t(Vokalzeichen ै)\nकौ\t=\tkau\t\t(Vokalzeichen ौ)"
    aufgaben           = "Aufgaben:\n\n1) zeichne die Zeichen nach\n2) unterscheide zwischen Vokalen und Konsonanten\n3) gib die Umschrift an\n4) erinnere und zeichne die Devanagari-Zeichen\n5) bestimme den Ort der Artikulation"
    neueZeichenIPhone         = "ऐ\t=\tai\nऔ\t=\tau\n\nzugehörige Vokalzeichen:\n\nकै\t=\tkai\t\t(Vokalzeichen ै)\nकौ\t=\tkau\t\t(Vokalzeichen ौ)"
    aufgabenIPhone            = "1) zeichne die Zeichen nach\n2) unterscheide zwischen Vokalen und Konsonanten\n3) gib die Umschrift an\n4) erinnere und zeichne die Devanagari-Zeichen\n5) bestimme den Ort der Artikulation"
    ergebnis.append(LektionsText(erklaerung: erklaerung, neueZeichen: neueZeichen, aufgaben: aufgaben, neueZeichenIPhone: neueZeichenIPhone, aufgabenIPhone: aufgabenIPhone))
    
    //Lektion9
    erklaerung         =   "Bisher haben wir nur einfache Verschlußlaute kennengelernt. Devanagari unterscheidet aber zusätzlich zwischen aspirierten und nicht aspirierten Lauten.\n\nAspirierte Laute werden von einem hörbaren Hauchlaut begleitet. Alle bisher eingeführten Konsonanten waren nicht aspiriert.\n\nFür jeden Artikulationsort gibt es zusätzlich einen aspirierten Konsonanten. Diese fünf aspirierten Laute lernen wir in dieser Lektion kennen."
    neueZeichen        = "neue Zeichen:\n\nख\t=\tkha\t\t(velar)\n(≈Deutsch:'k'ein)\nछ\t=\tcha\t\t(palatal)\n(≈Deutsch:deu'tsch')\nठ\t=\tṭha\t\t\t(retroflex)\nथ\t=\ttha\t\t\t(dental)\n(≈Deutsch:'T'omate)\nफ\t=\tpha\t\t(labial)\n(≈Deutsch:'P'ik)"
    aufgaben           = "Aufgaben:\n\n1) zeichne die Zeichen nach\n2) unterscheide zwischen Vokalen und Konsonanten\n3) gib die Umschrift an\n4) erinnere und zeichne die Devanagari-Zeichen\n5) bestimme den Ort der Artikulation\n6) beachte die Anzeige des neuen Feldes Aspiriation"
    var zusatzAufgaben     = "Zusatzaufgabe:\n\nÜbe die Unterscheidung zwischen aspirierten und nicht aspirierten Lauten durch Zuhilfenahme einer Kerze.\n\nBei der Aussprache aspirierter Laute sollte sich die Flamme deutlich bewegen.\n\nFür uns Europäer ist es häufig schwieriger Laute ohne Aspiration auszusprechen. In diesem Fall sollte sich die Flamme kaum bewegen."
    neueZeichenIPhone         = "ख\t=\tkha\t\t(velar)\n(≈Deutsch:'k'ein)\nछ\t=\tcha\t\t(palatal)\n(≈Deutsch:deu'tsch')\nठ\t=\tṭha\t\t\t(retroflex)\nथ\t=\ttha\t\t\t(dental)\n(≈Deutsch:'T'omate)\nफ\t=\tpha\t\t(labial)\n(≈Deutsch:'P'ik)"
    aufgabenIPhone            = "1) zeichne die Zeichen nach\n2) unterscheide zwischen Vokalen und Konsonanten\n3) gib die Umschrift an\n4) erinnere und zeichne die Devanagari-Zeichen\n5) bestimme den Ort der Artikulation\n6) beachte die Anzeige des neuen Feldes Aspiriation"
    var zusatzAufgabenIPhone      = "Übe die Unterscheidung zwischen aspirierten und nicht aspirierten Lauten durch Zuhilfenahme einer Kerze.\n\nBei der Aussprache aspirierter Laute sollte sich die Flamme deutlich bewegen.\n\nFür uns Europäer ist es häufig schwieriger Laute ohne Aspiration auszusprechen. In diesem Fall sollte sich die Flamme kaum bewegen."
    ergebnis.append(LektionsText(erklaerung: erklaerung, neueZeichen: neueZeichen, aufgaben: aufgaben, neueZeichenIPhone: neueZeichenIPhone, aufgabenIPhone: aufgabenIPhone,zusatzAufgaben:zusatzAufgaben,zusatzAufgabenIPhone:zusatzAufgabenIPhone))
    
    //Lektion10
    erklaerung         =   "In dieser Lektion wird die Unterscheidung zwischen aspirierten und nicht aspirierten Lauten geübt und gefestigt.\n\nWiederholung aus letzter Lektion:\n\nDevanagari unterscheidet zwischen aspirierten und nicht aspirierten Lauten. Aspirierte Laute werden von einem hörbaren Hauchlaut begleitet. \n\nFür jeden Artikulationsort gibt es zusätzlich einen aspirierten Konsonanten."
    neueZeichen        = "neue Zeichen:\n\n\nख\t=\tkha\t\t(velar)\nछ\t=\tcha\t\t(palatal)\nठ\t=\tṭha\t\t\t(retroflex)\nथ\t=\ttha\t\t\t(dental)\nफ\t=\tpha\t\t(labial)"
    aufgaben           = "Aufgaben:\n\n1) zeichne die Zeichen nach\n2) unterscheide zwischen Vokalen und Konsonanten\n3) gib die Umschrift an\n4) erinnere und zeichne die Devanagari-Zeichen\n5) bestimme den Ort der Artikulation\n6) unterscheide zwischen aspirierten und nicht aspirierten Konsonanten"
    zusatzAufgaben     = "Zusatzaufgabe:\n\nÜbe die Unterscheidung zwischen aspirierten und nicht aspirierten Lauten durch Zuhilfenahme einer Kerze.\n\nBei der Aussprache aspirierter Laute sollte sich die Flamme deutlich bewegen.\n\nFür uns Europäer ist es häufig schwieriger Laute ohne Aspiration auszusprechen. In diesem Fall sollte sich die Flamme kaum bewegen."
    neueZeichenIPhone        = "ख\t=\tkha\t\t(velar)\nछ\t=\tcha\t\t(palatal)\nठ\t=\tṭha\t\t\t(retroflex)\nथ\t=\ttha\t\t\t(dental)\nफ\t=\tpha\t\t(labial)"
    aufgabenIPhone           = "1) zeichne die Zeichen nach\n2) unterscheide zwischen Vokalen und Konsonanten\n3) gib die Umschrift an\n4) erinnere und zeichne die Devanagari-Zeichen\n5) bestimme den Ort der Artikulation\n6) unterscheide zwischen aspirierten und nicht aspirierten Konsonanten"
    zusatzAufgabenIPhone     = "Übe die Unterscheidung zwischen aspirierten und nicht aspirierten Lauten durch Zuhilfenahme einer Kerze.\n\nBei der Aussprache aspirierter Laute sollte sich die Flamme deutlich bewegen.\n\nFür uns Europäer ist es häufig schwieriger Laute ohne Aspiration auszusprechen. In diesem Fall sollte sich die Flamme kaum bewegen."
     ergebnis.append(LektionsText(erklaerung: erklaerung, neueZeichen: neueZeichen, aufgaben: aufgaben, neueZeichenIPhone: neueZeichenIPhone, aufgabenIPhone: aufgabenIPhone,zusatzAufgaben:zusatzAufgaben,zusatzAufgabenIPhone:zusatzAufgabenIPhone))
    
    //Lektion11
    erklaerung         = "Neben den bisherigen Vokalen kennt Devanagari noch einen weiteren Vokal, den Vokal ऋ ('ri').\n\nDer Laut ṛ entsteht, wenn bei der Aussprache eines langgezogenen i-Vokals die Zunge nach hinten gehoben wird, wie zur Aussprache eines gerollten r’s.\n\nWie a,i und u gibt es auch den Vokal ṛ in einer kurzen und langen Variante."
    neueZeichen        = "neue Zeichen:\n\nऋ\t=\tṛ\nॠ\t=\tṝ\n\nzugehörige Vokalzeichen:\n\nकृ\t=\tkṛ\t\t(Vokalzeichen ृ)\nकॄ\t=\tkṝ\t\t(Vokalzeichen ॄ)\n\nऋ etwa wie am.Eng.:b'ir'd"
    aufgaben           = "Aufgaben:\n\n1) zeichne die Zeichen nach\n2) unterscheide zwischen Vokalen und Konsonanten\n3) gib die Umschrift an\n4) erinnere und zeichne die Devanagari-Zeichen\n5) bestimme den Ort der Artikulation\n6) unterscheide zwischen aspirierten und nicht aspirierten Konsonanten"
    neueZeichenIPhone        = "ऋ\t=\tṛ\nॠ\t=\tṝ\n\nzugehörige Vokalzeichen:\n\nकृ\t=\tkṛ\t\t(Vokalzeichen ृ)\nकॄ\t=\tkṝ\t\t(Vokalzeichen ॄ)\n\nऋ etwa wie am.Eng.:b'ir'd"
    aufgabenIPhone           = "1) zeichne die Zeichen nach\n2) unterscheide zwischen Vokalen und Konsonanten\n3) gib die Umschrift an\n4) erinnere und zeichne die Devanagari-Zeichen\n5) bestimme den Ort der Artikulation\n6) unterscheide zwischen aspirierten und nicht aspirierten Konsonanten"
    ergebnis.append(LektionsText(erklaerung: erklaerung, neueZeichen: neueZeichen, aufgaben: aufgaben, neueZeichenIPhone: neueZeichenIPhone, aufgabenIPhone: aufgabenIPhone))
    
    //Lektion12
    erklaerung         = "Neben der Aspiration unterscheidet Devanagari zusätzlich ob ein Laut stimmhaft ist oder nicht.\n\nIm Fall von stimmhaften Lauten werden die Stimmbänder in Schwingung versetzt.\n\nAlle bisherigen Konsonanten waren stimmlos. Im Fall von stimmlosen Konsonanten schwingen die Stimmbänder nicht mit.\n\nIn dieser Lektion lernen wir die velaren, palatalen und labialen stimmhaften Konsonanten kennen. Diese gibt es jeweils in einer aspirierten und einer nicht aspirierten Variante."
    neueZeichen        = "neue Zeichen:\n\nग\t=\tga\t  (velar, nicht aspiriert)\n(Deutsch:'g'roß)\nघ\t=\tgha (velar, aspiriert)\n(≈Deutsch:'g'erne)\nज\t=\tja\t  (palatal, nicht aspiriert)\n(≈Englisch:'j'oke)\nझ\t=\tjha\t  (palatal, aspiriert)\n(≈Deutsch:'Dsch'ungel)\nब\t=\tba\t  (labial, nicht aspiriert)\n(Deutsch:'b'lau)\nभ\t=\tbha (labial, aspiriert)\n(≈Deutsch:'B'us)"
    aufgaben           = "Aufgaben:\n\n1) zeichne die Zeichen nach\n2) unterscheide zwischen Vokalen und Konsonanten\n3) gib die Umschrift an\n4) erinnere und zeichne die Devanagari-Zeichen\n5) bestimme den Ort der Artikulation\n6) unterscheide zwischen aspirierten und nicht aspirierten Konsonanten\n7) beobachte die Anzeige des neuen Feldes Stimmhaftigkeit"
    zusatzAufgaben     = "Zusatzaufgabe:\n\nÜbe die Unterscheidung zwischen stimmhaften und nicht stimmhaften Lauten, indem Du die Hand während der Aussprache an den Kehlkopf legst.\n\nStimmhafte Laute erzeugen eine spürbare Vibration. Bei stimmlosen Lauten hingegen sollte keine Vibration spürbar sein."
    neueZeichenIPhone        = "ग\t=\tga\t  (velar, nicht aspiriert)\n(Deutsch:'g'roß)\nघ\t=\tgha (velar, aspiriert)\n(≈Deutsch:'g'erne)\nज\t=\tja\t  (palatal, nicht aspiriert)\n(≈Englisch:'j'oke)\nझ\t=\tjha\t  (palatal, aspiriert)\n(≈Deutsch:'Dsch'ungel)\nब\t=\tba\t  (labial, nicht aspiriert)\n(Deutsch:'b'lau)\nभ\t=\tbha (labial, aspiriert)\n(≈Deutsch:'B'us)"
    aufgabenIPhone           = "1) zeichne die Zeichen nach\n2) unterscheide zwischen Vokalen und Konsonanten\n3) gib die Umschrift an\n4) erinnere und zeichne die Devanagari-Zeichen\n5) bestimme den Ort der Artikulation\n6) unterscheide zwischen aspirierten und nicht aspirierten Konsonanten\n7) beobachte die Anzeige des neuen Feldes Stimmhaftigkeit"
    zusatzAufgabenIPhone     = "Übe die Unterscheidung zwischen stimmhaften und nicht stimmhaften Lauten, indem Du die Hand während der Aussprache an den Kehlkopf legst.\n\nStimmhafte Laute erzeugen eine spürbare Vibration. Bei stimmlosen Lauten hingegen sollte keine Vibration spürbar sein."
     ergebnis.append(LektionsText(erklaerung: erklaerung, neueZeichen: neueZeichen, aufgaben: aufgaben, neueZeichenIPhone: neueZeichenIPhone, aufgabenIPhone: aufgabenIPhone,zusatzAufgaben:zusatzAufgaben,zusatzAufgabenIPhone:zusatzAufgabenIPhone))
    
    //Lektion13
    erklaerung         = "Diese Lektion dient dazu die Unterscheidung zwischen stimmhaften und nicht stimmhaften Lauten zu üben und zu festigen.\n\nIm Prüfset befinden sich die velaren, palatalen und labialen stimmhaften Konsonanten, die bereits in der vorangegangen Lektion vorgestellt wurden.\n\nWiederholung aus letzter Lektion:\n\nIm Fall von stimmhaften Lauten werden die Stimmbänder in Schwingung versetzt. Bei stimmlosen Konsonanten schwingen die Stimmbänder nicht mit."
    neueZeichen        = "neue Zeichen:\n\nग\t=\tga\t  (velar, nicht aspiriert)\nघ\t=\tgha (velar, aspiriert)\nज\t=\tja\t  (palatal, nicht aspiriert)\nझ\t=\tjha\t  (palatal, aspiriert)\nब\t=\tba\t  (labial, nicht aspiriert)\nभ\t=\tbha (labial, aspiriert)"
    aufgaben           = "Aufgaben:\n\n1) zeichne die Zeichen nach\n2) unterscheide zwischen Vokalen und Konsonanten\n3) gib die Umschrift an\n4) erinnere und zeichne die Devanagari-Zeichen\n5) bestimme den Ort der Artikulation\n6) unterscheide zwischen aspirierten und nicht aspirierten Konsonanten\n7) unterscheide zwischen stimmhaften und stimmlosen Konsonanten"
    zusatzAufgaben     = "Zusatzaufgabe:\n\nÜbe die Unterscheidung zwischen stimmhaften und nicht stimmhaften Lauten, indem Du die Hand während der Aussprache an den Kehlkopf legst.\n\nStimmhafte Laute erzeugen eine spürbare Vibration. Bei stimmlosen Lauten hingegen sollte keine Vibration spürbar sein."
    neueZeichenIPhone        = "ग\t=\tga\t  (velar, nicht aspiriert)\nघ\t=\tgha (velar, aspiriert)\nज\t=\tja\t  (palatal, nicht aspiriert)\nझ\t=\tjha\t  (palatal, aspiriert)\nब\t=\tba\t  (labial, nicht aspiriert)\nभ\t=\tbha (labial, aspiriert)"
    aufgabenIPhone           = "1) zeichne die Zeichen nach\n2) unterscheide zwischen Vokalen und Konsonanten\n3) gib die Umschrift an\n4) erinnere und zeichne die Devanagari-Zeichen\n5) bestimme den Ort der Artikulation\n6) unterscheide zwischen aspirierten und nicht aspirierten Konsonanten\n7) unterscheide zwischen stimmhaften und stimmlosen Konsonanten"
    zusatzAufgabenIPhone     = "Übe die Unterscheidung zwischen stimmhaften und nicht stimmhaften Lauten, indem Du die Hand während der Aussprache an den Kehlkopf legst.\n\nStimmhafte Laute erzeugen eine spürbare Vibration. Bei stimmlosen Lauten hingegen sollte keine Vibration spürbar sein."
     ergebnis.append(LektionsText(erklaerung: erklaerung, neueZeichen: neueZeichen, aufgaben: aufgaben, neueZeichenIPhone: neueZeichenIPhone, aufgabenIPhone: aufgabenIPhone,zusatzAufgaben:zusatzAufgaben,zusatzAufgabenIPhone:zusatzAufgabenIPhone))
    
    //Lektion14
    erklaerung         = "In dieser Lektion lernen wir die verbliebenen dentalen und retroflexen stimmhaften Konsonanten kennen.\n\nWiederholung aus vorangegangener Lektion:\n\nIm Fall von stimmhaften Lauten werden die Stimmbänder in Schwingung versetzt. Bei stimmlosen Konsonanten schwingen die Stimmbänder nicht mit."
    neueZeichen        = "neue Zeichen:\n\nद = da\t\t(dental, nicht aspiriert)\n(≈ Deutsch:'d'rei)\nध = dha\t(dental, aspiriert)\n(≈ Deutsch:'d'unkel)\nड = ḍa\t\t(retroflex, nicht aspiriert)\n(Amer.E.:mur'd'er)\nढ = ḍha\t(retroflex, aspiriert)"
    aufgaben           = "Aufgaben:\n\n1) zeichne die Zeichen nach\n2) unterscheide zwischen Vokalen und Konsonanten\n3) gib die Umschrift an\n4) erinnere und zeichne die Devanagari-Zeichen\n5) bestimme den Ort der Artikulation\n6) unterscheide zwischen aspirierten und nicht aspirierten Konsonanten\n7) unterscheide zwischen stimmhaften und stimmlosen Konsonanten"
    zusatzAufgaben     = "Zusatzaufgabe:\n\nÜbe die Unterscheidung zwischen stimmhaften und nicht stimmhaften Lauten, indem Du die Hand während der Aussprache an den Kehlkopf legst.\n\nStimmhafte Laute erzeugen eine spürbare Vibration. Bei stimmlosen Lauten hingegen sollte keine Vibration spürbar sein."
    neueZeichenIPhone        = "द = da\t\t(dental, nicht aspiriert)\n(≈ Deutsch:'d'rei)\nध = dha\t(dental, aspiriert)\n(≈ Deutsch:'d'unkel)\nड = ḍa\t\t(retroflex, nicht aspiriert)\n(Amer.E.:mur'd'er)\nढ = ḍha\t(retroflex, aspiriert)"
    aufgabenIPhone           = "1) zeichne die Zeichen nach\n2) unterscheide zwischen Vokalen und Konsonanten\n3) gib die Umschrift an\n4) erinnere und zeichne die Devanagari-Zeichen\n5) bestimme den Ort der Artikulation\n6) unterscheide zwischen aspirierten und nicht aspirierten Konsonanten\n7) unterscheide zwischen stimmhaften und stimmlosen Konsonanten"
    zusatzAufgabenIPhone     = "Übe die Unterscheidung zwischen stimmhaften und nicht stimmhaften Lauten, indem Du die Hand während der Aussprache an den Kehlkopf legst.\n\nStimmhafte Laute erzeugen eine spürbare Vibration. Bei stimmlosen Lauten hingegen sollte keine Vibration spürbar sein."
     ergebnis.append(LektionsText(erklaerung: erklaerung, neueZeichen: neueZeichen, aufgaben: aufgaben, neueZeichenIPhone: neueZeichenIPhone, aufgabenIPhone: aufgabenIPhone,zusatzAufgaben:zusatzAufgaben,zusatzAufgabenIPhone:zusatzAufgabenIPhone))
    
    
    
    //Lektion15
    erklaerung         = "Nasale entstehen dadurch, dass der Luftstrom bei der Artikulation nicht allein über den Mund, sondern auch über die Nase entweicht.\n\nDevanagari unterscheidet 5 Nasale. Für jeden Artikulationsort einen.\n\nNasale sind stimmhaft und werden nicht aspiriert."
    
    neueZeichen        = "neue Zeichen:\n\nङ\t=\tṅa\t\t(velar, wie Eṅgel)\nञ\t=\tña\t\t(palatal, wie engl.:fiñch)\nण\t=\tṇa\t\t(retroflex, wie Am.E.:huṇter)\nन\t=\tna\t\t(dental, wie Ente)\nम\t=\tma\t\t(labial, wie Ampel)"
    aufgaben           = "Aufgaben:\n\n1) zeichne die Zeichen nach\n2) unterscheide zwischen Vokalen und Konsonanten\n3) gib die Umschrift an\n4) erinnere und zeichne die Devanagari-Zeichen\n5) bestimme den Ort der Artikulation\n6) unterscheide zwischen aspirierten und nicht aspirierten Konsonanten\n7) unterscheide zwischen stimmhaften und stimmlosen Konsonanten\n8) beobachte die Anzeige des neuen Feldes Nasale"
    neueZeichenIPhone        = "ङ\t=\tṅa\t\t(velar, wie Eṅgel)\nञ\t=\tña\t\t(palatal, wie engl.:fiñch)\nण\t=\tṇa\t\t(retroflex, wie Am.E.:huṇter)\nन\t=\tna\t\t(dental, wie Ente)\nम\t=\tma\t\t(labial, wie Ampel)"
    aufgabenIPhone           = "1) zeichne die Zeichen nach\n2) unterscheide zwischen Vokalen und Konsonanten\n3) gib die Umschrift an\n4) erinnere und zeichne die Devanagari-Zeichen\n5) bestimme den Ort der Artikulation\n6) unterscheide zwischen aspirierten und nicht aspirierten Konsonanten\n7) unterscheide zwischen stimmhaften und stimmlosen Konsonanten\n8) beobachte die Anzeige des neuen Feldes Nasale"
    var lektionsText2 = LektionsText(erklaerung: erklaerung, neueZeichen: neueZeichen, aufgaben: aufgaben, neueZeichenIPhone: neueZeichenIPhone, aufgabenIPhone: aufgabenIPhone)
    lektionsText2.mitNasaleAnleitungViews = true
    ergebnis.append(lektionsText2)
    
    //Lektion16
    erklaerung         = "Diese Lektion dient dazu Nasale zu erkennen und die Unterscheidung zwischen Nasalen und einfachen Konsonanten zu festigen.\n\nWiederholung aus vorangegangener Lektion:\nNasale entstehen dadurch, dass der Luftstrom bei der Artikulation nicht allein über den Mund, sondern auch über die Nase entweicht.\n\nDevanagari unterscheidet 5 Nasale. Für jeden Artikulationsort einen.\n\nNasale sind stimmhaft und werden nicht aspiriert."
    
    neueZeichen        = "neue Zeichen:\n\nङ\t=\tṅa\t\t(velar, wie Eṅgel)\nञ\t=\tña\t\t(palatal, wie engl.:fiñch)\nण\t=\tṇa\t\t(retroflex, wie Am.E.:huṇter)\nन\t=\tna\t\t(dental, wie Ente)\nम\t=\tma\t\t(labial, wie Ampel)"
    aufgaben           = "Aufgaben:\n\n1) zeichne die Zeichen nach\n2) unterscheide zwischen Vokalen und Konsonanten\n3) gib die Umschrift an\n4) erinnere und zeichne die Devanagari-Zeichen\n5) bestimme den Ort der Artikulation\n6) unterscheide zwischen aspirierten und nicht aspirierten Konsonanten\n7) unterscheide zwischen stimmhaften und stimmlosen Konsonanten\n8) unterscheide zwischen einfachen Konsonanten und Nasalen"
    neueZeichenIPhone        = "ङ\t=\tṅa\t\t(velar, wie Eṅgel)\nञ\t=\tña\t\t(palatal, wie engl.:fiñch)\nण\t=\tṇa\t\t(retroflex, wie Am.E.:huṇter)\nन\t=\tna\t\t(dental, wie Ente)\nम\t=\tma\t\t(labial, wie Ampel)"
    aufgabenIPhone           = "1) zeichne die Zeichen nach\n2) unterscheide zwischen Vokalen und Konsonanten\n3) gib die Umschrift an\n4) erinnere und zeichne die Devanagari-Zeichen\n5) bestimme den Ort der Artikulation\n6) unterscheide zwischen aspirierten und nicht aspirierten Konsonanten\n7) unterscheide zwischen stimmhaften und stimmlosen Konsonanten\n8) unterscheide zwischen einfachen Konsonanten und Nasalen"
    var lektionsText3 = LektionsText(erklaerung: erklaerung, neueZeichen: neueZeichen, aufgaben: aufgaben, neueZeichenIPhone: neueZeichenIPhone, aufgabenIPhone: aufgabenIPhone)
    lektionsText3.mitNasaleAnleitungViews = true
    ergebnis.append(lektionsText3)
    
    
    //Lektion17
    erklaerung         = "Halbvokale stehen zwischen den Konsonanten und Vokalen.\n\nIm Gegensatz zu einfachen Konsonanten können Halbvokale, wie Vokale, anhaltend artikuliert werden.\n\nMit den Konsonanten haben sie wiederum gemeinsam, dass ihnen Vokale anhängen.\n\nHalbvokale sind stimmhaft und werden nicht aspiriert. Für vier Artikulationsorte gibt es einen Halbvokal."
    neueZeichen        = "neue Zeichen:\n\nय\t=\tya\t\t(velar, wie 'J'ude)\nर\t=\tra\t\t(retroflex, wie Am.E.: tea'r'ing)\nव\t=\tva\t\t(labial, wie 'W'al oder 'W'as)\nल\t=\tla\t\t(dental, wie 'l'ieben)"
    aufgaben           = "Aufgaben:\n\n1) zeichne die Zeichen nach\n2) unterscheide zwischen Vokalen und Konsonanten\n3) gib die Umschrift an\n4) erinnere und zeichne die Devanagari-Zeichen\n5) bestimme den Ort der Artikulation\n6) unterscheide zwischen aspirierten und nicht aspirierten Konsonanten\n7) unterscheide zwischen stimmhaften und stimmlosen Konsonanten\n8) unterscheide zwischen einfachen Konsonanten und Nasalen\n9) unterscheide zwischen Halbvokalen und einfachen Vokalen"
    zusatzAufgaben     = "Zusatzaufgabe:\n\nErkenne die Besonderheit der Halbvokale, indem Du jeden Halbvokal (य,र,व,ल) lang anhaltend artikulierst.\n\nVersuche das Gleiche mit einfachen Konsonanten, wie z.B. क, प, त oder च."
    neueZeichenIPhone        = "य\t=\tya\t\t(wie 'J'ude)\nर\t=\tra\t\t(wie Am.E.:tea'r'ing)\nव\t=\tva\t\t(Wie 'W'al oder 'W'as)\nल\t=\tla\t\t(Wie 'l'ieben)"
    aufgabenIPhone           = "1) zeichne die Zeichen nach\n2) unterscheide zwischen Vokalen und Konsonanten\n3) gib die Umschrift an\n4) erinnere und zeichne die Devanagari-Zeichen\n5) bestimme den Ort der Artikulation\n6) unterscheide zwischen aspirierten und nicht aspirierten Konsonanten\n7) unterscheide zwischen stimmhaften und stimmlosen Konsonanten\n8) unterscheide zwischen einfachen Konsonanten und Nasalen\n9) unterscheide zwischen Halbvokalen und einfachen Vokalen"
    zusatzAufgabenIPhone     = "Erkenne die Besonderheit der Halbvokale, indem Du jeden Halbvokal (य,र,व,ल) lang anhaltend artikulierst.\n\nVersuche das Gleiche mit einfachen Konsonanten, wie z.B. क, प, त oder च."
     ergebnis.append(LektionsText(erklaerung: erklaerung, neueZeichen: neueZeichen, aufgaben: aufgaben, neueZeichenIPhone: neueZeichenIPhone, aufgabenIPhone: aufgabenIPhone,zusatzAufgaben:zusatzAufgaben,zusatzAufgabenIPhone:zusatzAufgabenIPhone))
    
    //Lektion18
    erklaerung         = "Sibilianten beziehungsweise Zischlaute entstehen dadurch, dass der Luftstrom im Mundraum eine enge Stelle vor oder hinter den Zähnen passiert.\n\nDevanagari kennt drei Zischlaute. Einen dentalen, स - sa, einen palatalen श - śa und einen retroflexen ष - ṣa.\n\nSibilianten sind stimmlos und werden aspiriert."
    neueZeichen        = "neue Zeichen:\n\nस\t=\tsa\t\t(dental, wie wi'ss'en)\nश\t=\tśa\t\t(palatal, wie deutsch 'Sch'af)\nष\t=\tṣa\t\t(retroflex)"
    aufgaben           = "Aufgaben:\n\n1) zeichne die Zeichen nach\n2) unterscheide zwischen Vokalen und Konsonanten\n3) gib die Umschrift an\n4) erinnere und zeichne die Devanagari-Zeichen\n5) bestimme den Ort der Artikulation\n6) unterscheide zwischen aspirierten und nicht aspirierten Konsonanten\n7) unterscheide zwischen stimmhaften und stimmlosen Konsonanten\n8) unterscheide zwischen Halbvokalen und einfachen Vokalen\n9) unterscheide zwischen einfachen Konsonanten, Nasalen und Sibilanten"
    neueZeichenIPhone        = "स\t=\tsa\t\t(dental, wie wi'ss'en)\nश\t=\tśa\t\t(palatal, wie deutsch 'Sch'af)\nष\t=\tṣa\t\t(retroflex)"
    aufgabenIPhone           = "1) zeichne die Zeichen nach\n2) unterscheide zwischen Vokalen und Konsonanten\n3) gib die Umschrift an\n4) erinnere und zeichne die Devanagari-Zeichen\n5) bestimme den Ort der Artikulation\n6) unterscheide zwischen aspirierten und nicht aspirierten Konsonanten\n7) unterscheide zwischen stimmhaften und stimmlosen Konsonanten\n8) unterscheide zwischen Halbvokalen und einfachen Vokalen\n9) unterscheide zwischen einfachen Konsonanten, Nasalen und Sibilanten"
    ergebnis.append(LektionsText(erklaerung: erklaerung, neueZeichen: neueZeichen, aufgaben: aufgaben, neueZeichenIPhone: neueZeichenIPhone, aufgabenIPhone: aufgabenIPhone))
    
    //Lektion19
    erklaerung         = "Als letztes Grundzeichen des Devanagari-Alphabets lernen wir in dieser Lektion den Hauchlaut kennen.\n\nDer Hauchlaut in Sanskrit entspricht dem deutschen Laut 'ha', wie wir ihn in Haus oder Hirsch kennen.\n\nEr ist stimmhaft und wird aspiriert. Der Artikulationsort ist velar."
    neueZeichen        = "neue Zeichen:\n\nह\t=\tha\t\t(wie 'h'eim oder 'H'irsch)"
    aufgaben           = "Aufgaben:\n\n1) zeichne die Zeichen nach\n2) unterscheide zwischen Vokalen und Konsonanten\n3) gib die Umschrift an\n4) erinnere und zeichne die Devanagari-Zeichen\n5) bestimme den Ort der Artikulation\n6) unterscheide zwischen aspirierten und nicht aspirierten Konsonanten\n7) unterscheide zwischen stimmhaften und stimmlosen Konsonanten\n8) unterscheide zwischen Halbvokalen und einfachen Vokalen\n9) unterscheide zwischen einfachen Konsonanten, Nasalen, Sibilanten und dem Hauchlaut"
    neueZeichenIPhone        = "ह\t=\tha\t\t(wie 'h'eim oder 'H'irsch)"
    aufgabenIPhone           = "1) zeichne die Zeichen nach\n2) unterscheide zwischen Vokalen und Konsonanten\n3) gib die Umschrift an\n4) erinnere und zeichne die Devanagari-Zeichen\n5) bestimme den Ort der Artikulation\n6) unterscheide zwischen aspirierten und nicht aspirierten Konsonanten\n7) unterscheide zwischen stimmhaften und stimmlosen Konsonanten\n8) unterscheide zwischen Halbvokalen und einfachen Vokalen\n9) unterscheide zwischen einfachen Konsonanten, Nasalen, Sibilanten und dem Hauchlaut"
    ergebnis.append(LektionsText(erklaerung: erklaerung, neueZeichen: neueZeichen, aufgaben: aufgaben, neueZeichenIPhone: neueZeichenIPhone, aufgabenIPhone: aufgabenIPhone))
    
    //Lektion20
    erklaerung         =  "Nachdem wir nun bereits alle Grundzeichen des Devanagari-Alphabets kennen, kommen wir in dieser Lektion zu drei besonderen Zeichen, die den Abschluß einer Silbe bilden können.\n\nSehr häufig trifft man im Sanskrit auf den Visarga ः (doppelpunkt am Ende der Silbe), der meist am Ende eines Wortes vorkommt. Die Aussprache des Visarga hängt davon ab, ob er am Ende oder in der Mitte eines Satzes vorkommt. \n\nAm Ende des Satzes wird der Visarga wie das deutsche h ausgesprochen, wobei der dem Visarga vorangehende Vokal sehr kurz nach dem h-Laut wiederholt wird.\n\nBeispiel: 'śivāya namaḥ' wird 'śivāya namaha' gesprochen."
    
    var erklaerung2     = "Steht der Visarga jedoch in der Mitte eines Satzes, wird nichts hinzugefügt. Es wird also lediglich das h gesprochen\n\nBeispiel: 'namaḥ śivāya' wird 'namah śivāya' gesprochen.\n\nEtwas komplizierter ist die Ausprache des Anusvara ं (Punkt über der Silbe). In dieser Lektion tritt er lediglich am Ende eines Wortes, bzw. einer einzelnen Silbe auf. In diesem Fall wird der vorangegangene Vokal durch den Anusvara nasalisiert. \n\nDer Visarga wird in der IAST-Umschrift als ḥ und der Anusvara als ṃ geschrieben\n\nEndet eine Silbe mit einem Virāma ् (Strich unterhalb der Silbe), dann wird der Vokal a, der normalerweise jedem Zeichen anhängt unterdrückt. प् (प + ्) wird also nicht, wie bisher als 'pa' umschrieben, sondern als 'p'. Ein Virāma findet man nur am Ende eines Wortes, das auf einen Konsonanten endet."
    
    neueZeichen        = "neue Zeichen:\n\nः\t=\tḥ\t\t\n(am Ende eines Satzes:\nh+'vorangehender Vokal'\nin der Mitte eines Satzes: nur h)\n\nं\t=\tṃ\t\t\n(Am Ende eines Wortes:\nNasalisierung des vorangegangenen Vokals)\n\n्\t=\tunterdrückt den Vokal a\n(Beispiel क् = k und nicht ka)"
    aufgaben           = "Aufgaben:\n\n1) unterscheide zwischen Vokalen und Konsonanten\n2) gib die Umschrift an\n3) bestimme den Ort der Artikulation\n4) unterscheide zwischen aspirierten und nicht aspirierten Konsonanten\n5) unterscheide zwischen stimmhaften und stimmlosen Konsonanten\n6) unterscheide zwischen Halbvokalen und einfachen Vokalen\n7) unterscheide zwischen einfachen Konsonanten, Nasalen, Sibilanten und dem Hauchlaut"
    neueZeichenIPhone        = "ः\t=\tḥ\t\t\n(am Ende eines Satzes:\nh+'vorangehender Vokal'\nin der Mitte eines Satzes: nur h)\n\nं\t=\tṃ\t\t\n(Am Ende eines Wortes:\nNasalisierung des vorangegangenen Vokals)\n\n्\t=\tunterdrückt den Vokal a\n(Beispiel क् = k und nicht ka)"
    aufgabenIPhone           = "1) unterscheide zwischen Vokalen und Konsonanten\n2) gib die Umschrift an\n3) bestimme den Ort der Artikulation\n4) unterscheide zwischen aspirierten und nicht aspirierten Konsonanten\n5) unterscheide zwischen stimmhaften und stimmlosen Konsonanten\n6) unterscheide zwischen Halbvokalen und einfachen Vokalen\n7) unterscheide zwischen einfachen Konsonanten, Nasalen, Sibilanten und dem Hauchlaut"
    ergebnis.append(LektionsText(erklaerung: erklaerung, neueZeichen: neueZeichen, aufgaben: aufgaben, neueZeichenIPhone: neueZeichenIPhone, aufgabenIPhone: aufgabenIPhone, zusatzAufgaben: nil, zusatzAufgabenIPhone: nil, erklaerung2: erklaerung2))
    
    
    //Lektion21
    erklaerung         =  "In der letzten Lektion haben wir den Anusvara kennengelernt und erfahren, dass er am Ende eines Wortes den vorangehenden Vokal nasalisiert. \n\nIm Gegensatz zum Visarga tritt der Anusvara allerdings auch innerhalb von Worten auf.\n\nFolgt dem Anusvara ein einfacher Konsonant, so wird der Anusvara zum Nasal des jeweiligen Artikulationsortes des nachfolgenden Konsonanten."
    erklaerung2         = "Beispiele:\n1) Das deutsche Wort Ente könnte in der Devanagari-Umschrift auch Eṃte geschrieben werden. Weil dem Anusvara ein dentales t folgt, wird der Anusvare wie ein n, also wie der dentale Nasal ausgesprochen.\n\n2) Gleiches gilt für das deutsche Wort Ampel. In der Devanagari-Umschrift ist es möglich Aṃpel zu schreiben. Weil das p ein labialer Laut ist, wird der Anusvara als labialer Nasal, d.h. als m, gesprochen.\n\n3) Enkel ... Eṃkel (velarer Nasal = ṅ)"
    aufgaben           = "Aufgaben:\n\n1) gib die Umschrift der Zufalls-Nonsens-Silbengruppen an\n\n2) bestimme den Ort der Artikulation des Anusvara"
    aufgabenIPhone           = "1) gib die Umschrift der Zufalls-Nonsens-Silbengruppen an\n\n2) bestimme den Ort der Artikulation des Anusvara"
    ergebnis.append(LektionsText(erklaerung: erklaerung, neueZeichen: neueZeichen, aufgaben: aufgaben, neueZeichenIPhone: neueZeichenIPhone, aufgabenIPhone: aufgabenIPhone, zusatzAufgaben: nil, zusatzAufgabenIPhone: nil, erklaerung2: erklaerung2))
    
    //Lektion22
    erklaerung         = "Inzwischen kennen wir alle Grundzeichen des Devanagari-Alphabets und können damit einfache Worte, wie शिवः oder रामः lesen und schreiben.\n\nIn allen Sprachen gibt es allerdings auch Abfolgen von Konsonanten, die wir noch nicht kennengelernt haben. Bisher hatten wir es nur mit Silben, bestehend aus einzelnen Konsonanten, zu tun.\n\nViele Worte, wie zum Beispiel das Wort 'mantra', können wir deshalb mit dem gegenwärtigen Kenntnisstand noch nicht lesen oder schreiben. Dies soll sich in den kommenden Lektionen ändern."
    erklaerung2         = "Folgen mehrere Konsonanten aufeinander, wie das im Wort mantra bei 'ntr' der Fall ist, so wird diese Konsonanten-Abfolge durch ein einzelnes Zeichen repräsentiert, das Teile der jeweiligen Konsonanten-Zeichen enthält.\n\nSolche Zeichen werden Ligaturen genannt. Ein Beispiel für eine sehr einfache Ligatur ist न्द. Deutlich erkennt man den Nasal न gefolgt von द. Gelesen wird न्द als nda.\n\nDie Ligaturen dieser Lektion sind alle von dieser einfachen Art."
    neueZeichen        = "neue Zeichen:\n\nन्द = nda, न्म = nma, न्ध = ndha, न्त = nta\nत्य = ntya, प्त = pta,  प्स = psa, न्न = nna\nब्द = bda, स्य = sya, स्त = sta, स्प = spa\nस्व = sva, स्न = sna, ज्य = jya, श्य = śya\nव्य = vya, ल्य = lya, म्ब = mba, ष्त = ṣta\nय्य = yya, क्थ = ktha, क्ख = kkha"
    aufgaben           = "Aufgaben:\n\n1) zeichne die Zeichen nach\n2) gib die Umschrift an\n3) erinnere und zeichne die Devanagari-Zeichen"
    neueZeichenIPhone        = "न्द = nda, न्म = nma, न्ध = ndha, न्त = nta\nत्य = ntya, प्त = pta,  प्स = psa, न्न = nna\nब्द = bda, स्य = sya, स्त = sta, स्प = spa\nस्व = sva, स्न = sna, ज्य = jya, श्य = śya\nव्य = vya, ल्य = lya, म्ब = mba, ष्त = ṣta\nय्य = yya, क्थ = ktha, क्ख = kkha"
    aufgabenIPhone           = "1) zeichne die Zeichen nach\n2) gib die Umschrift an\n3) erinnere und zeichne die Devanagari-Zeichen"
    
    ergebnis.append(LektionsText(erklaerung: erklaerung, neueZeichen: neueZeichen, aufgaben: aufgaben, neueZeichenIPhone: neueZeichenIPhone, aufgabenIPhone: aufgabenIPhone, zusatzAufgaben: nil, zusatzAufgabenIPhone: nil, erklaerung2: erklaerung2))
    
    //Lektion23
    erklaerung         = "Neben den einfachen Ligaturen der letzten Lektion, gibt es eine Reihe von Konsonanten, die in Ligaturen ihr Aussehen völlig verändern.\n\nEin prominetes Beispiel dafür ist der Halbvokal र - ra. Abhängig davon, ob er am Anfang einer Ligatur (z.B. rka) oder am Ende (z.B. pra) steht, hat er sehr unterschiedliche Erscheinungsformen. Zu Beginn einer Ligatur wird ein र als Haken dargestellt (Bsp.: र्क = rka). Am Ende wird र zu einem Schrägstrich (Bsp. क्र = kra).\n\nNeben dem र lernen wir in dieser Lektion die häufig in Ligaturen vorkommende Sonderform des Sibilanten श - ś kennen (Bsp.:  श्र - śra)."
    neueZeichen        = "neue Zeichen:\n\nश्च = śca, श्र = śra, श्न = śna, ग्द = gda\nग्ध = gdha, प्र = pra, त्र = tra, र्ग = rga\nर्क  = rka, र्न्द = rnda, र्ध = rdha, र्भ = rbha\nर्ब = rba, र्न = rna, क्र = kra, स्र = sra\nह्र = hra, न्त्र = ntra, त्त = tta\nष्ट = ṣṭa, ष्ठ = ṣṭha, क्त = kkta"
    aufgaben           = "Aufgaben:\n\n1) zeichne die Zeichen nach\n2) gib die Umschrift an\n3) erinnere und zeichne die Devanagari-Zeichen"
    neueZeichenIPhone        = "श्च = śca, श्र = śra, श्न = śna, ग्द = gda\nग्ध = gdha, प्र = pra, त्र = tra, र्ग = rga\nर्क  = rka, र्न्द = rnda, र्ध = rdha, र्भ = rbha\nर्ब = rba, र्न = rna, क्र = kra, स्र = sra\nह्र = hra, न्त्र = ntra, त्त = tta\nष्ट = ṣṭa, ष्ठ = ṣṭha, क्त = kkta"
    aufgabenIPhone           = "1) zeichne die Zeichen nach\n2) gib die Umschrift an\n3) erinnere und zeichne die Devanagari-Zeichen"
    ergebnis.append(LektionsText(erklaerung: erklaerung, neueZeichen: neueZeichen, aufgaben: aufgaben, neueZeichenIPhone: neueZeichenIPhone, aufgabenIPhone: aufgabenIPhone))
    
    //Lektion24
    erklaerung         = "In dieser Lektion lernen wir zwei besondere Ligaturen kennen, die in ihrem Aussehen kaum ihre Grundkonsonante verraten.\n\nDabei handelt es sich einererseits um die Ligatur ज्ञ = jña, die sehr häufig vorkommt, zum Beispiel im Namen für das sechste Hauptchakra, dem आज्ञा (ājñā) cakra.\n\nDie zweite Ligatur ist das Zeichen क्ष = kṣa. Auch das क्ष tritt sehr häufig auf. Zum Beispiel im Namen der Gottheit (लक्ष्मी) Lakṣmī.\n\nNeben diesen beiden besonderen Ligaturen lernen wir einige einfache Ligaturen kennen."
    neueZeichen        = "neue Zeichen:\nज्ञ = jña, क्ष = kṣa, क्ष्म्य = kṣmya, ह्म = hma\nह्य = hya, ह्न = hna, ह्ण = hva, द्व = dva\nद्ध = ddha ,द्म = dma, द्य = dya, द्ग = dga\nद्भ = dbha, द्ब = dba, ञ्च = , ञ्ज = ñca\nच्च = cca, क्क = kka"
    aufgaben           = "Aufgaben:\n\n1) zeichne die Zeichen nach\n2) gib die Umschrift an\n3) erinnere und zeichne die Devanagari-Zeichen"
    neueZeichenIPhone        = "ज्ञ = jña, क्ष = kṣa, क्ष्म्य = kṣmya, ह्म = hma\nह्य = hya, ह्न = hna, ह्ण = hva, द्व = dva\nद्ध = ddha ,द्म = dma, द्य = dya, द्ग = dga\nद्भ = dbha, द्ब = dba, ञ्च = , ञ्ज = ñca\nच्च = cca, क्क = kka"
    aufgabenIPhone           = "1) zeichne die Zeichen nach\n2) gib die Umschrift an\n3) erinnere und zeichne die Devanagari-Zeichen"
    ergebnis.append(LektionsText(erklaerung: erklaerung, neueZeichen: neueZeichen, aufgaben: aufgaben, neueZeichenIPhone: neueZeichenIPhone, aufgabenIPhone: aufgabenIPhone))
    
    //Lektion25
    erklaerung         = "In dieser Lektion lernen wir die Ligaturen kennen, die bisher noch fehlen, um alle vorgestellten Mantras lesen und schreiben zu können.\n\nAuch das Zeichen für om wird in dieser Lektion vorgestellt, obwohl es keine Ligatur im klassischen Sinn ist.\n\nNeben den hier vorgestellten Ligaturen gibt es noch sehr viele weitere, die nicht alle hier einzeln aufgeführt werden. Im Laufe der Zeit - mit etwas Übung - wird es allerdings kein Problem sein, alle diese besonderen Zeichen zu erkennen"
    neueZeichen        = "neue Zeichen:\n\nॐ = om, ब्र = bra, स्म = sma, त्त्व = ttva\nक्ल = kla, ण्ड = ṇḍa, र्व = rva, र्म = rma\nस्त्र  = stra, त्स = tsa"
    aufgaben           = "Aufgaben:\n\n1) zeichne die Zeichen nach\n2) gib die Umschrift an\n3) erinnere und zeichne die Devanagari-Zeichen"
    neueZeichenIPhone        = "ॐ = om, ब्र = bra, स्म = sma, त्त्व = ttva\nक्ल = kla, ण्ड = ṇḍa, र्व = rva, र्म = rma\nस्त्र  = stra, त्स = tsa"
    aufgabenIPhone           = "1) zeichne die Zeichen nach\n2) gib die Umschrift an\n3) erinnere und zeichne die Devanagari-Zeichen"
    ergebnis.append(LektionsText(erklaerung: erklaerung, neueZeichen: neueZeichen, aufgaben: aufgaben, neueZeichenIPhone: neueZeichenIPhone, aufgabenIPhone: aufgabenIPhone))
    

    
    
    return ergebnis
}


struct ArtikulationAnleitungViewData {
    var text:String
    var imageName:String
    var artikulation:Artikulation
}

func getArtikulationViewData() -> [ArtikulationAnleitungViewData]{
    var ergebnis = [ArtikulationAnleitungViewData]()
    var text = "velar (क)\n\nVerschluss von Zunge und Gaumensegel (velum) im Rachenraum \n\nBeispiel: 'Karo'"
    ergebnis.append(ArtikulationAnleitungViewData(text: text, imageName: "velar", artikulation: .velar))
    text = "palatal (च)\n\n Verschluss von Zunge und vorderem (hartem) Gaumen. \n\nBeispiel: 'church'"
    ergebnis.append(ArtikulationAnleitungViewData(text: text, imageName: "palatal", artikulation: .palatal))
    text = "retroflex (ट)\n\nZungenspitze wird hinter den Zahndamm gelegt. Die Zunge biegt sich nach oben zurück.\n\nBeispiel: 'hurting'"
    ergebnis.append(ArtikulationAnleitungViewData(text: text, imageName: "retroflex", artikulation: .retroflex))
    text = "dental (त)\n\nVerschluss von Zungenspitze und vorderen Zähnen. \n\nBeispiel: 'Taste'"
    ergebnis.append(ArtikulationAnleitungViewData(text: text, imageName: "dental", artikulation: .dental))
    text = "labial (प)\n\nVerschluss der Lippen \n\nBeispiel: 'Panne'"
    ergebnis.append(ArtikulationAnleitungViewData(text: text, imageName: "labial", artikulation: .labial))
    return ergebnis
}

func getNasaleText()->String{
    return "Nasale entstehen dadurch, dass der Luftstrom bei der Artikulation nicht allein über den Mund, sondern auch über die Nase entweicht.\n\nDevanagari unterscheidet 5 Nasale. Für jeden Artikulationsort einen.\n\nNasale sind stimmhaft und werden nicht aspiriert."
}

////Bubbles
//self.bubbleNasalDesAnusvaraUmschrift.landscapeDE    = "Gib hier die Umschrift der Nonsens-Zeichenfolge ein.\n\nErsetze dabei den Anusvara durch den korrespondierenden Nasal"
//self.bubbleNasalDesAnusvaraUmschrift.iPhoneDE       = "Gib hier die Umschrift der \nNonsens-Zeichenfolge ein.\n\nErsetze dabei den Anusvara \ndurch den korrespondierenden Nasal"
//self.bubbleNasalDesAnusvaraArtikulation.landscapeDE = "Wähle hier den Artikulationsort des Anusvaranasals."
//self.bubbleNasalDesAnusvaraArtikulation.iPhoneDE    = "Wähle hier den Artikulationsort \ndes Anusvaranasals."
//self.bubbleUebersichtLektionZeichen.landscapeDE     = "Hier werden die Zeichen der aktuellen Lektion angezeigt.\nDiese werden grün, sobald sie im Rahmen\nder Lektion gemeistert wurden"
//self.bubbleUebersichtLektionZeichen.iPhoneDE        = "Hier werden die Zeichen der \naktuellen Lektion angezeigt.\nDiese werden grün, sobald \nsie im Rahmen der Lektion \ngemeistert wurden"
//self.bubbleUebersichtGrundzeichen.iPhoneDE          = "Diese Übersicht zeigt das \nDevanagari-Alphabet in der Ordnung,\nwie es die alten indischen \nGrammatiker erstellt haben.\n\nMit fortschreitender Kenntnis \nder einzelnen Grundzeichen,\nfärben diese sich allmählich grün"
//self.bubbleUebersichtGrundzeichen.landscapeDE       = "Diese Übersicht zeigt das Devanagari-Alphabet in der Ordnung,\nwie es die alten indischen Grammatiker erstellt haben.\n\nMit fortschreitender Kenntnis der einzelnen Grundzeichen,\nfärben diese sich allmählich grün"
//self.bubbleToolbarUmschrift.landscapeDE             = "Mit dieser Toolbar kann man IAST-Zeichen\nfür die Umschrift eingeben, die unsere\nTastatur nicht bereithält."
//self.bubbleToolbarUmschrift.iPhoneDE                = "Mit dieser Toolbar kann man \nIAST-Zeichen für die Umschrift \neingeben, die unsere\nTastatur nicht bereithält."
//self.bubbleFortschrittsbalkenGelb.landscapeDE       = "Ein gelbes Feld zeigt an, dass ein Prüfzeichen\nentweder im Zeichenfeldmodus oder im \nnormalen Abfragemodus richtig beantwortet wurde.\n\nEs wird grün, wenn es in beiden Modi bestanden wurde"
//self.bubbleFortschrittsbalkenGelb.iPhoneDE          = "Ein gelbes Feld zeigt an, dass \nein Prüfzeichen entweder im \nZeichenfeldmodus oder im \nnormalen Abfragemodus richtig \nbeantwortet wurde.\n\nEs wird grün, wenn es \nin beiden Modi bestanden wurde"
//self.bubbleFortschrittsbalkenGruen.landscapeDE      = "Hier wird der aktuelle Fortschritt innerhalb der Lektion angezeigt.\n\nJedes grüne Feld entspricht einem richtig beantworteten Prüfzeichen"
//self.bubbleFortschrittsbalkenGruen.iPhoneDE         = "Hier wird der aktuelle Fortschritt \ninnerhalb der Lektion angezeigt.\n\nJedes grüne Feld entspricht \neinem richtig beantworteten \nPrüfzeichen"
//self.bubbleVorschlagsButtons.iPhoneDE               = "Hier wird die Auswahl der \nerkannten Zeichen angezeigt.\n\nWähle daraus das richtige \nZeichen oder versuche erneut \nzu zeichnen"
//self.bubbleVorschlagsButtons.landscapeDE            = "Hier wird die Auswahl der erkannten Zeichen angezeigt.\n\nWähle daraus das richtige Zeichen oder versuche erneut zu zeichnen"
//self.bubbleFalscheAntwort.landscapeDE               = "Diese Antwort war nicht richtig.\n\nKlick auf falsche Antworten (rot) gibt Hilfestellung."
//self.bubbleFalscheAntwort.iPhoneDE                  = "Diese Antwort war nicht richtig.\n\nKlick auf falsche Antworten (rot) \ngibt Hilfestellung."
//self.bubbleOftOKGedrueckt.landscapeDE               = "Probleme das Zeichen richtig zu zeichnen?\n\nMit einer Wischbewegung nach rechts\nkannst Du das Zeichen noch einmal üben"
//self.bubbleOftOKGedrueckt.iPhoneDE                  = "Probleme das Zeichen richtig \nzu zeichnen?\n\nMit einer Wischbewegung \nnach rechts kannst Du \ndas Zeichen noch einmal üben"
//
//self.bubbleQuizzPruefeButton.landscapeDE            = "Nach Eingabe aller Abfragewerte\nführt dieser Knopf zum nächsten Zeichen\n\nnach rechts wischen,\nzeigt Antworten"
//self.bubbleQuizzPruefeButton.iPhoneDE               = "Nach Eingabe aller\nAbfragewerte führt dieser Knopf\nzum nächsten Zeichen\n\nnach rechts wischen,\nzeigt Antworten"
//self.bubbleQuizzZeichenfeldNachzeichnen.landscapeDE = "Zeichne das Devanagari-Zeichen nach \nund drücke dann OK.\n\nMit reset wird das Feld zurückgesetzt"
//self.bubbleQuizzZeichenfeldNachzeichnen.iPhoneDE    = "Zeichne das Devanagari-Zeichen nach \nund drücke dann OK.\n\nMit reset wird das Feld zurückgesetzt"
//self.bubbleQuizzZeichenfeldAnzeige.landscapeDE      = "Hier wird das aktuelle \nDevanagari-Zeichen angezeigt"
//self.bubbleQuizzZeichenfeldAnzeige.iPhoneDE         = "Hier wird das aktuelle \nDevanagari-Zeichen angezeigt"
//self.bubbleQuizzZeichenfeldAbfrage.landscapeDE      = "Zeichne hier das\ngesuchte Devanagari-Zeichen"
//self.bubbleQuizzZeichenfeldAbfrage.iPhoneDE         = "Zeichne hier das\ngesuchte Devanagari-Zeichen"
//self.bubbleQuizzUmschriftAnzeige.landscapeDE        = "Dieses Feld zeigt die Umschrift\ndes aktuellen Zeichens"
//self.bubbleQuizzUmschriftAnzeige.iPhoneDE           = "Dieses Feld zeigt die Umschrift\ndes aktuellen Zeichens"
//self.bubbleQuizzUmschriftAbfrage.landscapeDE        = "Gib nun selbst die\nUmschrift des aktuellen\nZeichens ein!"
//self.bubbleQuizzUmschriftAbfrage.iPhoneDE           = "Gib nun selbst die\nUmschrift des aktuellen\nZeichens ein!"
//self.bubbleQuizzVokalAnzeige.landscapeDE            = "Dieses Feld zeigt an,\nob es sich bei dem\naktuellen Zeichen um einen Vokal\nhandelt oder nicht"
//self.bubbleQuizzVokalAnzeige.iPhoneDE               = "Dieses Feld zeigt an,\nob es sich bei dem\naktuellen Zeichen um einen Vokal\nhandelt oder nicht"
//self.bubbleQuizzVokalAbfrage.landscapeDE            = "Entscheide nun selbst, ob es sich\nbei dem Zeichen um einen Vokal\nhandelt oder nicht"
//self.bubbleQuizzVokalAbfrage.iPhoneDE               = "Entscheide nun selbst, ob es sich\nbei dem Zeichen um einen Vokal\nhandelt oder nicht"
//self.bubbleQuizzArtikulationAnzeige.landscapeDE     = "Dieses Feld zeigt an,\nan welchem Ort im Mund- und Rachenraum\nder Laut des aktuellen Zeichens\nartikulatiert wird"
//self.bubbleQuizzArtikulationAnzeige.iPhoneDE        = "Dieses Feld zeigt an,\nan welchem Ort im Mund- \nund Rachenraumn der Laut \ndes aktuellen Zeichens\nartikulatiert wird"
//self.bubbleQuizzArtikulationAbfrage.landscapeDE     = "Entscheide nun selbst,\nan welchem Ort im Mund- und Rachenraum\ndas angezeigte Zeichen artikuliert wird"
//self.bubbleQuizzArtikulationAbfrage.iPhoneDE        = "Entscheide nun selbst,\nan welchem Ort im Mund- \nund Rachenraum das angezeigte \nZeichen artikuliert wird"
//self.bubbleQuizzAspirtationAnzeige.landscapeDE      = "Dieses Feld zeigt an,\nob es sich bei dem aktuellen\nZeichen um einen aspirierten Laut\nhandelt oder nicht"
//self.bubbleQuizzAspirtationAnzeige.iPhoneDE         = "Dieses Feld zeigt an,\nob es sich bei dem aktuellen\nZeichen um einen aspirierten Laut\nhandelt oder nicht"
//self.bubbleQuizzAspirationAbfrage.landscapeDE       = "Entscheide nun selbst,\nob es sich bei dem aktuellen\nZeichen um einen aspirierten Laut\nhandelt oder nicht"
//self.bubbleQuizzAspirationAbfrage.iPhoneDE          = "Entscheide nun selbst,\nob es sich bei dem aktuellen\nZeichen um einen aspirierten Laut\nhandelt oder nicht"
//self.bubbleQuizzStimmhaftAnzeige.landscapeDE        = "Dieses Feld zeigt an,\nob es sich bei dem aktuellen\nZeichen um einen stimmhaften Laut\nhandelt oder nicht"
//self.bubbleQuizzStimmhaftAnzeige.iPhoneDE           = "Dieses Feld zeigt an,\nob es sich bei dem aktuellen\nZeichen um einen stimmhaften Laut\nhandelt oder nicht"
//self.bubbleQuizzStimmhaftAbfrage.landscapeDE        = "Entscheide nun selbst,\nob es sich bei dem aktuellen\nZeichen um einen stimmhaften Laut\nhandelt oder nicht"
//self.bubbleQuizzStimmhaftAbfrage.iPhoneDE           = "Entscheide nun selbst,\nob es sich bei dem aktuellen\nZeichen um einen stimmhaften Laut\nhandelt oder nicht"
//self.bubbleQuizzNasaleAnzeige.landscapeDE           = "Dieses Feld zeigt an,\nob es sich bei dem aktuellen Zeichen \num einen Nasal oder einen \neinfachen Konsonanten handelt"
//self.bubbleQuizzNasaleAnzeige.iPhoneDE              = "Dieses Feld zeigt an,\nob es sich bei dem aktuellen \nZeichen um einen Nasal \noder einen einfachen \nKonsonanten handelt"
//
//self.bubbleQuizzNasaleAbfrage.landscapeDE           = "Entscheide nun selbst,\nob es sich bei dem aktuellen Zeichen \num einen Nasal oder einen \neinfachen Konsonanten handelt"
//self.bubbleQuizzNasaleAbfrage.iPhoneDE              = "Entscheide nun selbst,\nob es sich bei dem aktuellen\nZeichen um einen Nasal oder\neinen einfachen Konsonanten \nhandelt"
//self.bubbleQuizzHalbvokaleAnzeige.landscapeDE       = "Dieses Feld zeigt an,\nob es sich bei dem aktuellen\nZeichen um einen Halbvokal\noder einen einfachen Vokal handelt"
//self.bubbleQuizzHalbvokaleAnzeige.iPhoneDE          = "Dieses Feld zeigt an,\nob es sich bei dem aktuellen\nZeichen um einen Halbvokal\noder einen einfachen Vokal handelt"
//self.bubbleQuizzHalbvokaleAbfrage.landscapeDE       = "Entscheide selbst,\nob es sich bei dem aktuellen\nZeichen um einen Halbvokal\noder einen einfachen Vokal handelt"
//self.bubbleQuizzHalbvokaleAbfrage.iPhoneDE          = "Entscheide selbst,\nob es sich bei dem aktuellen\nZeichen um einen Halbvokal\noder einen einfachen Vokal handelt"
//self.bubbleQuizzSibilantenAnzeige.landscapeDE       = "Dieses Feld zeigt an,\nob es sich bei dem aktuellen Zeichen \num einen Nasal, einen einfachen Konsonanten\noder einen Sibilanten handelt"
//self.bubbleQuizzSibilantenAnzeige.iPhoneDE          = "Dieses Feld zeigt an,\nob es sich bei dem aktuellen \nZeichen um einen Nasal, \neinen einfachen Konsonanten\noder einen Sibilanten handelt"
//self.bubbleQuizzSibilantenAbfrage.landscapeDE       = "Entscheide nun selbst,\nob es sich bei dem aktuellen Zeichen \num einen Nasal, einen einfachen Konsonanten\noder einen Sibilanten handelt"
//self.bubbleQuizzSibilantenAbfrage.iPhoneDE          = "Entscheide nun selbst,\nob es sich bei dem aktuellen \nZeichen um einen Nasal, \neinen einfachen Konsonanten\noder einen Sibilanten handelt"
//self.bubbleQuizzHauchlautAnzeige.landscapeDE        = "Dieses Feld zeigt an,\nob es sich bei dem aktuellen Zeichen \num einen Nasal, einen einfachen Konsonanten,\neinen Sibilanten oder einen Hauchlaut handelt"
//self.bubbleQuizzHauchlautAnzeige.iPhoneDE           = "Dieses Feld zeigt an,\nob es sich bei dem aktuellen \nZeichen um einen Nasal, \neinen einfachen Konsonanten,\neinen Sibilanten oder \neinen Hauchlaut handelt"
//self.bubbleQuizzHauchlautAbfrage.landscapeDE        = "Entscheide nun selbst,\nob es sich bei dem aktuellen Zeichen \num einen Nasal, einen einfachen Konsonanten,\neinen Sibilanten oder einen Hauchlaut handelt"
//self.bubbleQuizzHauchlautAbfrage.iPhoneDE           = "Entscheide nun selbst,\nob es sich bei dem aktuellen \nZeichen um einen Nasal, \neinen einfachen Konsonanten,\neinen Sibilanten oder \neinen Hauchlaut handelt"
//
////FehlerHilfe
//self.fehlerHilfeVokal.aktuellDE                     = "Vokale können lang anhaltend artikuliert werden.\nVersuche z.B. für 5s 'a' zu sagen\n\nKonsonanten entstehen durch plötzliches Öffnen\neines Verschlusses im Mund- und Rachenraum.\nKonsonanten können aus diesem Grund\nnicht anhaltend artikuliert werden\nVersuche für 5s 'k' zu sagen"
//self.fehlerHilfeVokal.iPhoneDE                      = "Vokale können lang anhaltend \nartikuliert werden.Versuche z.B. \nfür 5s 'a' zu sagen\n\nKonsonanten entstehen durch \nplötzliches Öffnen eines \nVerschlusses im Mund- und \nRachenraum.\nKonsonanten können aus diesem \nGrund nicht anhaltend artikuliert\nwerden\nVersuche für 5s 'k' zu sagen"
//
//self.fehlerHilfeNasal.aktuellDE                     = "Nasale entstehen dadurch, dass der Luftstrom bei der Artikulation nicht allein über den Mund, sondern auch über die Nase entweicht.\n\nDevanagari unterscheidet 5 Nasale. Für jeden Artikulationsort einen."
//
//self.fehlerHilfeSibilant.aktuellDE                  = "Sibilianten beziehungsweise Zischlaute entstehen dadurch, dass der Luftstrom im Mundraum eine enge Stelle vor oder hinter den Zähnen passiert.\n\nDevanagari kennt drei Zischlaute. Einen dentalen, स - sa, einen palatalen श - śa und einen retroflexen ष - ṣa."
//self.fehlerHilfeHauchlaut.aktuellDE                 = "Der Hauchlaut in Sanskrit entspricht dem deutschen Laut 'ha', wie wir ihn in Haus oder Hirsch kennen"
//self.fehlerHilfeHalbVokal.aktuellDE                 = "Halbvokale stehen zwischen den Konsonanten und Vokalen.\n\nIm Gegensatz zu einfachen Konsonanten können Halbvokale,\nwie Vokale, anhaltend artikuliert werden.\n\nMit den Konsonanten haben sie wiederum gemeinsam,\ndass ihnen Vokale anhängen."
//self.fehlerHilfeHalbVokal.iPhoneDE                  = "Halbvokale stehen zwischen \nden Konsonanten und Vokalen.\n\nIm Gegensatz zu einfachen \nKonsonanten können Halbvokale,\nwie Vokale, anhaltend artikuliert \nwerden.\n\nMit den Konsonanten haben sie \nwiederum gemeinsam,dass \nihnen Vokale anhängen."
//
//self.fehlerHilfeArtikulation.landscapeDE            = "Sanskrit unterscheidet 5 Orte im Mund- und Rachenraum,\nan denen Laute gebildet werden können."
//self.fehlerHilfeArtikulation.portraitDE             = "Sanskrit unterscheidet 5 Orte im Mund- und Rachenraum,\nan denen Laute gebildet werden können."
//self.fehlerHilfeArtikulation.iPhoneDE               = "Sanskrit unterscheidet 5 Orte \nim Mund- und Rachenraum,\nan denen Laute gebildet \nwerden können."
//
//self.fehlerHilfeAspiriert.aktuellDE                 = "Devanagari hat eigene Zeichen jeweils für aspirierte\nund nicht aspirierte Laute.\n\nAspirierte Laute werden von einem hörbaren Hauchlaut begleitet."
//self.fehlerHilfeAspiriert.iPhoneDE                  = "Devanagari hat eigene Zeichen \njeweils für aspirierte und \nnicht aspirierte Laute.\n\nAspirierte Laute werden von \neinem hörbaren Hauchlaut \nbegleitet."
//
//self.fehlerHilfeStimmhaft.aktuellDE                 = "Zusätzlich zur Aspiration unterscheidet Devanagari\nzwischen stimmhaften und nicht stimmhaften Konsonanten.\n\nIm Fall von stimmhaften Lauten werden die Stimmbänder in Schwingung versetzt.\nBei stimmlosen Konsonanten schwingen die Stimmbänder nicht mit.\n\nTipp: Halte die Hand an den Kehlkopf,um zwischen stimmhaften und stimmlosen\nKonsonanten zu unterscheiden."
//self.fehlerHilfeStimmhaft.iPhoneDE                 = "Zusätzlich zur Aspiration \nunterscheidet Devanagari \nzwischen stimmhaften und \nnicht stimmhaften Konsonanten.\n\nIm Fall von stimmhaften Lauten \nwerden die Stimmbänder in \nSchwingung versetzt.\nBei stimmlosen Konsonanten \nschwingen die Stimmbänder \nnicht mit.\n\nTipp: Halte die Hand \nan den Kehlkopf,um zwischen \nstimmhaften und stimmlosen\nKonsonanten zu unterscheiden."
//
//

