//
//  ProfileUserViewController.swift
//  Goga1
//
//  Created by khmaies hassen on 1/11/18.
//  Copyright © 2018 malek cheikh. All rights reserved.
//

import Foundation
import UIKit
import LFTwitterProfile
import AVFoundation


class ProfileUserViewController: TwitterProfileViewController {
    
    var tweetTableView: UITableView!
    var photosTableView: UITableView!
    var favoritesTableView: UITableView!


    var custom: UIView!
    var label: UILabel!
    
    
    override func numberOfSegments() -> Int {
        return 1
    }
    
    override func segmentTitle(forSegment index: Int) -> String {
        
        var title:String?
        if (index == 0)
        {title = "tweet"}
        if(index == 1)
        {title = "photo"}
        if(index == 2)
        {title = "favorite"}

        return title!
    }
    
    override func prepareForLayout() {
        // TableViews
        let _tweetTableView = UITableView(frame: CGRect.zero, style: .plain)
        self.tweetTableView = _tweetTableView
        
        let _photosTableView = UITableView(frame: CGRect.zero, style: .plain)
        self.photosTableView = _photosTableView
        
        let _favoritesTableView = UITableView(frame: CGRect.zero, style: .plain)
        self.favoritesTableView = _favoritesTableView
        /* let layout =  PinterestLayout()
         print("layout")
         layout.delegate = self*/
        
        
        

        
        
        
        
        
        self.setupTables()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationString = "Hong Kong"
        self.username = "khmaies"
        
        self.profileImage = UIImage.init(named: "background3.png")
        
        setupTables()
    }
    
    override func scrollView(forSegment index: Int) -> UIScrollView {
       return photosTableView
    }
}



// MARK: UITableViewDelegates & DataSources
extension ProfileUserViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    
    
    
    fileprivate func setupTables() {
        self.tweetTableView.delegate = self
        self.tweetTableView.dataSource = self
        self.tweetTableView.register(UITableViewCell.self, forCellReuseIdentifier: "tweetCell")
        
        self.photosTableView.delegate = self
        self.photosTableView.dataSource = self
        //self.photosTableView.isHidden = true
        self.photosTableView.register(UITableViewCell.self, forCellReuseIdentifier: "photoCell")
        
        self.favoritesTableView.delegate = self
        self.favoritesTableView.dataSource = self
        //self.favoritesTableView.isHidden = true
        self.favoritesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "favCell")
        
        
     
    }
    
  
    
    
    
    
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case self.tweetTableView:
            return 30
        case self.photosTableView:
            return 10
        case self.favoritesTableView:
            return 0
        default:
            return 10
        }
    }
    
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case self.tweetTableView:
            let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath)
            cell.textLabel?.text = "Row \(indexPath.row)"
            
            return cell
            
        case self.photosTableView:
            let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell", for: indexPath)
            cell.textLabel?.text = "Photo \(indexPath.row)"
            return cell
            
        case self.favoritesTableView:
            let cell = tableView.dequeueReusableCell(withIdentifier: "favCell", for: indexPath)
            cell.textLabel?.text = "Fav \(indexPath.row)"
            return cell
            
        default:
            return UITableViewCell()
        }
    }
}





