//
//  UserWahlTableVC.swift
//  learnDevanagari2
//
//  Created by Matthias Pochmann on 08.12.17.
//  Copyright © 2017 Matthias Pochmann. All rights reserved.
//

import UIKit
import ReactiveSwift

//MARK: UserWahlTableVC
// zeigt die erstellten Nutzer
// ermöglicht Anmeldung eines Nutzers
// -> neue Nutzer können angelegt werden
class UserWahlTableVC: UITableViewController {
    var users = User.getAll(){ didSet{tableView.reloadData()} }

    // MARK: - Table view data source && delegates
    override func numberOfSections(in tableView: UITableView) -> Int { return 1 }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return users.count }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell                = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text    = users[indexPath.row].name
        return cell
    }
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath)                             { performSegue(withIdentifier: "createOrEditUser", sender: users[indexPath.row]) }
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool                                        { return true }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)  { if editingStyle == .delete { presentAlertForDelete() } }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        MainSettings.get()?.angemeldeterUser = users[indexPath.row]
        performSegue(withIdentifier: "goToQuiz", sender: nil)
    }
    
    //MARK: IBActions
    @IBAction func addButtonAction(_ sender: UIBarButtonItem) { performSegue(withIdentifier: "createOrEditUser", sender: nil) }
    
    // MARK: - VC LifeCycle
    override func viewDidLoad() { if MainSettings.get()?.angemeldeterUser != nil{ performSegue(withIdentifier: "goToQuiz", sender: nil) } }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination             = segue.destination.contentViewController as? CreateOrEditUserVC
        destination?.user           = sender as? User
        destination?.dismissAction  = dismissAction
    }
    
    private func dismissAction(){
        users = User.getAll()
        dismiss(animated: true, completion: nil)
    }
    private func presentAlertForDelete(){
        let user = users[indexPath.row]
        let alertView = UIAlertController.init(title: "\(user.name ?? "") wirklich Löschen?", message: "Der gesamte Fortschritt geht verloren.", preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "abbrechen", style: .cancel, handler: {[weak self]  _ in self?.dismiss(animated: true, completion: nil) }))
        alertView.addAction(UIAlertAction(title: "löschen", style: .destructive) {[weak self] action in
            self?.users.remove(at: indexPath.row).delete()
            self?.dismiss(animated: true, completion: nil)
        })
        present(alertView, animated: true, completion: nil)
    }
}
//MARK: CreateOrEditUserVC
// einen neuen Nutzer anlegen
// oder Namen eines bestehenden Nutzers ändern
class CreateOrEditUserVC:UIViewController{
    var user:User?                  { didSet{ title = "User Name ändern" } }
    var dismissAction:(()->Void)?
    
    //MARK: - VC LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.text      = user?.name
        okButton.isEnabled  = textField.text?.isEmpty == false
        okButton.reactive.isEnabled <~ textField.reactive.continuousTextValues.producer.map{$0?.isEmpty == false}
    }
    
    //MARK: IBOutlets
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet private weak var textField: UITextField!
    
    //MARK: IBActions
    @IBAction private func abbrechenButtonPressed(_ sender: UIBarButtonItem) { dismissAction?() }
    @IBAction private func okAction(_ sender: UIButton) {
        (user ?? User.neu())?.name = textField.text
        try? managedContext.save()
        dismissAction?()
    }
}


