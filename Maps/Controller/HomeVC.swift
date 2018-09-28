//
//  ViewController.swift
//  Maps
//
//  Created by К.К. on 26.09.18.
//  Copyright © 2018 TeamK. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    // latitude interface
    @IBOutlet weak var latitudeLabel: uiLabel!
    @IBOutlet weak var latitudeSlider: uiSlider!
    @IBAction func latitudeChanged(_ sender: Any) {
        latitudeLabel.text = String(latitudeSlider.value)
    }
    // longitude interface
    @IBOutlet weak var longitudeLabel: uiLabel!
    @IBOutlet weak var longitudeSlider: uiSlider!
    @IBAction func longitudeChanged(_ sender: Any) {
        longitudeLabel.text = String(longitudeSlider.value)
    }
    // latitude delta interface
    @IBOutlet weak var latitudeDeltaLabel: uiLabel!
    @IBOutlet weak var latitudeDeltaSlider: uiSlider!
    @IBAction func latitudeDeltaChanged(_ sender: Any) {
        latitudeDeltaLabel.text = String(latitudeDeltaSlider.value)
    }
    // longitude delta interface
    @IBOutlet weak var longitudeDeltaLabel: uiLabel!
    @IBOutlet weak var longitudeDeltaSlider: uiSlider!
    @IBAction func longitudeDeltaChanged(_ sender: Any) {
        longitudeDeltaLabel.text = String(longitudeDeltaSlider.value)
    }
 
    var lds:locationDataSet = locationDataSet.init(lat: 0, lon: 0, latD: 1, lonD: 1)
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // to BasicMapVC
        if segue.identifier == "HomeVCsegueBasicMapVC" {
            self.lds = locationDataSet.init(lat: Double(latitudeLabel.text!)!, lon: Double(longitudeLabel.text!)!, latD: Double(latitudeDeltaLabel.text!)!, lonD: Double(longitudeDeltaLabel.text!)!)
            let basicMapVC = segue.destination as! BasicMapVC
            basicMapVC.lds = lds
        }
    }
    
    // back from BasicMapVC
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.latitudeLabel.text = String(lds.latitude)
        self.latitudeSlider.setValue(Float(lds.latitude), animated: true )
        self.longitudeLabel.text = String(lds.longitude)
        self.longitudeSlider.setValue(Float(lds.longitude), animated: true )
        self.latitudeDeltaLabel.text = String(lds.latDelta)
        self.latitudeSlider.setValue(Float(lds.latDelta), animated: true )
        self.longitudeDeltaLabel.text = String(lds.lonDelta)
        self.longitudeDeltaSlider.setValue(Float(lds.lonDelta), animated: true )
   }
    
    
}

