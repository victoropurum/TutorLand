//
//  ReceiveController.swift
//  LocateTutors
//
//  Created by Victor Opurum on 1/27/18.
//  Copyright © 2018 Victor Opurum. All rights reserved.
//

import UIKit

class ReceiveController: UIViewController {

    
    @IBOutlet weak var Lbl1: UILabel!
    @IBOutlet weak var Lbl2: UILabel!
    @IBOutlet weak var Lbl3: UILabel!
    
    var sentData1:String!
    var sentData2:String!
    var sentData3:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        Lbl1?.text = sentData1
        Lbl2?.text = sentData2
        Lbl3?.text = sentData3
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

 

}
