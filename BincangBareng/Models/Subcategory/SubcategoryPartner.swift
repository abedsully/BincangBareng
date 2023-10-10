//
//  Subcategory.swift
//  BincangBareng
//
//  Created by Stefanus Albert Wilson on 10/9/23.
//

import Foundation
import RealmSwift

class SubcategoryPartner: Object {
    @objc dynamic var title: String = ""
    
    let items = List<ItemPartner>()
}
