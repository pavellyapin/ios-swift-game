//
//  SignUpViewContoller.swift
//  finalProject
//
//  Created by Pavel on 2016-04-02.
//  Copyright © 2016 cs2680. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class SighUpViewContoller: UIViewController
{

    
    @IBOutlet weak var userName: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    var newUser: NSManagedObject!
    
    override func viewDidLoad()
    {
        
            //self.viewDidLoad()
        
        
        
        
        
    }
    
    @IBAction func signUpButton(sender: AnyObject) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        
        
        let entity = NSEntityDescription.entityForName("User", inManagedObjectContext: managedContext)
        let userLogin = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        userLogin.setValue(userName.text, forKey: "name")
        userLogin.setValue(password.text, forKey: "pw")
        
        let iname  = userLogin.valueForKey("name") as? String
        let ipassword  = userLogin.valueForKey("pw") as? String
        
        
    
            
            do
            {
                try managedContext.save()
            }
            catch
            {	print(error)
            }
        
    }
    
    func validateUserName(userName : String) -> Bool
    {
        var userData: Array<NSManagedObject>!
        
         var valid = true
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
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
            
            if (newUser.valueForKey("name") as? String == userName)
            {
                valid =  false
                
            }

        }

        return valid
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if !validateUserName(userName.text!)
        {
            
            let alert = UIAlertController(title: "Warnning", message: "This User Name Already Exists", preferredStyle: .Alert)
            
            let fixIt = UIAlertAction(title: "Invalid User Name", style: .Default, handler: nil) // handler could also contain code to make text field red or something interesting
            
            alert.addAction(fixIt)
            
            presentViewController(alert, animated: true, completion: nil)
            
        }
        
        if (userName.text == "" || password.text == ""){
            
            let alert = UIAlertController(title: "Warnning", message: "Please Fill Both Text Boxes", preferredStyle: .Alert)
            
            let fixIt = UIAlertAction(title: "OK", style: .Default, handler: nil) // handler could also contain code to make text field red or something interesting
            
            alert.addAction(fixIt)
            
            presentViewController(alert, animated: true, completion: nil)
            
            
            
        }

        
        
    }
    
}