//
//  Weather.swift
//  WeatherApp
//
//  Created by Aakash Kumbhar on 04/02/19.
//  Copyright © 2019 Palvi Rane. All rights reserved.
//

import Foundation

struct WeatherModel: Decodable
{
    let value: Float?
    let year: Int?
    let month: Int?
}


struct WeatherGroup: Decodable
{
    let key: Int?
    var value: [WeatherModel]?
    
}
