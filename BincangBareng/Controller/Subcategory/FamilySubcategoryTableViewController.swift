//
//  FamilySubcategoryTableViewController.swift
//  BincangBareng
//
//  Created by Stefanus Albert Wilson on 10/10/23.
//

import UIKit
import RealmSwift

class FamilySubcategoryTableViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var subcategories: Results<SubcategoryFamily>?
    

    override func viewDidLoad() {
        super.viewDidLoad()
            
        addTopicsFamily()
        
        loadSubcategories()
    }
    
    // MARK: - Adding Default Topics and Questions
    
    func addTopicsFamily(){
        addDefaultSubcategory(title: "Childhood", fileName: "childhoodFamily")
        addDefaultSubcategory(title: "Dreams", fileName: "dreamsFamily")
        addDefaultSubcategory(title: "Experience", fileName: "experienceFamily")
        addDefaultSubcategory(title: "Growth", fileName: "growthFamily")
        addDefaultSubcategory(title: "Hobbies", fileName: "hobbiesFamily")
        addDefaultSubcategory(title: "Traditions", fileName: "traditionsFamily")
        addDefaultSubcategory(title: "Travelling", fileName: "travelFamily")
    }
    
    // MARK: - Table View Data Source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subcategories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.subcategoryFamilyCell, for: indexPath)
        
        cell.textLabel?.text = subcategories?[indexPath.row].title ?? "No topics added yet"
        
        return cell
    }
    
    // MARK: - Table View Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Constant.toFamilyItem, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! FamilyItemViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedSubcategory = subcategories?[indexPath.row]
        }
    }
    
    // MARK: - Data Manipulation Methods
    
    func saveSubcategories(subcategories: SubcategoryFamily) {
        do {
            try realm.write {
                realm.add(subcategories)
            }
        } catch {
            print("Error saving new topics \(error)")
        }
        tableView.reloadData()
    }
    
    func loadSubcategories(){
        subcategories = realm.objects(SubcategoryFamily.self)
        
        tableView.reloadData()
    }
    
    // MARK: - Adding New Topics
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: Constant.alertSubcategory, message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: Constant.alertActionSubcategory, style: .default) { (action) in
            let newSubcategory = SubcategoryFamily()
            
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
        
        if realm.objects(SubcategoryFamily.self).filter("title == %@", title).first != nil {
            print("Subcategory with title '\(title)' already exists. Skipping...")
            return
        }
        
        let subcategory = SubcategoryFamily()
        subcategory.title = title
        
        
        if let questions = loadQuestionsFromFile(fileName: fileName) {
            for question in questions {
                let newItem = ItemFamily()
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
