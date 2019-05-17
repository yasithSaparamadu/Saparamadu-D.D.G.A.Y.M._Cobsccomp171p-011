//
//  LoginViewController.swift
//  Saparamadu D.D.G.A.Y.M._Cobsccomp171p-011
//
//  Created by Yasith Maheshka Saparamadu on 5/17/2562 BE.
//  Copyright © 2562 BE Yasith Maheshka Saparamadu. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn

class LoginViewController: UIViewController {

    @IBOutlet weak var userLogin: UILabel!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var signup: UIButton!
    @IBOutlet weak var login: UIButton!
    @IBOutlet weak var forgetPassword: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func login(_ sender: Any) {
        
        Auth.auth().signIn(withEmail: self.userName.text!, password: self.password.text!) { [weak self] user, error in
            guard let strongSelf = self else { return }
            //  get existing users to sign in
            
            if error != nil {
                let alert = UIAlertController(title: "Logging Error", message: error? .localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                strongSelf.present(alert, animated: true, completion: nil)
                
            }else{
                strongSelf.dismiss(animated: true, completion: nil)
            }
        
        }
    }
    

    @IBAction func signup(_ sender: Any) {
    }
    
    @IBAction func forgotPassword(_ sender: Any) {
    }
    /*
    // MARK: - Navigation

     // In a storyboard-based application, you will often want to@IBOutlet weak var login: UIButton!
     @IBOutlet weak var login: UIButton!
     do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
