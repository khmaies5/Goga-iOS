//
//  PostView.swift
//  Goga1
//
//  Created by Khmaies Hassen on 11/23/17.
//  Copyright © 2017 malek cheikh. All rights reserved.
//

import UIKit

class PostView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var infoContainerView: UIView!
    
   
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false

        commonInit()
    }
    
    /*class func createMyClassView() -> PostView {
        let myClassNib = UINib(nibName: "PostView", bundle: nil)
        return myClassNib.instantiate(withOwner: nil, options: nil)[0] as! PostView
    }*/
    
   required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    
    titleView.translatesAutoresizingMaskIntoConstraints = false
    titleView.adjustsFontSizeToFitWidth = true
    //titleView.text = text
    titleView.font = UIFont.preferredFont(forTextStyle: .subheadline)
    //titleView.textAlignment = textAlignment ?? .left
    //titleView.textColor = textColor
    
    titleView.sizeToFit()
    
    
    
    //imageView.image = image
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.layer.cornerRadius = 0
    imageView.clipsToBounds = true
    imageView.isUserInteractionEnabled = true
    imageView.contentMode = .scaleAspectFill
    
    
    
    contentView.backgroundColor = .white
    contentView.layer.cornerRadius = 10.0
    contentView.layer.borderWidth = 0.5
    contentView.layer.borderColor = UIColor.gray.cgColor
    contentView.clipsToBounds = true
    
    
    commonInit()
    }
    
    private func commonInit(){
        Bundle.main.loadNibNamed("PostView", owner: self, options: nil)
        addSubview(contentView)
        //contentView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        
        
      /*  let infoContainerViewMargins = infoContainerView.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            
           /* contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.widthAnchor.constraint(equalTo: widthAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),*/
            
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.85),
            
            infoContainerView.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            infoContainerView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            infoContainerView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            infoContainerView.widthAnchor.constraint(equalTo: imageView.widthAnchor),
            
           
            titleView.leadingAnchor.constraint(equalTo: infoContainerViewMargins.leadingAnchor),
            titleView.topAnchor.constraint(equalTo: infoContainerViewMargins.topAnchor),
            
         
            
            ])*/
    }
    
    

    @IBAction func commentView(_ sender: Any) {
    }
}

/*extension PostView{
    func test(){
        
        commonInit()
    }
}*/
