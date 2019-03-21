//
//  AddListViewController.swift
//  ToDoList
//
//  Created by lpiem on 21/03/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit

class ListDetailViewController: UITableViewController {

    var delegate: ListDetailViewControllerDelegate?
    var listToEdit : Checklist?
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    override func viewWillAppear(_ animated: Bool) {
        doneButton.isEnabled = false
        textField.becomeFirstResponder()
    }
    
    @IBAction func done(_ sender: Any) {
        print(textField.text!)
        if(listToEdit == nil){
            print("not edit")
            let newList = Checklist.init(name: textField.text!)
            delegate?.listDetailViewController(self,didFinishAddingList: newList)
        } else {
            print("edit")
            listToEdit?.name = textField.text!
            delegate?.listDetailViewController(self,didFinishEditingList: listToEdit!)
        }
        
    }
    
    @IBAction func cancel(_ sender: Any) {
        //dismiss(animated: true, completion: nil)
        delegate?.listDetailViewControllerDidCancel(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(listToEdit as Any)
        if(listToEdit != nil){
            textField.text = listToEdit?.name
            self.title = "Edit a List"
        }
    }
    
    
}

extension ListDetailViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        
        let oldString = textField.text!
        let newString = oldString.replacingCharacters(in: Range(range, in: oldString)!,
                                                      with: string)
        if(newString.isEmpty) {
            doneButton.isEnabled = false
        } else {
            doneButton.isEnabled = true
        }
        return true
    }
}

protocol ListDetailViewControllerDelegate : class {
    func listDetailViewControllerDidCancel(_ controller: ListDetailViewController)
    func listDetailViewController(_ controller: ListDetailViewController, didFinishAddingList list: Checklist)
    func listDetailViewController(_ controller: ListDetailViewController, didFinishEditingList list: Checklist)
}

