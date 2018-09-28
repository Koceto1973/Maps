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
    
    var lds:locationDataSet = locationDataSet.init(lat: 0, lon: 0, latD: 1, lonD: 1)
    
    @IBOutlet var map: MKMapView!
    @IBOutlet weak var ZoomInButton: uiButton!
    @IBAction func ZoomIn(_ sender: Any) {
        lds.latDelta = lds.latDelta*0.8
        lds.lonDelta = lds.lonDelta*0.8
        lds = locationDataSet.init(lat: lds.latitude, lon: lds.longitude, latD: lds.latDelta, lonD: lds.lonDelta)
        map.setRegion(lds.region, animated: true)
    }
    
    @IBOutlet weak var ZoomOutButton: uiButton!
    @IBAction func ZoomOut(_ sender: Any) {
        lds.latDelta = lds.latDelta*1.2
        lds.lonDelta = lds.lonDelta*1.2
        lds = locationDataSet.init(lat: lds.latitude, lon: lds.longitude, latD: lds.latDelta, lonD: lds.lonDelta)
        map.setRegion(lds.region, animated: true)
    }
    
    @IBOutlet weak var LeftButton: uiButton!
    @IBAction func Left(_ sender: Any) {
        lds.longitude -= lds.lonDelta*0.2
        lds = locationDataSet.init(lat: lds.latitude, lon: lds.longitude, latD: lds.latDelta, lonD: lds.lonDelta)
        map.setRegion(lds.region, animated: true)
    }
    
    @IBOutlet weak var RightButton: uiButton!
    @IBAction func Right(_ sender: Any) {
        lds.longitude += lds.lonDelta*0.2
        lds = locationDataSet.init(lat: lds.latitude, lon: lds.longitude, latD: lds.latDelta, lonD: lds.lonDelta)
        map.setRegion(lds.region, animated: true)
    }
    
    @IBOutlet weak var UpButton: uiButton!
    @IBAction func Up(_ sender: Any) {
        lds.latitude += lds.latDelta*0.2
        lds = locationDataSet.init(lat: lds.latitude, lon: lds.longitude, latD: lds.latDelta, lonD: lds.lonDelta)
        map.setRegion(lds.region, animated: true)
    }
    
    @IBOutlet weak var DownButton: uiButton!
    @IBAction func Down(_ sender: Any) {
        lds.latitude -= lds.latDelta*0.2
        lds = locationDataSet.init(lat: lds.latitude, lon: lds.longitude, latD: lds.latDelta, lonD: lds.lonDelta)
        map.setRegion(lds.region, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // to HomeVC
        if let homeVC = segue.destination as? HomeVC {
            homeVC.lds = self.lds
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
        map.setRegion(lds.region, animated: true)
    }
 
}



    

    
    
    

