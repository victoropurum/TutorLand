//
//  TutorHours.swift
//  LocateTutors
//
//  Created by Victor Opurum on 1/15/18.
//  Copyright © 2018 Victor Opurum. All rights reserved.
//

import UIKit
import Firebase

class TutorHours: UITableViewController, UITextFieldDelegate {

    
    var refTutors: DatabaseReference!  //Create a reference to database
    var children = Database.database().reference().child("Users")
    
    
    var Timelist = [OfficeModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        refTutors = Database.database().reference().child("Users") //reference to the User node in the database
        
        fetchUsers()  //Call the fetch function to populate the table View
        
    }
    
    

    func fetchUsers(){
        
        children.observe(DataEventType.value, with: {(snapshot) in
            if snapshot.childrenCount>0{
                self.Timelist.removeAll()
                for User in snapshot.children.allObjects as! [DataSnapshot]{
                    
                    let OfficeObject = User.value as? [String: AnyObject]
                    let TutorDay =  OfficeObject?["TutorDay"]
                    let TutorStart = OfficeObject?["TutorStart"]
                    let TutorEnd = OfficeObject?["TutorEnd"]
                    
                    
                    
                    //create Tutor object with model and fetched values
                    let TutoringHours = OfficeModel(AppDay: TutorDay as! String?, AppStartTime: TutorStart as! String?, AppEndTime: TutorEnd as! String?)
                    
    
                    self.Timelist.append(TutoringHours)
                }
                self.tableView.reloadData()
            }
            
        })
        
    }
    
    
    
    

    override func numberOfSections(in tableView: UITableView) -> Int {
       
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return Timelist.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellHours", for: indexPath) as! TutorHourViewCell
        
        
        let TutoringHours: OfficeModel
        
        TutoringHours = Timelist[indexPath.row]

        // Configure the cell...
        
        cell.DayLbl.text = TutoringHours.AppDay
        cell.StartLbl.text = TutoringHours.AppStartTime
        cell.EndLbl.text = TutoringHours.AppEndTime
        
        
        cell.selectionStyle = .none
        cell.CheckBtn.addTarget(self, action: #selector(checkMarkButtonClicked(sender:)), for: .touchUpInside)

        return cell
    }
 
    
    @objc func checkMarkButtonClicked ( sender: UIButton) {
        
        print("button pressed")
        
        if sender.isSelected {
            //Uncheck the button
            sender.isSelected = false
        
        } else {
            //Checkmark it
            sender.isSelected = true
        }
        
        tableView.reloadData()
    }



}
