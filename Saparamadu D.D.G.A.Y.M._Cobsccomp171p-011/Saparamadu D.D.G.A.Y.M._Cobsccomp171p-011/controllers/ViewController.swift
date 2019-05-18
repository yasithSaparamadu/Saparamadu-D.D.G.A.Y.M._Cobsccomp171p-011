//
//  ViewController.swift
//  Saparamadu D.D.G.A.Y.M._Cobsccomp171p-011
//
//  Created by Yasith Maheshka Saparamadu on 5/17/2562 BE.
//  Copyright © 2562 BE Yasith Maheshka Saparamadu. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.saveData()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(_ animated: Bool) {
        ApptempData.userDataHaddle = Auth.auth().addStateDidChangeListener {(Auth, user) in
            
            if user == nil {
                self.performSegue(withIdentifier: "Login", sender: nil) // loard login screen with identifire
            }else{
                self.performSegue(withIdentifier: "Home", sender: nil) // loard home screen
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(ApptempData.userDataHaddle!)
    }
    
   
}

