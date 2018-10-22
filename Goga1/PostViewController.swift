//
//  PostViewController.swift
//  Goga1
//
//  Created by Khmaies Hassen on 11/21/17.
//  Copyright © 2017 malek cheikh. All rights reserved.
//

import UIKit
import Koloda
import paper_onboarding
import Alamofire
import SwiftyJSON
import ObjectMapper
import SwiftGifOrigin


private var numberOfCards: Int = 5
  
//var gogaPview = GogaPostView()


class KolodaPhoto {
    var photoUrlString = ""
    var title = ""
    
    init () {
    }
    
    convenience init(_ dictionary: Post) {
        self.init()
        
        title = (dictionary.title)!
        photoUrlString = (dictionary.type!)
        
      
        
    }
}


class PostViewController: UIViewController {
    
    
    @IBOutlet weak var kolodaView: KolodaView!
  //  let postView = PostView.createMyClassView()
    var postView:PostView!
    var gogaarray = [PostView]()//alternatively (does the same): var array = Array<Country>()
    var run: [Any] = []
       var photos: [Post] = []
    var spinner = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    var loadingView: UIView = UIView()
    var arrPost: [Post] = []
    var arrRating : [Rating] = []
    var userId : String!
    var postU = Post()
    
  
    /*let gogaView: GogaPostView = {
        let c = GogaPostView()
        return c
    }()*/
    var dataSource: [UIView] = {
        var array: [UIView] = []
        for index in 0..<numberOfCards {
            array.append(PostView())
        }
        
        return array
    }()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        let id:String = defaults.string(forKey: "id")!
        userId = id
       /* gogaarray.append(PostView())
        gogaarray.append(PostView())
        gogaarray.append(PostView())
        gogaarray.append(PostView())
        gogaarray.append(PostView())*/
         // getPosts()
      /*  Alamofire.request("http://192.168.1.35:3000/api/posts").responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                guard let responseJSON = responseData.result.value as? Array<[String: AnyObject]> else {
                    print(0,"Error reading response")
                    return
                }
                guard let post:[Post] = Mapper<Post>().mapArray(JSONArray: responseJSON) else {
                    print(0,"Error mapping response")
                    return
                }
                for p in post{
                    print(p.title as! String)
                    //var x : PostView
                    self.postView.titleView.text = "p.title"
                    self.gogaarray.append(self.postView)
                    self.kolodaView.dataSource = self
                    self.kolodaView.delegate = self
                    
                }
            }
        }*/
        
        
        
        
        kolodaView.dataSource = self
        kolodaView.delegate = self
     
        fetchPhotos()
        
        
     
   
        
     
       
        
        
