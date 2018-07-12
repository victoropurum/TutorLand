//
//  PopUpSubView.swift
//  LocateTutors
//
//  Created by Victor Opurum on 4/12/18.
//  Copyright © 2018 Victor Opurum. All rights reserved.
//

import UIKit

class PopUpSubView: UIView {

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }

}
