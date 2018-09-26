//
//  uiButton.swift
//  Maps
//
//  Created by К.К. on 26.09.18.
//  Copyright © 2018 TeamK. All rights reserved.
//

import Foundation
import UIKit

class uiButton:UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()  // super func to be called first
        
        layer.backgroundColor = UIColor.blue.cgColor
        self.setTitleColor(UIColor.white, for: UIControl.State.normal)
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 2.0
        layer.cornerRadius = 10
    }

}
