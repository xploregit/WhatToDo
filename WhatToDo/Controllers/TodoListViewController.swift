//
//  ToDoListViewController.swift
//  WhatToDo
//
//  Created by Djauhery on 9/4/19.
//  Copyright © 2019 Djauhery. All rights reserved.
//

import UIKit
import RealmSwift

class ToDoListViewController: UITableViewController {

    var todoItems : Results<Item>?
    let realm = try! Realm()
    
    var selectedCategory : Category? {
        didSet {
            loadItems()
        }
    }
    // Save to UserDefaults (1)
//    let defaults = UserDefaults.standard
    
    // Using NSCoder (1)
//    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let newItem = Item()
//        newItem.title = "Find Mike"
//        itemArray.append(newItem)
//
//        let newItem2 = Item()
//        newItem2.title = "Buy Eggos"
//        itemArray.append(newItem2)
//
//        let newItem3 = Item()
//        newItem3.title = "Destroy Demogorgon"
//        itemArray.append(newItem3)

//        loadItems()
        // Do any additional setup after loading the view.
        navigationItem.title = "ToDoList"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonPressed))
        navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        
        // Save to UserDefaults (3)
//        if let items = defaults.array(forKey: "TodoListDict") as? [Item] {
//            itemArray = items
//        }
        
//        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
    }
    
    @objc func addButtonPressed() {
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        var textField = UITextField()
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // What will happen once the user clicks the Add Item button on our UIAlert
            if textField.text != "" {
//                let newItem = Item()
                // Using CoreData (1)
                // First in AppDelegate rename the DataModel in NSPersistentContainer to be the same with the DataModel filename
                // Create an Entity and Attribute
                // Change the Module to Current Product Module
                
                // Using CoreData (3)
//                let newItem = Item(context: self.context)
//                newItem.title = textField.text!
//                newItem.parentCategory = self.selectedCategory
                // Using CoreData (5)
//                newItem.done = false
//                self.itemArray.append(newItem)
                // Save to UserDefaults (2)
//                self.defaults.set(self.itemArray, forKey: "TodoListDict")
                // Using NSCoder (2)
//                self.saveItems()
                // Using Core Data (7)
                if let currentCategory = self.selectedCategory {
                    do {
                        try self.realm.write {
                            let newItem = Item()
                            newItem.title = textField.text!
                            newItem.dateCreated = Date()
                            currentCategory.items.append(newItem)
                        }
                    } catch {
                        print("Error saving new Items, \(error)")
                    }
                }
                self.tableView.reloadData()
            }
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    // Using NSCoder (2)
//    func saveItems() {
//        let encoder = PropertyListEncoder()
//        do {
//            let data = try encoder.encode(itemArray)
//            try data.write(to: dataFilePath!)
//        } catch {
//            print("Error encoding item array, \(error)")
//        }
//        tableView.reloadData()
//    }
//
    // Using NSCoder (3)
//    func loadItems() {
//        if let data = try? Data(contentsOf: dataFilePath!) {
//            let decoder = PropertyListDecoder()
//            do {
//                itemArray = try decoder.decode([Item].self, from: data)
//            } catch {
//                print("Error encoding item array, \(error)")
//            }
//        }
//        tableView.reloadData()
//    }
    
    // Using CoreData (4)
    func saveItems() {
    }
    
    func loadItems() {
        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        if let item = todoItems?[indexPath.row] {
            cell.textLabel?.text = item.title
            cell.accessoryType = item.done ? .checkmark : .none
        } else {
            cell.textLabel?.text = "No Items Added"
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete Data
//            context.delete(itemArray[indexPath.row])
            if let item = todoItems?[indexPath.row] {
                do {
                    try realm.write {
                        realm.delete(item)
                    }
                } catch {
                    print("Error deleting item \(error)")
                }
            }
            tableView.reloadData()
//            itemArray.remove(at: indexPath.row)
//            saveItems()
        }
    }
    
    //MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        todoItems[indexPath.row].done = !todoItems[indexPath.row].done
        // Using NSCoder (2)
//        saveItems()
        // Using CoreData (2)
//        saveItems()
        if let item = todoItems?[indexPath.row] {
            do {
                try realm.write {
                    item.done = !item.done
                }
            } catch {
                print("Error saving done status, \(error)")
            }
                
        }
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Hapus"
    }
    
//    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//        // action one
//        let editAction = UITableViewRowAction(style: .default, title: "Koreksi", handler: { (action, indexPath) in
//            print("Edit tapped")
//        })
//        editAction.backgroundColor = UIColor.blue
//
//        // action two
//        let deleteAction = UITableViewRowAction(style: .default, title: "Hapus", handler: { (action, indexPath) in
//            self.context.delete(self.itemArray[indexPath.row])
//            self.itemArray.remove(at: indexPath.row)
//            self.saveItems()
//        })
//        deleteAction.backgroundColor = UIColor.red
//
//        return [editAction, deleteAction]
//    }

}

//MARK: - Search Bar Method
extension ToDoListViewController : UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        let request : NSFetchRequest<Item> = Item.fetchRequest()
//        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//        loadItems(with : request, predicate: predicate)
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
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



