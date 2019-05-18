//
//  HomeViewController.swift
//  Saparamadu D.D.G.A.Y.M._Cobsccomp171p-011
//
//  Created by Yasith Maheshka Saparamadu on 5/17/2562 BE.
//  Copyright © 2562 BE Yasith Maheshka Saparamadu. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import Kingfisher

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var studentDetail: [Student] = []
    var ref: DatabaseReference! // refenrence by the firebase
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        self.cellRegister()
        self.loardStudentData()
        self.tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        

        // Do any additional setup after loading the view.
    }
    
    //firebase user connection logout
    @IBAction func logout(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        self.navigationController?.dismiss(animated: true)
    }
   
    
    //register the viewCell
    func cellRegister() {
        self.tableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")
       
    }
    
    //get student data from firebase database
    func loardStudentData(){
        
       ///////////////////
//        ref.child("StudentDetails").observeSingleEvent(of: .value, with: { (snapshot) in
//            // Get user value
//            let value = snapshot.value as? NSDictionary
//            print("Studentr Data 2: \(value)")
//
//
//
//            // ...
//        }) { (error) in
//            print(error.localizedDescription)
//        }
        ///////////////////
        
        
        
        
        
        self.ref.child("StudentDetails/Students").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary

          // print("Studentr Data: \(value)")

            var nextstudent: [Student] = []

            if snapshot.childrenCount > 0 {

                for studentfor in snapshot.children.allObjects as! [DataSnapshot] {

                    let stdObject = studentfor.value as? [String: AnyObject]

                   // print("Studentr Data: \(stdObject)")
                    let dataModel = Student(firstName: stdObject!["firstName"] as! String,
                                            lastName: stdObject!["lastName"] as! String,
                                            phoneNo: stdObject!["phoneNo"] as? Int,
                                            facebookProfile: stdObject!["facebookProfile"] as! String,
                                            city: stdObject!["city"] as! String,
                                            profileImageURL: stdObject!["profileImageURL"] as! String)


//                    (firstName: stdObject!["firstName"] as! String, lastName: stdObject!["lastName"] as! String, phoneNo: stdObject!["phoneNo"] as! Int, facebookProfile: stdObject!["facebookProfile"] as! String, city: stdObject!["city"] as! String, profileImageURL: stdObject!["profileImageURL"] as! String)



                    nextstudent.append(dataModel)

                }
            }
            self.studentDetail = nextstudent
            self.tableView.reloadData()


        }) {(error) in
            print(error.localizedDescription)

        }
    }
    
    
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return self.studentDetail.count
   }
//
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let stdDetailCell = tableView.dequeueReusableCell(withIdentifier: "studentProtoCell", for: indexPath) as! HomeTableViewCell
        let profelImageURL = URL(string: self.studentDetail[indexPath.row].profileImageURL)
        stdDetailCell.profileImage.kf.setImage(with: profelImageURL)
        stdDetailCell.name.text = self.studentDetail[indexPath.row].firstName + "" + self.studentDetail[indexPath.row].lastName
        stdDetailCell.city.text = self.studentDetail[indexPath.row].city

  
        return stdDetailCell
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
