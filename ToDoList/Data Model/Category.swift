//
//  Category.swift
//  ToDoList
//
//  Created by gopalakrishna on 19/12/18.
//  Copyright © 2018 gopalakrishna. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
