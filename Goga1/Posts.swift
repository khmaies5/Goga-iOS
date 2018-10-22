//
//  Posts.swift
//  Goga1
//
//  Created by malek cheikh on 1/7/18.
//  Copyright © 2018 malek cheikh. All rights reserved.
//

import UIKit

class Posts: NSObject {
    
    private var id:String
    
    private var title:String
    private var category:String
    private var datepublication:String
    private var userId:String
    private var type:String
    
    
    //init
    override init() {
        self.id = "0"
        self.title = ""
        self.category = ""
        
        self.datepublication = ""
        self.userId = ""
        self.type = ""
        
        
    }
    
    init(id:String,title:String, datepublication: String,userId: String,type: String,category: String) {
        self.id = id
        self.title = title
        self.datepublication = datepublication
        self.userId = userId
        
        self.category = category
        self.type = type
      
        
    }
    
    //getters
    public func getId() -> String {
        return self.id
    }
    
    public func getTitle() -> String {
        return self.title
    }
    public func getdatepublication() -> String {
        return self.datepublication
    }
    public func getuserId() -> String {
        return self.userId
    }
    public func getcategory() -> String {
        return self.category
    }
    public func gettype() -> String{
        return self.type
    }
    
    
    
    
    // setters
    
    public func setId(id :String) {
        self.id = id
    }
    
    public func setTitle(title:String){
        self.title = title
    }
    public func setdatepublication(datepublication:String) {
        self.datepublication = datepublication
    }
    public func setuserId(userId:String) {
        self.userId = userId
    }
    public func setcategory(category:String)  {
        self.category = category
    }
    public func settype(type:String) {
        self.type = type
    }
    
    
}

