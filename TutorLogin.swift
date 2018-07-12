//
//  TutorLogin.swift
//  LocateTutors
//
//  Created by Victor Opurum on 11/22/17.
//  Copyright © 2017 Victor Opurum. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper


class TutorLogin: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBOutlet weak var TutorLoginBtn: UIButton!
    @IBOutlet weak var RegisterBtn: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textFieldShouldReturn(textField: emailTextField)
        textFieldShouldReturn(textField: passwordTextField)
        
        emailTextField.layer.borderWidth = 1.0
        emailTextField.layer.borderColor = UIColor.init(red: 204/255, green: 100/255, blue: 8/255, alpha: 1.0).cgColor
        passwordTextField.layer.borderWidth = 1.0
        passwordTextField.layer.borderColor = UIColor.init(red: 204/255, green: 100/255, blue: 8/255, alpha: 1.0).cgColor
        
        

        // Do any additional setup after loading the view.
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"",style:.plain,target:nil, action: nil)
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true;
    }
   
    
    @IBAction func loginAction(_ sender: Any) {
        
        
        if self.emailTextField.text == "" || self.passwordTextField.text == "" {
            
            //Alert to tell the user that there was an error because they didn't fill anything in the textfields because they didn't fill anything in
            
            let alertController = UIAlertController(title: "Error", message: "Please enter an email and password.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            
            Auth.auth().signIn(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!) { (user, error) in
                
           
                
                if error == nil {
                    
                    print("You have successfully logged in")
                    
                   
                    if let ID = user?.uid{
                        
                        KeychainWrapper.standard.set(ID, forKey: "login")
                    }
                    
                    
                    let NewID = Auth.auth().currentUser?.uid    //Saves the ID of the current user logged in
                   
                    let updateRef = Database.database().reference().child("Users").child(NewID!)
                    
                    
                    
                   
                    
                    updateRef.observe(.value, with: { (snapshot) in
                        if let val = snapshot.value as? Dictionary<String,Any>{
                            //Get the UserStatus and determine what segue to send user to
                            if let status = val["UserStatus"] as? String { //
                                if status == "Tutor"{
                                    
                                   let myVC = self.storyboard?.instantiateViewController(withIdentifier: "AppointmentLists") as! AppointmentLists
                                    
                                    
                                    myVC.stringPassed = NewID //Send the key to the next view controller
                                    
                                    
                                    //self.performSegue(withIdentifier: "AppointmentSegue", sender: self)
                                    
                                    let navigationController = UINavigationController(rootViewController: myVC)
                                    
                                    self.present(navigationController, animated: true, completion: nil)
                                    
                                    
                                    self.performSegue(withIdentifier: "AppointmentSegue", sender: self)
                                   
                                }
                                else if status == "Tutee"{
                                    
                                    
                                    let myVC: SeeAppts = self.storyboard?.instantiateViewController(withIdentifier: "SeeAppts") as! SeeAppts
                                    
                                    myVC.stringPassed = NewID
                                    
                                    let navigationController = UINavigationController(rootViewController: myVC)
                                    
                                    self.present(navigationController, animated: true, completion: nil)
                                    
                                    
                                    self.performSegue(withIdentifier: "loggedIn", sender: self)
                                   
                                    
                                    
                                }
                            }
                        }
                    })
      
                } else {
                    
                    //Tells the user that there is an error and then gets firebase to tell them the error
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    
                    //If there is an error then dont login
                    self.present(alertController, animated: true, completion: nil)
                    
                    return
                }
                
            }
            
        }
        
    }
        
}

