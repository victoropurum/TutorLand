//
//  TutorHourViewCell.swift
//  LocateTutors
//
//  Created by Victor Opurum on 1/15/18.
//  Copyright © 2018 Victor Opurum. All rights reserved.
//

import UIKit

class TutorHourViewCell: UITableViewCell {

   
    @IBOutlet weak var DayLbl: UILabel!
    
    @IBOutlet weak var StartLbl: UILabel!
    
    @IBOutlet weak var EndLbl: UILabel!
    
    
    @IBOutlet weak var CheckBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
