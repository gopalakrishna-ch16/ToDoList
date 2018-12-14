//
//  ViewController.swift
//  ToDoList
//
//  Created by gopalakrishna on 14/12/18.
//  Copyright © 2018 gopalakrishna. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
var itemArray = ["Find Mike","Buy Eggos","Destroy Demogorgon"]
    let defaults = UserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let item = defaults.array(forKey: "ToDoListArray") {
            itemArray = defaults.array(forKey: "ToDoListArray") as! [String]
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
//MARK - TableView DataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoList", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - Bar Button Action

    @IBAction func barButtonPressed(_ sender: UIBarButtonItem) {
        var textFld = UITextField()
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            self.itemArray.append(textFld.text!)
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTextFld) in
            alertTextFld.placeholder = "Add New Item"
            textFld = alertTextFld
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

