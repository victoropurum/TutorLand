//
//  ListViewCell.swift
//  LocateTutors
//
//  Created by Victor Opurum on 1/11/18.
//  Copyright © 2018 Victor Opurum. All rights reserved.
//

import UIKit
import Firebase

class ListViewCell: UITableViewCell {
    
    
    @IBOutlet weak var TutorName: UILabel!
    @IBOutlet weak var TutorLocation: UILabel!
    @IBOutlet weak var TutorCourse: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}



