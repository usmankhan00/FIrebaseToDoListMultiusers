//
//  ViewController.swift
//  firebaseApp
//
//  Created by Faiq on 4/20/15.
//  Copyright (c) 2015 Faiq. All rights reserved.
//

import UIKit
var retrieveDictOfuid = [:]
var arrOfValuesOfuid = []
var arrOfkeysOfuid = []
var globalVarValues = ""
var globalVarKeys = ""
var dictKey = ""

class ViewController: UIViewController {

    @IBOutlet weak var signInPasswordField: UITextField!
    @IBOutlet weak var signInUsernameField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func SignInBtn(sender: AnyObject) {
        
        var userTextField = signInUsernameField.text
        var passwordTextField = signInPasswordField.text
        
        let ref = Firebase(url: "https://todolistapp293.firebaseio.com")
        ref.authUser(userTextField, password: passwordTextField,
            withCompletionBlock: { error, authData in
                if error != nil {
                    println("error in logging")
                } else {
                    ref.observeEventType(.Value, withBlock: { snapshot in
                        retrieveDictOfuid = snapshot.value as NSDictionary
                        retrieveDictOfuid = retrieveDictOfuid.valueForKey("usersAccounts") as NSDictionary
                        arrOfValuesOfuid = retrieveDictOfuid.allValues
                        arrOfkeysOfuid = retrieveDictOfuid.allKeys
                        
                        for var match = 0; match <= arrOfValuesOfuid.count; match++ {
                            if arrOfValuesOfuid[match] as NSString == userTextField {
                                
                                
                                self.performSegueWithIdentifier("moveToAddTaskContoller", sender: self)
                                globalVarValues = arrOfValuesOfuid[match] as NSString as String
                                globalVarKeys = arrOfkeysOfuid[match] as NSString as String
                                var dictKey = globalVarValues
                                
                                println(arrOfValuesOfuid[match])
                                println(arrOfkeysOfuid[match])
                                break
                            }
                        }
                        
                        }, withCancelBlock: { error in
                            println(error.description)
                    })
                    
                }
        })
        
    }

}

