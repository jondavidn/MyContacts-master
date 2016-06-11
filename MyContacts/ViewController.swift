//
//  ViewController.swift
//  MyContacts
//
//  Created by Chuck Konkol on 6/4/16.
//  Copyright © 2016 Rock Valley College. All rights reserved.
//

import UIKit
//0
import CoreData

class ViewController: UIViewController {
    
    //Outlets and Actions
    
    @IBOutlet weak var fullname: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var status: UILabel!
    
    @IBAction func btnSave(sender: UIButton) {
        //1
        
        if (contactdb != nil)
        {
            contactdb.setValue(fullname.text, forKey: "fullname" )
            contactdb.setValue(email.text, forKey: "email")
            contactdb.setValue(phone.text, forKey: "phone" )
        }
        else {
            let entityDescription = NSEntityDescription.entityForName("Contact",inManagedObjectContext: managedObjectContext)
            
            let contact = Contact(entity: entityDescription!,
                insertIntoManagedObjectContext: managedObjectContext)
            
            contact.fullname = fullname.text!
            contact.email = email.text!
            contact.phone = phone.text!
        }
        var error: NSError?
        do {
            try managedObjectContext.save()
        } catch let error1 as NSError {
            error = error1
        }
        
        if let err = error {
            status.text = err.localizedFailureReason
        } else {
            self.dismissViewControllerAnimated(false, completion: nil)
        }
    }
    
    @IBAction func btnBack(sender: UIBarButtonItem) {
        //2
        
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
    //3
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    //4
    
    var contactdb:NSManagedObject!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //5
        
        if (contactdb != nil)
        {
            fullname.text = contactdb.valueForKey("fullname") as? String
            email.text = contactdb.valueForKey("email") as? String
            phone.text = contactdb.valueForKey("phone") as? String
            btnSave.setTitle("Update", forState: UIControlState.Normal)
        }
        fullname.becomeFirstResponder()
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
//6
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) { super.touchesBegan(touches , withEvent:event)
        if (touches.first as UITouch!) != nil {
            DismissKeyboard()
        }

}

//7

    func DismissKeyboard() {
        fullname.endEditing(true)
        email.endEditing(true)
        phone.endEditing(true)
}


//8

    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        textField.resignFirstResponder()
        return true;
}
}