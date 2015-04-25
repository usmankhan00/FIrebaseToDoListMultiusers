//
//  SignUpViewController.swift
//  firebaseApp
//
//  Created by Faiq on 4/20/15.
//  Copyright (c) 2015 Faiq. All rights reserved.
//

import UIKit

var dictOfuid = [String: String]()
var uniqueID = ""

var arrOfKeysOFUsersAccounts = []


class SignUpViewController: UIViewController {

    @IBOutlet weak var signUpUsernameField: UITextField!
    @IBOutlet weak var signUpPasswordField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func SignUpBtn(sender: AnyObject) {
        
        var userTextField = signUpUsernameField.text
        var passwordTextField = signUpPasswordField.text
        
        let ref = Firebase(url: "https://todolistapp293.firebaseio.com")
        ref.createUser(userTextField, password: passwordTextField,
            withValueCompletionBlock: { error, result in
                if error != nil {
                    println("error")
                } else {
                    var uid = result["uid"] as? String
                    println("Successfully created user account with uid: \(uid)")
                    println(userTextField)
                    
                    var uniqueID = uid
                    
                    
                    var usersRef = ref.childByAppendingPath("usersAccounts")
                    
                    dictOfuid.updateValue(userTextField, forKey: uniqueID!)
                    
                    usersRef.updateChildValues(dictOfuid)
                    
                   
                }
        })
        signUpUsernameField.text = ""
        signUpPasswordField.text = ""

        self.performSegueWithIdentifier("GoToMainViewController", sender: self)
    }

    

}
