//
//  MembershipTableController.swift
//  finalProject
//
//  Created by Pavel on 2016-03-29.
//  Copyright © 2016 cs2680. All rights reserved.
//

import Foundation
import UIKit

class MembershipTableConroller: UITableViewController
{
    
    var week: String!
    var path: String!
    var membershipList: Array<NSDictionary>!
    
    var curIndex: Int = 0
    
    
    
    override func viewDidLoad()
    {
        
        let nib = UINib(nibName: "MembershipCell", bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: "MembershipCellID")
        
        self.title = "Game Level"
        self.tableView.reloadData()
        
        let urlString = "http://www.google.com"
        let url = NSURL(string: urlString)
        
        let session = NSURLSession.sharedSession()
        
        
        let task = session.dataTaskWithURL(url!)
            { (data, response, error) -> Void in
                
                // Do something with the data
        }
        
        task.resume()
        
        

        
        
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 100.0;//Choose your custom row height
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        self.path = NSBundle.mainBundle().pathForResource("memberships", ofType: "json")
        
        if path != "" {
            do {
                let data = try NSData(contentsOfURL: NSURL(fileURLWithPath: path), options: NSDataReadingOptions.DataReadingMappedIfSafe)
                let dictionary = try NSJSONSerialization.JSONObjectWithData(data, options: []) as? NSDictionary
                
                self.membershipList = dictionary!["memberships"] as! Array<NSDictionary>
                
                print(membershipList.count)
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        } else {
            print("Invalid filename/path.")
        }
        
        return membershipList.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("MembershipCellID") as! MembershipCell
        cell.setMembership(self.membershipList[indexPath.row])
        
        
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        var gameTable = GameViewContoller()
        gameTable.level = indexPath.row
        
        self.navigationController?.pushViewController(gameTable, animated: true)
    }

    
    
}
