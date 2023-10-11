//
//  FriendsSwipeTableViewController.swift
//  BincangBareng
//
//  Created by Stefanus Albert Wilson on 10/11/23.
//

import UIKit
import RealmSwift
import SwipeCellKit

class FriendsSwipeTableViewController: UITableViewController, SwipeTableViewCellDelegate {
    
    var friendsItems: Results<ItemFriends>?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 70.0
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.friendsItemCell, for: indexPath) as! SwipeTableViewCell
        
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }

        let updateAction = SwipeAction(style: .destructive, title: "") { action, indexPath in
            self.updateModel(at: indexPath)
        }

        updateAction.image = UIImage(named: "flag-icon")

        if let item = self.friendsItems?[indexPath.row] {
            if item.done {
                updateAction.title = "Undone"
            } else {
                updateAction.title = "Done"
            }
        }

        return [updateAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .selection
        return options
    }
    
    func updateModel(at indexPath: IndexPath){
        
    }
    
}
