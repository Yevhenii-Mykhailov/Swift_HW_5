//
//  ShoppingItemModel.swift
//  Homework_5
//
//  Created by Yevhenii M on 04.11.2022.
//

import Foundation
import RealmSwift

class ShoppingItem: Object {

    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var name: String = ""
    
    convenience init(name: String) {
           self.init()
           self.name = name
       }
}
