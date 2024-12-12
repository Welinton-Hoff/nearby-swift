//
//  HomeViewModel.swift
//  Nearby
//
//  Created by Welinton Hoff on 11/12/2024.
//

import Foundation
import CoreLocation

class HomeViewModel {
    private let baseURL = "http://127.0.0.1:3333"
    
    var userLatidude = -23.561187293883442
    var userLongitude = -46.656451388116494
    
    var places: [Place] = []
    var filteredPlaces: [Place] = []
    var didUpdatePlaces: (() -> Void)?
    var didUpdateCategories: (() -> Void)?
    
    public func fetchInitialData(completion: @escaping ([Category]) -> Void) {
        fetchCategories { categories in
            if let foodCategory = categories.first(where: {$0.name == "Alimentação"}) {
                self.fetchPlaces(
                    for: foodCategory.id,
                    userLocation: CLLocationCoordinate2D(latitude: self.userLatidude, longitude: self.userLongitude))
            }
        }
    }
    
    private func fetchCategories(completion: @escaping ([Category]) -> Void) {
        guard let url = URL(string: "\(baseURL)/categories") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error fetching categories: \(error)")
                return
            }
            
            guard let data = data else {
                completion([])
                return
            }
            
            do {
                let categories = try JSONDecoder().decode([Category].self, from: data)
                DispatchQueue.main.async {  completion(categories) }
            } catch {
                print("Error decoding categories: \(error)")
                completion([])
            }
        }.resume()
    }
    
    func fetchPlaces(for categoryID: String, userLocation: CLLocationCoordinate2D) {
        guard let url = URL(string: "\(baseURL)/markets/category/\(categoryID)") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error fetching places: \(error)")
                return
            }
            
            guard let data = data else { return }
            
            if let jsonString = String(data: data, encoding: .utf8) {
                print("fetchPlaces Response: \(jsonString)")
            }
            
            do {
                self.places = try JSONDecoder().decode([Place].self, from: data)
                DispatchQueue.main.async {  self.didUpdatePlaces?() }
            } catch {
                print("Error decoding places: \(error)")
            }
        }.resume()
    }
    
}
