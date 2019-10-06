//
//  ViewController.swift
//  Todoey
//
//  Created by Piotr Cybulski on 06/10/2019.
//  Copyright © 2019 Piotr Cybulski. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var todoListArray = ["A", "B", "C"]
    var defaults = UserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.alwaysBounceVertical = false
        // Do any additional setup after loading the view.
        
        if let items = defaults.object(forKey: "itemsList") as? [String] {
            todoListArray = items
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoListCell", for: indexPath)
        cell.textLabel?.text = todoListArray[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoListArray.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(todoListArray[indexPath.row])
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
            
        tableView.deselectRow(at: indexPath, animated: true)
    }

    @IBAction func addItemPressed(_ sender: UIBarButtonItem) {
        
        var textField : UITextField?
        
        let alert = UIAlertController(title: "Adding new item", message: "", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Add item", style: .default, handler: {
            (action) in
            if let text = textField?.text {
                self.todoListArray.append(text)
                self.tableView.reloadData()
                self.defaults.set(todoListArray, forKey: "itemsList")
            } else {
                print("Textfield was blank!")
            }
        }))
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Type in new item's name"
            textField = alertTextField
        }
        
        present(alert, animated: true, completion: nil)
        
    }
}

