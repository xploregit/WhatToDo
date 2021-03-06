//
//  Item.swift
//  WhatToDo
//
//  Created by Djauhery on 11/4/19.
//  Copyright © 2019 Djauhery. All rights reserved.
//

//import Foundation
//
//class Item : Codable {
//    var title : String = ""
//    var done : Bool = false
//}

import Foundation
import RealmSwift

class Item : Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var dateCreated : Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
