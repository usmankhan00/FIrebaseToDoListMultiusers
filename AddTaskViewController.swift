//
//  AddTaskViewController.swift
//  firebaseApp
//
//  Created by Faiq on 4/20/15.
//  Copyright (c) 2015 Faiq. All rights reserved.
//

import UIKit

var saveTaskDict = [String: String]()

class AddTaskViewController: UIViewController {

    @IBOutlet weak var descField: UITextField!
    @IBOutlet weak var taskField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func AddBtn(sender: AnyObject) {
        
        if taskField.text != "" && descField.text != "" {
        
            var taskText = taskField.text
            var descText = descField.text
            
            saveTaskDict = [:]
            var ref = Firebase(url: "https://todolistapp293.firebaseio.com")
        
            saveTaskDict[taskText] = descText
            ref.childByAppendingPath(globalVarKeys).updateChildValues(saveTaskDict)
        
            self.performSegueWithIdentifier("moveToTableViewController", sender: self)
        }
        else {
            println("Error no task")
        }
    }
    
    @IBAction func signOutBtn(sender: AnyObject) {
        
        var ref = Firebase(url: "https://todolistapp293.firebaseio.com")
        saveTaskDict = [:]
        ref.unauth()
        performSegueWithIdentifier("signOutSegue", sender: self)
        
    }
    
}
