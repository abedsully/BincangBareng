//
//  ItemFamily.swift
//  BincangBareng
//
//  Created by Stefanus Albert Wilson on 10/10/23.
//

import Foundation
import RealmSwift

class ItemFamily: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
    
    var parentCategory = LinkingObjects(fromType: SubcategoryFamily.self, property: "items")
}
