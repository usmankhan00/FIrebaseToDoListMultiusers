//
//  UserTableViewController.swift
//  firebaseApp
//
//  Created by Faiq on 4/20/15.
//  Copyright (c) 2015 Faiq. All rights reserved.
//

import UIKit

var retrieveDictOfTask = [:]
var arrOfTask:[String] = []
var arrOfDesc: [String] = []
var arrToRemove = []


class UserTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    

    @IBOutlet weak var tableViewOutlet: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var ref = Firebase(url:"https://todolistapp293.firebaseio.com")
        
        
        ref.observeEventType(.Value, withBlock: { snapshot in
            retrieveDictOfTask = snapshot.value as NSDictionary
            println(globalVarKeys)
            arrOfTask = []
            arrOfDesc = []
            retrieveDictOfTask = retrieveDictOfTask.valueForKey(globalVarKeys)as NSDictionary
            arrToRemove = retrieveDictOfTask.allKeys
            
            println(globalVarKeys)
            arrOfTask = retrieveDictOfTask.allKeys as [String]
            arrOfDesc = retrieveDictOfTask.allValues as [String]
                self.tableViewOutlet.reloadData()
            
            
            }, withCancelBlock: { error in
                println(error.description)
        })

        tableViewOutlet.reloadData()
    }
    override func viewDidAppear(animated: Bool) {
        tableViewOutlet.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return arrOfTask.count
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.text = "\(arrOfTask[indexPath.row])"
        cell.detailTextLabel?.text = "\(arrOfDesc[indexPath.row])"
        
        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            
            var keyy = arrOfTask[indexPath.row] as String
            println("keyy is \(keyy)")
            arrOfTask.removeAtIndex(indexPath.row)
            arrOfDesc.removeAtIndex(indexPath.row)
            
            var ref = Firebase(url:"https://todolistapp293.firebaseio.com/\(globalVarKeys)/\(keyy)")
            ref.removeValue()
            
            tableViewOutlet.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
            
            tableViewOutlet.reloadData()
        }
        
    }


    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "CellToViewController"){
            let VC = segue.destinationViewController as DeleteSaveEditViewController
            VC.keyOfUser = arrOfTask[self.tableViewOutlet.indexPathForSelectedRow()!.row] as String
            var userKey = arrOfTask[self.tableViewOutlet.indexPathForSelectedRow()!.row] as String
            
            VC.keyOfDesc = arrOfDesc[self.tableViewOutlet.indexPathForSelectedRow()!.row] as String
       }
    
    }
    

}
