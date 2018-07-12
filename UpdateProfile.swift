//
//  UpdateProfile.swift
//  LocateTutors
//
//  Created by Victor Opurum on 2/15/18.
//  Copyright © 2018 Victor Opurum. All rights reserved.
//

import UIKit
import Firebase

class UpdateProfile: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
   
    @objc func didTapView(gesture: UITapGestureRecognizer) {
        // This should hide keyboard for the view.
        view.endEditing(true)
    }
    
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var PosField: UITextField!
    
    @IBOutlet weak var positionPickerView: UIPickerView!
    
    
    var Positon = [" ", "Tutee", "Tutor"]
    
    //var Profile: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView(gesture:)))
        positionPickerView.isHidden = true
        fetchUsers()
    }

    
  func fetchUsers(){
    
       let ProfileID = Auth.auth().currentUser?.uid
  
        let updateRef = Database.database().reference().child("Users").child(ProfileID!)
    
        updateRef.observe(DataEventType.value, with: {(snapshot) in
        print("HERRE")
        
        if let value = snapshot.value as? Dictionary<String, Any>{
            if let userName = value["UserName"] as? String, let userEmail = value["UserEmail"] as? String, let userStatus = value["UserStatus"] as? String{
                
                self.nameField.text = userName
                self.emailField.text = userEmail
                self.PosField.text = userStatus
                
                
                
            }
        }
        
            
    })

}


    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Positon.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Positon[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        
        if pickerView == positionPickerView {
            
            self.PosField.text = self.Positon[row]
            self.positionPickerView.isHidden = true
            
        }
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        view.endEditing(true)
        
        if (textField == self.PosField){
            self.positionPickerView.isHidden = false
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
    
    
    //Sign Out Function
    func SignOut(){
        
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
        let SignOutAction =  self.storyboard?.instantiateViewController(withIdentifier: "loginPage")  //After you sign out take back to login view
        self.present(SignOutAction!, animated: true, completion: nil)
    }
    
    
    @IBAction func SignOutBtn(_ sender: Any) {
        SignOut()
    }
    
  
    func UpdateValues(){

            //let refTutors = Database.database().reference().child("Users").child(ID!) //reference to the User node in the database
            
            let NewID = Auth.auth().currentUser?.uid
            
            let updateRef = Database.database().reference().child("Users").child(NewID!)
            
            let updates = ["UserName": nameField.text! as String,
                           "UserEmail": emailField.text! as String,
                           "UserStatus": PosField.text! as String
            ]
            
            updateRef.updateChildValues(updates)
    }
    
    @IBAction func confirmChangeBtn(_ sender: Any) {
        
        if nameField.text == ""{
            displayAlertMessage(messageToDisplay: "Please Enter a Name")
        }
        
        else if emailField.text == ""{
            displayAlertMessage(messageToDisplay: "Please Enter a Valid Email")
        }
        
        else if PosField.text == " "{
            displayAlertMessage(messageToDisplay: "Please select a position")
        }
        
        else{
            UpdateValues()
            let ConfirmChanges =  self.storyboard?.instantiateViewController(withIdentifier: "loginPage")  //After you sign out take back to login view
            self.present(ConfirmChanges!, animated: true, completion: nil)
        }
    }
    
}
