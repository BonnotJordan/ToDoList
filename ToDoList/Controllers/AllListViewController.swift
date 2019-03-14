//
//  AllListViewController.swift
//  ToDoList
//
//  Created by lpiem on 14/03/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit

class AllListViewController: UITableViewController {

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
        }
    }

}
