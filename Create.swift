//
//  Create.swift
//  LocateTutors
//
//  Created by Victor Opurum on 1/9/18.
//  Copyright © 2018 Victor Opurum. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper
import Foundation

class Create: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var VerifyPasswordField: UITextField!
    @IBOutlet weak var position: UITextField!
    @IBOutlet weak var classificationTextField: UITextField!
    @IBOutlet weak var classificationPicker: UIPickerView!
    @IBOutlet weak var dropdown: UIPickerView!
    @IBOutlet weak var SignIn: UIButton!
    
    
    @IBOutlet weak var CreateAcctOutlet: UIButton!  //Make the button circular
    @IBOutlet weak var RegisterOutlet: UIButton! //Make the register button circular
    
    
    var refTutors: DatabaseReference!  //Create a reference to database
    
    let classPick = [" ", "Freshman", "Sophomore", "Junior", "Senior"]
    
    let category = [" ", "Tutee", "Tutor"]  //Drop down for the picker view
    
    var keyPass = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView(gesture:)))
        view.addGestureRecognizer(tapGesture)
        
        refTutors = Database.database().reference().child("Users") //reference to the User node in the database
        
       
        //Make the button circular
        CreateAcctOutlet.frame = CGRect(x: 160, y: 100, width: 50, height: 50)
        CreateAcctOutlet.layer.cornerRadius = 0.5
        
        
        
        //For the picker view
        classificationPicker.isHidden = true
        
        dropdown.isHidden = true
        
        
    }
    
    @objc func didTapView(gesture: UITapGestureRecognizer) {
        // This should hide keyboard for the view.
        view.endEditing(true)
    }
    
    
    
    
    //Verify that the data does not already exist
    func PreventRedundancy(){
        
        let userRef = refTutors.child("Users")
    
        userRef.observe(.value, with: { snapshot in
    
        if snapshot.exists() {
    
        print("Username Already taken!")
    
        } else {
    
       self.addUser() // Create new username
    
    }
    
        userRef.removeAllObservers()
    
        }, withCancel: { error in
    
        print(error)
    
        })
    }
    

    
    func addUser(){
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            
            
            if error == nil {
                
                if let key = user?.uid{
                    let User = ["id": key,
                                "UserName": self.nameTextField.text! as String,
                                "UserEmail": self.emailTextField.text! as String,
                                "UserClassification": self.classificationTextField.text! as String,
                                "UserPassword": self.passwordTextField.text! as String,
                                "UserStatus": self.position.text! as String
                    ]
                    
                    if self.position.text == "Tutee"{
                    self.refTutors.child(key).setValue(User)
                    let loginPageView =  self.storyboard?.instantiateViewController(withIdentifier: "loginPage")
                    self.present(loginPageView!, animated: true, completion: nil)
                    }
                    
                    else if self.position.text == "Tutor" {
                        self.refTutors.child(key).setValue(User)
                        self.performSegue(withIdentifier: "CreateTutor", sender: self)
                    }
                    
                }
                
            }
                
            else if error != nil{
                
                self.displayAlertMessage(messageToDisplay: "Error, please check all fields")
                
            }
        }
        
    }

    
    
    
    func displayAlertMessage(messageToDisplay: String)
    {
        let alertController = UIAlertController(title: "Error", message: messageToDisplay, preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            
            // Code in this block will trigger when OK button tapped.
            //print("Ok button tapped");
            
        }
        
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true, completion:nil)
    
    }
    
    
    
    
    //Validate email format
    func validateEmail(){
        let providedEmailAddress = emailTextField.text
        
        let isEmailAddressValid = isValidEmailAddress(emailAddressString: providedEmailAddress!)
        
        if isEmailAddressValid
        {
            print("Email address is valid")
        } else {
            print("Email address is not valid")
            let alertController = UIAlertController(title: "Error", message: "Please enter your email and password", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
        }
        
        //displayAlertMessage(messageToDisplay: "incorrect")
    }
    
    
    //Verify mvsu email
    func isValidEmailAddress(emailAddressString: String) -> Bool {
        
      
        var returnValue = true
        //let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        //let emailRegEx = "[A-Z0-9a-z.-_]+@[^abcdefghijklnopqrvwxyz]{4}+\\.[^abcfghijklmnopqrstvwxyz]{3}"
        
        //let emailRegEx = "[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,}"
        
        let emailRegEx = "[A-Z0-9a-z.-_]+@[m|v|s|u]+\\.[e|d|u]{4,3}"
        
        //let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        //return emailTest.evaluate(with: emailAddressString)
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailAddressString as NSString
            let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                returnValue = false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        
        return  returnValue
        
    }
    
    
    @IBAction func SignInBtn(_ sender: Any) {
        
        let SignInPage =  self.storyboard?.instantiateViewController(withIdentifier: "loginPage")
        self.present(SignInPage!, animated: true, completion: nil)
    }
    
 
    
    @IBAction func CreateAcct(_ sender: Any) {
        
        
        if nameTextField.text == ""{
            displayAlertMessage(messageToDisplay: "Enter Name")
            return
        }
        
        else if emailTextField.text == ""{
            displayAlertMessage(messageToDisplay: "Enter Email")
        }
        
        else if classificationTextField.text == " "{
            displayAlertMessage(messageToDisplay: "Select your classification")
        }
        
        else if VerifyPasswordField.text != passwordTextField.text{
            displayAlertMessage(messageToDisplay: "Passwords do not match")
        }
        
        else if position.text == " "{
            displayAlertMessage(messageToDisplay: "Select a position")
        }
        
        else {
            addUser()
        }
        
    }
    

    
    //For category
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == classificationPicker{
            return classPick.count
        }
        else{
           
            return category.count
        }

    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        
        if pickerView == classificationPicker {
            
            let titleRow = classPick[row]
    
            return titleRow
        }
        
        else{
            
            
            let titleRow = category[row]
    
            return titleRow
        }
        

    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        
        
        if pickerView == classificationPicker {
            
            self.classificationTextField.text = self.classPick[row]
            self.classificationPicker.isHidden = true
           
        }
        
        else if pickerView == dropdown {
           
            self.position.text = self.category[row]
            self.dropdown.isHidden = true
            
        }
        
        
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        view.endEditing(true)
        
        if (textField == self.classificationTextField){
            self.classificationPicker.isHidden = false
            self.dropdown.isHidden = true
        }
        
        else if (textField == self.position){
            self.dropdown.isHidden = false
            self.classificationPicker.isHidden = true
        }
        
    }
    
    
}
