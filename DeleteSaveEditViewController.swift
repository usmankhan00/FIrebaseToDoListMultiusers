//
//  DeleteSaveEditViewController.swift
//  firebaseApp
//
//  Created by Panacloud on 22/04/2015.
//  Copyright (c) 2015 Faiq. All rights reserved.
//

import UIKit


var dictForEditingAndDelete = [:]
var keyOfUserDict: [String] = []


class DeleteSaveEditViewController: UIViewController {
    
    var arrOfUserTask: [String] = []
    var arrOfUserTaskDesc: [String] = []
    var keyOfUser = ""
    var keyOfDesc = ""

    @IBOutlet weak var descField: UITextField!
    @IBOutlet weak var taskField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        var ref = Firebase(url:"https://todolistapp293.firebaseio.com")
        ref.observeEventType(.Value, withBlock: { snapshot in
            dictForEditingAndDelete = snapshot.value as NSDictionary
            dictForEditingAndDelete = dictForEditingAndDelete.valueForKey(globalVarKeys) as NSDictionary
            
            }, withCancelBlock: { error in
                println(error.description)
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func saveBtn(sender: AnyObject) {
        var taskText = taskField.text
        var descText = descField.text
        
        if taskText == keyOfUser {
        saveTaskDict.updateValue(descText, forKey: taskText)
        var ref = Firebase(url:"https://todolistapp293.firebaseio.com")
        ref.childByAppendingPath(globalVarKeys).updateChildValues(saveTaskDict)
        }
        else if descText == keyOfDesc && taskText != keyOfUser {
            saveTaskDict.updateValue(keyOfDesc, forKey: taskText)
            var ref = Firebase(url:"https://todolistapp293.firebaseio.com")
            ref.childByAppendingPath(globalVarKeys).updateChildValues(saveTaskDict)
            
        }
        else {
            saveTaskDict.updateValue(descText, forKey: taskText)
            var ref = Firebase(url:"https://todolistapp293.firebaseio.com")
         
            ref.childByAppendingPath(globalVarKeys).updateChildValues(saveTaskDict)
        }
        performSegueWithIdentifier("SaveItemIdentifier", sender: self)
        
    }
    /*@IBAction func delBtn(sender: AnyObject) {
        
        //println(globalVarKeys)
        var keyy = keyOfUser
        //var url = globalVarKeys
        var ref = Firebase(url:"https://todolistapp293.firebaseio.com/\(globalVarKeys)/\(keyy)")//simplelogin%3A21/\(keyy)")
       // ref.childByAppendingPath(globalVarKeys)?.valueForKey(keyOfUser)?.removeValue()
        //ref.childByAppendingPath(globalVarKeys).updateChildValues(saveTaskDict)
        
        ref.removeValue()
        
    }*/
    
    
}
