//
//  RegisterController.swift
//  Goga1
//
//  Created by malek cheikh on 11/21/17.
//  Copyright © 2017 malek cheikh. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
class RegisterController: UIViewController {
    var id: String = ""
    let url = Utils.urlUsers
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var Registerbtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func RegisterAction(_ sender: Any) {
        
        
        if ((username.text?.isEmpty)!)
        {
            let alert = UIAlertController(title: "Alert", message: "USERNAME_REQUIRED", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)}
        if ((email.text?.isEmpty)!){
            let alert = UIAlertController(title: "Alert", message: "EMAIL_REQUIRED", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        if ((password.text?.isEmpty)!){
            let alert = UIAlertController(title: "Alert", message: "PASSWORD_REQUIRED", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
            else{

         SVProgressHUD.show(withStatus: "Connecting...")
        let params: [String: String] = ["username": username.text!, "password":password.text!,"email": email.text!]
       
     //    let param: [String: String] = ["username": username.text!, "password":password.text!,"email": "malek.cheikh@esprit.com"]
        Alamofire.request(url, method: .post,parameters: params ,encoding: JSONEncoding.default)
            .responseJSON { response in
               // print(response.request as Any)  // original URL request
             //   print(response.response as Any) // URL response
              // print(response.result.value as Any)   // result of response serialization
               
                        //debugPrint(response)
                        
                        if let result1 = response.result.value{
                            let JSON = result1 as! NSDictionary
                            let userid = JSON.object(forKey: "id")!
                            
                            self.id = userid as! String
                            print(userid)
                            
                            let defaults = UserDefaults.standard
                            defaults.set(self.id, forKey: "id")

                            
                }
                
                            //let json = try? JSONSerialization.jsonObject(with: data, options: [])     }
               //////////////////////////////
                
                let  code:Int = (response.response?.statusCode as Any as? Int)!
                print (code)
               
                self.Registerverif(code: code)

                ////////
                
                      }
            }}
    
    func Registerverif(code:Int)-> Void {
        
        
        
        if (code == 400){
            SVProgressHUD.dismiss()
            
            let alert = UIAlertController(title: "Alert", message: "USERNAME_EMAIL_REQUIRED", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            
            
        }

        if (code == 400){
            SVProgressHUD.dismiss()

            let alert = UIAlertController(title: "Alert", message: "USERNAME_EMAIL_REQUIRED", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            
            
        }
        else
            if (code == 422){
                SVProgressHUD.dismiss()

                let alert = UIAlertController(title: "Alert", message: "Email or Username already exists", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
            }
            else
                if (code == 200){
                    SVProgressHUD.dismiss()

                  /*  let alert = UIAlertController(title: "WELCOME", message: "Welome To GOGA !! Email Verif is Sended check your Email!!!", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)*/
                  //  let param: [String: String] = ["id": id]
                     let url2 = Utils.urlUsers+"/"+id+"/verify"
                    Alamofire.request(url2, method: .post,encoding: JSONEncoding.default)
                        .responseJSON { response in
                            print(response.request as Any)  // original URL request

                            debugPrint(response)
                           // self.dismiss(animated: true, completion: nil)
                    
                           

                   
        }
        
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "TokenView") as UIViewController
                    self.present(vc, animated: true, completion: nil)
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

