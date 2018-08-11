//
//  ViewController.swift
//  AllInOnePracticeTarun
//
//  Created by tarun naveen on 26/07/18.
//  Copyright © 2018 tarun naveen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var lbl: UILabel!
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    override func viewDidDisappear(_ animated: Bool)
    {
            self.lbl.text = "We all love Autolayout, don't we? I had a less than ideal experience with it when I started. However, after continuous practice and reading a Book - iOS Auto Layout Demystified I got more comfortable with it. However, there are certain cases where it's still possible to solve problem with Auto layout, but it takes time to figure out correct thing to do."
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(_ animated: Bool) {
        
        self.showAlertWhenNetworkLoss(withTitle: "123456", andMsg: "123456789") { (action) in
            
            if action == true
            {
                self.reAction()
            }
            
        }

    }

    func reAction() {
        print("retry")
    }
    @IBAction func login(sender: UIButton) {
        
        let bounds = self.loginButton.bounds
        UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: [], animations: {
            self.loginButton.bounds = CGRect(x: bounds.origin.x - 20, y: bounds.origin.y, width: bounds.size.width + 60, height: bounds.size.height)
            self.loginButton.isEnabled = true
        }, completion: nil)
        
    }

    
}

