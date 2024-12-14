//
//  DetailRowView.swift
//  Nearby
//
//  Created by Welinton Hoff on 14/12/2024.
//

import Foundation
import UIKit

class DetailRowView: UIView {
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = Colors.gray500
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = Typography.textSM
        label.textColor = Colors.gray500
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 8
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    init(iconName: String, text: String) {
        super.init(frame: .zero)
        
        setupComponent(iconName: iconName, text: text)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupComponent(iconName: String, text: String) {
        iconImageView.image = UIImage(named: iconName)
        label.text = text
    }

    private func setupView() {
        stackView.addArrangedSubview(iconImageView)
        stackView.addArrangedSubview(label)
        addSubview(stackView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}

