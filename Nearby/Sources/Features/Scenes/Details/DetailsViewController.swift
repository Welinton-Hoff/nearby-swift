//
//  DetailsViewController.swift
//  Nearby
//
//  Created by Welinton Hoff on 13/12/2024.
//

import Foundation
import UIKit

class DetailsViewController: UIViewController {
    var place: Place?
    private let detailsView = DetailsView()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func loadView() {
        view = detailsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureDetails()
        setupBackButton()
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func setupBackButton() {
        detailsView.backButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    @objc private func didTapButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func configureDetails() {
        guard let place = place else { return }
        
        detailsView.titleLabel.text = place.name
        detailsView.descriptionLabel.text = place.description
        
        let phoneRow = DetailRowView(iconName: "phone", text: place.phone)
        let addressRow = DetailRowView(iconName: "mapPin", text: place.address)
        let couponsRow = DetailRowView(iconName: "ticket", text: "\(place.coupons) cupons disponíveis")
        
        detailsView.infoStackView.addArrangedSubview(phoneRow)
        detailsView.infoStackView.addArrangedSubview(addressRow)
        detailsView.infoStackView.addArrangedSubview(couponsRow)
        
        detailsView.couponCodeLabel.text = place.id
        detailsView.regulationLabel.text = """
        • Válido apenas para consumo local
        
        • Disponível até 31/12/2024 
        """
        
        if let url = URL(string: place.cover) {
            URLSession.shared.dataTask(with: url) { data, _, _ in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.detailsView.coverImageView.image = image
                    }
                }
            }.resume()
        }
    }

}
