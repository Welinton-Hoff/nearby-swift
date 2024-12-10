//
//  WelcomeView.swift
//  Nearby
//
//  Created by Welinton Hoff on 10/12/2024.
//

import Foundation
import UIKit

class WelcomeView: UIView {
    private let logoImageView: UIImageView = {
        let logo = UIImageView(image: UIImage(named: "logo"))
        
        logo.contentMode = .scaleAspectFit
        logo.translatesAutoresizingMaskIntoConstraints = false
        
        return logo
    }()
    
    private let welcomeLabel: UILabel = {
        let title = UILabel()
        
        title.text = "Boas vindas ao Nearby!"
        title.translatesAutoresizingMaskIntoConstraints = false
        
        return title
    }()
    
    private let descriptionLabel: UILabel = {
        let description = UILabel()
        
        description.text = "Tenha cupons de vantegem para usar em seus estabelecimentos favoritos."
        description.translatesAutoresizingMaskIntoConstraints = false
        
        return description
    }()
    
    private let tipsStackView: UIStackView = {
       let stackView = UIStackView()
        
        stackView.spacing = 16
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let startButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.layer.cornerRadius = 8
        button.setTitle("Começar", for: .normal)
        button.backgroundColor = Colors.greenBase
        button.setTitleColor(Colors.gray100, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        setupTips()
        
        addSubview(logoImageView)
        addSubview(welcomeLabel)
        addSubview(descriptionLabel)
        addSubview(tipsStackView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            logoImageView.widthAnchor.constraint(equalToConstant: 48),
            logoImageView.heightAnchor.constraint(equalToConstant: 48),
            logoImageView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            logoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            
            welcomeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            welcomeLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 8),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            descriptionLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 4),
            
            tipsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            tipsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            tipsStackView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            
            startButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 8),
            startButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            startButton.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 8),
        ])
    }
    
    private func setupTips() {
        guard let icon1 = UIImage(named: "mapIcon") else { return }
        let tip1 = TipsView(
            icon: icon1,
            title: "Encontre estabelecimentos",
            description: "Veja locais perto de você que são parceiros Nearby")
        
        guard let icon2 = UIImage(named: "qrcode") else { return }
        let tip2 = TipsView(
            icon: icon2,
            title: "Ative o cupom com QR code",
            description: "Escaneie o código no estabelecimento para usar o benefício")
        
        guard let icon3 = UIImage(named: "ticket") else { return }
        let tip3 = TipsView(
            icon: icon3,
            title: "Garanta vantagens perto de você",
            description: "Ative cupons onde estiver, em diferentes tipos de estabelecimento")
        
        tipsStackView.addArrangedSubview(tip1)
        tipsStackView.addArrangedSubview(tip2)
        tipsStackView.addArrangedSubview(tip3)
    }
    
}


