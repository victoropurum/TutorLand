//
//  PopUp.swift
//  LocateTutors
//
//  Created by Victor Opurum on 1/16/18.
//  Copyright © 2018 Victor Opurum. All rights reserved.
//

import UIKit

class PopUp: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        
        self.showAnimate()
        
        
        // Do any additional setup after loading the view.
    }

   
    @IBAction func CloseBtn(_ sender: Any) {
        
        self.removeAnimate()
        
        //self.view.removeFromSuperview()
    }
    
    func showAnimate()
    {
        
        self.view.transform = CGAffineTransform (scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform (scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion: {(finished : Bool) in
                if (finished)
                {
                    self.view.removeFromSuperview()
            }
        });
    }
    

}
