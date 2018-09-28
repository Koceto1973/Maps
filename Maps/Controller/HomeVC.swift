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
        if segue.identifier == "HomeVCsegueBasicMapVC" {
            self.lds = locationDataSet.init(lat: Double(latitudeLabel.text!)!, lon: Double(longitudeLabel.text!)!, latD: Double(latitudeDeltaLabel.text!)!, lonD: Double(longitudeDeltaLabel.text!)!)
            let basicMapVC = segue.destination as! BasicMapVC
            basicMapVC.lds = lds
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.latitudeLabel.text = String(lds.latitude)
        self.latitudeSlider.value = Float(lds.latitude)
        self.longitudeLabel.text = String(lds.longitude)
        self.longitudeSlider.value = Float(lds.longitude)
        self.latitudeDeltaLabel.text = String(lds.latDelta)
        self.latitudeSlider.value = Float(lds.latDelta)
        self.longitudeDeltaLabel.text = String(lds.lonDelta)
        self.longitudeDeltaSlider.value = Float(lds.lonDelta)
        
             
    }
    
    
}

