//
//  AppointmentLists.swift
//  LocateTutors
//
//  Created by Victor Opurum on 2/6/18.
//  Copyright © 2018 Victor Opurum. All rights reserved.
//

import UIKit
import EventKit
import EventKitUI
import Firebase

class AppointmentLists: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var stringPassed: String!
    
    //var ID: String!
    
    var TimeList = [String]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTime()
       
    }

    
    
    /*func addTime() {
        
        
        //ID = stringPassed
        //print(ID)
        
        let ID = Auth.auth().currentUser?.uid
        
        let updateRef = Database.database().reference().child("Users").child((ID!)).child("Availability").child("SelectedTime")
        //let key = updateRef.childByAutoId().key
        
        //Add TimeList variables from firebase to the tableView
        updateRef.observeSingleEvent(of: .value, with: { (snapshot) in
            if let value = snapshot.value as? Dictionary<String,String>{
                for (key, val) in value{
                    
                    self.TimeList.append(val)
                    self.tableView.reloadData()
                }
            }
            
        })
    }*/
    
    
       func addTime() {
            
            
           let NewID = Auth.auth().currentUser?.uid
     
            
            let updateRef = Database.database().reference().child("Users").child((NewID!)).child("Availability").child("SelectedTime")
        
            //Add TimeList variables from firebase to the tableView
            updateRef.observeSingleEvent(of: .value, with: { (snapshot) in
                if let value = snapshot.value as? [String: Any] {
                    for (key, val) in value{
                        if let s  = val as? String {
                            //self.Timelist.append("\(key): \(s)")
                            //self.tableView.reloadData()
                        }
                        
                        if let map = val as? [String : String] {
                            for (key, val) in map{
                                if let stuTime  = val as? String {
                                    self.TimeList.append(stuTime)
                                    self.tableView.reloadData()
                                }
                            }
                        }
                        
                    }
                }
                
            })
        }
        
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return TimeList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let row = indexPath.row
        
        
        cell.textLabel?.text = self.TimeList[row]
        //print(Timelist)
        
        
        if cell == nil{
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell") as! ViewAppointmentCellTableViewCell
        }
        
        
        return cell
    }
    
    
   /*func createCalendarEvent(with title: String, forDate eventStartDate: Date, toDate eventEndDate:Date)
    {
        let store  = EKEventStore()
        
        store.requestAccess(to: .event) { (success, error) in
            
            if error == nil {
                print("Access granted!")
                let event = EKEvent.init(eventStore: store)
                event.title = title
                event.calendar = store.defaultCalendarForNewEvents
                event.startDate = eventStartDate
                event.endDate = eventEndDate
                
                do {
                    try store.save(event, span: .thisEvent)
                    
                }catch let error as NSError{
                    print("failed to save")
                }
            } else {
                print("error = \(String(describing: error?.localizedDescription))")
            }
        }
    }*/
    
    
    

    
    
    
    
}
