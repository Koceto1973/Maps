//
//  LocationDataSet.swift
//  Maps
//
//  Created by К.К. on 26.09.18.
//  Copyright © 2018 TeamK. All rights reserved.
//

import Foundation
import MapKit

struct locationDataSet {
    var latitude: CLLocationDegrees
    var longitude: CLLocationDegrees
    var latDelta: CLLocationDegrees
    var lonDelta: CLLocationDegrees 
    var span:MKCoordinateSpan
    var coordinates:CLLocationCoordinate2D
    var region:MKCoordinateRegion
    
    init(lat:CLLocationDegrees, lon:CLLocationDegrees, latD:CLLocationDegrees, lonD:CLLocationDegrees){
        self.latitude = lat
        self.longitude = lon
        self.latDelta = latD
        self.lonDelta = lonD
        self.span = MKCoordinateSpan(latitudeDelta: self.latDelta, longitudeDelta: self.lonDelta)
        self.coordinates = CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
        self.region = MKCoordinateRegion(center: self.coordinates, span: self.span)
    
    }
    
   
   
}


    

