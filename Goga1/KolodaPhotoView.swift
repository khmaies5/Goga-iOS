//
//  KolodaPhotoView.swift
//  Goga1
//
//  Created by Khmaies Hassen on 11/29/17.
//  Copyright © 2017 malek cheikh. All rights reserved.
//
import UIKit
import SwiftGifOrigin

extension UIImageView {
    public func imageFromUrl(_ urlString: String) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main, completionHandler: {[unowned self] response, data, error in
                
                   let gif = UIImage.gif(url: urlString)
                    self.image = gif
                    
                
            })
        }
    }
}

class KolodaPhotoView: UIView {
    
    @IBOutlet var photoImageView: UIImageView?
    @IBOutlet var photoTitleLabel: UILabel?
    @IBOutlet weak var upVoteImageView: UIImageView!
    @IBOutlet weak var upVoteText: UILabel!
    @IBOutlet weak var downVoteImageView: UIImageView!
    @IBOutlet weak var downVoteText: UILabel!
    
    
}
