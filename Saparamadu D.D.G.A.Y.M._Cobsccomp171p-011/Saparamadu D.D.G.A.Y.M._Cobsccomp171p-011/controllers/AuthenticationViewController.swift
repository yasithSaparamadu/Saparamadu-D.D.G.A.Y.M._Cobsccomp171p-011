//
//  AuthenticationViewController.swift
//  Saparamadu D.D.G.A.Y.M._Cobsccomp171p-011
//
//  Created by Yasith Maheshka Saparamadu on 5/26/2562 BE.
//  Copyright © 2562 BE Yasith Maheshka Saparamadu. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class AuthenticationViewController: UIViewController {
    
    let IDauth = BiometricIDAuth()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
   
    func touchIdLoginAction(){
        
        IDauth.authenticateUser(){ [weak self] message in
            if let message = message {
                
                let alertView = UIAlertController(title: "Authentication Error", message: message, preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: "Ok", style: .default, handler: {(action:UIAlertAction!) in
                    
                })
                
                alertView.addAction(okAction)
                self!.present(alertView, animated: true)
            }else{
                
                ApptempData.userDataHaddle = Auth.auth().addStateDidChangeListener{(auth, user) in
                    if user == nil{
                        //self!.performSegue(withIdentifier: "<#T##String#>", sender: <#T##Any?#>)
                    }else{
                        self!.performSegue(withIdentifier: "touchID", sender: nil)
                    }
                }
            }
        }
        
    }
    
    @IBAction func fingerprintAuth(_ sender: Any) {
        
        self.touchIdLoginAction()
        
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
