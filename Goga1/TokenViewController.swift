//
//  TokenViewController.swift
//  Goga1
//
//  Created by malek cheikh on 1/8/18.
//  Copyright © 2018 malek cheikh. All rights reserved.
//

import UIKit
import Alamofire

class TokenViewController: UIViewController {

    @IBOutlet weak var Tokentext: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
          }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
}
    
    @IBAction func Logout(_ sender: Any) {
        let defaults = UserDefaults.standard
        defaults.set(false, forKey: "USERISLOGIN")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LoginView") as UIViewController
        self.present(vc, animated: true, completion: nil)

        
    }
    
    
    @IBAction func sendToken(_ sender: Any) {
        
        
        let url = Utils.urlUsers+"/confirm"
        
        let defaults = UserDefaults.standard
       let  id : String = defaults.string(forKey: "id")!
      /*  let json :[String : Any] = [
            "uid": id,
            "token": Tokentext.text]*/
        
        let params: [String: String] = ["uid": id, "token":Tokentext.text]


   Alamofire.request(url, method: .get,parameters: params ,encoding: JSONEncoding.default)
 .responseJSON { response in
 
 //to get JSON return value
 print(response.result.value as Any)
    let  code : Int = (response.response!.statusCode as Int)
    if (code == 204){
        
        
       /* let alert = UIAlertController(title: "WELCOME", message: "Welome To GOGA !! ", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)*/
        //  let param: [String: String] = ["id": id]
        
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "LoginView") as UIViewController
                self.present(vc, animated: true, completion: nil)
                
                
        }
    else{
        let alert = UIAlertController(title: "Alert", message: "Check your token", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
