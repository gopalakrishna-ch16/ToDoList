//
//  CategoryViewController.swift
//  ToDoList
//
//  Created by gopalakrishna on 18/12/18.
//  Copyright © 2018 gopalakrishna. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {
    let realm = try! Realm()
    var categories: Results<Category>?
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCetegory()
    
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cetegorycell", for: indexPath)
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories Added Yet"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
        
    }
    


    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var txtField = UITextField()
        let alert = UIAlertController(title: "Add New Cetegory", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Cetegory", style: .default) { (action) in
            
            let newCategory = Category()
            newCategory.name = txtField.text!
            self.save(category: newCategory)
        }
        alert.addTextField { (myTxtFld) in
            myTxtFld.placeholder = "enter cetegory"
            txtField = myTxtFld
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    func save(category: Category) {
        
        do {
            try realm.write {
                realm.add(category)
            }
           }catch {
            print("error savings,\(error)")
                  }
        tableView.reloadData()
    }
    
    func loadCetegory(){
        categories = realm.objects(Category.self)
        tableView.reloadData()

    }
}
