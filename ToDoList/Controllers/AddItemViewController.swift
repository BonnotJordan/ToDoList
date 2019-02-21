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

    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var textField: UITextField!
    @IBAction func done(_ sender: Any) {
        let newItem = ChecklistItem(text: textField.text!)
        print(textField.text!)
        delegate?.addItemViewController(self,didFinishAddingItem: newItem)
    }
    
    @IBAction func cancel(_ sender: Any) {
        delegate?.addItemViewControllerDidCancel(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        doneButton.isEnabled = false
        textField.becomeFirstResponder()
        
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
}
