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
    
    var placemarks: [[String]] = [[]]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let uilpgr = UILongPressGestureRecognizer(target: self, action: #selector(self.longpress(gestureRecognizer:)))
        uilpgr.minimumPressDuration = 2
        map.addGestureRecognizer(uilpgr)
        
        // reading the permanent storage
        if let data = UserDefaults.standard.object(forKey: "placemarks") as? [[String]] {
            self.placemarks = data
        }
        if placemarks.count != 0 {
            if placemarks[0].count == 0 {
                placemarks.remove(at: 0)
                UserDefaults.standard.set(self.placemarks, forKey: "placemarks")
            }
        }
        
    }
    
    var annotationIndex = -1
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // reading the permanent storage
        if let data = UserDefaults.standard.object(forKey: "placemarks") as? [[String]] {
            self.placemarks = data
        }
        
        // show selected annotation from PlacemarksVC table
        if annotationIndex != -1 {
            // add anotation to updated map
            let latitude = Double(self.placemarks[annotationIndex][1])!
            let longitude = Double(self.placemarks[annotationIndex][2])!
            lds = locationDataSet.init(lat: latitude, lon: longitude, latD: 0.05, lonD: 0.05)
            map.setRegion(lds.region, animated: true)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate.latitude = latitude
            annotation.coordinate.longitude = longitude
            annotation.title = self.placemarks[annotationIndex][0]
            self.map.addAnnotation(annotation)
            
            self.annotationIndex = -1
        }
    }
    
    // map annotation add by long press gesture recognizer
    @objc func longpress(gestureRecognizer: UIGestureRecognizer) {
        if gestureRecognizer.state == UIGestureRecognizer.State.began {
            let touchPoint = gestureRecognizer.location(in: self.map)
            let newCoordinate = self.map.convert(touchPoint, toCoordinateFrom: self.map)
            let location = CLLocation(latitude: newCoordinate.latitude, longitude: newCoordinate.longitude)
            var title = ""
            
            CLGeocoder().reverseGeocodeLocation(location, completionHandler: { (places, error) in
                if error != nil { print(error!)  } else {
                    if let place = places?[0] {
                        if place.subThoroughfare != nil { title += place.subThoroughfare! + " " }
                        if place.thoroughfare != nil { title += place.thoroughfare! }
                    }
                }
                // add anotation to map
                if title == "" { title = "Added \(NSDate())" }
                let annotation = MKPointAnnotation()
                annotation.coordinate = newCoordinate
                annotation.title = title
                self.map.addAnnotation(annotation)
                // update storage
                self.placemarks.append([title,String(newCoordinate.latitude),String(newCoordinate.longitude)])
                UserDefaults.standard.set(self.placemarks, forKey: "placemarks")
            })
        }
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



    

    
    
    

