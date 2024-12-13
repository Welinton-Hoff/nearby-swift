//
//  DetailsViewController.swift
//  Nearby
//
//  Created by Welinton Hoff on 13/12/2024.
//

import Foundation
import UIKit

class DetailsViewController: UIViewController {
    var place : Place?
    
    private let contentView = UIView()
    private let scrollView = UIScrollView()
    
    private let coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        view.backgroundColor = Colors.gray100
        
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = Typography.titleLG
        
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .darkGray
        label.font = Typography.textSM

        return label
    }()
    
    private let infoTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Informações"
        label.font = Typography.textMD
        label.textColor = Colors.gray500
        
        return label
    }()
    
    private let regulationTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Regulamento"
        label.font = Typography.titleMD
        label.textColor = Colors.gray500

        return label
    }()
    
    private let couponTitleLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.titleMD
        label.textColor = Colors.gray500
        label.text = "Utilize esse cupom"
        
        return label
    }()
    
    private let infoStackView = UIStackView()
    
    private let regulationLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .darkGray
        label.font = Typography.titleSM
        
        return label
    }()
    
    private let couponStackView: UIStackView = {
        let iconImageView = UIImageView(image: UIImage(named: "ticket"))
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.tintColor = Colors.greenBase
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
    
    private let couponCodeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = Typography.titleMD
        label.textColor = Colors.gray600

        return label
    }()
    
    private let qrCodeButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 8
        button.backgroundColor = Colors.greenBase
        button.titleLabel?.font = Typography.action
        button.setTitle("Ler QR Code", for: .normal)
        button.setTitleColor(Colors.gray100, for: .normal)
        
        return button
    }()
    
    private let divider: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.gray200
        
        return view
    }()
    
    private let divider2: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.gray200
        
        return view
    }()
    
    private let backButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.layer.cornerRadius = 12
        button.backgroundColor = Colors.greenBase
        
        
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        configureDetails()
        setupBackButton()
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(coverImageView)
        contentView.addSubview(containerView)
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(descriptionLabel)
        containerView.addSubview(infoTitleLabel)
        containerView.addSubview(infoStackView)
        containerView.addSubview(divider)
        containerView.addSubview(regulationTitleLabel)
        containerView.addSubview(regulationLabel)
        containerView.addSubview(divider2)
        containerView.addSubview(couponTitleLabel)
        containerView.addSubview(couponStackView)
        containerView.addSubview(qrCodeButton)
        
        couponStackView.addArrangedSubview(couponCodeLabel)
        infoStackView.axis = .vertical
        infoStackView.spacing = 8
        setupTranslates()
        setupConstraints()
        
    }
    
    private func setupTranslates() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        coverImageView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        infoTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        infoStackView.translatesAutoresizingMaskIntoConstraints = false
        divider.translatesAutoresizingMaskIntoConstraints = false
        regulationTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        regulationLabel.translatesAutoresizingMaskIntoConstraints = false
        divider2.translatesAutoresizingMaskIntoConstraints = false
        couponTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        qrCodeButton.translatesAutoresizingMaskIntoConstraints = false

    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            
            coverImageView.topAnchor.constraint(equalTo: view.topAnchor),
            coverImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.4),
            coverImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            coverImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            containerView.topAnchor.constraint(equalTo: coverImageView.bottomAnchor, constant: -20),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 32),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            
            infoTitleLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 24),
            infoTitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            
            infoStackView.topAnchor.constraint(equalTo: infoTitleLabel.bottomAnchor, constant: 12),
            
            divider.topAnchor.constraint(equalTo: infoStackView.bottomAnchor, constant: 16),
            divider.heightAnchor.constraint(equalToConstant: 1),
            
            regulationTitleLabel.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 16),
            regulationTitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            
            regulationLabel.topAnchor.constraint(equalTo: regulationTitleLabel.bottomAnchor, constant: 12),
            
            divider2.topAnchor.constraint(equalTo: regulationLabel.bottomAnchor, constant: 16),
            divider2.heightAnchor.constraint(equalToConstant: 1),
            
            couponTitleLabel.topAnchor.constraint(equalTo: divider2.bottomAnchor, constant: 16),
            couponTitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            
            couponStackView.topAnchor.constraint(equalTo: couponTitleLabel.bottomAnchor, constant: 12),
            couponStackView.heightAnchor.constraint(equalToConstant: 40),
            
            qrCodeButton.heightAnchor.constraint(equalToConstant: 44),
            qrCodeButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -32),

        ])
        
        applyLateralConstraints(to: descriptionLabel)
        applyLateralConstraints(to: infoStackView)
        applyLateralConstraints(to: divider)
        applyLateralConstraints(to: divider2)
        applyLateralConstraints(to: regulationLabel)
        applyLateralConstraints(to: couponStackView)
        applyLateralConstraints(to: qrCodeButton)
    }
    
    private func applyLateralConstraints(to view: UIView) {
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
        ])
    }
    
    private func setupBackButton() {
        view.addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            backButton.heightAnchor.constraint(equalToConstant: 40),
            backButton.widthAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    @objc private func didTapButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func configureDetails() {
        guard let place = place else { return }
        
        titleLabel.text = place.name
        descriptionLabel.text = place.description
        
        infoStackView.addArrangedSubview(createInfoRow(iconName: "ticket", text: "\(place.coupons) cupons disponíveis"))
        infoStackView.addArrangedSubview(createInfoRow(iconName: "mapIcon", text: place.address))
        infoStackView.addArrangedSubview(createInfoRow(iconName: "phone", text: place.phone))
        
        couponCodeLabel.text = place.id
        regulationLabel.text = """
        * Válido apenas para consumo local
        
        * Disponível até 31/12/2024 
        """
        
        if let url = URL(string: place.cover) {
            URLSession.shared.dataTask(with: url) { data, _, _ in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.coverImageView.image = image
                    }
                }
            }.resume()
        }
        
    }
    
    private func createInfoRow(iconName: String, text: String) -> UIStackView {
        let iconImageView = UIImageView(image: UIImage(named: iconName))
        iconImageView.tintColor = Colors.gray500
        iconImageView.contentMode = .scaleAspectFill
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        
        let label = UILabel()
        label.text = text
        label.font = Typography.textSM
        label.textColor = Colors.gray500
        
        let stackView = UIStackView(arrangedSubviews: [iconImageView, label])
        stackView.spacing = 8
        stackView.axis = .horizontal
        
        return stackView
    }
}
