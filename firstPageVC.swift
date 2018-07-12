//
//  firstPageVC.swift
//  LocateTutors
//
//  Created by Victor Opurum on 1/17/18.
//  Copyright © 2018 Victor Opurum. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class firstPageVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        
        KeychainWrapper.standard.removeObject(forKey: "login")
        if let ID = KeychainWrapper.standard.string(forKey: "login"){
            performSegue(withIdentifier: "loggedIn", sender: nil)
            print("VIC: logged in \(ID)")
            
        }
        else{
            performSegue(withIdentifier: "login", sender: nil)
            print("HEN: not logged in")
        }
    }
    

}
