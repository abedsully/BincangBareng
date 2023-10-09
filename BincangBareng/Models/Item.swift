//
//  Item.swift
//  BincangBareng
//
//  Created by Stefanus Albert Wilson on 10/9/23.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var done: Bool = false
    
    var parentCategory = LinkingObjects(fromType: Subcategory.self, property: "items")
}
