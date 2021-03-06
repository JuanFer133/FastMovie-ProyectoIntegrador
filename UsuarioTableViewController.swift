//
//  UsuarioTableViewController.swift
//  FastMovie
//
//  Created by JuanFer on 23/04/15.
//  Copyright (c) 2015 JuanFer. All rights reserved.
//

import UIKit

class UsuarioTableViewController: UITableViewController {

    var dict:NSArray = NSArray()
    var textuser: NSMutableArray! = NSMutableArray()
    
    override func viewDidLoad() {
             super.viewDidLoad()
        self.tableView.reloadData()
        seguelogin()
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 44.0
       
        
    }
     
    override func viewDidAppear(animated: Bool) {
        self.textuser.removeAllObjects()
        self.textuser.addObject(NSUserDefaults.standardUserDefaults().objectForKey("user_username")!)
        self.textuser.addObject(NSUserDefaults.standardUserDefaults().objectForKey("user_email")!)
        self.tableView.reloadData()
    }
    
    func seguelogin(){
        if(NSUserDefaults.standardUserDefaults().objectForKey("user_email") == nil){
        self.performSegueWithIdentifier("pasologin", sender: nil)
        }
    }
    
    @IBAction func signOut(sender: AnyObject) {
        NSUserDefaults.standardUserDefaults().removeObjectForKey("user_email")
        NSUserDefaults.standardUserDefaults().removeObjectForKey("user_username")
        NSUserDefaults.standardUserDefaults().removeObjectForKey("user_name")
        NSUserDefaults.standardUserDefaults().removeObjectForKey("user_id")
        seguelogin()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.textuser.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        
        if(indexPath.row == 0){
            cell.textLabel?.text = "Nombre de Usuario"
            cell.detailTextLabel?.text = self.textuser.objectAtIndex(indexPath.row ) as? String
        }else if (indexPath.row == 1){
            cell.textLabel?.text = "Correo"
            cell.detailTextLabel?.text = self.textuser.objectAtIndex(indexPath.row) as? String
        }
        
        
        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
    

}
