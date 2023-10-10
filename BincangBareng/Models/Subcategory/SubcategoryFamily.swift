//
//  SubcategoryFamily.swift
//  BincangBareng
//
//  Created by Stefanus Albert Wilson on 10/10/23.
//

import Foundation
import RealmSwift

class SubcategoryFamily: Object {
    @objc dynamic var title: String = ""
    
    let items = List<ItemFamily>()
}
