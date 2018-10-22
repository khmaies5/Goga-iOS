//
//  Post.swift
//  Goga1
//
//  Created by Khmaies Hassen on 11/23/17.
//  Copyright © 2017 malek cheikh. All rights reserved.
//

import UIKit

class Post: NSObject
{
    var title: String?
    var category:String?
    var datepublication:String?
    var type:String?
    var id: String?
    var userId:String?
    var rating:[Rating]
    var totalLike:Int?
    var totalDislike:Int?
    
    
    
    
    override init() {
        self.title = ""
        self.category = ""
        self.datepublication = ""
        self.type = ""
        self.id = ""
        self.userId = ""
        self.rating = []
        self.totalLike=0
        self.totalDislike=0
        
    }
    init(title:String , category:String,datepublication:String ,type:String, id:String, userId:String, rating:[Rating], totalLike:Int, totalDislike:Int ) {
        self.title = title
        self.category = category
        self.datepublication = datepublication
        self.type = type
        self.id = id
        self.userId = userId
        self.rating = rating
        self.totalLike=totalLike
        self.totalDislike=totalDislike
        
    }
    
    
    
    
}
