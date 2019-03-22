//
//  Checklist.swift
//  ToDoList
//
//  Created by lpiem on 14/03/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit

class Checklist : Codable {
    
    var name : String = ""
    var items = Array<ChecklistItem>()
    var icon : IconAsset = .NoIcon
    
    var uncheckedItemsCount : Int {
        get {
            return items.filter{(item) -> Bool in !item.checked }.count
        }
    }
    
    init(name: String, items: Array<ChecklistItem> = Array<ChecklistItem>(), icon : IconAsset = .NoIcon) {
        self.name = name
        self.items = items
    }
}
