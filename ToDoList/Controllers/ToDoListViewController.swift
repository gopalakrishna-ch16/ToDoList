//
//  ViewController.swift
//  ToDoList
//
//  Created by gopalakrishna on 14/12/18.
//  Copyright © 2018 gopalakrishna. All rights reserved.
//

import UIKit
import RealmSwift

class ToDoListViewController: UITableViewController {
    
    let realm = try! Realm()
    var toDoItems: Results<Item>?
    
    var selectedCategory: Category?{
        didSet {
           loadItems()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        }
//MARK - TableView DataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoList", for: indexPath)
        if let item = toDoItems?[indexPath.row]{
            cell.textLabel?.text = item.title
            //Ternary operatoe ==>
            //variable = condition ? valueiftrue : valueiffalse
            
            cell.accessoryType = item.done ? .checkmark : .none
        }else{
            cell.textLabel?.text = "no Items added"
        }
        
        return cell
    }
    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = toDoItems?[indexPath.row] {
            do {
             try realm.write {
                item.done = !item.done
            }
            }catch{
                print("Error savings,\(error)")
            }
            
        }
             tableView.reloadData()
            tableView.deselectRow(at: indexPath, animated: true)
    }

    //MARK - Bar Button Action

    @IBAction func barButtonPressed(_ sender: UIBarButtonItem) {
        var textFld = UITextField()
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            if let currentCategory = self.selectedCategory {
                do {
                    try self.realm.write {
                        let newItem = Item()
                        newItem.title = textFld.text!
                        newItem.dateCreated = Date()
                        currentCategory.items.append(newItem)
                    }
                }catch{
                    print("Error savings,\(error)")
                }
            }
            self.tableView.reloadData()
            }
        alert.addTextField { (alertTextFld) in
            alertTextFld.placeholder = "Add New Item"
            textFld = alertTextFld
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    func loadItems() {
        toDoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
    }
}

extension ToDoListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        toDoItems = toDoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        tableView.reloadData()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }

        }
    }
}

