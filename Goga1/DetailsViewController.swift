//
//  DetailsViewController.swift
//  Goga1
//
//  Created by malek cheikh on 1/8/18.
//  Copyright © 2018 malek cheikh. All rights reserved.
//

import UIKit
import Alamofire

class DetailsViewController: UIViewController {

    @IBOutlet weak var imagedetail: UIImageView!
    @IBOutlet weak var titre: UILabel!
   
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var category: UILabel!
    var currentpost = Posts()
    var strTemp:String = ""
    var date1:String = ""
    var category1:String = ""
    //var strTemp:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        titre.text = currentpost.getTitle()
        date.text = currentpost.getdatepublication()
        category.text = currentpost.getcategory()
        imagedetail.imageFromUrl1(Utils.urlAttachement + "/images/download/"+currentpost.gettype())
        //titre.text = strTemp
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func DeletePost(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Post:"+currentpost.getTitle(), message: "Do you want delete this Post?", preferredStyle: UIAlertControllerStyle.alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) { (result : UIAlertAction) -> Void in
            print("Cancel")
            //////////////
            
          
            ////////////
        }
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
            print("OK")
            //////////
            
            let url = Utils.urlPost+"/"+self.currentpost.getId()
            
            print (url)
            
            Alamofire.request(url, method: .delete ,parameters: nil ,encoding: JSONEncoding.default)
                .responseJSON { response in
                    print(response.request as Any)  // original URL request
                    print(response.response as Any) // URL response
                    print(response.result.value as Any)   // result of response serialization
                    
                    
                    // print(response.response?.statusCode as Any)
                    
                    let  code:Int = (response.response?.statusCode as Any as? Int)!
                    print (code)
                    if (code == 200){
                        //   var user:User?
                        print("delete ok")
                        
                        
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: "ProfileNVB") as UIViewController
                        
                        self.present(vc, animated: true, completion: nil)
                        self.dismiss(animated: true, completion: nil)
                        
                    }
                    }

            
            /////////
        }
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
        
      
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
    @IBAction func ReProfile(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ProfileNVB") as! ProfileController
        vc.user = currentpost.getuserId()
        
        self.present(vc, animated: true, completion: nil)
        
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