        self.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal
    }
    
    
  
    
    //MARK: Datahandling
    func fetchPhotos() {
        
       var totalLike:Int = 0
        var totalDislike:Int = 0
        showActivityIndicator()
        
        Alamofire.request( Utils.urlPost+"/withRatings")
            .responseJSON { response -> Void in
                switch response.result {
                case .success(let value):
                    let jsonArray = JSON(value)
                   
                    
                    for json in jsonArray["Posts"] {
                        let post = Post()
                        let rating = Rating()
                          print(3,json.1["userId"])
                        
                        post.id = json.1["id"].string!
                        post.title = json.1["title"].string!
                        post.category = json.1["category"].string!
                        post.type = json.1["type"].string!
                        post.userId = json.1["userId"].string!
                       
                        let jsonobj = JSON(json.1["rating"])
                        
                        for rArray in jsonobj{
                            rating.id = rArray.1["id"].string!
                            rating.like = String(describing: rArray.1["like"].int!)
                            totalLike += rArray.1["like"].int!
                            totalDislike += rArray.1["dislike"].int!
                            
                            rating.dislike = String(describing: rArray.1["dislike"].int!)
                            rating.postId = rArray.1["postId"].string!
                            rating.userId = rArray.1["userId"].string
                        }
                        
                        post.totalLike = totalLike
                        post.totalDislike = totalDislike
                        
                        totalDislike = 0
                        totalLike = 0
                        self.postU = post
                        post.rating.append(rating)
                        self.arrPost.append(post)
                        
                        DispatchQueue.main.async() {
                      
                            
                            
                            //self.dismiss(animated: false, completion: nil)
                            
                            
                            
                        }
                    }
                    self.photos = self.arrPost
                    self.kolodaView.reloadData()
                    self.hideActivityIndicator()
                    
                case .failure(let error):
                    print(error)
                }
                
        }
        
        
        
        
        
        
        
        
        
    }
    
    
    
    
    func showActivityIndicator() {
        DispatchQueue.main.async {
            self.loadingView = UIView()
            self.loadingView.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.width, height: self.view.frame.height)
            self.loadingView.center = self.view.center
            self.loadingView.backgroundColor = UIColor.black
            self.loadingView.alpha = 0.9
            self.loadingView.clipsToBounds = true
            self.spinner = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
            self.spinner.frame = CGRect(x: 0.0, y: 0.0, width: 80.0, height: 80.0)
            self.spinner.center = CGPoint(x:self.loadingView.bounds.size.width / 2, y:self.loadingView.bounds.size.height / 2)
            self.loadingView.addSubview(self.spinner)
            self.view.addSubview(self.loadingView)
            self.spinner.startAnimating()
        }
    }
    
    func hideActivityIndicator() {
        DispatchQueue.main.async {
            self.spinner.stopAnimating()
            self.loadingView.removeFromSuperview()
        }
    }
    
    
    
    
    // MARK: IBActions
    @IBAction func leftButtonTapped() {
        kolodaView?.swipe(.left)
        
        print("left button")
        var uId : String?
        var rId : String?
        var like : String?
        var dislike : String?
        for t in self.photos[kolodaView.currentCardIndex-1].rating{
           // print(10,t.dislike)
            if t.userId == self.userId{
                uId = t.userId
                rId = t.id
                like = t.like
                dislike = t.dislike
            }
            
            
        }
        
        
        if self.userId == uId {
            print(dislike,"user  liked this")
            if dislike == "0"{
                
                let params: [String: String] = ["like": "0", "dislike":"1","postId":self.photos[kolodaView.currentCardIndex-1].id!,"userId":self.userId]
                
                Alamofire.request(Utils.baseUrl+"/ratings/"+rId!, method: .patch,parameters: params ,encoding: JSONEncoding.default)
                    .responseJSON { response in
                        print(response.request as Any)  // original URL request
                        print(response.response as Any) // URL response
                        print(response.result.value as Any)   //
                        
                }
            }
        } else {
            print("user did not liked this")
            
            let params: [String: String] = ["like": "0", "dislike":"1","postId":self.photos[kolodaView.currentCardIndex-1].id!,"userId":self.userId]
            
            Alamofire.request(Utils.baseUrl+"/ratings", method: .post,parameters: params ,encoding: JSONEncoding.default)
                .responseJSON { response in
                    print(response.request as Any)  // original URL request
                    print(response.response as Any) // URL response
                    print(response.result.value as Any)   //
                    
            }
        }
        
    }
    @IBAction func rightButtonTapped() {
        kolodaView?.swipe(.right)
        var uId : String?
        var rId : String?
        var like : String?
        var dislike : String?
       
        //print(10,self.photos[kolodaView.currentCardIndex-1].rating[0].dislike)
        for t in self.photos[kolodaView.currentCardIndex-1].rating{
            //print(10,t.userId)
                if t.userId == self.userId{
                    uId = t.userId
                    rId = t.id
                    like = t.like
                    dislike = t.dislike
                }
                
            
        }
        
        
        if self.userId == uId {
            
            if like == "0"{
            print("user disliked this")
            let params: [String: String] = ["like": "1", "dislike":"0","postId":self.photos[kolodaView.currentCardIndex-1].id!,"userId":self.userId]
            
            Alamofire.request(Utils.baseUrl+"/ratings/"+rId!, method: .patch,parameters: params ,encoding: JSONEncoding.default)
                .responseJSON { response in
                    print(response.request as Any)  // original URL request
                    print(response.response as Any) // URL response
                    print(response.result.value as Any)   //
                    self.sendNotif()
            }
            } else {
                print(like,"user liked this")
            }
        } else {
            print("user did not liked this")

        let params: [String: String] = ["like": "1", "dislike":"0","postId":self.photos[kolodaView.currentCardIndex-1].id!,"userId":self.userId]
        
        Alamofire.request(Utils.baseUrl+"/ratings", method: .post,parameters: params ,encoding: JSONEncoding.default)
            .responseJSON { response in
                
                print(response.request as Any)  // original URL request
                print(response.response as Any) // URL response
                print(response.result.value as Any)   //
                self.sendNotif()
        }
        }
    }
    @IBAction func undoButtonTapped() {
        kolodaView?.revertAction()
        
      
    }
    
    ////////////
    
    @IBAction func OpenProfile(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ProfileNVB") as! ProfileController
        vc.user = userId
        vc.from = "recent"
        self.present(vc, animated: true, completion: nil)
        
        
    }
    
    
    
    //////////////
    
    
    
    
    
    
    func sendNotif(){
       
      
        let params: [String: String] = ["title": "post like state changed", "msg":"some one liked/unliked your post","sound":"some one liked/unliked your post","id":userId];
        print("userid",userId);
        Alamofire.request(Utils.baseUrl+"/posts/senNotif", method: .post, parameters: params, encoding: JSONEncoding.default)
            .responseJSON { response in
                print("request",response.request as Any)  // original URL request
                print("response",response as Any) // URL response
                print("result",response.result.debugDescription as Any)   //
                
        }
    }
}

