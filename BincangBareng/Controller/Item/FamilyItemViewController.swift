//
//  FamilyItemViewController.swift
//  BincangBareng
//
//  Created by Stefanus Albert Wilson on 10/5/23.
//

import UIKit
import RealmSwift

class FamilyItemViewController: FamilySwipeTableViewController {
    
    let realm = try! Realm()
    
    var selectedSubcategory: SubcategoryFamily? {
        didSet {
            loadItems()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = 70.0
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Table View Datasource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return familyItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let item = familyItems?[indexPath.row] {
            cell.textLabel?.text = item.name
            
            cell.accessoryType = item.done ? .checkmark : .none
            
            cell.textLabel?.numberOfLines = 0 
        }
        
        else {
            cell.textLabel?.text = "No Questions Added"
        }

        return cell
    }
    
    // MARK: - Table View Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    // MARK: - Adding New Questions
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: Constant.alertItem, message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: Constant.alertActionItem, style: .default) { (action) in
            if let currentSubcategory = self.selectedSubcategory {
                do {
                    try self.realm.write {
                        let newItem = ItemFamily()
                        newItem.name = textField.text!
                        newItem.dateCreated = Date()
                        currentSubcategory.items.append(newItem)
                    }
                } catch {
                    print("Error saving new question \(error)")
                }
            }
            
            self.tableView.reloadData()
        }
        
        alert.addAction(action)
        
        alert.addTextField { (alertTextField) in
            textField = alertTextField
        }
        
        present(alert, animated: true, completion: nil)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissAlertController))
                tapGesture.cancelsTouchesInView = false
                view.window?.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissAlertController(sender: UITapGestureRecognizer) {
            self.view.window?.removeGestureRecognizer(sender)
            self.presentedViewController?.dismiss(animated: true, completion: nil)
        }
    
    // MARK: - Data Manipulation Methods
    
    func loadItems(){
        familyItems = selectedSubcategory?.items.sorted(by: [
            SortDescriptor(keyPath: "done", ascending: true),
            SortDescriptor(keyPath: "dateCreated", ascending: false)
        ])
        tableView.reloadData()
    }
    
    // MARK: - Update Model
    
    override func updateModel(at indexPath: IndexPath) {
        if let itemsToUpdate = self.familyItems?[indexPath.row] {
            do {
                try self.realm.write {
                    itemsToUpdate.done = !itemsToUpdate.done // Toggle the 'done' property
                }
            } catch {
                print("Error updating items \(error)")
            }
        }
        tableView.reloadData()
    }
    
}

// MARK: - Search Bar Methods

extension FamilyItemViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        familyItems = familyItems?.filter("name CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "done", ascending: true)

        tableView.reloadData()
    }


    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchBar.text?.count == 0){
            loadItems()

            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
        
        else{
            searchBarSearchButtonClicked(searchBar)
        }
    }
}
