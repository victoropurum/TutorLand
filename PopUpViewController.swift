//
//  PopUpViewController.swift
//  LocateTutors
//
//  Created by Victor Opurum on 4/13/18.
//  Copyright © 2018 Victor Opurum. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //self.view.backgroundColor = UIColor.gray.withAlphaComponent(0.8)
        
        showAnimate()
        
    }

    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    
    @IBAction func DismissPopUp(_ sender: Any) {
         dismiss(animated: true, completion: nil)
        
    }
    
    
    func removeAnimate()
     {
     UIView.animate(withDuration: 0.25, animations: {
     self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
     self.view.alpha = 0.0;
     
     }, completion:{(finished : Bool)  in
     if (finished)
          {
     self.view.removeFromSuperview()
           }
        });
     }

}
