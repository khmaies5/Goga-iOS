//
//  Rating.swift
//  Goga1
//
//  Created by khmaies hassen on 1/7/18.
//  Copyright © 2018 malek cheikh. All rights reserved.
//

import UIKit

class Rating :NSObject {

    var id:String?
    var like:String?
    var dislike:String?
    var userId:String?
    var postId:String?
    
    
    
    override init() {
        self.id = ""
        self.like = ""
        self.dislike = ""
        self.userId = ""
        self.postId = ""
        
        
    }
    init(id:String , like:String,dislike:String ,userId:String, postId:String) {
        self.id = id
        self.like = like
        self.dislike = dislike
        self.userId = userId
        self.postId = postId
     
        
    }
}
