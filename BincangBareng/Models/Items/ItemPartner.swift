//
//  Item.swift
//  BincangBareng
//
//  Created by Stefanus Albert Wilson on 10/9/23.
//

import Foundation
import RealmSwift

class ItemPartner: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
    
    var parentCategory = LinkingObjects(fromType: SubcategoryPartner.self, property: "items")
}
