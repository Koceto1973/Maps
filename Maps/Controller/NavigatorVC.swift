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
    
    var lds:locationDataSet = locationDataSet.init(lat: 0, lon: 0, latD: 1, lonD: 1)
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //print(locations[0])
        lds = locationDataSet.init(lat: locations[0].coordinate.latitude, lon: locations[0].coordinate.longitude, latD: 0.05, lonD: 0.05)
        self.map.setRegion(lds.region, animated: true)
        
        let location = locations[0]
        //self.latitudeLabel.text = String(location.coordinate.latitude)
        //self.longitudeLabel.text = String(location.coordinate.longitude)
        //self.courseLabel.text = String(location.course)
        //self.speedLabel.text = String(location.speed)
        //self.altitudeLabel.text = String(location.altitude)
        
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
                    
                    print(address)  //self.addressLabel.text = address
               }
            }
        }
    }
}
