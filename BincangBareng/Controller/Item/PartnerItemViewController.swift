//
//  ViewController.swift
//  BincangBareng
//
//  Created by Stefanus Albert Wilson on 10/5/23.
//

import UIKit
import RealmSwift

class PartnerItemViewController: UITableViewController {
    
    var partnerItems: Results<ItemPartner>?
    let realm = try! Realm()
    
    var selectedSubcategory: SubcategoryPartner? {
        didSet {
            loadItems()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 70.0
        
    }
    
    // MARK: - Table View Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return partnerItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.partnerItemCell, for: indexPath)
        
        if let item = partnerItems?[indexPath.row] {
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
        
        if let item = partnerItems?[indexPath.row] {
            do {
                try realm.write {
                    item.done = !item.done
                }
            } catch {
                print("Error saving new questions \(error)")
            }
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        tableView.reloadData()
        
    }
    
    // MARK: - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: Constant.alertItem, message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: Constant.alertActionItem, style: .default) { (action) in
            if let currentSubcategory = self.selectedSubcategory {
                do {
                    try self.realm.write {
                        let newItem = ItemPartner()
                        newItem.name = textField.text!
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
    
    
    func loadItems(){
        partnerItems = selectedSubcategory?.items.sorted(byKeyPath: "name", ascending: true)
        tableView.reloadData()
    }
}

