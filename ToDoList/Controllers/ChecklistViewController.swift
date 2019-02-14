//
//  ViewController.swift
//  ToDoList
//
//  Created by lpiem on 14/02/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import Foundation
import UIKit

class ChecklistViewController: UITableViewController {

    var checklistItems = Array<ChecklistItem>()
    override func viewDidLoad() {
        super.viewDidLoad()
        let item1 = ChecklistItem.init(text: "Cellule1")
        let item2 = ChecklistItem.init(text: "Cellule2",checked: true)
        let item3 = ChecklistItem.init(text: "Cellule3")
        let item4 = ChecklistItem.init(text: "Cellule4", checked: true)
        checklistItems.append(item1)
        checklistItems.append(item2)
        checklistItems.append(item3)
        checklistItems.append(item4)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //datasource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return checklistItems.count
    }

    @IBAction func addDummyTodo(_ sender: Any) {
        let itemCreated = ChecklistItem.init(text: "Un item ajouté")
        checklistItems.append(itemCreated)
        let indexPath = IndexPath(row: checklistItems.count-1, section: 0)
        tableView.insertRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
    }
    
    //delegate
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
        configureText(for: cell, withItem: checklistItems[indexPath.item])
        configureCheckmark(for: cell, withItem: checklistItems[indexPath.item])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        checklistItems[indexPath.item].toggleChecked()
        tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        checklistItems.remove(at: indexPath.item)
        tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
    }
    
    func configureCheckmark(for cell: UITableViewCell, withItem item : ChecklistItem){
        cell.accessoryType = item.checked ? .checkmark : .none
        
    }
    
    func configureText(for cell: UITableViewCell, withItem item: ChecklistItem) {
        cell.textLabel?.text = item.text
    }
}

