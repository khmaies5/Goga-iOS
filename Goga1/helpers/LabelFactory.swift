//
//  LabelFactory.swift
//  GoGa
//
//  Created by Khmaies Hassen on 11/15/17.
//  Copyright © 2017 Khmaies Hassen. All rights reserved.
//


import Foundation
import UIKit

enum LabelFactory {
    
    case standardLabel(text: String, textColor: UIColor, fontStyle: UIFontTextStyle, textAlignment: NSTextAlignment?, sizeToFit: Bool, adjustToFit: Bool)
    
    var new: UILabel {
        
        switch self {
        case .standardLabel(let text,let textColor,let fontStyle, let textAlignment,let sizeToFit, let adjustToFit):
            return createStandardLabel(text: text, textColor: textColor, fontStyle: fontStyle, textAlignment: textAlignment, sizeToFit: sizeToFit, adjustToFit: adjustToFit)
        }
    }
    
    private func createStandardLabel(text: String, textColor: UIColor, fontStyle: UIFontTextStyle, textAlignment: NSTextAlignment?, sizeToFit: Bool, adjustToFit: Bool) -> UILabel {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = adjustToFit
        label.text = text
        label.font = UIFont.preferredFont(forTextStyle: fontStyle)
        label.textAlignment = textAlignment ?? .left
        label.textColor = textColor
        if sizeToFit {
            label.sizeToFit()
        }
        return label
    }
}

