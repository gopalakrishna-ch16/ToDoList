//
//  CategoryViewController.swift
//  ToDoList
//
//  Created by gopalakrishna on 18/12/18.
//  Copyright © 2018 gopalakrishna. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var cetegoryArray = [Cetegory]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCetegory()
    
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cetegoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cetegorycell", for: indexPath)
        cell.textLabel?.text = cetegoryArray[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = cetegoryArray[indexPath.row]
        }
        
    }
    


    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var txtField = UITextField()
        let alert = UIAlertController(title: "Add New Cetegory", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Cetegory", style: .default) { (action) in
            let cetegory = Cetegory(context: self.context)
            cetegory.name = txtField.text!
            self.cetegoryArray.append(cetegory)
            self.saveCetegory()
        }
        alert.addTextField { (myTxtFld) in
            myTxtFld.placeholder = "enter cetegory"
            txtField = myTxtFld
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    func saveCetegory() {
        
        do {
            try context.save()
           }catch {
            print("error savings,\(error)")
                  }
        tableView.reloadData()
    }
    
    func loadCetegory(){
        let request: NSFetchRequest<Cetegory> = Cetegory.fetchRequest()
        do {
        cetegoryArray = try context.fetch(request)
        }catch{
            print("Error fetching context,\(error)")
        }
        tableView.reloadData()

    }
}
