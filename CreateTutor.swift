//
//  CreateTutor.swift
//  LocateTutors
//
//  Created by Victor Opurum on 1/9/18.
//  Copyright © 2018 Victor Opurum. All rights reserved.
//

import UIKit
import Firebase
import Foundation
import EventKit

extension Date {
    func add(minutes: Int) -> Date {
        return Calendar(identifier: .gregorian).date(byAdding: .minute, value: minutes, to: self)!
    }
}


private extension UIStoryboard {
    class func mainStoryboard() -> UIStoryboard { return UIStoryboard(name: "Main", bundle: Bundle.main) }
    
    class func centerViewController() -> CreateTutor? {
        return mainStoryboard().instantiateViewController(withIdentifier: "AppointmentPopUp") as? CreateTutor
    }
}


class CreateTutor: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate,UINavigationControllerDelegate {
  
    
    @IBOutlet weak var coursesField: UITextField!
    @IBOutlet weak var coursePicker: UIPickerView!
    @IBOutlet weak var Started: UILabel!
    @IBOutlet weak var StartDate: UIDatePicker!
    @IBOutlet weak var SelectDay: UITextField!
    @IBOutlet weak var DayofWeek: UIPickerView!
    @IBOutlet weak var tableView: UITableView!
    
    
    
    var OfficeHourTime = [OfficeModel]()
    var refTutors: DatabaseReference!  //Create a reference to database
    var ID: String!  //Store the UID of Tutor User
    
    let days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
    let courses = ["Programming", "Abstract Algebra", "Calculus", "Analysis", "Database Management", "Networking", "Cyber Security"] //List of courses
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
         refTutors = Database.database().reference().child("Users").child(ID) //reference to the User node in the database
        
     
        
    }
    
    
    //Format the date
    func formatTime(){
        
        let dateFormatter = DateFormatter()
        
        
        dateFormatter.dateFormat = "HH:mm"  //The format of the date
        
        let StartDateStr = dateFormatter.string(from: StartDate.date)
        
        let section2 = StartDate.date.add(minutes: 60)
        
        Started.text = StartDateStr   //Save in a string format with label Started
        
        
        print(StartDateStr)
        print(section2)
        
        
    }
    
   
    
    func updateUser(){
        
        //let key = refTutors.childByAutoId().key
        //If choosen position is Tutor then update with the following, so find exact child node
        
        let User = ["TutorCourse": coursesField.text! as String,
                    "StartTime": Started.text! as String,
                    //"EndTime": Ended.text! as String
        ]
        
        
        
        refTutors.updateChildValues(User)
        
    
    }
    
    
    
    
    
    
    @IBAction func AddAvailability(_ sender: Any) {
        
       DisplayOfficeHours()
        
        let CreateTutorVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AppointmentPopUp") as! PopUp
        self.addChildViewController(CreateTutorVC)
        CreateTutorVC.view.frame = self.view.frame
        self.view.addSubview(CreateTutorVC.view)
        CreateTutorVC.didMove(toParentViewController: self)
        
    }
    
    
  //Add availability as a node
    func DisplayOfficeHours(){
        
        let Availability = [//"id": key,
                              "UserDay": SelectDay.text! as String,
                              "TutorStrTime": Started.text! as String,
                              //"UserEndTime": Started.text! as String,
                           ]
        
        refTutors.updateChildValues(Availability)
        
    }
    
    
    @IBAction func CompleteProfile(_ sender: Any) {
        
        formatTime()
        
        updateUser()
        
        
    }
    
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        if pickerView == DayofWeek{
            return days.count
        }
        else{
            
            return courses.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        
        if pickerView == DayofWeek{
            
            let titleRow = days[row]
            
            return titleRow
        }
            
        else{
            
            let titleRow = courses[row]
            
            return titleRow
        }
        
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        
        if pickerView == DayofWeek {
            
            self.SelectDay.text = self.days[row]
            self.DayofWeek.isHidden = true
        }
            
        else if pickerView == coursePicker {
            
            self.coursesField.text = self.courses[row]
            self.coursePicker.isHidden = true
        }
        
    }
    
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if (textField == self.SelectDay){
            self.DayofWeek.isHidden = false
        }
            
        else if (textField == self.coursesField){
            
            self.coursePicker.isHidden = false
        }
    
   }
    
  

}

