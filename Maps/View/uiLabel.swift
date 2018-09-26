//
//  uiLabel.swift
//  Maps
//
//  Created by К.К. on 26.09.18.
//  Copyright © 2018 TeamK. All rights reserved.
//

import Foundation
import UIKit

class uiLabel:UILabel {
    
    override func awakeFromNib() {
        super.awakeFromNib()  // super func to be called first
        
        layer.backgroundColor = UIColor.lightGray.cgColor
        self.textColor = UIColor.white
        layer.borderColor = UIColor.orange.cgColor
        layer.borderWidth = 2.0
        layer.cornerRadius = 5
    }
    
}
