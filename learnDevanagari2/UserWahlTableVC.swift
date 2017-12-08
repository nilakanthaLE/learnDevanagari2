//
//  UserWahlTableVC.swift
//  learnDevanagari2
//
//  Created by Matthias Pochmann on 08.12.17.
//  Copyright © 2017 Matthias Pochmann. All rights reserved.
//

import UIKit
import ReactiveSwift


class UserWahlTableVC: UITableViewController {
    var users = User.getAll(){ didSet{tableView.reloadData()} }
    

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int { return 1 }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return users.count }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text    = users[indexPath.row].name
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool { return true }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let user = users[indexPath.row]
            let alertView = UIAlertController.init(title: "\(user.name ?? "") wirklich Löschen?", message: "Der gesamte Fortschritt geht verloren.", preferredStyle: .alert)
            alertView.addAction(UIAlertAction(title: "abbrechen", style: .cancel, handler: {[weak self]  _ in
                self?.dismiss(animated: true, completion: nil)
            }))
            alertView.addAction(UIAlertAction(title: "löschen", style: .destructive) {[weak self] action in
                self?.users.remove(at: indexPath.row).delete()
                self?.dismiss(animated: true, completion: nil)
            })
            present(alertView, animated: true, completion: nil)
        }
    }

    // MARK: - Navigation
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "createOrEditUser", sender: users[indexPath.row])
    }
    @IBAction func addButtonAction(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "createOrEditUser", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination             = segue.destination.contentViewController as? CreateOrEditUserVC
        destination?.user           = sender as? User
        destination?.dismissAction  = dismissAction
    }
    func dismissAction(){
        users = User.getAll()
        dismiss(animated: true, completion: nil)
    }
}

class CreateOrEditUserVC:UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.text      = user?.name
        okButton.isEnabled  = textField.text?.isEmpty == false
        okButton.reactive.isEnabled <~ textField.reactive.continuousTextValues.producer.map{$0?.isEmpty == false}
    }
    var user:User?{ didSet{ title = "User Name ändern" } }
    var dismissAction:(()->Void)?
    @IBOutlet private weak var textField: UITextField!
    @IBAction private func okAction(_ sender: UIButton) {
        (user ?? User.neu())?.name = textField.text
        dismissAction?()
    }
    @IBAction private func abbrechenButtonPressed(_ sender: UIBarButtonItem) { dismissAction?() }
    @IBOutlet weak var okButton: UIButton!
}

extension UIViewController{
    var contentViewController:UIViewController {
        if let navCon = self as? UINavigationController{
            return navCon.visibleViewController ?? navCon
        }else{
            return self
        }
    }
}
