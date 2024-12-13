//
//  TipsView.swift
//  Nearby
//
//  Created by Welinton Hoff on 10/12/2024.
//

import Foundation
import UIKit

public class TipsView: UIView {
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = Colors.redBase
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let title = UILabel()
        title.numberOfLines = 0
        title.font = Typography.titleSM
        title.translatesAutoresizingMaskIntoConstraints = false
        
        return title
    }()
    
    private let descriptionLabel: UILabel = {
        let description = UILabel()
        description.numberOfLines = 0
        description.font = Typography.textSM
        description.translatesAutoresizingMaskIntoConstraints = false
        
        return description
    }()
    
    init(icon: UIImage, title: String, description: String) {
        super.init(frame: .zero)
        
        setupUI()
        setupComponent(icon: icon, title: title, description: description)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupComponent(icon: UIImage, title: String, description: String) {
        iconImageView.image = icon
        titleLabel.text = title
        descriptionLabel.text = description
    }
    
    private func setupUI() {
        self.addSubview(iconImageView)
        self.addSubview(titleLabel)
        self.addSubview(descriptionLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            iconImageView.widthAnchor.constraint(equalToConstant: 24),
            iconImageView.heightAnchor.constraint(equalToConstant: 24),
            iconImageView.topAnchor.constraint(equalTo: self.topAnchor),
            iconImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 16),
            
            descriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 4),
        ])
    }
    
}
