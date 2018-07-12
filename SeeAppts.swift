//
//  SeeAppts.swift
//  LocateTutors
//
//  Created by Victor Opurum on 2/6/18.
//  Copyright © 2018 Victor Opurum. All rights reserved.
//

import UIKit
import Firebase

class SeeAppts: UIViewController {

    var stringPassed: String!   //Receive data from Log in controller
    
    var ID: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    @IBAction func profile(_ sender: Any) {
        self.performSegue(withIdentifier: "accessProfile", sender: self)
    }
    
    @IBAction func SeeApptsBtn(_ sender: Any) {
        
        self.performSegue(withIdentifier: "SeeStudentAppointment", sender: self)

    }
    
    
}
