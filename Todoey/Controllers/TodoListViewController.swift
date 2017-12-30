//
//  ViewController.swift
//  Todoey
//
//  Created by Søren Knudsen on 27/12/2017.
//  Copyright © 2017 Søren Knudsen. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()
    
    let dataFilePath = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).first?.appendingPathComponent("Items.plist")
    //let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        loadItems()
    
        
    }

   //MARK - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]

        
        //Ternary operator ==>
        // vlaue = condition ? valueTRue : valueFalse
        
        //cell.accessoryType = item.done == true ? .checkmark : .none
        cell.accessoryType = item.done ? .checkmark : .none
        

        
        cell.textLabel?.text = item.title
        return cell
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    
    //MARK - TbleView Deligate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done   //sets the variable to the opposite of what it is now - that is the ! function.
        
        
        
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.saveItems()
        
    
        
        

    }
    
   //MARK - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: UIAlertControllerStyle.alert)
        
        let action = UIAlertAction(title: "Add Item", style: UIAlertActionStyle.default) { (action) in
            // What will happen once the user clicks the add Item button on out UIAlert.
            
            
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
        
            
            self.saveItems()
            
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    //MARK - Save Data function
    
    func saveItems() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding data: \(error)")
        }
        tableView.reloadData()
    }
    
    //MARK - Retrive Data function
    
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            
            do {
            itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("Error decoding data \(error)")
            }
        }
        }

    
}

