//
//  AllListViewController.swift
//  ToDoList
//
//  Created by lpiem on 14/03/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit

class AllListViewController: UITableViewController {

    let dataModel = DataModel.shared
    
    
    
    var listToEdit : Checklist? = nil
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataModel.sortCheckList()
        //var listItems1 = Array<ChecklistItem>()
        /*listItems1.append(ChecklistItem(text: "Test 1"))
        listItems1.append(ChecklistItem(text: "Test 2"))
        listItems1.append(ChecklistItem(text: "Test 3"))
        listItems1.append(ChecklistItem(text: "Test 4"))*/
        
        //var listItems2 = Array<ChecklistItem>()
        /*listItems2.append(ChecklistItem(text: "Test 11"))
        listItems2.append(ChecklistItem(text: "Test 12"))
        listItems2.append(ChecklistItem(text: "Test 13"))
        listItems2.append(ChecklistItem(text: "Test 14"))*/
        
        
        /*let list1 = Checklist.init(name: "Liste 1")
        let list2 = Checklist.init(name: "Liste 2")
        let list3 = Checklist.init(name: "Liste 3")
        
        lists.append(list1)
        lists.append(list2)
        lists.append(list3)
        
        for list in lists {
            list.items.append(ChecklistItem(text: "Item for \(list.name)"))
        }*/
        
        //loadChecklists()
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
        return dataModel.listofChecklists.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listName", for: indexPath)
        cell.textLabel?.text = dataModel.listofChecklists[indexPath.row].name
        if (dataModel.listofChecklists[indexPath.row].uncheckedItemsCount == 0) {
            if (dataModel.listofChecklists[indexPath.row].items.count == 0) {
                cell.detailTextLabel?.text = "No item"
            } else {
                cell.detailTextLabel?.text = "All Done !"
            }
        } else {
            if (dataModel.listofChecklists[indexPath.row].uncheckedItemsCount == 1) {
                cell.detailTextLabel?.text = "\(String(dataModel.listofChecklists[indexPath.row].uncheckedItemsCount)) item unchecked"
            } else {
                cell.detailTextLabel?.text = "\(String(dataModel.listofChecklists[indexPath.row].uncheckedItemsCount)) items unchecked"
            }
            
        }
        
        return cell
    }
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "listNameClicked") {
            let delegateVC = segue.destination as! ChecklistViewController
            let cell = sender
            let index = tableView.indexPath(for: cell as! UITableViewCell)
            let list = dataModel.listofChecklists[index!.row]
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
            listToEdit = dataModel.listofChecklists[index!.row]
            delegateVC.listToEdit = listToEdit
            delegateVC.delegate = self
        }
    }
    
    @IBAction func addDummyList(_ sender : Any) {
        let listCreated = Checklist.init(name: "Dummy")
        dataModel.listofChecklists.append(listCreated)
        let indexPath = IndexPath(row: dataModel.listofChecklists.count-1, section: 0)
        tableView.insertRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        dataModel.listofChecklists.remove(at: indexPath.item)
        tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        
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
        dataModel.listofChecklists.append(list)
        print("save list")
        tableView.insertRows(at: [IndexPath(row: dataModel.listofChecklists.count - 1, section: 0)], with: UITableView.RowAnimation.automatic)
    }
    
    func listDetailViewController(_ controller: ListDetailViewController, didFinishEditingList list: Checklist) {
        print("new text",list.name)
        tableView.reloadRows(at: [IndexPath(row: dataModel.listofChecklists.firstIndex(where: { $0 === list })!, section: 0)], with: UITableView.RowAnimation.automatic)
        dismiss(animated: true, completion: nil)
        print("save list")
    }
    
    
}
