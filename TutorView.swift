//
//  TutorView.swift
//  LocateTutors
//
//  Created by Victor Opurum on 1/11/18.
//  Copyright © 2018 Victor Opurum. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class TutorView: UITableViewController, UITextFieldDelegate, UISearchBarDelegate {
    
    var refTutors: DatabaseReference!  //Create a reference to database
    var children = Database.database().reference().child("Users")
    
    @IBOutlet var searchBar: UITableView!
    
    
    var key: String!
    var keyArray = [String]()
    var TutorList = [TutorModel]()    //Original Tutorlist
    var filtered = [TutorModel]()   //Filtered TutorList
    
    var searchActive = false  //For the searchbar
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        keyArray.removeAll()
        fetchUsers()  //Call the fetch function to populate the table View
        
    }
    
    
    
    func fetchUsers(){
        
        children.observe(DataEventType.value, with: {(snapshot) in
            if snapshot.childrenCount>0{
                self.TutorList.removeAll()
                for User in snapshot.children.allObjects as! [DataSnapshot]{
                    
                    let UserObject = User.value as? [String: AnyObject]
                    //let key = User.key
                    self.key =  User.key
                    let UserId = UserObject?["Id"]
                    let UserName = UserObject?["UserName"]
                    let UserStatus = UserObject?["UserStatus"]
                    let LocationSelected = UserObject?["LocationSelected"]
                    let CourseSelected = UserObject?["CourseSelected"]
                    
                    
                    
                    //create Tutor object with model and fetched values
                    let Tutor = TutorModel(id:UserId as? String , name:UserName as? String , courses: CourseSelected as? String , status: UserStatus as? String ,location: LocationSelected as? String )
                    
                    print(self.key)   //This gets the user IDs for all the values in the database
                    
                    if UserStatus! as! String == "Tutor" {   //If the status is Tutor add to tableview
                        self.keyArray.append(self.key)
                        self.TutorList.append(Tutor)
                        self.tableView.reloadData()
                    }
                }
                //self.tableView.reloadData()
            }
            
        })
        
    }
    
    
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text != nil || searchBar.text != ""{
            searchActive = true
            
            
            filtered = TutorList.filter {$0.courses?.range(of: searchText, options: .caseInsensitive) != nil}   //Implement a case Insensitive search function
            
            
        }
        
        if filtered.count == 0{
            searchActive = false
        }else {
            searchActive = true;
        }
        
        self.tableView.reloadData()
    }
    
    
    func searchBarSearchButtonClicked(_searchBar: UISearchBar) {
        
        self.view.endEditing(true)
    }
    
    //Implement search bar clear button
    func searchBarCancelButtonClicked(_searchBar: UISearchBar){
        view.endEditing(true)
    }
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive){
            return filtered.count
            
        }
        return TutorList.count
    }
    
    
    
    //Send specific selected value of key to the next view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        
        if (segue.identifier == "DisplayAppointments"){
            let DVC = segue.destination as! ViewAppointments
            //let key = keyArray
            if let indexpath = self.tableView.indexPathForSelectedRow {
                DVC.sentData = keyArray[indexpath.row]
                print("Essay \(indexpath.row)")
                //DVC.sentData = key
                
            }
            self.tableView.reloadData()
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ListViewCell
        
        //the Tutor object
        let Tutor:TutorModel
        
        //getting the Tutor of the selected position
        Tutor = TutorList[indexPath.row]
        
        
        if (searchActive){
            if let filtTutor = filtered[indexPath.row] as? TutorModel{
                cell.TutorName.text = filtTutor.name
                cell.TutorCourse.text = filtTutor.courses
                cell.TutorLocation.text = filtTutor.location
                
            }
        }
        else if(!searchActive){
            //adding values to labels
            cell.TutorName.text = Tutor.name
            cell.TutorCourse.text = Tutor.courses
            cell.TutorLocation.text = Tutor.location
            
        }
        
        return cell
    }
    
}

