//
//  CategoryViewController.swift
//  WhatToDo
//
//  Created by Djauhery on 15/4/19.
//  Copyright © 2019 Djauhery. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {
    
    let realm = try! Realm()
    
    // Results a collection of Result
    var categories : Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategory()
        
        
    }
    
    //MARK: - TableView DataSource Methods
    //Display all category
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let catCell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        catCell.textLabel?.text = categories?[indexPath.row].name ?? "No categories added yet"
        return catCell
    }
    
    //MARK: - TableView Manipulation
    //Save dan Load
    func save(category : Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving context \(error)")
        }
        tableView.reloadData()
    }
    
    func loadCategory() {
        categories = realm.objects(Category.self)
        tableView.reloadData()
    }
    
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            context.delete(categoryArray[indexPath.row])
//            categoryArray.remove(at: indexPath.row)
//            saveCategory()
//        }
//    }
    
//    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
//        return "Hapus"
//    }
    
    //MARK: - Add New Categories

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        var textField = UITextField()
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            if textField.text != "" {
                let newCategory = Category()
                newCategory.name = textField.text!
                self.save(category : newCategory)
            }
        }
        alert.addTextField { (inputTextField) in
            inputTextField.placeholder = "Create new category"
            textField = inputTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    

    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    // Do before performSegue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
//        if segue.identifier == "goToItems" {
            if let indexPath = tableView.indexPathForSelectedRow {
                destinationVC.selectedCategory = categories?[indexPath.row]
            }

//        }
    }
    
 
}
