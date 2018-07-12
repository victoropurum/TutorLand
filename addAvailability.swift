//
//  addAvailability.swift
//  LocateTutors
//
//  Created by Henry Akaeze on 1/16/18.
//  Copyright © 2018 Victor Opurum. All rights reserved.
//

import UIKit
import Firebase

class addAvailability: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource {
    
    var ID: String!
    var NewID: String!
    //var refTutors: DatabaseReference!  //Create a reference to database
    
    let days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
    let courses = ["Programming", "Abstract Algebra", "Calculus", "Analysis", "Database Management", "Networking", "Cyber Security", "Discrete Structures", "Languages and Compilers", "Algorithms", "Linear Algebra", "Operating Systems", "Software Engineering"]
    
    
    let Location = ["CRB 208", "Main Lab", "CRB 108", "CRB 104", "CRB 205", "CRB 206"]
    
    
    var avArray = [String]()
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == coursePicker{
            return courses.count
        }
        else if pickerView == dayPicker{
            return days.count
        }
        else {
            return Location.count
        }
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == coursePicker{
            return courses[row]
        }
        else if pickerView == dayPicker{
            return days[row]
        }
        else {
            return Location[row]
        }
        
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == coursePicker{
            selectCourseBtn.titleLabel?.text = courses[row]
            coursePicker.isHidden = true
        }
        else if pickerView == dayPicker{
            dayBtn.titleLabel?.text = days[row]
            dayPicker.isHidden = true
        }
        else {
            LocationBtn.titleLabel?.text = Location[row]
            SetLocationBtn.isHidden = true
        }
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return avArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row = indexPath.row
        let reuseIdentifier = "avcell"
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        
        cell.textLabel?.text = avArray[row]
        
        return cell
    }
    
    
    @IBOutlet weak var selectCourseBtn: UIButton!
    @IBOutlet weak var dayBtn: UIButton!
    @IBOutlet weak var timeBtn: UIButton!
    @IBOutlet weak var addAvBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var coursePicker: UIPickerView!
    @IBOutlet weak var dayPicker: UIPickerView!
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var LocationBtn: UIButton!
    
    @IBOutlet weak var SetLocationBtn: UIPickerView!
    
    
    @IBAction func selCoursePressed(_ sender: Any) {
        coursePicker.isHidden = false
    }
    @IBAction func selDayPressed(_ sender: Any) {
        dayPicker.isHidden = false
    }
    
    @IBAction func selTimePressed(_ sender: Any) {
        timePicker.isHidden = false
    }
    
    @IBAction func SetLocationPressed(_ sender: Any) {
        SetLocationBtn.isHidden = false
        
    }
    
    
    
    @IBAction func dateSelected(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.short
        
        let strDate = dateFormatter.string(from: timePicker.date)
        
        timePicker.isHidden = true
        timeBtn.titleLabel?.text = strDate
        
    }
    
    
    
   //When button is pressed this adds the selected day and time to the prototype cell
    @IBAction func addPressed(_ sender: Any) {
        let day = (dayBtn.titleLabel?.text)!
        let time = (timeBtn.titleLabel?.text)!
        
        
        let val = "\(day) @ \(time)"
        if day == "Select Day"{
            displayAlertMessage(messageToDisplay: "Select a Day")
            return
        }
        
        else if time == "Select Time"{
            displayAlertMessage(messageToDisplay: "Select a Time")
            return
        }
        
        else if val == "Select Day @ Select Time"{
            displayAlertMessage(messageToDisplay: "Please select a day and Time")
            return
        }
            
        else{
        avArray.append(val)  //Add the value with format day @ time
        tableView.reloadData()  //Reload table
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
    
    
    //Update Tutor Info with Location and Course
    func updateTutorInfo()
    {
        //let refTutors = Database.database().reference().child("Users").child(ID!) //reference to the User node in the database
        
        let NewID = Auth.auth().currentUser?.uid   //Get the current user ID from firebase
        
        let updateRef = Database.database().reference().child("Users").child(NewID!)
        
        let updates = ["CourseSelected": (selectCourseBtn.titleLabel?.text)! as String,
                       "LocationSelected": (LocationBtn.titleLabel?.text)! as String
                      ]
        
        updateRef.updateChildValues(updates) //Update firebase with new data set updates
    }
    
    
    //Complete Registration
    @IBAction func completeBtnPressed(_ sender: Any) {
        
        //Input validation for select course button
        if selectCourseBtn.titleLabel?.text == "Select Course"{
            displayAlertMessage(messageToDisplay: "Select a Course!")
        }
        
        //Input validation for select location button
        else if LocationBtn.titleLabel?.text == "Select Location"{
            displayAlertMessage(messageToDisplay: "Select a Location!")
        }
        
        else{
        //Update Information
        updateTutorInfo()
        
        let ID = Auth.auth().currentUser?.uid //get current User ID
        
        let createRef = Database.database().reference().child("Users").child(ID!).child("Availability")
        
        for element in avArray{
            let auto = createRef.childByAutoId()  //Create a reference in firebase using automated or computer generated UID
            auto.setValue(element)
            
        }
        
        //After registration is complete go back to login page
        let loginPageView =  self.storyboard?.instantiateViewController(withIdentifier: "loginPage")
        self.present(loginPageView!, animated: true, completion: nil)
        
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coursePicker.isHidden = true
        dayPicker.isHidden = true
        timePicker.isHidden = true
        SetLocationBtn.isHidden = true
        // Do any additional setup after loading the view.
        
        //updateTutorInfo()
    }
    
    

}
