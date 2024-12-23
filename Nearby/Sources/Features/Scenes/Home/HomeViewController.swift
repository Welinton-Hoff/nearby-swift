//
//  HomeViewController.swift
//  Nearby
//
//  Created by Welinton Hoff on 11/12/2024.
//

import Foundation
import UIKit
import MapKit

class HomeViewController: UIViewController {
    private var places: [Place] = []
    private let homeview = HomeView()
    private var homeViewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = homeview
        homeview.mapView.delegate = self
        homeview.configureTableViewDelegate(self, dataSource: self)
        
        defineInitialLocation()
        
        homeViewModel.fetchInitialData{ [weak self] categories in
                guard let self = self else { return }
            self.homeview.updateFilterButtons(with: categories) { selectedCategory in
                self.filterPlaces(by: selectedCategory)
            }
        }
        
        self.addAnnotationsToMap()
        homeViewModel.didUpdatePlaces = { [weak self] in
            DispatchQueue.main.async {
                self?.places = self?.homeViewModel.places ?? []
                self?.homeview.reloadTableViewData()
                self?.addAnnotationsToMap()
            }
        }
    }
    
    private func defineInitialLocation() {
        let initialLocation = CLLocationCoordinate2D(latitude: -23.561187293883442, longitude: -46.656451388116494)
        homeview.mapView.setRegion(
            MKCoordinateRegion(center: initialLocation,
                               span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)), animated: false)
    }
    
    private func addAnnotationsToMap() {
        homeview.mapView.removeAnnotations(homeview.mapView.annotations)
        let annotations = places.map{ PlaceAnnotation(place: $0) }
        
        homeview.mapView.addAnnotations(annotations)
        
        if let firstAnnotation = annotations.first {
            homeview.mapView.setRegion(
                MKCoordinateRegion(center: firstAnnotation.coordinate,
                                   span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)), animated: true)
        }
    }
    
    private func filterPlaces(by category: Category) {
        let currentCenter = homeview.mapView.region.center
        homeViewModel.fetchPlaces(for: category.id, userLocation: currentCenter)
    }
}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return places.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PlaceTableViewCell.indentifier, for: indexPath)
                as? PlaceTableViewCell else {
            return UITableViewCell()
        }

        cell.configure(with: places[indexPath.section])
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let details = DetailsViewController()
        details.place = places[indexPath.section]

        navigationController?.pushViewController(details, animated: true)
    }
}

extension HomeViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else { return nil }
        
        let identifier = "CustomPin"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            
            annotationView?.canShowCallout = true
            annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            
            if let pinImage = UIImage(named: "mapIcon") {
                annotationView?.image = pinImage
                annotationView?.frame.size = CGSize(width: 32, height: 32)
            }
        } else {
            annotationView?.annotation = annotation
        }
        
        return annotationView
    }
    
    func mapView(
        _ mapView: MKMapView,
        annotationView view: MKAnnotationView,
        calloutAccessoryControlTapped control: UIControl) {
            guard view.annotation is PlaceAnnotation else { return }
        }
}
