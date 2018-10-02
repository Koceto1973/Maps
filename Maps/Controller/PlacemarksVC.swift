//
//  PlacemarksVC.swift
//  Maps
//
//  Created by К.К. on 30.09.18.
//  Copyright © 2018 TeamK. All rights reserved.
//

import UIKit

class PlacemarksVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var placemarks:[[String]] = [[]]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return placemarks.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell" )
        cell.textLabel?.text = placemarks[indexPath.row][0]
        
        return cell
    }
    
    // swipe delete table view row
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            placemarks.remove(at: indexPath.row)
            tableView.reloadData()
            UserDefaults.standard.set(self.placemarks, forKey: "placemarks")
        }
    }
    
    // prepare for segue to show annotation
    var annotationIndex = -1
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAnnotation" {
            let destinationVC = segue.destination as! BasicMapVC
            destinationVC.annotationIndex = self.annotationIndex
            self.annotationIndex = -1
        }
    }
    
    // segue after row selection to show annotation
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.annotationIndex = indexPath.row
        performSegue(withIdentifier: "showAnnotation", sender: nil)
    }
   
}
