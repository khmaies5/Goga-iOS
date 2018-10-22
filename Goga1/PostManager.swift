//
//  PostManager.swift
//  Goga1
//
//  Created by Khmaies Hassen on 11/23/17.
//  Copyright © 2017 malek cheikh. All rights reserved.
//

import Alamofire
import ObjectMapper

var p = ""
class PostManager{
    /*
     static let sharedInstance = PostManager()
    
    
    func getCostumers(completion:@escaping (Array<Post>) -> Void, failure:@escaping (Int, String) -> Void) -> Void{
        let url: String = "http://localhost:3000/api/posts/withRatings"
        
        Alamofire.request(url).validate(statusCode: 200..<300).responseJSON { response in
            switch response.result {
            case .success:
                //to get JSON return value
                guard let responseJSON = response.result.value as? Array<[String: AnyObject]> else {
                    failure(0,"Error reading response")
                    return
                }
                guard let post:[Post] = Mapper<Post>().mapArray(JSONArray: responseJSON) else {
                    failure(0,"Error mapping response")
                    return
                }
                print(post)
                completion(post)
            case .failure(let error):
                failure(0,"Error \(error)")
            }
        }
    }
    
    class func shared() -> PostManager {
        return sharedInstance
    }*/
}
