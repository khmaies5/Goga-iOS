//
//  User.swift
//  Goga1
//
//  Created by malek cheikh on 11/25/17.
//  Copyright © 2017 malek cheikh. All rights reserved.
//

import Foundation


class User {
    var firstName: String
    var lastName: String
    var photo: String //must be stored as a string for the filename.
  //  var listOfJoinedOpportunities = [Opportunity]()
  //  var listOfJoinedOpportunitiesKeys = [String]()
   // var listOfFriendsOnTheApp: NSArray
   
    var email: String
    var userID: String   //A unique ID that is used to persist data about the user to the database (Firebase).
    
    
    init(firstName: String, lastName: String, photo: String, email:String, userID: String){
        self.firstName = firstName
        self.lastName = lastName
        self.photo = photo
        self.email = email
        self.userID = userID
    }   
}
