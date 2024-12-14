//
//  DetailsView.swift
//  Nearby
//
//  Created by Welinton Hoff on 14/12/2024.
//

import Foundation
import UIKit

class DetailsView: UIView {
    private let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        view.backgroundColor = Colors.gray100
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    let backButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.layer.cornerRadius = 12
        button.backgroundColor = Colors.greenBase
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let arrowImage = UIImage(systemName: "arrow.left")?.withRenderingMode(.alwaysTemplate)
        let arrowImageView = UIImageView(image: arrowImage)
        
        button.addSubview(arrowImageView)
        arrowImageView.tintColor = Colors.gray100
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            arrowImageView.widthAnchor.constraint(equalToConstant: 20),
            arrowImageView.heightAnchor.constraint(equalToConstant: 20),
            arrowImageView.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            arrowImageView.centerYAnchor.constraint(equalTo: button.centerYAnchor)
        ])
        
        return button
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = Typography.titleLG
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .darkGray
        label.font = Typography.textSM
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let infoTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Informações"
        label.font = Typography.textMD
        label.textColor = Colors.gray500
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let regulationTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Regulamento"
        label.font = Typography.titleMD
        label.textColor = Colors.gray500
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let couponTitleLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.titleMD
        label.textColor = Colors.gray500
        label.text = "Utilize esse cupom"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 8
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    let regulationLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .darkGray
        label.font = Typography.titleSM
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let couponStackView: UIStackView = {
        let iconImageView = UIImageView()
        iconImageView.tintColor = Colors.greenBase
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.image = UIImage(named: "ticket")
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        let stackView = UIStackView(arrangedSubviews: [iconImageView])
        stackView.spacing = 4
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.layer.cornerRadius = 8
        stackView.backgroundColor = Colors.greenExtraLight
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        
        return stackView
    }()
    
    let couponCodeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = Typography.titleMD
        label.textColor = Colors.gray600
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let qrCodeButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 8
        button.backgroundColor = Colors.greenBase
        button.titleLabel?.font = Typography.action
        button.setTitle("Ler QR Code", for: .normal)
        button.setTitleColor(Colors.gray100, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private let divider: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.gray200
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let divider2: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.gray200
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(coverImageView)
        addSubview(backButton)
        addSubview(containerView)
        
        containerView.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(infoTitleLabel)
        contentView.addSubview(infoStackView)
        contentView.addSubview(divider)
        contentView.addSubview(regulationTitleLabel)
        contentView.addSubview(regulationLabel)
        contentView.addSubview(divider2)
        contentView.addSubview(couponTitleLabel)
        contentView.addSubview(couponStackView)
        contentView.addSubview(qrCodeButton)
        couponStackView.addArrangedSubview(couponCodeLabel)

        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            coverImageView.topAnchor.constraint(equalTo: topAnchor),
            coverImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            coverImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            coverImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.35),
            
            backButton.widthAnchor.constraint(equalToConstant: 40),
            backButton.heightAnchor.constraint(equalToConstant: 40),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.topAnchor.constraint(equalTo: coverImageView.bottomAnchor, constant: -16),
            
            scrollView.topAnchor.constraint(equalTo: containerView.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 32),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            
            infoTitleLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 24),
            infoTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            
            infoStackView.topAnchor.constraint(equalTo: infoTitleLabel.bottomAnchor, constant: 12),
            infoStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            infoStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            
            divider.heightAnchor.constraint(equalToConstant: 1),
            divider.topAnchor.constraint(equalTo: infoStackView.bottomAnchor, constant: 16),
            divider.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            divider.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            
            regulationTitleLabel.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 16),
            regulationTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            
            regulationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            regulationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            regulationLabel.topAnchor.constraint(equalTo: regulationTitleLabel.bottomAnchor, constant: 12),
            
            divider2.heightAnchor.constraint(equalToConstant: 1),
            divider2.topAnchor.constraint(equalTo: regulationLabel.bottomAnchor, constant: 16),
            divider2.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            divider2.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            
            couponTitleLabel.topAnchor.constraint(equalTo: divider2.bottomAnchor, constant: 16),
            couponTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            
            couponStackView.heightAnchor.constraint(equalToConstant: 40),
            couponStackView.topAnchor.constraint(equalTo: couponTitleLabel.bottomAnchor, constant: 12),
            couponStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            couponStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            
            qrCodeButton.heightAnchor.constraint(equalToConstant: 44),
            qrCodeButton.topAnchor.constraint(equalTo: couponStackView.bottomAnchor, constant: 64),
            qrCodeButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -32),
            qrCodeButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            qrCodeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
        ])
    }
}
