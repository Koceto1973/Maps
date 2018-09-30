//
//  PlacemarksVC.swift
//  Maps
//
//  Created by К.К. on 30.09.18.
//  Copyright © 2018 TeamK. All rights reserved.
//

import UIKit

class PlacemarksVC: UIViewController {
    
    var placemarks = Placemarks.init()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // reading the permanent storage
        if let data = UserDefaults.standard.object(forKey: "placemarks") as? Placemarks {
            self.placemarks = data
        }
        
    }
    
    // UserDefaults.standard.set("data", forKey: "keyToData")
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
