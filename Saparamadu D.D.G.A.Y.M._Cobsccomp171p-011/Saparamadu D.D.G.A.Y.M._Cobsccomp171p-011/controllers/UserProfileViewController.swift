//
//  UserProfileViewController.swift
//  Saparamadu D.D.G.A.Y.M._Cobsccomp171p-011
//
//  Created by Yasith Maheshka Saparamadu on 5/20/2562 BE.
//  Copyright © 2562 BE Yasith Maheshka Saparamadu. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import Kingfisher

class UserProfileViewController: UIViewController {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var birthday: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    
    
    let usImage: String = ""
    let usName: String = ""
    let usAge: Int = 0
    let usBirthday: String = ""
    let usphoneNumber: Int = 0
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userImage.layer.cornerRadius = self.userImage.bounds.height / 2
        userImage.clipsToBounds = true
        getUserProfile()
        

        
        // Do any additional setup after loading the view.
    }
    
    func getUserProfile(){
        
        let userId = Auth.auth().currentUser?.uid
        
        Database.database().reference().child("user").child(userId!).observeSingleEvent(of: .value, with: {(DataSnapshot) in
        
            
            print(DataSnapshot)
            if let userProf = DataSnapshot.value as? [String : AnyObject]{
                
                let imgURL = URL(string: userProf["userImg"] as! String)
                self.userImage.kf.setImage(with: imgURL)
                self.userName.text! = userProf["userName"] as! String
                self.age.text! = "Age : \(String(userProf["age"] as! Int))"
                self.birthday.text! = "Birthday : \(userProf["birthdate"] as! String)"
                self.phoneNumber.text! = "Phone Number : \(String(userProf["phoneNo"] as! Int))"
                
            }
        }, withCancel: nil)
            
    }

   
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
