//
//  ProfileController.swift
//  Goga1
//
//  Created by malek cheikh on 11/24/17.
//  Copyright © 2017 malek cheikh. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

import SwiftyJSON
import FirebaseMessaging


class ProfileController: UIViewController,UINavigationControllerDelegate,  UIImagePickerControllerDelegate ,UITableViewDataSource , UITableViewDelegate {
    
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(ProfileController.handleRefresh(_:)),
                                 for: UIControlEvents.valueChanged)
        refreshControl.tintColor = UIColor.red
        
        return refreshControl
    }()
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var uploadPostBtnN: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var Email: UILabel!
    @IBOutlet var subscribeBtn: UIView!
    
    
    var Postlist = [Posts]()
    var imagePicker = UIImagePickerController()
    
    var imageToUpload : UIImage!
    var imageName : String!
    var imageURL : URL! //(string : "http://www.localhost.png")!
    var fileExtenion : String!
    var mimetype : String!
    var user:String!
    var from:String!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        self.hideKeyboardWhenTappedAround()
        /*  imageView.layer.cornerRadius = imageView.frame.size.width / 2
         imageView.clipsToBounds = true
         imageView.layer.borderWidth = 2
         imageView.layer.borderColor = UIColor.black.cgColor*/
        let defaults = UserDefaults.standard
        let id:String = defaults.string(forKey: "id")!
        if (user == id){
        
        UserPreference()
        
        LoadPosts()
           // self.subscribeBtn.isHidden = true
    }
        else{
            UserSubscribe(UserId: user)
            LoadPostSubscribe(UserId: user)
        }
        
        /*  image.layer.borderWidth = 1
         image.layer.masksToBounds = false
         image.layer.borderColor = UIColor.black.cgColor
         image.layer.cornerRadius = image.frame.height/2
         image.clipsToBounds = true*/
        imagePicker.delegate = self
    }
    
    @IBAction func subscribeBtn(_ sender: Any) {
        
        let defaults = UserDefaults.standard
        let id:String = defaults.string(forKey: "id")!
        
        
        let json :[String : Any] = [
            
            "subscribee":id,
            "subsribed":user
            
            
            
            
            
        ]
        print(json)
        
        Alamofire.request(Utils.baseUrl+"/subscribtions", method: .post, parameters: json, encoding: JSONEncoding.default).responseJSON { response in switch response.result {
        case .success(let JSON):
            print("Success with JSON: \(JSON)")
            let response = JSON as! NSDictionary
            //let status:String = response.object(forKey: "response")! as! String
            print("comment response",response)
            
            Messaging.messaging().subscribe(toTopic: String(describing: "subscribe"+self.user) )
            //self.subscribeBtn.isUserInteractionEnabled = false
            break
        case .failure(let error):
            print("Request failed with error: \(error)")
            
            
            
            }
        }
       
        DispatchQueue.main.async() {
           
            
            
            
            
        }
        
        //subscribeBtn.isHidden = true;
        
    }
    
    @IBAction func ReturnView(_ sender: Any) {
        if(from == "recent"){
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "recentView") as! PostViewController
         
            self.present(vc, animated: true, completion: nil)
            
        } else if(from == "hot"){
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "hotView") as! HotPostViewController
      
            self.present(vc, animated: true, completion: nil)
        } else if (from == "details"){
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "SinglePost") as! SinglePostViewController
          
            self.present(vc, animated: true, completion: nil)
        
        } else {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "NewsDetailsVCID") as! UITabBarController
        
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Postlist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        
        //cell.textLabel?.text = "Hello from new Cell"
        
        
        // let downloadURL2 = NSURL(string: urlforimage +   Postlist[indexPath.row].user.profilepicUrl )
        //  let downloadURL1 = NSURL(string: urlforimage +   Postlist[indexPath.row].imageUrl)
        //  let imgProfile:UIImageView = cell.viewWithTag(101) as! UIImageView
        //   imgProfile.af_setImage(withURL: downloadURL2! as URL)
        
        let lblName:UILabel = cell.viewWithTag(102) as! UILabel
        lblName.text =  Postlist[indexPath.row].getcategory()
        
        let lblContent:UILabel = cell.viewWithTag(103) as! UILabel
        lblContent.text =  Postlist[indexPath.row].getTitle()
        
        let lblContent1:UILabel = cell.viewWithTag(105) as! UILabel
        lblContent1.text =  Postlist[indexPath.row].getdatepublication()
        
        let imgPost:UIImageView = cell.viewWithTag(104) as! UIImageView
        imgPost.imageFromUrl1(Utils.urlAttachement + "/images/download/"+Postlist[indexPath.row].gettype())
        
        return cell  }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        
        if segue.identifier == "segueCell",
            let svc:DetailsViewController = segue.destination as? DetailsViewController,
            let indexPath = self.tableView.indexPathForSelectedRow {
            let selectedVehicle = Postlist[indexPath.row]
            svc.currentpost = selectedVehicle
        }
        /* {
         let index:IndexPath = tableView.indexPathForSelectedRow!
         
         svc.strTemp = " \(Postlist[index.row].getTitle())"
         svc.category1 = "\(Postlist[index.row].getcategory())"
         svc.date1 = "\(Postlist[index.row].getdatepublication())"
         svc.imagedetail.image = imagedetail.imageFromUrl(Utils.urlAttachement + "/images/download/"+Postlist[index.row].gettype())
         
         
         
         
         }*/
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    @IBAction func LogoutAction(_ sender: Any) {
        let defaults = UserDefaults.standard
        defaults.set(false, forKey: "USERISLOGIN")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LoginView") as UIViewController
        self.present(vc, animated: true, completion: nil)
        
    }
    
    
    
    @IBAction func AddPhoto(_ sender: Any) {
        
       // let img = UIImagePickerController()
       //img.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
       // img.sourceType = UIImagePickerControllerSourceType.photoLibrary
       // img.allowsEditing = false
      
        
        
        // self.present(img, animated: true)
        
        
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.allowsEditing = true
        
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else {
            //for video in gallery picker.mediaTypes = [kUTTypeMovie as! String]
            picker.sourceType = .photoLibrary
            picker.modalPresentationStyle = .fullScreen
        }
        
        present(picker, animated: true)
        
      
        
        
        
        
        
    }
    /* func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
     if let img = info[UIImagePickerControllerOriginalImage] as? UIImage
     
     {   image.image = img
     
     //   let imageUrl          = info[UIImagePickerControllerReferenceURL] as! NSURL
     //   let imageName         = imageUrl.lastPathComponent
     //   let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
     //  let photoURL          = NSURL(fileURLWithPath: documentDirectory)
     //   let localPath         = photoURL.appendingPathComponent(imageName!)
     //  let image1             = info[UIImagePickerControllerOriginalImage]as! UIImage
     //   let data              = UIImagePNGRepresentation(image1)
     
     //  print (localPath as Any)
     
     print (imageURL as Any)
     print (imageName as Any)
     
     
     
     /*     do
     {
     try data?.write(to: localPath!, options: Data.WritingOptions.atomic)
     }
     catch
     {
     // Catch exception here and act accordingly
     }*/
     // var file_name = NSURL(fileURLWithPath: img).lastPathComponent!
     
     // print(file_name)
     //   let jpegCompressionQuality: CGFloat = 0.9
     //  let base64String = UIImageJPEGRepresentation(img, jpegCompressionQuality)?.base64EncodedString();
     //   let url = "http://192.168.198.135:3000/api/users/login"
     /*  let params: [String: String] = ["profilepicture": elf.imageName + self.fileExtenion]
     
     Alamofire.request(url, method: .post,parameters: params ,encoding: JSONEncoding.default)
     .responseJSON { response in
     print(response.request as Any)  // original URL request
     print(response.response as Any) // URL response
     print(response.result.value as Any)   // result of response serialization
     
     
     // print(response.response?.statusCode as Any)
     
     var  code:Int = (response.response?.statusCode as Any as? Int)!
     print (code)*/
     
     
     
     
     }
     
     
     self.dismiss(animated: true, completion: nil)
     } */
    // Do any additional setup after loading the view.
    
    @IBAction func selectImageClick(_ sender: UIButton) {
        
       
        
    }
    
    
    func UserPreference(){
        
        
        
        let defaults = UserDefaults.standard
        let id:String = defaults.string(forKey: "id")!
        
        let url = Utils.urlUsers+"/"+id
        
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
                    let defaults = UserDefaults.standard
                    defaults.set(username, forKey: "username")
                    defaults.set(email, forKey: "email")
                    defaults.set(profilepicture, forKey: "profilepicture")
                    self.imageView.imageFromUrl1(Utils.urlAttachement + "/profilepicture/download/"+defaults.string(forKey: "profilepicture")!)
                    self.Name.text = defaults.string(forKey: "username")!
                    self.Email.text = defaults.string(forKey: "email")!
                    
                    
                }
        }
        
    }
    
    
    func UserSubscribe(UserId: String){
        
        
        
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
                    let defaults = UserDefaults.standard
                    defaults.set(UserId, forKey: "SubscribeId")
                  //  defaults.set(email, forKey: "email")
                  //  defaults.set(profilepicture, forKey: "profilepicture")
                    self.imageView.imageFromUrl1(Utils.urlAttachement + "/profilepicture/download/"+profilepicture)
                    self.Name.text = username
                    self.Email.text = email
                    
                    
                }
        }
        
    }
    
    
    func LoadPostSubscribe(UserId: String){
        
      //  let defaults = UserDefaults.standard
       // let id:String = defaults.string(forKey: "SubscribeId")!
        
        
        let url = Utils.urlUsers+"/"+UserId+"/posts"
        
        Alamofire.request(url, method: .get,parameters: nil ,encoding: JSONEncoding.default)
            .responseJSON{ response in
                let jsonArray = JSON(response.result.value!)
                print("JSON: \(jsonArray)")
                //   let JsonMap = Map(mappingType: jsonArray, JSON:
                for json in jsonArray {
                    let post = Posts()
                    // let rating = Rating()
                    // print(3,json.1["rating"])
                    
                    post.setId(id: json.1["id"].string!)
                    post.setTitle(title: json.1["title"].string!)
                    post.setcategory(category: json.1["category"].string!)
                    post.setdatepublication(datepublication: json.1["datepublication"].string!)
                    post.settype(type: json.1["type"].string!)
                    //  let jsonobj:[String:Any] = json.1["rating"].dictionaryObject!
                    /*  rating.id = jsonobj["id"] as! String
                     rating.like = jsonobj["like"] as! String
                     rating.dislike = jsonobj["dislike"] as! String
                     rating.postId = jsonobj["postId"] as! String
                     rating.userId = jsonobj["userId"] as! String
                     post.rating.append(rating)*/
                    self.Postlist.append(post)
                    
                    DispatchQueue.main.async() {
                        print(1,post)
                        self.tableView.reloadData()
                        // self.dismiss(animated: false, completion: nil)
                        //self.photos.append(KolodaPhotoHot(self.arrPost))
                        // self.dismiss(animated: false, completion: nil)
                        
                        
                        
                    }
                }
                
        }
    }
    
    
    
    func LoadPosts(){
        
        // let url = Utils.urlUsers
        //  let defaults = UserDefaults.standard
        //  let id:String = defaults.string(forKey: "id")!
        
        /*  let json :[String : Any] = [
         "userId":"5a0b78134ab4ca15045aa3ea"
         
         ]*/
        
        
        /*   Alamofire.request(url, method: .get,parameters: nil ,encoding: JSONEncoding.default)
         .responseJSON { response in
         switch response.result {
         case .success:
         //to get JSON return value
         guard let responseJSON = response.result.value as? Array<[String: AnyObject]> else {
         // failure(0,"Error reading response")
         return
         }
         guard let post:[Post] = Mapper<Post>().mapArray(JSONArray: responseJSON) else {
         //   failure(0,"Error mapping response")
         return
         }
         print(post)
         post.forEach({ p in
         print(p.userId)
         
         
         
         })
         //   self.Postlist.append(post.toJSON())
         //  completion(post)
         
         default:print("error")}
         }*/
        
        // let responseJSON = response.result.value as? Array<[String: AnyObject]>
        //   let post:[Post] = Mapper<Post>().mapArray(JSONArray: responseJSON)
        
        // let post :[Post] = Mapper<Post>().mapArray(JSONArray: responseJSON!)
        //    print(post.description)
        /*    let jsonArray = JSON(response.result.value!)
         
         print(jsonArray)
         for json in jsonArray {
         let post:[Post] = Mapper<Post>().mapDictionary(JSONArray: jsonArray )
         
         self.Postlist = post
         // let post = Post(jsonA: Map)
         // let user = User()
         post.
         
         post.append(json.1["id"])
         post.content = json.1["content"].string!
         post.like = json.1["likes"].int!
         post.comment = json.1["comments"].int!
         post.date = json.1["date"].string!
         post.imageUrl = json.1["image_path"].string!
         let jsonobj:[String:Any] = json.1["user"].dictionaryObject!
         post.user = user
         self.Postlist.append(post)
         
         DispatchQueue.main.async() {
         self.tableView.reloadData()
         self.dismiss(animated: false, completion: nil)
         
         
         
         }
         }
         
         }
         
         
         self.tableView.addSubview(self.refreshControl)
         tableView.estimatedRowHeight = 700
         tableView.rowHeight = UITableViewAutomaticDimension*/
        
        
        
        
        
        let defaults = UserDefaults.standard
        let id:String = defaults.string(forKey: "id")!
        
        
        let url = Utils.urlUsers+"/"+id+"/posts"
        
        Alamofire.request(url, method: .get,parameters: nil ,encoding: JSONEncoding.default)
            .responseJSON{ response in
                let jsonArray = JSON(response.result.value!)
                print("JSON: \(jsonArray)")
                //   let JsonMap = Map(mappingType: jsonArray, JSON:
                for json in jsonArray {
                    let post = Posts()
                    // let rating = Rating()
                    // print(3,json.1["rating"])
                    
                    post.setId(id: json.1["id"].string!)
                    post.setTitle(title: json.1["title"].string!)
                    post.setcategory(category: json.1["category"].string!)
                    post.setdatepublication(datepublication: json.1["datepublication"].string!)
                    post.settype(type: json.1["type"].string!)
                    //  let jsonobj:[String:Any] = json.1["rating"].dictionaryObject!
                    /*  rating.id = jsonobj["id"] as! String
                     rating.like = jsonobj["like"] as! String
                     rating.dislike = jsonobj["dislike"] as! String
                     rating.postId = jsonobj["postId"] as! String
                     rating.userId = jsonobj["userId"] as! String
                     post.rating.append(rating)*/
                    self.Postlist.append(post)
                    
                    DispatchQueue.main.async() {
                        print(1,post)
                        self.tableView.reloadData()
                        // self.dismiss(animated: false, completion: nil)
                        //self.photos.append(KolodaPhotoHot(self.arrPost))
                        // self.dismiss(animated: false, completion: nil)
                        
                        
                        
                    }
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
    func randomAlphaNumericString(length: Int) -> String {
        let allowedChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let allowedCharsCount = UInt32(allowedChars.characters.count)
        var randomString = ""
        
        for _ in 0..<length {
            let randomNum = Int(arc4random_uniform(allowedCharsCount))
            let randomIndex = allowedChars.index(allowedChars.startIndex, offsetBy: randomNum)
            let newCharacter = allowedChars[randomIndex]
            randomString += String(newCharacter)
        }
        
        return randomString
    }
    
    func handleRefresh(_ refreshControl: UIRefreshControl) {
        //LoadPosts()
        
        refreshControl.endRefreshing()
    }
    
}


extension ProfileController {
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            print("Info did not have the required UIImage for the Original Image")
            dismiss(animated: true)
            return
        }
        if #available(iOS 11.0, *) {
            guard let imageUrl = info[UIImagePickerControllerImageURL] as? URL else {
                print(" info did not have the required URL for the Original image")
                return
            }
            imageURL = imageUrl
            if(imageUrl.pathExtension.lowercased() == "jpg" || imageUrl.pathExtension.lowercased() == "jpeg"){
                
                print("Parse image ext is a jpg: \(imageUrl.pathExtension.lowercased())");
                
                fileExtenion = ".jpg";
                mimetype = "image/"+imageUrl.pathExtension
                uploadPostBtnN.isEnabled = true
            } else if(imageUrl.pathExtension.lowercased() == "png"){
                print("Parse image is a png: \(imageUrl.pathExtension.lowercased())");
                
                fileExtenion = ".png";
                mimetype = "image/"+imageUrl.pathExtension
                uploadPostBtnN.isEnabled = true
            } else if (imageUrl.pathExtension.lowercased() == "gif"){
                print("Parse image is a gif: \(imageUrl.pathExtension.lowercased())");
                
                fileExtenion = ".gif";
                mimetype = "image/"+imageUrl.pathExtension
                uploadPostBtnN.isEnabled = true
            } else{
                uploadPostBtnN.isEnabled = false
            }
            
        } else {
            // Fallback on earlier versions
            print("not ios 11.0")
            let imageURLl = info[UIImagePickerControllerReferenceURL] as! NSURL
            let imagePath =  imageURLl.path!
            let localPath = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(imagePath)
            print("local path : ",localPath!.absoluteURL)
            imageURL = localPath!
            if(localPath!.pathExtension.lowercased() == "jpg" || localPath!.pathExtension.lowercased() == "jpeg"){
                
                print("Parse image ext is a jpg: \(localPath!.pathExtension.lowercased())");
                
                fileExtenion = ".jpg";
                mimetype = "image/"+localPath!.pathExtension
                uploadPostBtnN.isEnabled = true
            } else if(localPath!.pathExtension.lowercased() == "png"){
                print("Parse image is a png: \(localPath!.pathExtension.lowercased())");
                
                fileExtenion = ".png";
                mimetype = "image/"+localPath!.pathExtension
                uploadPostBtnN.isEnabled = true
            } else if (localPath!.pathExtension.lowercased() == "gif"){
                print("Parse image is a gif: \(localPath!.pathExtension.lowercased())");
                
                fileExtenion = ".gif";
                mimetype = "image/"+localPath!.pathExtension
                uploadPostBtnN.isEnabled = true
            } else{
                uploadPostBtnN.isEnabled = false
            }
            
        }
        imageView.image = image
        imageToUpload = image
        
        
        
        
        /* progressView.progress = 0.0
         progressView.isHidden = false
         activityIndicatorView.startAnimating()*/
        
        
        dismiss(animated: true)
        
        let imgData = try! Data(contentsOf: imageURL) //UIImagePNGRepresentation(imageToUpload!)!
        
        let defaults = UserDefaults.standard
        let id:String = defaults.string(forKey: "id")!
        self.imageName = randomAlphaNumericString(length: 10)
        //let parameters = ["name": rname]
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imgData, withName: "fileset",fileName: self.imageName + self.fileExtenion, mimeType: self.mimetype)
            
        },
                         to: Utils.urlAttachement+"/profilepicture/upload")
        { (result) in
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (progress) in
                    print("Upload Progress: \(progress.fractionCompleted)")
                    // self.progressView.progress = Float(progress.fractionCompleted)
                })
                
                upload.responseJSON { response in
                    // self.activityIndicatorView.stopAnimating()
                    
                    let parameters: Parameters = [
                        
                        //  "title": self.descField.text,
                        
                        
                        "profilepicture": self.imageName + self.fileExtenion,
                        
                        "id": id
                        
                    ]
                    
                    let url = Utils.urlUsers
                    
                    Alamofire.request(url, method:.patch, parameters:parameters).responseJSON { response in
                        switch response.result {
                        case .success:
                            debugPrint(response)
                            
                        case .failure(let error):
                            print(error)
                        }
                        //    self.selectImage.isHidden = false
                        
                    }
                    
                }
                
            case .failure(let encodingError):
                print(encodingError.localizedDescription)
                //  self.selectImage.isHidden = false
                
            }
        }
        
        
    }
    override func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    override func dismissKeyboard() {
        view.endEditing(true)
    }
}
extension UIImageView {
    public func imageFromUrl1(_ urlString: String) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main, completionHandler: {[unowned self] response, data, error in
                if let data = data {
                    self.image = UIImage(data: data)
                }
            })
        }
    }
}



