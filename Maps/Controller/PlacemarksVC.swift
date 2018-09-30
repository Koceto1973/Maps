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
    
    var placemarks = Placemarks.init()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // reading the permanent storage
        if let data = UserDefaults.standard.object(forKey: "placemarks") as? Placemarks {
            self.placemarks = data
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return placemarks.number }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell" )
        cell.textLabel?.text = String(placemarks.Get(item: 1, of: indexPath.row))
        
        return cell
    }
    
    // UserDefaults.standard.set("data", forKey: "keyToData")
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
