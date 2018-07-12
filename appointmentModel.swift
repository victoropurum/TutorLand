//
//  appointmentModel.swift
//  LocateTutors
//
//  Created by Victor Opurum on 12/30/17.
//  Copyright © 2017 Victor Opurum. All rights reserved.
//


class appointmentModel{
    
    var TuteeAppId: String?
    var Tuteename: String?
    var TuteeStartDate: String?
    var TuteeEndDate: String?
   
    
    init(TuteeAppId: String?, Tuteename: String?, TuteeStartDate: String?, TuteeEndDate: String?){
        
        self.TuteeAppId = TuteeAppId
        self.Tuteename = Tuteename
        self.TuteeStartDate = TuteeStartDate
        self.TuteeEndDate = TuteeEndDate
        
    }
    
}
