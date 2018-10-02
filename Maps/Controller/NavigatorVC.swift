//
//  NavigatorVC.swift
//  Maps
//
//  Created by К.К. on 28.09.18.
//  Copyright © 2018 TeamK. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class NavigatorVC: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var latitude: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var longitude: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var speed: UILabel!
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var course: UILabel!
    @IBOutlet weak var altitudeLabel: UILabel!
    @IBOutlet weak var altitude: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var address: UILabel!
    
    @IBOutlet weak var detailsButton: uiButton!
    @IBAction func detailsClick(_ sender: Any) {
        if detailsFlag {
            detailsButton.setTitle("Show Details", for: UIControl.State.normal)
        } else {
            detailsButton.setTitle("Hide Details", for: UIControl.State.normal)
        }
        
        ToggleDetails(with: detailsFlag)
    }
    
    
    var lds:locationDataSet = locationDataSet.init(lat: 0, lon: 0, latD: 1, lonD: 1)
    
    var locationManager = CLLocationManager()
    
    var detailsFlag:Bool = true
    var placemarks :[[String]] = [[]]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        ToggleDetails(with: detailsFlag)
        
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // reading the permanent storage
        if let data = UserDefaults.standard.object(forKey: "placemarks") as? [[String]] {
            self.placemarks = data
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
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //animate current location
        lds = locationDataSet.init(lat: locations[0].coordinate.latitude, lon: locations[0].coordinate.longitude, latD: 0.05, lonD: 0.05)
        self.map.setRegion(lds.region, animated: true)
        
        let location = locations[0]
        self.latitudeLabel.text = String(location.coordinate.latitude)
        self.longitudeLabel.text = String(location.coordinate.longitude)
        self.courseLabel.text = String(location.course)
        self.speedLabel.text = String(location.speed)
        self.altitudeLabel.text = String(location.altitude)
        
        // address data extraction
        CLGeocoder().reverseGeocodeLocation(location) { (placemarks, error) in
            if error != nil { print(error!) } else {
                if let placemark = placemarks?[0] {
                    var address = ""
                    if placemark.subThoroughfare != nil       { address += placemark.subThoroughfare! + " "        }
                    if placemark.thoroughfare != nil          { address += placemark.thoroughfare! + "\n"          }
                    if placemark.subLocality != nil           { address += placemark.subLocality! + "\n"           }
                    if placemark.subAdministrativeArea != nil { address += placemark.subAdministrativeArea! + "\n" }
                    if placemark.postalCode != nil            { address += placemark.postalCode! + "\n"            }
                    if placemark.country != nil               { address += placemark.country! + "\n"               }
                    
                    self.addressLabel.text = address
               }
            }
        }
    }
    
    func ToggleDetails(with detailsFlag:Bool){
        self.detailsFlag = !detailsFlag
        
        latitudeLabel.isHidden = detailsFlag
        latitude.isHidden = detailsFlag
        longitudeLabel.isHidden = detailsFlag
        longitude.isHidden = detailsFlag
        speedLabel.isHidden = detailsFlag
        speed.isHidden = detailsFlag
        courseLabel.isHidden = detailsFlag
        course.isHidden = detailsFlag
        altitudeLabel.isHidden = detailsFlag
        altitude.isHidden = detailsFlag
        addressLabel.isHidden = detailsFlag
        address.isHidden = detailsFlag
        
        
    }
}
