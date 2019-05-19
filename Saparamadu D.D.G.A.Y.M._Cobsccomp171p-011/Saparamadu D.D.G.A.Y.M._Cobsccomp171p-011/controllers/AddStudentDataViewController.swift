//
//  AddStudentDataViewController.swift
//  Saparamadu D.D.G.A.Y.M._Cobsccomp171p-011
//
//  Created by Yasith Maheshka Saparamadu on 5/18/2562 BE.
//  Copyright © 2562 BE Yasith Maheshka Saparamadu. All rights reserved.
//

import UIKit

class AddStudentDataViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var addImage: UIButton!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var facebookProfile: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var clear: UIButton!
    @IBOutlet weak var save: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clear.layer.cornerRadius = self.clear.bounds.height / 2
        save.layer.cornerRadius = self.save.bounds.height / 2

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addPhoto(_ sender: Any) {
    }
    
    
    @IBAction func clear(_ sender: Any) {
    }
    
    
    @IBAction func saveStudent(_ sender: Any) {
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
