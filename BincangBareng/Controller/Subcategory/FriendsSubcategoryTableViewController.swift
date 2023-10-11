//
//  FriendsSubcategoryTableViewController.swift
//  BincangBareng
//
//  Created by Stefanus Albert Wilson on 10/10/23.
//

import UIKit
import RealmSwift

class FriendsSubcategoryTableViewController: UITableViewController {
    
    let realm = try! Realm()
    var subcategories: Results<SubcategoryFriends>?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTopicsFriends()
        
        loadSubcategories()
    }
    
    // MARK: - Adding Default Topics and Questions
    
    func addTopicsFriends(){
        addDefaultSubcategory(title: "Books", fileName: "booksFriends")
        addDefaultSubcategory(title: "Events", fileName: "eventsFriends")
        addDefaultSubcategory(title: "Foods", fileName: "foodFriends")
        addDefaultSubcategory(title: "Funny Stories", fileName: "funnyStoriesFriends")
        addDefaultSubcategory(title: "Growth", fileName: "growthFriends")
        addDefaultSubcategory(title: "Hobbies", fileName: "hobbiesFriends")
        addDefaultSubcategory(title: "Movies", fileName: "moviesFriends")
        addDefaultSubcategory(title: "Travel", fileName: "travelFriends")
        addDefaultSubcategory(title: "Goals", fileName: "goalsFriends")
        addDefaultSubcategory(title: "Musics", fileName: "musicFriends")
    }

    // MARK: - Table View Data Source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subcategories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.subcategoryFriendsCell, for: indexPath)
        
        cell.textLabel?.text = subcategories?[indexPath.row].title ?? "No topics added yet"
        
        return cell
    }
    
    // MARK: - Table View Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Constant.toFriendsItem, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! FriendsItemViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedSubcategory = subcategories?[indexPath.row]
        }
    }
    
    // MARK: - Data Manipulation Methods
    
    func saveSubcategories(subcategories: SubcategoryFriends) {
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
        subcategories = realm.objects(SubcategoryFriends.self)
        
        tableView.reloadData()
    }
    
    // MARK: - Adding New Topics
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: Constant.alertSubcategory, message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: Constant.alertActionSubcategory, style: .default) { (action) in
            let newSubcategory = SubcategoryFriends()
            
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
        
        if realm.objects(SubcategoryFriends.self).filter("title == %@", title).first != nil {
            print("Subcategory with title '\(title)' already exists. Skipping...")
            return
        }
        
        let subcategory = SubcategoryFriends()
        subcategory.title = title
        
        
        if let questions = loadQuestionsFromFile(fileName: fileName) {
            for question in questions {
                let newItem = ItemFriends()
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
