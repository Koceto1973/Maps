//
//  ViewController.swift
//  Maps
//
//  Created by К.К. on 26.09.18.
//  Copyright © 2018 TeamK. All rights reserved.
//

import UIKit
import MapKit

class BasicMapVC: UIViewController, MKMapViewDelegate  {
    
    @IBOutlet var map: MKMapView!
    var lds:locationDataSet = locationDataSet.init(lat: 0, lon: 0, latD: 1, lonD: 1)

    override func viewDidLoad() {
        super.viewDidLoad()
        map.setRegion(lds.region, animated: true)
    }
 
}



    

    
    
    

