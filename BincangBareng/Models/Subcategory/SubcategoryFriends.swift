//
//  SubcategoryFriends.swift
//  BincangBareng
//
//  Created by Stefanus Albert Wilson on 10/10/23.
//

import Foundation
import RealmSwift

class SubcategoryFriends: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var dateCreated: Date?
    
    let items = List<ItemFriends>()
}
