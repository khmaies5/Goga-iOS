//
//  Photo.swift
//  RWDevCon
//
//  Created by Mic Pringle on 04/03/2015.
//  Copyright (c) 2015 Ray Wenderlich. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class Photo {
    
    class func allPhotos() -> [Photo] {
        var photos = [Photo]()
        
        
        Alamofire.request("http://localhost:3000/api/posts", method: .get,parameters: nil ,encoding: JSONEncoding.default)
            .responseJSON{ response in
                let jsonArray = JSON(response.result.value!)
                print("JSON: \(jsonArray)")
                //   let JsonMap = Map(mappingType: jsonArray, JSON:
                for json in jsonArray {
                    
                    
                    let photo = Photo(dictionary: json)
                    
                    photos.append(photo)
                }
                
        }
        
        
        
        /*
         if let URL = Bundle.main.url(forResource: "Photos", withExtension: "plist") {
         if let photosFromPlist = NSArray(contentsOf: URL) {
         for dictionary in photosFromPlist {
         let photo = Photo(dictionary: dictionary as! NSDictionary)
         
         
         photos.append(photo)
         
         }
         }
         }*/
        return photos
    }
    
    
    
    
    
    
    /*
     
     
     */
    
    
    
    
    
    var caption: String
    var comment: String
    var image: UIImage
    
    init(caption: String, comment: String, image: UIImage) {
        self.caption = caption
        self.comment = comment
        self.image = image
    }
    
    convenience init(dictionary: (String,JSON)) {
        let caption = dictionary.1["title"].string
        let comment = dictionary.1["category"].string
        let photo = dictionary.1["type"].string
        
        var t : UIImageView
        
        let image = t.imageFromUrl2(Utils.urlAttachement + "/images/download/"+photo!)//UIImage(named: photo!)?.decompressedImage
       
    
        self.init(caption: caption!, comment: comment!, image: image)
    }
    
    func heightForComment(_ font: UIFont, width: CGFloat) -> CGFloat {
        let rect = NSString(string: comment).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        return ceil(rect.height)
    }
    
}

extension UIImage {
    

    
    
    public func imageFromUrl2(_ urlString: String) -> UIImage {
        if let url = URL(string: urlString) {
            var _image: UIImage!
            let request = URLRequest(url: url)
            NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main, completionHandler: {[unowned self] response, data, error in
                if let data = data {
                    _image = UIImage(data: data)
                }
            })
            return _image
        }
    }
}



