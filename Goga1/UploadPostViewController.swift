//
//  UploadPostViewController.swift
//  Goga1
//
//  Created by Khmaies Hassen on 11/29/17.
//  Copyright © 2017 malek cheikh. All rights reserved.
//

import UIKit
import Alamofire
import MobileCoreServices
import AssetsLibrary
import PopupDialog
import FirebaseMessaging


class UploadPostViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate  {

    @IBOutlet weak var selectImage: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descField: UITextView!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var uploadPostBtnN: UIButton!
    var userId : String!
    var imageToUpload : UIImage!
    var imageName : String!
    var imageURL : URL!//(string : "http://www.localhost.png")!
    var fileExtenion : String!
    var mimetype : String!
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        let id:String = defaults.string(forKey: "id")!
        userId = id
        let notificationCenter = NotificationCenter.default
        
        if Messaging.messaging().fcmToken != nil {
            Messaging.messaging().subscribe(toTopic: "maw")
        }
        guard !UIImagePickerController.isSourceTypeAvailable(.camera) else { return }

        selectImage.setTitle("Select Photo", for: .normal)
       self.hideKeyboardWhenTappedAround()
    }

    @IBAction func next(_ sender: Any) {
        
       showCustomDialog()
    }
    
    
    func showCustomDialog(animated: Bool = true) {
        
        // Create a custom view controller
        let ratingVC = NextPopUpViewController(nibName: "NextPopUpViewController", bundle: nil)
        
        // Create the dialog
        let popup = PopupDialog(viewController: ratingVC, buttonAlignment: .horizontal, transitionStyle: .bounceDown, gestureDismissal: true)
        
        // Create first button
        let buttonOne = CancelButton(title: "CANCEL", height: 60) {
            //self.label.text = "You canceled the dialog"
        }
        
        // Create second button
        let buttonTwo = DefaultButton(title: "Upload", height: 60) {
            //self.label.text = "You rated \(ratingVC.cosmosStarRating.rating) stars"
           // ratingVC.pickedItem
        }
        
        // Add buttons to dialog
        popup.addButtons([buttonOne, buttonTwo])
        
        // Present dialog
        present(popup, animated: animated, completion: nil)
    }
    
    
    
    @IBAction func uploadPostBtn(_ sender: Any) {
        self.selectImage.isHidden = true
        //let image = UIImage.init(named: "myImage")
        
        //let image = UIImage(data: try! Data(contentsOf: imageURL))!
        /*if let jpegData = image.jpeg {
            print(jpegData.count) // 416318   number of bytes contained by the data object
            if let imageFromData =  jpegData.uiImage {
                print(imageFromData.size)  // (719.0, 808.0)
            }
        }
        if let pngData = image.png {
            print(pngData.count)  // 1282319
            if let imageFromData =  pngData.uiImage {
                print(imageFromData.size)  // (719.0, 808.0)
            }
        }*/
        //Data(buffer: UnsafeBufferPointer(start: &imageToUpload, count: 1))//
        
        
        let imgData = try! Data(contentsOf: imageURL) //UIImagePNGRepresentation(imageToUpload!)!
        
        
        self.imageName = randomAlphaNumericString(length: 10)
        //let parameters = ["name": rname]
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imgData, withName: "fileset",fileName: self.imageName + self.fileExtenion, mimeType: self.mimetype)
            
        },
                         to:Utils.baseUrl+"/attachments/images/upload")
        { (result) in
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (progress) in
                    print("Upload Progress: \(progress.fractionCompleted)")
                    self.progressView.progress = Float(progress.fractionCompleted)
                })
                
                upload.responseJSON { response in
                    self.activityIndicatorView.stopAnimating()
                    
                    let parameters: Parameters = [
                    
                        "title": self.descField.text,
                        
                        
                        "type": self.imageName + self.fileExtenion,
                        
                        "userId": self.userId!
                        
                    ]
                    
                    let url = Utils.baseUrl+"/posts"
                    
                    Alamofire.request(url, method:.post, parameters:parameters).responseJSON { response in
                        switch response.result {
                        case .success:
                            debugPrint(response)
                            Messaging.messaging().subscribe(toTopic: String(describing: self.userId!) )
                        case .failure(let error):
                            print(error)
                        }
                        self.selectImage.isHidden = false

                    }
                    
                }
                
            case .failure(let encodingError):
                print(encodingError.localizedDescription)
                self.selectImage.isHidden = false

            }
        }
        
        
        
    }
    func sendNotif(){
        
        
        let params: [String: String] = ["title": "post like state changed", "msg":"some one liked/unliked your post","sound":"some one liked/unliked your post","id":"subscribe"+userId];
        print("userid",userId);
        Alamofire.request(Utils.baseUrl+"/posts/senNotif", method: .post, parameters: params, encoding: JSONEncoding.default)
            .responseJSON { response in
                print("request",response.request as Any)  // original URL request
                print("response",response as Any) // URL response
                print("result",response.result.debugDescription as Any)   //
                
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        imageView.image = nil
        imageToUpload = nil
        imageView.isUserInteractionEnabled = true
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        imageView.addGestureRecognizer(tapRecognizer)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imageTapped(sender: UIImageView) {
        print("image tapped")
    
       // let tappedImage = tapGestureRecognizer.view as! UIImageView
        
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.allowsEditing = true
        
        
        
            //for video in gallery picker.mediaTypes = [kUTTypeMovie as! String]
            picker.sourceType = .photoLibrary
            picker.modalPresentationStyle = .fullScreen
        
        
        present(picker, animated: true)
    }
   
    @IBAction func selectImageClick(_ sender: UIButton) {
        
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.allowsEditing = true
        
        
       
            //for video in gallery picker.mediaTypes = [kUTTypeMovie as! String]
            picker.sourceType = .photoLibrary
            picker.modalPresentationStyle = .fullScreen
        
        
        present(picker, animated: true)
        
    }
}

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

// MARK: - UIImagePickerControllerDelegate
extension UploadPostViewController {
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            print("Info did not have the required UIImage for the Original Image")
            dismiss(animated: true)
            return
        }
        if #available(iOS 11.0, *) {
            guard let imageUrl = info[UIImagePickerControllerImageURL] as? URL else { //  UIImagePickerControllerReferenceURL
                print("info did not have the required URL for the Original image")
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
            let imageURL = info[UIImagePickerControllerReferenceURL] as! NSURL
            let imagePath =  imageURL.path!
            let localPath = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(imagePath)
            print("local path : ",localPath)

        }
        imageView.image = image
        imageToUpload = image
        
       
        
        
        progressView.progress = 0.0
        progressView.isHidden = false
        activityIndicatorView.startAnimating()
        
        
        dismiss(animated: true)
        
        
        
        
        
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

