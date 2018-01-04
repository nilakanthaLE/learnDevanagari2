//
//  ZeichenAuswahlConfigView.swift
//  learnDevanagari2
//
//  Created by Matthias Pochmann on 02.01.18.
//  Copyright © 2018 Matthias Pochmann. All rights reserved.
//

import Foundation
import ReactiveSwift


class ZeichenAuswahlConfigViewModel:AbfrageZeichenViewModelProtocol{
    var zeichenArray        = MutableProperty([[(title:String,color:UIColor)]]())
    
    var editButtonIsHidden      = MutableProperty(true)
    
    var zeichenInGrundauswahl   = [Zeichen]()
    var gewaehlteZeichen        = [Zeichen]()
    
    
    
    
    init (configZeichensatzGrundauswahl:MutableProperty<[Zeichen]>,configZeichensatzGewaehltausGrundauswahl:MutableProperty<[Zeichen]>){
        zeichenArray <~ configZeichensatzGrundauswahl.producer.map{
            ZeichenAuswahlConfigViewModel.updateZeichenArray(configZeichensatzGrundauswahl: $0, configZeichensatzGewaehltausGrundauswahl: configZeichensatzGewaehltausGrundauswahl.value)
        }
        zeichenArray <~ configZeichensatzGewaehltausGrundauswahl.producer.map{
            ZeichenAuswahlConfigViewModel.updateZeichenArray(configZeichensatzGrundauswahl: configZeichensatzGrundauswahl.value, configZeichensatzGewaehltausGrundauswahl:$0)
        }
    }
    
    static func updateZeichenArray(configZeichensatzGrundauswahl:[Zeichen],configZeichensatzGewaehltausGrundauswahl:[Zeichen]) -> [[(title:String,color:UIColor)]]{
        var grundauswahl            = configZeichensatzGrundauswahl
        let anzahlReihen            = Int(ceil(sqrt(Double(configZeichensatzGrundauswahl.count))))
        let array                   = Array.init(repeating: Array.init(repeating: String(), count: anzahlReihen), count: anzahlReihen)
        func getAndRemoveFirst() -> (title:String,color:UIColor)  {
            if grundauswahl.count > 0{
                let zeichen = grundauswahl.removeFirst()
                let color   = configZeichensatzGewaehltausGrundauswahl.contains(zeichen) ? UIColor.lightGray : UIColor.clear
                return (title:zeichen.devanagari ?? String(),color:color)
            }
            return (title: String() , color : .clear)
        }
        return array.map {row in row.map{_ in  getAndRemoveFirst()}}
    }
}


//MARK: GrundauswahlPopover
class GrundauswahlPopoverViewModel{
    init(configZeichensatzGewaehlteLektionen:MutableProperty<[Lektion]>,gesamtZeichensatz:[Zeichen]){
        var alleLektionenBisher:[Lektion]   { return MainSettings.get()?.angemeldeterUser?.alleLektionenBisher ?? [Lektion]() }
        tableViewTitles                     = alleLektionenBisher.map{$0.title ?? "Fehlt"}
        tableViewSubtitles                  = alleLektionenBisher.map{ lektion in gesamtZeichensatz.filter{($0.lektion  ?? -1) == lektion.nummer ?? 1000}.reduce(""){$0 + " " + ($1.devanagari ?? "")}}
        
        tableViewSelectedRows.value         = Set(configZeichensatzGewaehlteLektionen.value.map{IndexPath.init(row: $0.nummer ?? 1000, section: 0)})
        
        configZeichensatzGewaehlteLektionen <~ tableViewSelectedRows.signal.map{ indices in alleLektionenBisher.filter{ indices.map{$0.row}.contains(($0.nummer ?? 1000)) } }
        
        configZeichensatzGewaehlteLektionen <~ alleBisherigenButton.signal.map { _ in alleLektionenBisher}
        
        tableViewSelectedRows                               <~ alleBisherigenButton.signal.map {_ in Set(alleLektionenBisher.map{IndexPath.init(row: $0.nummer ?? -1, section: 0)})}
    }
    var alleBisherigenButton    = MutableProperty(Void())
    
    var tableViewTitles         = [String]()
    var tableViewSubtitles      = [String]()
    var tableViewSelectedRows   = MutableProperty(Set<IndexPath>())
    
    
}

class GrundauswahlPopoverVC:UITableViewController{
    var viewModel:GrundauswahlPopoverViewModel!{
        didSet{
            viewModel.tableViewSelectedRows.producer.combinePrevious().startWithValues { [weak self] prevIndices, currentIndices in
                self?.tableView.reloadRows(at: Array(currentIndices.symmetricDifference(prevIndices)), with: .automatic)
            }
        }
    }
    @IBAction func alleBisherigenButtonPressed(_ sender: Any) { viewModel.alleBisherigenButton.value = Void()}
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {return viewModel.tableViewTitles.count }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text        = viewModel.tableViewTitles[indexPath.row]
        cell.detailTextLabel?.text  = viewModel.tableViewSubtitles[indexPath.row]
        cell.accessoryType          = viewModel.tableViewSelectedRows.value.contains(indexPath) ? .checkmark : .none
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.tableViewSelectedRows.value.formSymmetricDifference(Set([indexPath]))
    }
}
