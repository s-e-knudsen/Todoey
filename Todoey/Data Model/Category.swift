//
//  Category.swift
//  Todoey
//
//  Created by Søren Knudsen on 14/01/2018.
//  Copyright © 2018 Søren Knudsen. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name : String = ""
    let items = List<Item>()
}
