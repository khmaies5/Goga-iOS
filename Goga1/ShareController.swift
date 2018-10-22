//
//  ShareController.swift
//  Goga1
//
//  Created by malek cheikh on 11/25/17.
//  Copyright © 2017 malek cheikh. All rights reserved.
//

import UIKit
import Alamofire
import Social

class ShareController: UIViewController {

    @IBAction func ShareButton(_ sender: Any) {
        
        let alert = UIAlertController(title: "Share", message:"Share your GAG", preferredStyle: .actionSheet)
        
        let actionOne = UIAlertAction(title: "Share with Facebook", style: .default) { (action) in
            if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeFacebook)
            {
                
                let post = SLComposeViewController(forServiceType: SLServiceTypeFacebook)!
                post.setInitialText("Post Of the Day")
                
                
                //// here ya khmaies bech taadi les champs mtaa l post/////
                post.add(UIImage(named:"goga.jpg"))
                self.present(post, animated: true, completion: nil)
            }
            else{self.showAlert(service: "Facebook")}}
            
            
            let actionTwo = UIAlertAction(title: "Share with Twitter", style: .default) { (action) in
                if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter)
                {
                    
                    let post = SLComposeViewController(forServiceType: SLServiceTypeTwitter)!
                    post.setInitialText("Post Of the Day")
                    post.add(UIImage(named:"goga.jpg"))
                    self.present(post, animated: true, completion: nil)
                }
                else{self.showAlert(service: "Twitter")}
        }
        let actionThree = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(actionOne)
            alert.addAction(actionTwo)
            alert.addAction(actionThree)
            self.present(alert, animated: true, completion: nil)
        }
        
        
    
    func showAlert(service: String)
    {
        let alert = UIAlertController(title: "Erreur", message:"You are not connected to \(service)", preferredStyle: .alert)
        
        let actionOne = UIAlertAction(title: "Dissmis", style: .cancel , handler: nil)
        alert.addAction(actionOne)
        present(alert, animated: true, completion: nil)
        
    }
  
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
