//
//  DataModel.swift
//  ToDoList
//
//  Created by lpiem on 21/03/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//


import UIKit

var documentDirectory : URL {
    get {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
}

var dataFileUrl : URL {
    get {
        let fileUrl = documentDirectory.appendingPathComponent("Checklists").appendingPathExtension("json")
        return fileUrl
    }
}

class DataModel {
    
    
   
    static let shared = DataModel()
    
    private init(){
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(saveChecklists),
            name: UIApplication.didEnterBackgroundNotification,
            object: nil)
        loadChecklists()
    }
    
    var listofChecklists = Array<Checklist>()
    
    @objc func saveChecklists() {
        print("Save")
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try! encoder.encode(listofChecklists)
        try! data.write(to: dataFileUrl)
    }
    
    
    func loadChecklists() {
        let jsonFile = try! Data(contentsOf: dataFileUrl)
        let decoder = JSONDecoder()
        let data = try! decoder.decode(Array<Checklist>.self, from: jsonFile)
        listofChecklists = data
        
    }
    
    func sortCheckList() {
        let sortedList = listofChecklists.sorted { $0.name.lowercased() < $1.name.lowercased() }
        listofChecklists = sortedList
    }
    
    
    
}
