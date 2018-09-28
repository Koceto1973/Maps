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
        if (lds.latitude+lds.latDelta/2) < 90 && (lds.latitude-lds.latDelta/2) > -90 {
            lds.latDelta = lds.latDelta*1.2
            lds.lonDelta = lds.lonDelta*1.2
            lds = locationDataSet.init(lat: lds.latitude, lon: lds.longitude, latD: lds.latDelta, lonD: lds.lonDelta)
            map.setRegion(lds.region, animated: true)
        }
    }
    
    @IBOutlet weak var WButton: uiButton!
    @IBAction func W(_ sender: Any) {
        lds.longitude -= lds.lonDelta*0.2
        if lds.longitude < -180 {
            lds.longitude += 360
        }
        lds = locationDataSet.init(lat: lds.latitude, lon: lds.longitude, latD: lds.latDelta, lonD: lds.lonDelta)
        map.setRegion(lds.region, animated: true)
    }
    
    @IBOutlet weak var EButton: uiButton!
    @IBAction func E(_ sender: Any) {
        lds.longitude += lds.lonDelta*0.2
        if lds.longitude > 180 {
            lds.longitude -= 360
        }
        lds = locationDataSet.init(lat: lds.latitude, lon: lds.longitude, latD: lds.latDelta, lonD: lds.lonDelta)
        map.setRegion(lds.region, animated: true)
    }
    
    @IBOutlet weak var NButton: uiButton!
    @IBAction func N(_ sender: Any) {
        if (lds.latitude+lds.latDelta/2) < 90  {
            lds.latitude += lds.latDelta*0.2
            lds = locationDataSet.init(lat: lds.latitude, lon: lds.longitude, latD: lds.latDelta, lonD: lds.lonDelta)
            map.setRegion(lds.region, animated: true)
        }
        
    }
    
    @IBOutlet weak var SButton: uiButton!
    @IBAction func S(_ sender: Any) {
        if (lds.latitude-lds.latDelta/2) > -90 {
            lds.latitude -= lds.latDelta*0.2
            lds = locationDataSet.init(lat: lds.latitude, lon: lds.longitude, latD: lds.latDelta, lonD: lds.lonDelta)
            map.setRegion(lds.region, animated: true)
        }
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // to HomeVC
        if let homeVC = segue.destination as? HomeVC {
            homeVC.lds = locationDataSet.init(lat: lds.latitude, lon: lds.longitude, latD: 1, lonD: 1)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
        map.setRegion(lds.region, animated: true)
    }
 
}



    

    
    
    

