//
//  ViewAppointmentCellTableViewCell.swift
//  LocateTutors
//
//  Created by Victor Opurum on 1/24/18.
//  Copyright © 2018 Victor Opurum. All rights reserved.
//

import UIKit

class ViewAppointmentCellTableViewCell: UITableViewCell {

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
    }


    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        accessoryType = selected ?.checkmark: .none
    }

}
