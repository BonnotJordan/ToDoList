//
//  ChecklistItem.swift
//  ToDoList
//
//  Created by lpiem on 14/02/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit

class ChecklistItem {
    var text: String
    var checked: Bool

    
    init(text: String, checked: Bool = false) {
        self.text = text
        self.checked = checked
    }
    
    func toggleChecked() {
        if(checked){
            self.checked  = false
        } else {
            self.checked = true
        }
    }
    
}
