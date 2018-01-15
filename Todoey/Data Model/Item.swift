//
//  Item.swift
//  Todoey
//
//  Created by Søren Knudsen on 14/01/2018.
//  Copyright © 2018 Søren Knudsen. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var done : Bool = false
    @objc dynamic var title : String = ""
    @objc dynamic var dateCreated: Date?
    var parrentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
