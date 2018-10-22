//
//  BaseView.swift
//  GoGa
//
//  Created by Khmaies Hassen on 11/15/17.
//  Copyright © 2017 Khmaies Hassen. All rights reserved.
//

import Foundation
import UIKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews() {
        //perform UI configuration by overriding class
    }
}

