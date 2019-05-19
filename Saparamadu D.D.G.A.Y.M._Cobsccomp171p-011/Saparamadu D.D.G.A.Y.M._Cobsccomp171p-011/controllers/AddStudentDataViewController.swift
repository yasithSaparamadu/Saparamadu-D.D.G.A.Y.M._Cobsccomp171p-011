//
//  AddStudentDataViewController.swift
//  Saparamadu D.D.G.A.Y.M._Cobsccomp171p-011
//
//  Created by Yasith Maheshka Saparamadu on 5/18/2562 BE.
//  Copyright © 2562 BE Yasith Maheshka Saparamadu. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import Photos

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
    
    //image and databse haddle variables
    var imgPicker:UIImagePickerController!
    var imageURL: String = ""
    var firebaseDbReference: DatabaseReference!
    var orgImage: String = ""
    
    //to handle student data
    var fstName: String = ""
    var lstName: String = ""
    var facebookURL: String = ""
    var phone: Int = 0
    var cty: String = ""
    var imgProf: String = ""
    
    //profile image set (time feedback problem solve)
    var setprofileimg = 0{ // when set the URL value is 1 then didset
        didSet{
            print("set the URL : \(imageURL)")
            self.addStudent()
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clear.layer.cornerRadius = self.clear.bounds.height / 2
        save.layer.cornerRadius = self.save.bounds.height / 2

        
        //image picker set
        imgPicker = UIImagePickerController()
        imgPicker.allowsEditing = true
        imgPicker.sourceType = .photoLibrary
        imgPicker.delegate = self
        
        let imageClick = UITapGestureRecognizer(target: self, action: #selector(pickerLoad))
        profileImage.isUserInteractionEnabled = true
        profileImage.addGestureRecognizer(imageClick)
        addImage.addTarget(self, action: #selector(pickerLoad), for: .touchUpInside)
        
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func addPhoto(_ sender: Any) {
    }
    
    
    @IBAction func clear(_ sender: Any) {
    }
    
    
    @IBAction func saveStudent() {
        self.fstName = self.firstName.text!
        self.lstName = self.lastName.text!
        self.facebookURL = self.facebookProfile.text!
        self.phone = Int(self.phoneNumber.text!)!
        self.cty = self.city.text!
        
        //print(fstName, lstName, facebookURL, phone, city)
       getImage()
    }
    
    //picker load function
    @objc func pickerLoad(_sender: Any){
        self.present(imgPicker, animated: true, completion: nil)
    }
    
    //Save function
    func addStudent(){
        firebaseDbReference = Database.database().reference().child("StudentDetails/Students").childByAutoId()
        let student = ["firstName": self.fstName,
                       "lastName": self.lstName,
                       "facebookProfile": self.facebookURL,
                       "phoneNumber": self.phone,
                       "city": self.cty,
                       "profileImageURL": self.imgProf] as [String: Any]
        
        self.firebaseDbReference!.setValue(student){error, ref in
            
            if error != nil{
                let alert = UIAlertController(title: "Error", message: "Save not successfully", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }else{
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    //upload image func
    func getImage(){

        let storeRef = Storage.storage().reference()

        guard let data = self.profileImage.image!.jpegData(compressionQuality: 0.75) else {return}
        let image: UIImage = self.profileImage.image!
        print("Image Data ")

        //create a referance
        let getRef = storeRef.child("profileImg/\(orgImage)")

        //file upload (get image details and create URL)
        let uploadImg = getRef.putData(data, metadata: nil){(metadata, error) in
            guard let metadata = metadata else{
                return
            }
            let size = metadata.size
            let url = getRef.downloadURL{(url, error) in

                guard let downloadURL = url else {
                    return
                }
                
                self.imgProf = downloadURL.absoluteString
                if self.imgProf != "" {self.setprofileimg = 1}
            }
        }
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

extension AddStudentDataViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imgPicker.dismiss(animated: true, completion: nil)
    }
    
    //
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let imageUrl = info[UIImagePickerController.InfoKey.imageURL] as? URL{
            let imgName = imageUrl.lastPathComponent
            print("imgName: \(imgName)")
            let imageExten = imageUrl.pathExtension
            self.orgImage  = imgName
            print("image Name: \(imageExten)")
            
        }
        if let pickImg = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            
            print("Image Picker : \(pickImg)")
            self.profileImage.image = pickImg
        }
        
        imgPicker.dismiss(animated: true, completion: nil)
        
    }
}
