//
//  ViewController.swift
//  Goga1
//
//  Created by malek cheikh on 11/15/17.
//  Copyright © 2017 malek cheikh. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
import Firebase


class ViewController: UIViewController {
    
    
    //let url = "http://localhost:3000/api/users/login"
    
    var url = Utils.urlUsers+"/login"
    @IBOutlet weak var login: UIButton!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var username: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
                      //login when clicking on done in the keyboard
        //self.password.delegate = self

        // Do any additional setup after loading the view, typically from a nib.
    }

    
    @IBAction func connect(_ sender: Any) {
        
        if ((username.text?.isEmpty)!)
        {
            let alert = UIAlertController(title: "Alert", message: "USERNAME_REQUIRED", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)}
        if ((password.text?.isEmpty)!){
            let alert = UIAlertController(title: "Alert", message: "PASSWORD_REQUIRED", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else{

      
        SVProgressHUD.show(withStatus: "Connecting...")

       
        
         let params: [String: String] = ["username": username.text!, "password":password.text!]
       
        Alamofire.request(url, method: .post,parameters: params ,encoding: JSONEncoding.default)
            .responseJSON { response in
           //  print(response.request as Any)  // original URL request
             //  print(response.response as Any) // URL response
           //  print(response.result.value as! JSONEncoding)   // result of response serialization
                let a: Bool = response.result.value.debugDescription.contains("LOGIN_FAILED_EMAIL_NOT_VERIFIED")
                print(a)
               // print(response.response?.statusCode as Any)
                
                let  code:Int = (response.response?.statusCode as Any as? Int)!
                print (code)
                /////////////////////////////////
                
                
                
                if (code == 400){
                    SVProgressHUD.dismiss()
                    let alert = UIAlertController(title: "Alert", message: "Veuillez introduire votre username and password SVP!!", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                    
                    
                }
                else
                    if (code == 401 ){
                        if (a == true){
                        SVProgressHUD.dismiss()
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let vc = storyboard.instantiateViewController(withIdentifier: "TokenView") as UIViewController
                            self.present(vc, animated: true, completion: nil)

                        
                        }
                        else{
                        SVProgressHUD.dismiss()
                        let alert = UIAlertController(title: "Alert", message: "Username or Password is Invalid!!", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        }
                    }
                    else
                        if (code == 200){
                            SVProgressHUD.dismiss()
                            //  let alert = UIAlertController(title: "WELCOME", message: "Welome To GOGA !!", preferredStyle: UIAlertControllerStyle.alert)
                            //   alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
                            //     self.present(alert, animated: true, completion: nil)
                            // Set a var in your appDelegate
                            
                            // user?.firstName =
                            //  user
                            
                            // Accessing it from any view
                            let user = response.result.value  as! NSDictionary
                            
                            let id:String = user.object(forKey: "userId")! as! String
                            
                            let defaults = UserDefaults.standard
                            defaults.set(id, forKey: "id")
                            defaults.set(true, forKey: "USERISLOGIN")
                            
                            
                           /* let json :[String : Any] = [
                                "id":id
                                
                            ]*/

                            Messaging.messaging().subscribe(toTopic: id)

                            
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let vc = storyboard.instantiateViewController(withIdentifier: "NewsDetailsVCID") as! UITabBarController
                            self.present(vc, animated: true, completion: nil)
                            
                }
                
                
                //////////////////////////
            /*  if (code == 200){
                //   var user:User?
                let user = response.result.value  as! NSDictionary
                
                let id:String = user.object(forKey: "userId")! as! String
                
                let defaults = UserDefaults.standard
                defaults.set(id, forKey: "id")
                
                
                
                let json :[String : Any] = [
                    "id":id
                    
                ]
                 //       let JSON = response.result.value as! NSDictionary
                    //     user? = JSON.object(forKey: "id")! as! User
                    //   let id = user as! String
                    //    print(user)

        
                }
                loginverif(code: code)*/
               
             //   let data:[String:AnyObject] = response.result. as! [String : AnyObject]
             //  print(data["status code"]!)
                
              
                ///////////////////////////
                
        }
        }
        
                
          
   /* func loginverif(code:Int)-> Void {
        
        if (code == 400){
            SVProgressHUD.dismiss()
            let alert = UIAlertController(title: "Alert", message: "Veuillez introduire votre username and password SVP!!", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            

            
        }
        else
            if (code == 401){
                 SVProgressHUD.dismiss()
                let alert = UIAlertController(title: "Alert", message: "Username or Password is Invalid!!", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                }
            else
            if (code == 200){
               SVProgressHUD.dismiss()
              //  let alert = UIAlertController(title: "WELCOME", message: "Welome To GOGA !!", preferredStyle: UIAlertControllerStyle.alert)
             //   alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
           //     self.present(alert, animated: true, completion: nil)
                // Set a var in your appDelegate
               
               // user?.firstName =
              //  user
               
                // Accessing it from any view
             
                
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "NewsDetailsVCID") as UIViewController
                self.present(vc, animated: true, completion: nil)
                
                           }

   
    }*/


    }
}

    

   
//hide keyboard when taped anywhere
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

//login when clicking on done in the keyboard
/*extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == password {
            
            let params: [String: String] = ["username": username.text!, "password":password.text!]
            Alamofire.request(url, method: .post,parameters: params ,encoding: JSONEncoding.default)
                .responseJSON { response in
                    print(response.request as Any)  // original URL request
                    print(response.response as Any) // URL response
                    print(response.result.value as Any)   // result of response serialization
            }
            
            return false
        }
        return true
    }
    
}*/