// MARK: KolodaViewDelegate

extension PostViewController: KolodaViewDelegate {
    
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        /*let position = kolodaView.currentCardIndex
        for i in 1...5 {
            dataSource.append(gogaarray[i])
        }
        kolodaView.insertCardAtIndexRange(position..<position + 4, animated: true)*/
        fetchPhotos()
    }
    
    func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
        //todo : click on a post action
     
        
        
        
            
            
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "SinglePost") as! SinglePostViewController
        vc.post = arrPost[index]
        print("arrpost",arrPost[index].userId)
        vc.like = arrPost[index].totalLike!
        vc.dislike = arrPost[index].totalDislike!
        self.show(vc, sender: nil)
        //self.show(vc, animated: true)
        
        
        
    }
    
}


extension PostViewController{
    
    
    func getPosts(){
        
        /* Alamofire.request("http://192.168.1.4:3000/api/posts").responseJSON { (responseData) -> Void in
         if((responseData.result.value) != nil) {
         let swiftyJsonVar = JSON(responseData.result.value!).arrayObject
         
         if let resData = swiftyJsonVar {
         
         
         print(resData)
         //self.arrRes = resData as! [[String:AnyObject]]
         }
         /*if self.arrRes.count > 0 {
         self.tblJSON.reloadData()
         }*/
         }
         }
         
         
         }*//*
        Alamofire.request("http://localhost:3000/api/posts/withRatings").responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                guard let responseJSON = responseData.result.value as? Array<[String: AnyObject]> else {
                    print(0,"Error reading response")
                    return
                }
                guard let post:[Post] = Mapper<Post>().mapArray(JSONArray: responseJSON) else {
                    print(0,"Error mapping response")
                    return
                }
                self.run = post
            }
        }*/
    }
    
}

// MARK: KolodaViewDataSource

extension PostViewController: KolodaViewDataSource {
    
    
    
    
    
    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        return self.photos.count //self.run.count
    }
    
    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .default
    }
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        
        
        let photoView = Bundle.main.loadNibNamed("KolodaPhotoView",
                                                 owner: self, options: nil)?[0] as? KolodaPhotoView
        let photo = photos[Int(index)]
        
        photoView?.photoImageView?.layer.cornerRadius = 0
        photoView?.photoImageView?.imageFromUrl(Utils.baseUrl+"/attachments/images/download/"+photo.type!)
        photoView?.photoTitleLabel?.text = photo.title
        photoView?.downVoteText.text = photo.totalDislike?.description
        photoView?.upVoteText?.text = photo.totalLike?.description
        return photoView!
        /*
        let cell = Bundle.main.loadNibNamed("PostView", owner: self, options: nil)?.first as? PostView
        let runs = self.run[Int(index)]
        cell!.titleView!.text = "(runs as AnyObject).type"
        return cell!*/
    }
    
    func koloda(_ koloda: KolodaView, viewForCardOverlayAt index: Int) -> OverlayView? {
        return Bundle.main.loadNibNamed("CustomOverlayView", owner: self, options: nil)?[0] as? OverlayView
    }
    
    
    
    
    
    
}

