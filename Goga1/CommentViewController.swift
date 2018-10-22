//
//  CommentViewController.swift
//  Goga1
//
//  Created by khmaies hassen on 1/9/18.
//  Copyright © 2018 malek cheikh. All rights reserved.
//

import UIKit
import Alamofire

class CommentViewController: UIViewController,UITableViewDataSource , UITableViewDelegate {
    var arrComment = [Comment]()
    var post:Post?
    
    
    @IBOutlet weak var commentText: UITextView!
    @IBOutlet weak var commentTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func CommetnSubmitBtn(_ sender: Any) {
        
        let defaults = UserDefaults.standard
        let id:String = defaults.string(forKey: "id")!
        let profilepicture = defaults.string(forKey: "profilepicture")
        let username = defaults.string(forKey: "username")
        
        let json :[String : Any] = [
            "postId":self.post!.id,
            "userId":id,
            "text":commentText.text!,
            "username":username,
            "profilepicture":profilepicture
            
            
            
            
        ]
        print(json)
        
        Alamofire.request(Utils.baseUrl+"/comments", method: .post, parameters: json, encoding: JSONEncoding.default).responseJSON { response in switch response.result {
        case .success(let JSON):
            print("Success with JSON: \(JSON)")
            let response = JSON as! NSDictionary
            //let status:String = response.object(forKey: "response")! as! String
            print("comment response",response)
            break
        case .failure(let error):
            print("Request failed with error: \(error)")
            
            
            
            }
        }
        commentText.text=""
        DispatchQueue.main.async() {
            self.commentTable.reloadData()
            
            
            
            
        }
        
        
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrComment.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = commentTable.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        
        
        
        //cell.textLabel?.text = "Hello from new Cell"
        
        let imgProfile:UIImageView = cell.viewWithTag(101) as! UIImageView
        imgProfile.imageFromUrl(Utils.baseUrl+"/attachments/images/download/"+arrComment[indexPath.row].profilepicture!)
        let lblName:UILabel = cell.viewWithTag(102) as! UILabel
        lblName.text =  arrComment[indexPath.row].username
        
        let lblContent:UILabel = cell.viewWithTag(103) as! UILabel
        lblContent.text =  arrComment[indexPath.row].text
        
        return cell        }
    
    

    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


