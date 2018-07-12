//
//  TutorModel.swift
//  LocateTutors
//
//  Created by Victor Opurum on 11/23/17.
//  Copyright © 2017 Victor Opurum. All rights reserved.
//

class TutorModel{
    
    var id: String?
    var name: String?
    var courses: String?
    var status: String?
    var location: String?
   
    
    init(id: String?, name: String?, courses: String?, status: String?,location: String?){
        
        self.id = id
        self.name = name
        self.courses = courses
        self.status = status
        self.location = location
       
        
    }
    
}

