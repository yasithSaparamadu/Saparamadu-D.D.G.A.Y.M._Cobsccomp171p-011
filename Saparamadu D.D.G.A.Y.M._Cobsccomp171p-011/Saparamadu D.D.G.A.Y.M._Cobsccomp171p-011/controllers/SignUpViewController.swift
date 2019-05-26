//
//  SignUpViewController.swift
//  Saparamadu D.D.G.A.Y.M._Cobsccomp171p-011
//
//  Created by Yasith Maheshka Saparamadu on 5/19/2562 BE.
//  Copyright © 2562 BE Yasith Maheshka Saparamadu. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import Photos

class SignUpViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var addImage: UIButton!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var birthday: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var cancel: UIButton!
    @IBOutlet weak var signUp: UIButton!
    
    //image and databse haddle variables
    var imgPicker:UIImagePickerController!
    var imageURL: String = ""
    var firebaseDbReference: DatabaseReference!
    var orgImage: String = ""
    
    //to handle user data
    var userName: String = ""
    var userAge: Int = 0
    var phNumber: Int = 0
    var birthDay: String = ""
    var userEmail: String = ""
    var userPassword: String = ""
    var userImg: String = ""
    
    //user image set (time feedback problem solve)
    var setuserimg = 0{ // when set the URL value is 1 then didset
        didSet{
            print("set the URL : \(imageURL)")
            self.addUser()
        }
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imageView.layer.cornerRadius = self.imageView.bounds.height / 2
        imageView.clipsToBounds = true
        
        //image picker set
        imgPicker = UIImagePickerController()
        imgPicker.allowsEditing = true
        imgPicker.sourceType = .photoLibrary
        imgPicker.delegate = self
        
        let tapImageClick = UITapGestureRecognizer(target: self, action: #selector(tapImageLoad))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapImageClick)
        addImage.addTarget(self, action: #selector(tapImageLoad),
        for: .touchUpInside)

        // Do any additional setup after loading the view.
    }
    
    @objc func tapImageLoad(_sender: Any){
        self.present(imgPicker, animated: true, completion: nil)
    }
    
    @IBAction func signUp(_ sender: Any) {
        self.userName = self.name.text!
        self.userAge = Int(self.age.text!)!
        self.phNumber = Int(self.phoneNumber.text!)!
        self.birthDay = self.birthday.text!
        
        print(self.userName)
        self.getImage()
        
    }
    
    @IBAction func cancel(_ sender: Any) {
        
    }
    
    
     //upload image func
    func getImage(){
        
        let storeRef = Storage.storage().reference()
        
        guard let data = self.imageView.image!.jpegData(compressionQuality: 0.75) else {return}
        let image: UIImage = self.imageView.image!
        
        //create a referance
        let getRef = storeRef.child("userImage/\(orgImage)")
        
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
                
                self.userImg = downloadURL.absoluteString
                if self.userImg != "" {self.setuserimg = 1}
            }
        }
    }
        
        //save function
        func addUser(){
            Auth.auth().createUser(withEmail: self.email.text!, password: self.password.text!) { authResult, error in
                
                if error == nil && authResult != nil{
                    
                    guard let userId = Auth.auth().currentUser?.uid else {return}
                    
                    self.firebaseDbReference = Database.database().reference().child("user/\(userId)")
                    
                    let user = [
                        "userName": self.userName,
                        "age": self.userAge,
                        "birthdate": self.birthDay,
                        "phoneNo": self.phNumber,
                        "userImg": self.userImg
                    ] as [String: Any]
                    
                    self.firebaseDbReference!.setValue(user){errorAdd, ref in
       
                        if errorAdd != nil{
                            let alert = UIAlertController(title: "Error", message: "SignUp Error", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        }else{
                            self.dismiss(animated: true, completion: nil)
                        }
                            
                        }
                }else{
                    if error != nil{
                        let alert = UIAlertController(title: "Error", message: "SignUp Error", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }else{
                        self.dismiss(animated: true, completion: nil)
                    }
   
                }

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



extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imgPicker.dismiss(animated: true, completion: nil)
    }
    
    //image upload delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let imageUrl = info[UIImagePickerController.InfoKey.imageURL] as? URL{
            let imgName = imageUrl.lastPathComponent
            print("imgName: \(imgName)")
            let imageExten = imageUrl.pathExtension
            self.orgImage  = imgName
            print("image Name: \(imageExten)")
            
        }
        if let pickImg = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            
            self.imageView.image = pickImg
        }
        
        imgPicker.dismiss(animated: true, completion: nil)
        
    }
}
