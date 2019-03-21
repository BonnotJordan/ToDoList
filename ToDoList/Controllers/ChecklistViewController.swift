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

    /*var documentDirectory : URL {
        get {
            return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        }
    }
    var dataFileUrl : URL {
        get {
            let fileUrl = documentDirectory.appendingPathComponent("Checklists").appendingPathExtension("json")
            return fileUrl
        }
    }*/
    
    var itemToEdit : ChecklistItem? = nil
    var checklistItems = Array<ChecklistItem>()
    var list : Checklist!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = list.name
        /*print(documentDirectory)
        print(dataFileUrl)*/
        
        checklistItems = list.items
        //loadChecklistItems()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func awakeFromNib() {
        //loadChecklistItems()
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
        //saveChecklistItems()
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        checklistItems.remove(at: indexPath.item)
        tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        //saveChecklistItems()
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
            let delegateVC = navigation.topViewController as! ItemDetailViewController
            delegateVC.itemToEdit = nil
            delegateVC.delegate = self
        }
        else if (segue.identifier == "editItem"){
            let navigation = segue.destination as! UINavigationController
            let delegateVC = navigation.topViewController as! ItemDetailViewController
            let cell = sender as! ChecklistItemCell
            let index = tableView.indexPath(for: cell)
            itemToEdit = checklistItems[index!.row]
            
            delegateVC.itemToEdit = itemToEdit
            delegateVC.delegate = self
        }
    }
    
    /*func saveChecklistItems() {
        print("Save")
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        let data = try! encoder.encode(checklistItems)
        try! data.write(to: dataFileUrl)
    }
    
    
    func loadChecklistItems() {
        let jsonFile = try! Data(contentsOf: dataFileUrl)
        let decoder = JSONDecoder()
        let data = try! decoder.decode(Array<ChecklistItem>.self, from: jsonFile)
        checklistItems = data
        
    }*/
    
}

extension ChecklistViewController : ItemDetailViewControllerDelegate {
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishEditingItem item: ChecklistItem) {
        print("new text",item.text)
        
        tableView.reloadRows(at: [IndexPath(row: checklistItems.firstIndex(where: { $0 === item })!, section: 0)], with: UITableView.RowAnimation.automatic)
        
        dismiss(animated: true, completion: nil)
        //saveChecklistItems()
    }
    
    func itemDetailViewControllerDidCancel(_ controller: ItemDetailViewController) {
        print("Cancel")
        dismiss(animated: true, completion: nil)
    }
    
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishAddingItem item: ChecklistItem)
    {
        print("Ok",item.text)
        dismiss(animated: true, completion: nil)
        checklistItems.append(item)
        tableView.insertRows(at: [IndexPath(row: checklistItems.count - 1, section: 0)], with: UITableView.RowAnimation.automatic)
        //saveChecklistItems()
        
    }
    
}

