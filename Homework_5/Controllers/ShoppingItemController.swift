//
//  ShoppingItemController.swift
//  Homework_5
//
//  Created by Yevhenii M on 04.11.2022.
//

import Foundation
import RealmSwift

class ShoppingItemController {
    let realm = try! Realm()
    
    func addRecord(_ itemName: String) {
        let shoppingItem = ShoppingItem()
        shoppingItem.name = itemName
        
        try! realm.write({
            realm.add(shoppingItem)
        })
    }
    
    func getAllShopItems() -> [ShoppingItem] {
        var items = [ShoppingItem]()
        let itemsResult = realm.objects(ShoppingItem.self)
        
        for item in itemsResult {
            items.append(item)
        }
        
        return items
    }
    
    func removeRecord(_ index: Int) {
        let itemToDelete = realm.objects(ShoppingItem.self)[index]
        try! realm.write {
            realm.delete(itemToDelete)
        }
    }
}
