//
//  MyLocation.swift
//  WeatherAndMap
//
//  Created by 田中康志 on 2025/02/16.
//

import Foundation
import CoreLocation

struct MyLocation: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}
