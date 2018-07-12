//
//  StudentAppointments.swift
//  LocateTutors
//
//  Created by Victor Opurum on 2/6/18.
//  Copyright © 2018 Victor Opurum. All rights reserved.
//

import UIKit
import Firebase

class StudentAppointments: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var ReceiveData: String!
    
    var Timelist = [String]()  //The entire list of all the available times
    
    var StuAppID: String!  //Gets the current user ID
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        //print(ReceiveData)
        
        addTime()
    }
    
    
    
    //This adds the selected appointment to the Tutee Profile and displays it when VC is launched
    func addTime() {
        
        
        StuAppID = Auth.auth().currentUser?.uid
      
        
        let updateRef = Database.database().reference().child("Users").child((StuAppID!))
        let key = updateRef.childByAutoId().key
        
        //Add TimeList variables from firebase to the tableView
        updateRef.observeSingleEvent(of: .value, with: { (snapshot) in
            if let value = snapshot.value as? [String: Any] {
                for (key, val) in value{
                    if let s  = val as? String {
                        //self.Timelist.append("\(key): \(s)")
                        self.tableView.reloadData()
                    }
                    
                    if let map = val as? [String : String] {
                        for (key, val) in map{
                            if let stuTime  = val as? String {
                                self.Timelist.append(stuTime)
                                self.tableView.reloadData()
                            }
                        }
                    }
                    
                }
            }
            
        })
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
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return Timelist.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let row = indexPath.row
        
        
        cell.textLabel?.text = self.Timelist[row]
        print("Timelist: \(Timelist)")
        
        
        /*if cell == nil{
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell") as! ViewAppointmentCellTableViewCell
        }*/
        
        
        return cell
    }
    
    

}
