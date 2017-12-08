//
//  ConfigZeichensatzVC.swift
//  learnDevanagari2
//
//  Created by Matthias Pochmann on 19.11.17.
//  Copyright © 2017 Matthias Pochmann. All rights reserved.
//

import UIKit
import ReactiveSwift

class ConfigZeichensatzViewModel{
    var quizConfigModel:QuizConfigModel
    init(quizConfigModel:QuizConfigModel){
        self.quizConfigModel = quizConfigModel
        
        anzahlAusGrundauswahl.value         = quizConfigModel.configZeichensatzGewaehltausGrundauswahl.value.count
        tableViewTitles                     = quizConfigModel.alleLektionenBisher.map{$0.title ?? "Fehlt"}
        tableViewSubtitles                  = quizConfigModel.alleLektionenBisher.map{ lektion in quizConfigModel.gesamtZeichenSatz.filter{($0.lektion  ?? -1) == lektion.nummer ?? 1000}.reduce(""){$0 + " " + ($1.devanagari ?? "")}}
        tableViewSelectedRows.value         = Set(quizConfigModel.configZeichensatzGewaehlteLektionen.value.map{IndexPath.init(row: $0.nummer ?? 1000, section: 0)})
        
        
        quizConfigModel.configZeichensatzGewaehlteLektionen <~ tableViewSelectedRows.signal.map{ indices in quizConfigModel.alleLektionenBisher.filter{ indices.map{$0.row}.contains(($0.nummer ?? 1000)) } }
        quizConfigModel.configZeichensatzGewaehlteLektionen <~ alleBisherigenButton.signal.map { _ in quizConfigModel.alleLektionenBisher}
        tableViewSelectedRows                               <~ alleBisherigenButton.signal.map {_ in Set(quizConfigModel.alleLektionenBisher.map{IndexPath.init(row: $0.nummer ?? -1, section: 0)})}
        
        quizConfigModel.freiesUebenZeichenSatz          <~ gewaehltAusGrundauswahl
        
        grundAuswahl                                    <~ quizConfigModel.configZeichensatzGrundauswahl
        gewaehltAusGrundauswahl                         <~ quizConfigModel.configZeichensatzGewaehltausGrundauswahl
        quizConfigModel.configZeichensatzGewaehltausGrundauswahl    <~ anzahlAusGrundauswahl.signal.map{[weak self] anzahl in Array((self?.grundAuswahl.value ?? [Zeichen]()).prefix(anzahl) )}
        
        anzahlAusGrundauswahl   <~ grundAuswahl.signal.filter{[weak self] grundauswahl in grundauswahl.count < self?.anzahlAusGrundauswahl.value ?? 0}.map{$0.count}
    }
    
    var tableViewTitles         = [String]()
    var tableViewSubtitles      = [String]()
    var tableViewSelectedRows   = MutableProperty(Set<IndexPath>())
    
    //Mutable Properties
    var grundAuswahl            = MutableProperty([Zeichen]())
    var gewaehltAusGrundauswahl = MutableProperty([Zeichen]())
    var anzahlAusGrundauswahl   = MutableProperty(0)
    var alleBisherigenButton    = MutableProperty(Void())
    var zufallButton            = MutableProperty(Void())
    var seltenGeuebtButton      = MutableProperty(Void())
    var haufigFalschButton      = MutableProperty(Void())
}
class ConfigZeichensatzVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
    var viewModel:ConfigZeichensatzViewModel!
    override func viewDidLoad() {
        anzahlGesamtLabel.reactive.text         <~ viewModel.grundAuswahl.producer.map{"\($0.count)"}
        viewModel.anzahlAusGrundauswahl         <~ slider.reactive.values.map{Int($0.rounded())}
        gewaehltAusGesamtLabel.reactive.text    <~ viewModel.anzahlAusGrundauswahl.producer.map{"\($0)"}
        slider.reactive.maximumValue            <~ viewModel.grundAuswahl.producer.map{Float($0.count)}
        slider.reactive.value                   <~ viewModel.anzahlAusGrundauswahl.producer.map{Float($0)}
        
        
        viewModel.tableViewSelectedRows.producer.combinePrevious().startWithValues { [weak self] prevIndices, currentIndices in
            self?.tableView.reloadRows(at: Array(currentIndices.symmetricDifference(prevIndices)), with: .automatic)
        }
        
        
        //Button Actions
        viewModel.alleBisherigenButton          <~ alleBisherigenButton.reactive.controlEvents(.touchUpInside).map{_ in ()}
        viewModel.zufallButton                  <~ zufallButton.reactive.controlEvents(.touchUpInside).map{_ in ()}
        viewModel.seltenGeuebtButton            <~ seltenGeuebtButton.reactive.controlEvents(.touchUpInside).map{_ in ()}
        viewModel.haufigFalschButton            <~ haufigFalschButton.reactive.controlEvents(.touchUpInside).map{_ in ()}
    }
    
    //MARK: TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return viewModel.tableViewTitles.count }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text        = viewModel.tableViewTitles[indexPath.row]
        cell.detailTextLabel?.text  = viewModel.tableViewSubtitles[indexPath.row]
        cell.accessoryType          = viewModel.tableViewSelectedRows.value.contains(indexPath) ? .checkmark : .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.tableViewSelectedRows.value.formSymmetricDifference(Set([indexPath]))
    }
    
    //Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var grundauswahlView: UIView!{ didSet{ setBorder(for: grundauswahlView) } }
    @IBOutlet weak var auswahlView: UIView!     { didSet{ setBorder(for: auswahlView) } }
    @IBOutlet weak var anzahlGesamtLabel: UILabel!
    @IBOutlet weak var gewaehltAusGesamtLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var alleBisherigenButton: UIButton!
    @IBOutlet weak var zufallButton: UIButton!
    @IBOutlet weak var seltenGeuebtButton: UIButton!
    @IBOutlet weak var haufigFalschButton: UIButton!
    
    //helper
    private func setBorder(for view:UIView){
        view.layer.borderColor = UIColor.darkGray.cgColor
        view.layer.borderWidth = 2.0
    }
}




//    override func viewDidLoad() {
//        super.viewDidLoad()
//        animationInit()
//    }
//    @IBAction func animationStarten(_ sender: UIButton) {
//        flip()
//    }
//    private func animationInit() {
//        firstView = UIView(frame: CGRect(x: 32, y: 200, width: 128, height: 128))
//        secondView = UIView(frame: CGRect(x: 32, y: 200, width: 128, height: 128))
//        firstView.backgroundColor = UIColor.red
//        secondView.backgroundColor = UIColor.blue
//        secondView.isHidden = true
//        view.addSubview(firstView)
//        view.addSubview(secondView)
//    }
//
//    var firstView: UIView!
//    var secondView: UIView!
//    func flip() {
//        let transitionOptions: UIViewAnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]
//
//        UIView.transition(with: firstView, duration: 1.0, options: transitionOptions, animations: {
//            self.firstView.isHidden = true
//        })
//
//        UIView.transition(with: secondView, duration: 1.0, options: transitionOptions, animations: {
//            self.secondView.isHidden = false
//        })
//    }
