//
//  User.swift
//  TakeHomeProject
//
//  Created by Kayra Akbaş on 27.08.2024.
//

import UIKit

struct User : Codable{
    let login : String 
    let avatarUrl : String
    var name : String?
    var loacation : String?
    var bio : String?
    let publicRepos : Int
    let publicGists : Int
    let htmlUrl : String
    let following : Int
    let followers : Int
    let createdAt : Date
    
    
}
