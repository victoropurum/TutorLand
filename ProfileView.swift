//
//  ProfileView.swift
//  LocateTutors
//
//  Created by Victor Opurum on 11/30/17.
//  Copyright © 2017 Victor Opurum. All rights reserved.
//

import UIKit
import Firebase
import EventKit

class ProfileView: UIViewController {

    
    @IBOutlet weak var Tutor_Name: UILabel!
    @IBOutlet weak var Tutor_Email: UILabel!
    @IBOutlet weak var Tutor_Course: UILabel!
    
    
    @IBOutlet weak var SelectTimeBtn: UIButton!  //Declare the button so you can resize
    @IBOutlet weak var CheckAvailBtn: UIButton!
    
    var sentData1:String!
    var sentData2:String!
    var sentData3:String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        SelectTimeBtn.layer.borderWidth = 2
        SelectTimeBtn.layer.cornerRadius = 15   //Make the button curved
        
        CheckAvailBtn.layer.borderWidth = 2
        CheckAvailBtn.layer.cornerRadius = 15   //Make the button curved
        
        
        Tutor_Name.text = sentData1
        Tutor_Email.text = sentData2
        Tutor_Course.text = sentData3
        

        // Do any additional setup after loading the view. And this is to eliminate the Back on the button
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"",style:.plain,target:nil, action: nil)
    }

    

    @IBAction func AddEvent(_ sender: Any) {
    
        let eventStore:EKEventStore = EKEventStore()
        
        //eventStore.requestAccess(to: .event) {(granted, error) in
        
        eventStore.requestAccess(to: EKEntityType.event, completion: {(granted, error) in
            if (granted) && (error == nil)
            {
                print("granted \(granted)")
                print("error \(String(describing: error))")
                
                
                let event:EKEvent = EKEvent(eventStore: eventStore)
                event.title = "Tutoring Appointment"
                event.startDate = Date()
                event.endDate = Date()
                event.notes = "Take Notes"
                event.calendar = eventStore.defaultCalendarForNewEvents
                //eventStore.saveEvent(event, span: EKSpanThisEvent, commit: nil)
                //try eventStore.saveEvent(event, span: .ThisEvent)
            
                
                do {
                    try eventStore.save(event, span: .thisEvent)
                } catch let specError as NSError {
                    print("A specific error occurred: \(specError)")
                } catch {
                    print("An error occurred")
                }
                
                //eventStore.saveEvent(event, span: EKSpanThisEvent, error: nil)
                /*do{
                    try eventStore.save(event, span: .thisEvent)
                }catch {
                    let alert = UIAlertController(title: "Calendar could not save" , message: (error as NSError).localizedDescription, preferredStyle: .alert)
                    let OKAction = UIAlertAction(title: "OK" , style: .default, handler: nil)
                    alert.addAction(OKAction)
                    
                    self.present(alert, animated: true, completion: nil)
                }*/
                print("Saved Event")
            }
        })
        
            
            
            // This lists every reminder
            let predicate = eventStore.predicateForReminders(in: [])
            eventStore.fetchReminders(matching: predicate) { reminders in
                for reminder in reminders! {
                    print(reminder.title)
                }}
            
            //Calendar enties
            let startDate = Date().addingTimeInterval(-60*60*24)
            let endDate = Date().addingTimeInterval(60*60*24*3)
            let predicate2 = eventStore.predicateForEvents(withStart: startDate as Date, end: endDate as Date, calendars: nil)
            
            print("startDate:\(startDate) endDate:\(endDate)")
            let eV = eventStore.events(matching: predicate2) as [EKEvent]!
            
            if eV != nil {
                for i in eV! {
                    print("Title  \(i.title)" )
                    print("stareDate: \(i.startDate)" )
                    print("endDate: \(i.endDate)" )
                    
                    if i.title == "Test Title" {
                        print("YES" )
                        
                        // Uncomment if you want to delete
                        //eventStore.removeEvent(i, span: EKSpanThisEvent, error: nil)
                    }
                }
            }
         }
    }
/*
    //Every reminder is listed thus
    var predicate = eventStore.predicateForRemindersInCalendars([])
    eventStore.fetchRemindersMatchingPredicate(predicate) {reminders in
    for reminder in reminders {
        println(reminder.title)
    }
}*/


                    
                    
/*let error as NSError{
                    print("error: \(error)")
                }
                print("Save Event")
                
                
            }else{
                
                
                print("error: \(String(describing: error))")
            }
    
        }
    }    
}

@IBAction func addCalendar(_ sender: Any) {
    
    //Create an Event store
    let eventStore = EKEventStore();
    
    //Use Event store to create a new calendar
    let newCalendar = EKCalendar(for: .event, eventStore: eventStore)
    
    //Dont let soeone save if they dont give a calendar name
    newCalendar.title = calendarNameTextField.text!
    
    
    //Access list of available sources from the Event Source
    let sourcesInEventStore = eventStore.sources
    
    
    //Filter available sources and select
    newCalendar.source = sourcesInEventStore.filter{
        (source: EKSource) -> Bool in
        source.sourceType.rawValue == EKSourceType.local.rawValue
        }.first!
    
    //Save the calendar using Event Store Instance
    do{
        try eventStore.saveCalendar(newCalendar, commit: true)
        UserDefaults.standard.set(newCalendar.calendarIdentifier, forKey: "Event Tracker Primary Key")
        delegate?.calendarDidAdd()
        self.dismiss(animated: true, completion: nil)
    } catch {
        let alert = UIAlertController(title: "Calendar could not save" , message: (error as NSError).localizedDescription, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK" , style: .default, handler: nil)
        alert.addAction(OKAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
}
}*/
