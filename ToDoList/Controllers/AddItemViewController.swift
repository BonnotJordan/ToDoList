//
//  AddItemViewController.swift
//  ToDoList
//
//  Created by lpiem on 14/02/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit

class AddItemViewController: UITableViewController {
    
    var delegate: AddItemViewControllerDelegate?
    var isAddingItem: Bool = false
    var itemToEdit : ChecklistItem?

    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func done(_ sender: Any) {
        
        print(textField.text!)
        if(itemToEdit == nil){
            print("not edit")
            let newItem = ChecklistItem(text: textField.text!)
            delegate?.addItemViewController(self,didFinishAddingItem: newItem)
        } else {
            print("edit")
            itemToEdit?.text = textField.text!
            delegate?.addItemViewController(self,didFinishEditingItem: itemToEdit!)
        }
        //delegate?.addItemViewController(self,didFinishAddingItem: newItem)
    }
    
    @IBAction func cancel(_ sender: Any) {
        delegate?.addItemViewControllerDidCancel(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        doneButton.isEnabled = false
        textField.becomeFirstResponder()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(itemToEdit as Any)
        if(itemToEdit != nil){
            textField.text = itemToEdit?.text
            self.title = "Edit an item"
        }
        
    }
    
    
}

extension AddItemViewController: UITextFieldDelegate {

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

protocol AddItemViewControllerDelegate : class {
    func addItemViewControllerDidCancel(_ controller: AddItemViewController)
    func addItemViewController(_ controller: AddItemViewController, didFinishAddingItem item: ChecklistItem)
    func addItemViewController(_ controller: AddItemViewController, didFinishEditingItem item: ChecklistItem)
}
