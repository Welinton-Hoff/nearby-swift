//
//  PlaceModel.swift
//  Nearby
//
//  Created by Welinton Hoff on 11/12/2024.
//

import Foundation

struct Place: Decodable {
    let id: String
    let name: String
    let coupons: Int
    let phone: String
    let cover: String
    let address: String
    let latitude: Double
    let longitude: Double
    let categoryId: String
    let description: String
}
