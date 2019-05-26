//
//  ViewStudentViewController.swift
//  Saparamadu D.D.G.A.Y.M._Cobsccomp171p-011
//
//  Created by Yasith Maheshka Saparamadu on 5/19/2562 BE.
//  Copyright © 2562 BE Yasith Maheshka Saparamadu. All rights reserved.
//

import UIKit
import Kingfisher

class ViewStudentViewController: UIViewController {


    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var lastName: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var facebookProfile: UILabel!
    
    
    var studentData: Student!
    
    override func viewDidLoad() {
        
        self.userImage.layer.cornerRadius = self.userImage.bounds.height / 2
        userImage.clipsToBounds = true
        
        super.viewDidLoad()
        let imgURL = URL(string: studentData.profileImageURL)
        userImage.kf.setImage(with: imgURL)
        
        firstName.text = studentData.firstName
        lastName.text = studentData.lastName
        city.text = studentData.city
        phoneNumber.text = String(studentData.phoneNo!)
        facebookProfile.text = studentData.facebookProfile
        

        // Do any additional setup after loading the view.
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
