//
//  ZeichenGrundAuswahlPopoverVC.swift
//  learnDevanagari2
//
//  Created by Matthias Pochmann on 28.01.18.
//  Copyright © 2018 Matthias Pochmann. All rights reserved.
//

import Foundation
import ReactiveSwift

//MARK: GrundauswahlPopover
// popover mit einer Tabelle, die alle bekannten Lektionen und die darin vorgestellten Zeichen zeigt
// einzelne Zeilen (Lektionen) können an und abgewählt werden
// dadurch wird eine Zeichenbasis definiert,
// aus der im folgenden der Zeichensatz für das freie Üben Quiz gewählt wird
class GrundauswahlPopoverViewModel{
    var tableViewTitles         = [String]()
    var tableViewSubtitles      = [String]()
    var tableViewSelectedRows   = MutableProperty(Set<IndexPath>())
    init(configZeichensatzGewaehlteLektionen:MutableProperty<[Lektion]>){
        //initiale Werte setzen
        // Titles,Subtitles für Cells
        // initial gewählte Reihen
        let alleLektionenBisher:[Lektion]   = { return MainSettings.get()?.angemeldeterUser?.alleLektionenBisher ?? [Lektion]() }()
        tableViewTitles                     = alleLektionenBisher.map{$0.title ?? "Fehlt"}
        tableViewSubtitles                  = alleLektionenBisher.map{ lektion in Singleton.sharedInstance.zeichenSatz.filter{($0.lektion  ?? -1) == lektion.nummer ?? 1000}.reduce(""){$0 + " " + ($1.devanagari ?? "")}}
        tableViewSelectedRows.value         = Set(configZeichensatzGewaehlteLektionen.value.map{IndexPath.init(row: $0.nummer ?? 1000, section: 0)})
        
        //Änderungen gewählter Lektionen (+gewählter Reihen)
        configZeichensatzGewaehlteLektionen <~ tableViewSelectedRows.signal.map{ indices in alleLektionenBisher.filter{ indices.map{$0.row}.contains(($0.nummer ?? 1000)) } }
        tableViewSelectedRows               <~ alleBisherigenButtonAction.signal.map {_ in Set(alleLektionenBisher.map{IndexPath.init(row: $0.nummer ?? -1, section: 0)})}
    }
    var alleBisherigenButtonAction    = MutableProperty(Void())
}

class GrundauswahlPopoverVC:UITableViewController{
    var viewModel:GrundauswahlPopoverViewModel!{
        didSet{ viewModel.tableViewSelectedRows.producer.combinePrevious().startWithValues { [weak self] prevIndices, currentIndices in self?.tableView.reloadRows(at: Array(currentIndices.symmetricDifference(prevIndices)), with: .automatic) } }
    }
    
    //MARK: IBAction
    @IBAction func alleBisherigenButtonPressed(_ sender: Any) { viewModel.alleBisherigenButtonAction.value = Void()}
    
    //MARK: TableView dataSource & delegate
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {return viewModel.tableViewTitles.count }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text        = viewModel.tableViewTitles[indexPath.row]
        cell.detailTextLabel?.text  = viewModel.tableViewSubtitles[indexPath.row]
        cell.accessoryType          = viewModel.tableViewSelectedRows.value.contains(indexPath) ? .checkmark : .none
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)  { viewModel.tableViewSelectedRows.value.formSymmetricDifference(Set([indexPath])) }
}
