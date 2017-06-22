//
//  ViewController.swift
//  finalProject
//
//  Created by Pavel on 2016-03-27.
//  Copyright © 2016 cs2680. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    var userData: Array<NSManagedObject>!
    
    var newUser: NSManagedObject!

    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var pwField: UITextField!
    
    @IBAction func signUpButton(sender: AnyObject) {
        
        
                
        
    }
    @IBAction func loginButton(sender: AnyObject) {
        
        //self.loadCoreData()
        
        
        if !self.validateUserNamePw(nameField.text!, pw: pwField.text!) {
            
            let alert = UIAlertController(title: "Wrong!", message: "Incorrect Password or User Name", preferredStyle: .Alert)
            
            let fixIt = UIAlertAction(title: "OK", style: .Default, handler: nil) // handler could also contain code to make text field red or something interesting
            
            alert.addAction(fixIt)
            
            presentViewController(alert, animated: true, completion: nil)
            
        }
        
        if (nameField.text == "" || pwField.text == ""){
            
            let alert = UIAlertController(title: "Warnning", message: "Please Fill Both Text Boxes", preferredStyle: .Alert)
            
            let fixIt = UIAlertAction(title: "OK", style: .Default, handler: nil) // handler could also contain code to make text field red or something interesting
            
            alert.addAction(fixIt)
            
            presentViewController(alert, animated: true, completion: nil)
            
            
            
        }
        
    }
    
    func validateUserNamePw(userName : String , pw : String) -> Bool
    {
        
        var valid = false
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        managedContext.deletedObjects
        
        let fetchRequest = NSFetchRequest(entityName: "User")
        
        do
        {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            userData = results as! Array<NSManagedObject>
        }
        catch
        {	print(error)
        }
        
        for index in 0...userData.count-1 {
            
            newUser = userData[userData.count-1 - index]
            
            
            
            let name  = newUser.valueForKey("name") as! String
            let password  = newUser.valueForKey("pw") as! String
            
            if (name == userName && password == pw)
            {
                valid =  true
                
            }
            
        }
        
        return valid
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 

}

