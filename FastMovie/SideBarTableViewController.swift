//
//  SideBarTableViewController.swift
//  FastMovie
//
//  Created by JuanFer on 19/03/15.
//  Copyright (c) 2015 JuanFer. All rights reserved.
//

import UIKit


protocol SideBarTableViewControllerDelegate{
    func sideBarControlDidSelectRow(indexPath:NSIndexPath)
    
}

class SideBarTableViewController: UITableViewController {

    var delegate:SideBarTableViewControllerDelegate?
    var tableData:Array<String> = []

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
   
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
  
        return tableData.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("Cell") as? UITableViewCell
        
        if cell==nil{
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
            cell!.backgroundColor = UIColor.clearColor()
            cell!.textLabel?.textColor = UIColor.darkGrayColor()
            
            let selectedView:UIView = UIView(frame: CGRect(x: 0, y: 0, width: cell!.frame.size.width, height: cell!.frame.size.width))
            selectedView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.3) //transparencia
            
            cell!.selectedBackgroundView = selectedView
        }
        
        
        cell?.textLabel?.text = tableData[indexPath.row]
        
        return cell!
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 45.0
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        delegate?.sideBarControlDidSelectRow(indexPath)
    }
    

}

















