//
//  MembershipCell.swift
//  finalProject
//
//  Created by Pavel on 2016-03-29.
//  Copyright © 2016 cs2680. All rights reserved.
//

import Foundation
import UIKit




class MembershipCell: UITableViewCell
{
    
    
    @IBOutlet weak var membershipLabel: UILabel!
    @IBOutlet weak var membershipIcon: UIImageView!
    
    func setMembership(membership: NSDictionary)
    {
        let nameString = membership["name"] as! String
        let imageString = membership["image"] as! String
        
        self.membershipLabel?.text = nameString
        
        if let checkedUrl = NSURL(string: imageString) {
            membershipIcon.contentMode = .ScaleAspectFit
            downloadImage(checkedUrl)
        }
        print("End of code. The image will continue downloading in the background and it will be loaded when it ends.")
    }
    
    
    func downloadImage(url: NSURL){
        print("Download Started")
        print("lastPathComponent: " + (url.lastPathComponent ?? ""))
        getDataFromUrl(url) { (data, response, error)  in
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                guard let data = data where error == nil else { return }
                print(response?.suggestedFilename ?? "")
                print("Download Finished")
                self.membershipIcon.image = UIImage(data: data)
            }
        }
    }
    func getDataFromUrl(url:NSURL, completion: ((data: NSData?, response: NSURLResponse?, error: NSError? ) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            completion(data: data, response: response, error: error)
            }.resume()
    }
}
