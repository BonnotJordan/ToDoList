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

    var itemToEdit : ChecklistItem? = nil
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
        configureText(for: cell as! ChecklistItemCell, withItem: checklistItems[indexPath.item])
        configureCheckmark(for: cell as! ChecklistItemCell, withItem: checklistItems[indexPath.item])
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
    
    func configureCheckmark(for cell: ChecklistItemCell, withItem item : ChecklistItem){
        //cell.accessoryType = item.checked ? .checkmark : .none
        if(item.checked) {
            cell.checkLabel.isHidden = false;
        } else {
            cell.checkLabel.isHidden = true;
        }
        
    }
    
    func configureText(for cell: ChecklistItemCell, withItem item: ChecklistItem) {
        cell.itemLabel.text = item.text
        //cell.textLabel?.text = item.text
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "addItem"){
            let navigation = segue.destination as! UINavigationController
            let delegateVC = navigation.topViewController as! AddItemViewController
            delegateVC.itemToEdit = nil
            delegateVC.delegate = self
        }
        else if (segue.identifier == "editItem"){
            let navigation = segue.destination as! UINavigationController
            let delegateVC = navigation.topViewController as! AddItemViewController
            let cell = sender as! ChecklistItemCell
            let index = tableView.indexPath(for: cell)
            itemToEdit = checklistItems[index!.row]
            
            delegateVC.itemToEdit = itemToEdit
            delegateVC.delegate = self
        }
    }
    
    
}

extension ChecklistViewController : AddItemViewControllerDelegate {
    func addItemViewController(_ controller: AddItemViewController, didFinishEditingItem item: ChecklistItem) {
        print("new text",item.text)
        
        tableView.reloadRows(at: [IndexPath(row: checklistItems.firstIndex(where: { $0 === item })!, section: 0)], with: UITableView.RowAnimation.automatic)

        dismiss(animated: true, completion: nil)
    }
    
    func addItemViewControllerDidCancel(_ controller: AddItemViewController) {
        print("Cancel")
        dismiss(animated: true, completion: nil)
    }
    
    func addItemViewController(_ controller: AddItemViewController, didFinishAddingItem item: ChecklistItem)
    {
        print("Ok",item.text)
        dismiss(animated: true, completion: nil)
        checklistItems.append(item)
        tableView.insertRows(at: [IndexPath(row: checklistItems.count - 1, section: 0)], with: UITableView.RowAnimation.automatic)
        
    }
    
}

