//
//  PlaceTableViewCell.swift
//  Nearby
//
//  Created by Welinton Hoff on 11/12/2024.
//

import Foundation
import UIKit

class PlaceTableViewCell: UITableViewCell {
    static let indentifier: String = "PlaceTableViewCell"
    
    let itemImageView: UIImageView = {
        let itemImage = UIImageView()
        itemImage.clipsToBounds = true
        itemImage.layer.cornerRadius = 8
        itemImage.contentMode = .scaleAspectFill
        itemImage.translatesAutoresizingMaskIntoConstraints = false
        
        return itemImage
    }()
    
    let titleLabel: UILabel = {
        let title = UILabel()
        title.font = Typography.titleSM
        title.translatesAutoresizingMaskIntoConstraints = false
        
        return title
    }()
    
    let descriptionLabel: UILabel = {
        let description = UILabel()
        description.numberOfLines = 0
        description.font = Typography.textXS
        description.textColor = Colors.gray500
        description.translatesAutoresizingMaskIntoConstraints = false
        
        return description
    }()
    
    let ticketIconView: UIImageView = {
        let ticketIcon = UIImageView()
        ticketIcon.clipsToBounds = true
        ticketIcon.layer.cornerRadius = 8
        ticketIcon.tintColor = Colors.redBase
        ticketIcon.contentMode = .scaleAspectFit
        ticketIcon.image = UIImage(named: "ticket")
        ticketIcon.translatesAutoresizingMaskIntoConstraints = false
        
        return ticketIcon
    }()
    
    let ticketLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.textXS
        label.textColor = Colors.gray400
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let containerView: UIView = {
        let container = UIView()
        container.layer.borderWidth = 1
        container.layer.cornerRadius = 8
        container.layer.borderColor = Colors.gray200.cgColor
        container.translatesAutoresizingMaskIntoConstraints = false
        
        return container
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(containerView)
        containerView.addSubview(itemImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(descriptionLabel)
        containerView.addSubview(ticketIconView)
        containerView.addSubview(ticketLabel)
        
        setupContraints()
    }
    
    private func setupContraints() {
        NSLayoutConstraint.activate([
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            containerView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 8),
            
            itemImageView.widthAnchor.constraint(equalToConstant: 116),
            itemImageView.heightAnchor.constraint(equalToConstant: 104),
            itemImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            itemImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            itemImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8),
            itemImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            descriptionLabel.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            
            ticketIconView.widthAnchor.constraint(equalToConstant: 13),
            ticketIconView.heightAnchor.constraint(equalToConstant: 11),
            ticketIconView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8),
            ticketIconView.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 16),
            
            ticketLabel.centerYAnchor.constraint(equalTo: ticketIconView.centerYAnchor),
            ticketLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            ticketLabel.leadingAnchor.constraint(equalTo: ticketIconView.trailingAnchor, constant: 4)
        ])
    }
    
    func configure(with place: Place) {
        if let url = URL(string: place.cover) {
            URLSession.shared.dataTask(with: url) { data, _, _ in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async { self.itemImageView.image = image }
                }
            }.resume()
        }
        
        titleLabel.text = place.name
        descriptionLabel.text = place.description
        ticketLabel.text = "\(place.coupons) cupoms disponíveis"
    }
}
