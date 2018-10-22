//
//  GogaPostView.swift
//  GoGa
//
//  Created by Khmaies Hassen on 11/15/17.
//  Copyright © 2017 Khmaies Hassen. All rights reserved.
//
import Foundation
import UIKit
import Alamofire
import SwiftyJSON

var pi : LabelFactory?

class GogaPostView: BaseView {
    
   

    
    
    
    
    
    let profileImageView = ImageViewFactory.standardImageView(image: #imageLiteral(resourceName: "cards_3"), cornerRadius: 0, interactionEnabled: true, contentMode: .scaleAspectFill, sizeToFit: false).new
    
    let friendsIconView = ImageViewFactory.standardImageView(image: #imageLiteral(resourceName: "icon-comment"), cornerRadius: 0, interactionEnabled: false, contentMode: .scaleAspectFill, sizeToFit: false).new
    
    let containerView: BaseView = {
        let v = BaseView()
        v.backgroundColor = .white
        v.layer.cornerRadius = 10.0
        v.layer.borderWidth = 0.5
        v.layer.borderColor = UIColor.gray.cgColor
        v.clipsToBounds = true
       
        return v
    }()
    
    let infoContainerView: BaseView = {
        let v = BaseView()
        
        return v
    }()
    
    var nameLabel : UILabel!
    
    let workLabel = LabelFactory.standardLabel(text: "Member of the Alliance to Restore the Republic", textColor: .gray, fontStyle: .subheadline, textAlignment: .left, sizeToFit: true, adjustToFit: true).new
    
    
    
    
    override func setUpViews() {
       // nameLabel = LabelFactory.standardLabel(text: "Member of the Alliance to Restore the Republic", textColor: .gray, fontStyle: .subheadline, textAlignment: .left, sizeToFit: true, adjustToFit: true).new
        addSubview(containerView)
        containerView.addSubview(profileImageView)
        containerView.addSubview(infoContainerView)
        infoContainerView.addSubview(nameLabel)
        infoContainerView.addSubview(workLabel)
        infoContainerView.addSubview(friendsIconView)
        
        let infoContainerViewMargins = infoContainerView.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.widthAnchor.constraint(equalTo: widthAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            profileImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            profileImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            profileImageView.widthAnchor.constraint(equalTo: containerView.widthAnchor),
            profileImageView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.85),
            
            infoContainerView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor),
            infoContainerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            infoContainerView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            infoContainerView.widthAnchor.constraint(equalTo: containerView.widthAnchor),
            
            friendsIconView.centerYAnchor.constraint(equalTo: infoContainerViewMargins.centerYAnchor),
            friendsIconView.heightAnchor.constraint(equalTo: infoContainerViewMargins.heightAnchor, multiplier: 0.7),
            friendsIconView.widthAnchor.constraint(equalTo: friendsIconView.heightAnchor),
            friendsIconView.trailingAnchor.constraint(equalTo: infoContainerViewMargins.trailingAnchor),
            
            nameLabel.leadingAnchor.constraint(equalTo: infoContainerViewMargins.leadingAnchor),
            nameLabel.topAnchor.constraint(equalTo: infoContainerViewMargins.topAnchor),
            
            workLabel.leadingAnchor.constraint(equalTo: infoContainerViewMargins.leadingAnchor),
            workLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            workLabel.trailingAnchor.constraint(equalTo: friendsIconView.leadingAnchor, constant: -20)
            
            ])
    }
}


    
  

