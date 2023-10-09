//
//  Subcategory.swift
//  BincangBareng
//
//  Created by Stefanus Albert Wilson on 10/9/23.
//

import Foundation
import RealmSwift

class Subcategory: Object {
    @objc dynamic var title: String = ""
    
    let items = List<Item>()
}
