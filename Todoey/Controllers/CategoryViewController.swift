//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Søren Knudsen on 08/01/2018.
//  Copyright © 2018 Søren Knudsen. All rights reserved.
//

import UIKit
import RealmSwift


class CategoryViewController: SwipeTableViewController {
    //MARK: - Variables global
    let realm = try! Realm()
    
    var catArray : Results<Category>?
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategories()
        tableView.rowHeight = 80
    }

    //MARK: - Tableview Datasource Metods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        let cell = super.tableView(tableView, cellForRowAt: indexPath) //this takes the cell and row from the superclass swipetable...
        
        
        cell.textLabel?.text = catArray?[indexPath.row].name ?? "No category added yet"
        
     
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catArray?.count ?? 1
        
    }
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! SwipeTableViewCell
//        cell.delegate = self
//        return cell
//    }
    
    
    
    
    //MARK: - TableView Deligate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = catArray?[indexPath.row]
            
        }
    }
    
    //MARK: - Data Manipulation Methods
    
    
    //MARK: - Add New Categories
  
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new category", message: "", preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "Add", style: UIAlertActionStyle.default) { (action) in
            // What will happen once the user clicks the add Item button on out UIAlert.
            
            let newCat = Category()
            newCat.name = textField.text!
            
            
            self.save(category: newCat)
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new category"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    
    }
    
 
    
    //MARK - Delete data
    
    override func updateModel(at indexPath: IndexPath) {
        
    
        if let categoryItem = catArray?[indexPath.row] {
            do {
                try realm.write {
                    realm.delete(categoryItem)  //deletes the item.
                    
                }
            } catch {
                print("Error updating status, \(error)")
            }
        }

        
        
    }
    
    
    //MARK: - Save Data function
    
    func save(category: Category) {
        
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error savind data \(error)")
        }
        tableView.reloadData()
    }
    
    func loadCategories() {
        catArray = realm.objects(Category.self)
        tableView.reloadData()
    }
    
    
}

