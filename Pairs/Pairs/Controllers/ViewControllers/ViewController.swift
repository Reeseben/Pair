//
//  ViewController.swift
//  Pairs
//
//  Created by Ben Erekson on 8/20/21.
//

import UIKit

class ViewController: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet var tableView: UITableView!
    
    //MARK: - Properties
    var randomizedArray = PersonController.shared.people
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        PersonController.shared.loadFromPresistenceStore()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        // Do any additional setup after loading the view.
    }
    //MARK: - Actions
    @IBAction func randomizeButtonPressed(_ sender: Any) {
        randomize()
    }
    
    @IBAction func addNameButtonPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Add new name", message: "Enter the name of the person to add", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Enter Name Here"
        }
        let add = UIAlertAction(title: "Add", style: .default) { _ in
            guard let name = alert.textFields?.first?.text, !name.isEmpty else { return }
            PersonController.shared.createPerson(name: name)
            self.tableView.reloadData()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(add)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    //MARK: - Helper Methods
    func randomize(){
        PersonController.shared.shuffle()
        tableView.reloadData()
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if PersonController.shared.people.count == 1 {
            return 1
        }
        if PersonController.shared.people.count % 2 == 0 {
            return 2
        } else {
            if section == PersonController.shared.people.count / 2 - 1 {
                return 3
            } else {
                return 2
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath)
        
            let person = PersonController.shared.people[indexPath.row + (indexPath.section)*2]
            cell.textLabel?.text = person.name
            return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if PersonController.shared.people.count == 1 {
            return 1
        }
        return PersonController.shared.people.count / 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Group \(section + 1)"
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let personToDelete = PersonController.shared.people[indexPath.row + (indexPath.section)*2]
            PersonController.shared.delete(person: personToDelete)
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("Selected row: \(indexPath.row + (indexPath.section)*2)")
    }
    
}
