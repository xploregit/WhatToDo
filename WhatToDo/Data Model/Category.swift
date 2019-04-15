//
//  Category.swift
//  WhatToDo
//
//  Created by Djauhery on 15/4/19.
//  Copyright © 2019 Djauhery. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object {
    @objc dynamic var name : String = ""
    let items = List<Item>()
}
