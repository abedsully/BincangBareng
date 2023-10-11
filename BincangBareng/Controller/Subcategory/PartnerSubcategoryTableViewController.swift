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
    
    var subcategories: Results<SubcategoryPartner>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTopicsPartner()
        
        loadSubcategories()
    }
    
    // MARK: - Adding Default Topics and Questions
    
    func addTopicsPartner(){
        addDefaultSubcategory(title: "Love", fileName: "lovePartner")
        addDefaultSubcategory(title: "Work", fileName: "workPartner")
        addDefaultSubcategory(title: "Travel", fileName: "travelPartner")
        addDefaultSubcategory(title: "Hobbies", fileName: "hobbiesPartner")
        addDefaultSubcategory(title: "Goals", fileName: "goalsPartner")
        addDefaultSubcategory(title: "Memories", fileName: "memoriesPartner")
        addDefaultSubcategory(title: "Entertainment", fileName: "entertainmentPartner")
        addDefaultSubcategory(title: "Foods", fileName: "foodPartner")
        addDefaultSubcategory(title: "Wellness", fileName: "wellnessPartner")
        addDefaultSubcategory(title: "Events", fileName: "eventsPartner")
        addDefaultSubcategory(title: "Future", fileName: "futurePartner")
    }
    
    // MARK: - Table View Data Source
    
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
    
    func saveSubcategories(subcategories: SubcategoryPartner) {
        do {
            try realm.write {
                realm.add(subcategories)
            }
        }
        
        catch {
            print("Error new topics \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadSubcategories(){
        subcategories = realm.objects(SubcategoryPartner.self)
        
        tableView.reloadData()
    }
    
    
    // MARK: - Adding New Topics
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: Constant.alertSubcategory, message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: Constant.alertActionSubcategory, style: .default) { (action) in
            let newSubcategory = SubcategoryPartner()
            
            newSubcategory.title = textField.text!
            
            self.saveSubcategories(subcategories: newSubcategory)
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
    
    // // MARK: - Default Topics and Questions
    
    func addDefaultSubcategory(title: String, fileName: String) {
        
        if realm.objects(SubcategoryPartner.self).filter("title == %@", title).first != nil {
            print("Subcategory with title '\(title)' already exists. Skipping...")
            return
        }
        
        let subcategory = SubcategoryPartner()
        subcategory.title = title
        
        
        if let questions = loadQuestionsFromFile(fileName: fileName) {
            for question in questions {
                let newItem = ItemPartner()
                newItem.name = question
                newItem.done = false
                newItem.dateCreated = Date()
                subcategory.items.append(newItem)
            }
        } else {
            print("Failed to load questions from file.")
        }
        
        saveSubcategories(subcategories: subcategory)
    }
    
    
    
    
}
