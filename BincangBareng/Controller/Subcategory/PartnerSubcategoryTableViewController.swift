//
//  PartnerSubcategoryTableViewController.swift
//  BincangBareng
//
//  Created by Stefanus Albert Wilson on 10/9/23.
//

import UIKit
import RealmSwift

class PartnerSubcategoryTableViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var subcategories: Results<Subcategory>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addDefaultSubcategory(title: "Love", fileName: "lovePartner")
        addDefaultSubcategory(title: "Work", fileName: "workPartner")
        
        loadSubcategories()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subcategories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.subcategoryPartnerCell, for: indexPath)
        
        cell.textLabel?.text = subcategories?[indexPath.row].title ?? "No topics added yet"
        
        return cell
    }
    
    // MARK: - Table View Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Constant.toPartnerItem, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! PartnerItemViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedSubcategory = subcategories?[indexPath.row]
        }
    }
    
    // MARK: - Data Manipulation Methods
    
    func saveSubcategories(subcategories: Subcategory) {
        do {
            try realm.write {
                realm.add(subcategories)
            }
        }
        
        catch {
            print("Error saving subcategories \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadSubcategories(){
        subcategories = realm.objects(Subcategory.self)
        
        tableView.reloadData()
    }
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: Constant.alertSubcategory, message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: Constant.alertActionSubcategory, style: .default) { (action) in
            let newSubcategory = Subcategory()
            
            newSubcategory.title = textField.text!
            
            self.saveSubcategories(subcategories: newSubcategory)
        }
        
        alert.addAction(action)
        
        alert.addTextField { (alertTextField) in
            textField = alertTextField
        }
        
        present(alert, animated: true, completion: nil)
    }
    
    
    
    // // MARK: - Default Topics and Questions
    func addDefaultSubcategory(title: String, fileName: String) {
        
        if realm.objects(Subcategory.self).filter("title == %@", title).first != nil {
            print("Subcategory with title '\(title)' already exists. Skipping...")
            return
        }
        
        let subcategory = Subcategory()
        subcategory.title = title
        
        if let questions = loadQuestionsFromFile(fileName: fileName) {
            for question in questions {
                let newItem = Item()
                newItem.name = question
                newItem.done = false
                subcategory.items.append(newItem)
            }
        } else {
            print("Failed to load questions from file.")
        }
        
        saveSubcategories(subcategories: subcategory)
    }
    
    
    
    
}
