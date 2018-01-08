//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Søren Knudsen on 08/01/2018.
//  Copyright © 2018 Søren Knudsen. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

  
    //MARK: - Variables global
    
    var catArray = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategories()
    }

    //MARK: - Tableview Datasource Metods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        let category = catArray[indexPath.row]
        
        
        cell.textLabel?.text = category.name
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catArray.count
        
    }
    //MARK: - Data Manipulation Methods
    
    
    //MARK: - Add New Categories
  
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new category", message: "", preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "Add", style: UIAlertActionStyle.default) { (action) in
            // What will happen once the user clicks the add Item button on out UIAlert.
            
            let newCat = Category(context: self.context)
            newCat.name = textField.text!
            self.catArray.append(newCat)
            
            self.saveCategories()
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new category"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    
    }
    
    
    //MARK: - TableView Deligate Methods
    
    
    
    
    
    //MARK: - Save Data function
    
    func saveCategories() {
        
        do {
            try context.save()
        } catch {
            print("Error savind data \(error)")
        }
        tableView.reloadData()
    }
    
    func loadCategories(with request: NSFetchRequest<Category> = Category.fetchRequest()) {  // the with: is the external param and the request is the internal. The after = is the default is not a param i given to the finc.
        
        //let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        do {
            catArray = try context.fetch(request)
        } catch {
            print("Error feaching data \(error)")
        }
        tableView.reloadData()
    }
    
    
}
