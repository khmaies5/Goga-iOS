//
//  Comment.swift
//  Goga1
//
//  Created by khmaies hassen on 1/9/18.
//  Copyright © 2018 malek cheikh. All rights reserved.
//

import UIKit

class Comment: NSObject {
    var id:String?
    var text:String?
    var profilepicture:String?
    var username:String?
    var postId:String?
    var userId:String?
    
    
    
    override init() {
        self.id = ""
        self.text = ""
        self.profilepicture = ""
        self.username = ""
        self.postId = ""
        self.userId = ""
        
        
    }
    init(id:String , text:String,profilepicture:String ,username:String, postId:String, userId:String) {
        self.id = id
        self.text = text
        self.profilepicture = profilepicture
        self.username = username
        self.postId = postId
        self.userId = userId
        
        
    }
}
