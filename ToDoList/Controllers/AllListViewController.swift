//
//  AllListViewController.swift
//  ToDoList
//
//  Created by lpiem on 14/03/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit

class AllListViewController: UITableViewController {

    var listToEdit : Checklist? = nil
    var lists = Array<Checklist>()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var listItems1 = Array<ChecklistItem>()
        listItems1.append(ChecklistItem(text: "Test 1"))
        listItems1.append(ChecklistItem(text: "Test 2"))
        listItems1.append(ChecklistItem(text: "Test 3"))
        listItems1.append(ChecklistItem(text: "Test 4"))
        
        var listItems2 = Array<ChecklistItem>()
        listItems2.append(ChecklistItem(text: "Test 1"))
        listItems2.append(ChecklistItem(text: "Test 2"))
        listItems2.append(ChecklistItem(text: "Test 3"))
        listItems2.append(ChecklistItem(text: "Test 4"))
        
        
        let list1 = Checklist.init(name: "Liste 1")
        let list2 = Checklist.init(name: "Liste 2", items: listItems1)
        let list3 = Checklist.init(name: "Liste 3", items: listItems2)
        
        lists.append(list1)
        lists.append(list2)
        lists.append(list3)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return lists.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listName", for: indexPath)
        cell.textLabel?.text = lists[indexPath.row].name

        return cell
    }
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "listNameClicked") {
            let delegateVC = segue.destination as! ChecklistViewController
            let cell = sender
            let index = tableView.indexPath(for: cell as! UITableViewCell)
            let list = lists[index!.row]
            delegateVC.list = list
        } else if(segue.identifier == "addList") {
            let navigation = segue.destination as! UINavigationController
            let delegateVC = navigation.topViewController as! ListDetailViewController
            delegateVC.listToEdit = nil
            delegateVC.delegate = self
        } else if(segue.identifier == "editList") {
            let navigation = segue.destination as! UINavigationController
            let delegateVC = navigation.topViewController as! ListDetailViewController
            let cell = sender as! UITableViewCell
            let index = tableView.indexPath(for: cell)
            listToEdit = lists[index!.row]
            delegateVC.listToEdit = listToEdit
            delegateVC.delegate = self
        }
    }
    
    @IBAction func addDummyList(_ sender : Any) {
        let listCreated = Checklist.init(name: "Dummy")
        lists.append(listCreated)
        let indexPath = IndexPath(row: lists.count-1, section: 0)
        tableView.insertRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        lists.remove(at: indexPath.item)
        tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        //saveChecklistItems()
    }
    
    
    

}

extension AllListViewController : ListDetailViewControllerDelegate {
    
    func listDetailViewControllerDidCancel(_ controller: ListDetailViewController) {
            print("Cancel")
            dismiss(animated: true, completion: nil)
    }
    
    func listDetailViewController(_ controller: ListDetailViewController, didFinishAddingList list: Checklist) {
        print("Ok",list.name)
        dismiss(animated: true, completion: nil)
        lists.append(list)
        tableView.insertRows(at: [IndexPath(row: lists.count - 1, section: 0)], with: UITableView.RowAnimation.automatic)
        //saveChecklistItems()
    }
    
    func listDetailViewController(_ controller: ListDetailViewController, didFinishEditingList list: Checklist) {
        print("new text",list.name)
        
        tableView.reloadRows(at: [IndexPath(row: lists.firstIndex(where: { $0 === list })!, section: 0)], with: UITableView.RowAnimation.automatic)
        
        dismiss(animated: true, completion: nil)
        //saveChecklistItems()
    }
    
    
}
