//
//  studentmodel.swift
//  Saparamadu D.D.G.A.Y.M._Cobsccomp171p-011
//
//  Created by Yasith Maheshka Saparamadu on 5/18/2562 BE.
//  Copyright © 2562 BE Yasith Maheshka Saparamadu. All rights reserved.
//

import Foundation

class Student{
    let firstName: String!
    let lastName: String!
    let phoneNo: Int!
    let facebookProfile: String!
    let city: String!
    let profileImageURL: String!
    
    init(firstName: String, lastName: String, phoneNo: Int!, facebookProfile: String, city: String, profileImageURL: String){
        self.firstName = firstName
        self.lastName = lastName
        self.phoneNo = phoneNo
        self.facebookProfile = facebookProfile
        self.city = city
        self.profileImageURL = profileImageURL
        
    }
    
}
