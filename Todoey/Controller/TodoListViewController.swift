//
//  ViewController.swift
//  Todoey
//
//  Created by Piotr Cybulski on 06/10/2019.
//  Copyright © 2019 Piotr Cybulski. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var todoList = [Item]()
    var dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    let encoder = PropertyListEncoder()
    let decoder = PropertyListDecoder()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.alwaysBounceVertical = false
        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoListCell", for: indexPath)
        
        let item = todoList[indexPath.row]
        
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        todoList[indexPath.row].done = !todoList[indexPath.row].done
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func addItemPressed(_ sender: UIBarButtonItem) {
        
        var textField : UITextField?
        
        let alert = UIAlertController(title: "Adding new item", message: "", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Add item", style: .default, handler: {
            (action) in
            
            if let text = textField?.text {
                self.todoList.append(Item(title: text))
                saveData()
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
    
    func saveData () {
        do {
            let data = try encoder.encode(todoList)
            try data.write(to: self.dataFilePath!)
        } catch {
            print ("Problem with encoding data \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func loadData () {
        do {
            let data = try decoder.decode([Item].self, from: Data(contentsOf: dataFilePath!))
            todoList = data
        } catch {
            print ("Problem with decoding data \(error)")
        }
    }
}

