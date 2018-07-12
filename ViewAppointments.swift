//
//  ViewAppointments.swift
//  LocateTutors
//
//  Created by Victor Opurum on 1/24/18.
//  Copyright © 2018 Victor Opurum. All rights reserved.
//

import UIKit
import Firebase

class ViewAppointments: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var ID: String!
    
    var sentData: String!  //Receive the keys of from the tableView
    
    var Timelist = [String]()  //The entire list of all the available times
    
    var selectedItems = [Int]() //Array of selected items

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.allowsMultipleSelection = true
        addTime()
   
    }

    

    func addTime() {
        
       ID = sentData
        
        let updateRef = Database.database().reference().child("Users").child(ID!).child("Availability")
        
    
        //Add TimeList variables from firebase to the tableView
        updateRef.observeSingleEvent(of: .value, with: { (snapshot) in
            if let value = snapshot.value as? Dictionary<String,String>{
                for (key, val) in value{
        
                    self.Timelist.append(val)
                    self.tableView.reloadData()
                }
            }
            
        })
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return Timelist.count
    }
    
    
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let row = indexPath.row
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
    
        //Display the available time from firebase
        cell.textLabel?.text = self.Timelist[row]

        
        if cell == nil{
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell") as! ViewAppointmentCellTableViewCell
        }
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    
    func displayAlertMessage(messageToDisplay: String)
    {
        let alertController = UIAlertController(title: "Confirmed", message: messageToDisplay, preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            
            // Code in this block will trigger when OK button tapped.
            //print("Ok button tapped");
            
        }
        
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true, completion:nil)
        
    }
    


    func saveCheckedAppt(){
        
        let CurrentID = Auth.auth().currentUser?.uid
        
        let NewID = sentData  //Save the ID of user Passed
        
        let dbRef = Database.database().reference().child("Users").child(NewID!).child("Availability").child("SelectedTime")
        
        let CurrentRef = Database.database().reference().child("Users").child(CurrentID!) //Save the database reference of current User
        
        
        
        //saveCheckedAppt()
        if let nums = tableView.indexPathsForSelectedRows{
            for num in nums{
                
                let key = dbRef.childByAutoId().key
                let Currentkey = CurrentRef.childByAutoId().key
                let TimeUpdates = [key: Timelist[num.row]]
                
                let CurrentUserTimeUpdates = [key: Timelist[num.row]]
                
                
                //dbRef.child(key).updateChildValues(TimeUpdates)
                dbRef.childByAutoId().updateChildValues(TimeUpdates)
                CurrentRef.childByAutoId().updateChildValues(CurrentUserTimeUpdates)
                
                
                //print(num.row)
                
                //let SignOutAction =  self.storyboard?.instantiateViewController(withIdentifier: "loginPage")  //After you sign out take back to login view
                //self.present(SignOutAction!, animated: true, completion: nil)
                
            }
        }
        else{
            print("Nothing")
        }
}
    
    
    //Sign Out Function
    func LogOut(){
        
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
        let SignOutAction =  self.storyboard?.instantiateViewController(withIdentifier: "loginPage")  //After you sign out take back to login view
        self.present(SignOutAction!, animated: true, completion: nil)
    }
   
    
    @IBAction func LogOutBtn(_ sender: Any) {
        
        LogOut()
        
    }
    
    
    @IBAction func SaveCheckedBtn(_ sender: Any) {
        
        saveCheckedAppt()
        
        //tableView.reloadData()
        
        let popOverVC = self.storyboard?.instantiateViewController(withIdentifier: "PhotoPopUpView") as! PopUpViewController
        
        //let popOverVC = UIStoryboard(name: "PhotoPopUpView", bundle: nil).instantiateViewController(withIdentifier: "PhotoPopUpView") as! PopUpViewController
        
        self.addChildViewController(popOverVC)
        
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)
    }
    
    
}




