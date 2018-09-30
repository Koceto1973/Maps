//
//  Placemarks.swift
//  Maps
//
//  Created by К.К. on 30.09.18.
//  Copyright © 2018 TeamK. All rights reserved.
//

import Foundation


typealias Placemark = (String,String,String)

struct Placemarks {
    private var data:[Placemark]
    var number:Int
    
    init(){
        data = []
        number = 0
    }
    init(with data:[Placemark]){
        self.data = data
        number = data.count
    }
    
    mutating func Add( placemark:Placemark) {
        data.append(placemark)
        number += 1
    }
    
    mutating func Remove(at index:Int) {
        data.remove(at: index)
        number -= 1
    }
    
    func Get() -> [Placemark] {
        let data = self.data
        return data
    }
    
    func Get( item number:Int, of element:Int) ->String {
        if element >= 0 && element < self.number {
            switch number
            {
            case 1 : return data[element].0
            case 2 : return data[element].1
            case 3 : return data[element].2
            
            default: return ""
            }
        }
        
        return ""
    }
}
