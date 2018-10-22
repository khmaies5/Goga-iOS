//
//  SinglePostViewController.swift
//  Goga1
//
//  Created by khmaies hassen on 1/8/18.
//  Copyright © 2018 malek cheikh. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SinglePostViewController: UIViewController{
    
    
    
    var post:Post?
    var like:Int = 0
    var dislike:Int = 0
    var Commentlist = [Comment]()
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var dislikeNbr: UILabel!
    @IBOutlet weak var likeNbr: UILabel!
   
  
    override func viewDidLoad() {
        super.viewDidLoad()
        postImg.imageFromUrl(Utils.baseUrl+"/attachments/images/download/"+(post?.type!)!)
        postTitleLabel.text = post?.title
        likeNbr.text = String(like)
        dislikeNbr.text = String(dislike)
        print("user1",(post?.userId)!)
        print("user1",post?.userId)
        UserSubscribe(UserId: (post?.userId)!)
        Alamofire.request(Utils.baseUrl+"/posts/"+(post?.id)!+"/comment").responseJSON { response in
            
            let jsonArray = JSON(response.result.value!)
            
            print(jsonArray)
            for json in jsonArray {
                let comment = Comment()
                //let user = User()
                print(json)
                
                comment.id = json.1["id"].string!
                comment.text = json.1["text"].string!
                comment.profilepicture = json.1["profilepicture"].string!
                comment.username = json.1["username"].string!
                comment.userId = json.1["userId"].string!
                comment.postId = json.1["postId"].string!
                self.Commentlist.append(comment)
                
               
            }
            
        }
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        userImg.isUserInteractionEnabled = true
        userImg.addGestureRecognizer(tapGestureRecognizer)
    }
    func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
      
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "ProfileNVB") as! ProfileController
        vc.user = post?.userId
      
        self.show(vc, sender: nil)
        // Your action
    }
    
    @IBAction func commetnBtn(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "CommentView") as! CommentViewController
       vc.arrComment = Commentlist
        vc.post = post
        self.show(vc, sender: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
       
    }
    
    

    
    func UserSubscribe(UserId: String){
        
        
        print("user1",UserId)
        // let defaults = UserDefaults.standard
        //  let id:String = defaults.string(forKey: "id")!
        
        let url = Utils.urlUsers+"/"+UserId
        
        Alamofire.request(url, method: .get,parameters: nil ,encoding: JSONEncoding.default)
            .responseJSON { response in
                print(response.request as Any)  // original URL request
                print(response.response as Any) // URL response
                print(response.result.value as Any)   // result of response serialization
                
                
                // print(response.response?.statusCode as Any)
                
                let  code:Int = (response.response?.statusCode as Any as? Int)!
                print (code)
                if (code == 200){
                    //   var user:User?
                    let user = response.result.value  as! NSDictionary
                    
                    let username:String = user.object(forKey: "username")! as! String
                    let email:String = user.object(forKey: "email")! as! String
                    let profilepicture:String = user.object(forKey: "profilepicture")! as! String
                   // let defaults = UserDefaults.standard
                    //defaults.set(UserId, forKey: "SubscribeId")
                    //  defaults.set(email, forKey: "email")
                    //  defaults.set(profilepicture, forKey: "profilepicture")
                    self.userImg.imageFromUrl1(Utils.urlAttachement + "/profilepicture/download/"+profilepicture)
                    self.userNameLabel.text = username
                    //self.Email.text = email
                    
                    
                }
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UIImageView {
    public func imageFromUrl2(_ urlString: String) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main, completionHandler: {[unowned self] response, data, error in
                
                let gif = UIImage.gif(url: urlString)
                self.image = gif
                
                
            })
        }
    }
}
