//
//  HomeView.swift
//  Nearby
//
//  Created by Welinton Hoff on 11/12/2024.
//

import Foundation
import MapKit

class HomeView: UIView {
    private var selectedButton: UIButton?
    private var categories: [Category] = []
    private var filterButtonAction: ((Category) -> Void)?
    
    let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        return mapView
    }()
    
    private let filterScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isUserInteractionEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    private let containerView: UIView = {
        let container = UIView()
        container.clipsToBounds = true
        container.layer.cornerRadius = 16
        container.backgroundColor = Colors.gray100
        container.translatesAutoresizingMaskIntoConstraints = false
        
        return container
    }()
    
    private let dragIndicatorView: UIView = {
        let dragIndicator = UIView()
        dragIndicator.layer.cornerRadius = 3
        dragIndicator.backgroundColor = Colors.gray300
        dragIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        return dragIndicator
    }()
    
    private let descriptionLabel: UILabel = {
        let description = UILabel()
        description.font = Typography.textMD
        description.textColor = Colors.gray600
        description.text = "Explore locais perto de você"
        description.translatesAutoresizingMaskIntoConstraints = false
        
        return description
    }()
    
    private let filterStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 8
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.isUserInteractionEnabled = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let placesTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.contentInset = UIEdgeInsets(top: -10, left: 0, bottom: 0, right: 0)
        tableView.register(PlaceTableViewCell.self, forCellReuseIdentifier: PlaceTableViewCell.indentifier)
        
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var containerTopConstraint: NSLayoutConstraint!
    
    private func setupUI() {
        addSubview(mapView)
        addSubview(filterScrollView)
        addSubview(containerView)
        
        filterScrollView.addSubview(filterStackView)
        
        containerView.addSubview(dragIndicatorView)
        containerView.addSubview(descriptionLabel)
        containerView.addSubview(placesTableView)
        
        setupPanGesture()
        setupContraints()
    }
    
    private func setupContraints() {
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: topAnchor),
            mapView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mapView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.65),
            
            filterScrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            filterScrollView.topAnchor.constraint(equalTo: topAnchor, constant: 72),
            filterScrollView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            filterScrollView.heightAnchor.constraint(equalTo: filterStackView.heightAnchor),
            
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            filterStackView.heightAnchor.constraint(equalToConstant: 40),
            filterStackView.topAnchor.constraint(equalTo: filterScrollView.topAnchor),
            filterStackView.bottomAnchor.constraint(equalTo: filterScrollView.bottomAnchor),
            filterStackView.leadingAnchor.constraint(equalTo: filterScrollView.leadingAnchor),
            filterStackView.trailingAnchor.constraint(equalTo: filterScrollView.trailingAnchor),
        ])
        
        containerTopConstraint = containerView.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: -16)
        containerTopConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            dragIndicatorView.widthAnchor.constraint(equalToConstant: 80),
            dragIndicatorView.heightAnchor.constraint(equalToConstant: 4),
            dragIndicatorView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            dragIndicatorView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            
            
            descriptionLabel.topAnchor.constraint(equalTo: dragIndicatorView.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            descriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            
            placesTableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            placesTableView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            placesTableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            placesTableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
        ])
    }
    
    func configureTableViewDelegate(_ delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        placesTableView.delegate = delegate
        placesTableView.dataSource = dataSource
    }
    
    func setupPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        containerView.addGestureRecognizer(panGesture)
        
    }
    
    func updateFilterButtons(with categories: [Category], action: @escaping (Category) -> Void) {
        let categoryIcons: [String: String] = [
            "Cinema": "film",
            "Compras": "cart",
            "Hospedagem": "bed.double",
            "Alimentação": "fork.knife",
            "Padaria": "cup.and.saucer",
        ]
        
        self.categories = categories
        self.filterButtonAction = action
        
        for (index, category) in categories.enumerated() {
            let iconName = categoryIcons[category.name] ?? "questionmark.circle"
            let button = createFilterButton(title: category.name, iconName: iconName)
            
            button.tag = index
            button.addTarget(self, action: #selector(filterButtonTapped(_:)), for: .touchUpInside)
            
            if category.name == "Alimentação" {
                updateButtonSelection(button: button)
            }
            
            filterStackView.addArrangedSubview(button)
        }
    }
    
    private func createFilterButton(title: String, iconName: String) -> UIButton {
        let button = UIButton(type: .system)
        
        button.setTitle(title, for: .normal)
        button.setImage(UIImage(systemName: iconName), for: .normal)
        
        button.layer.cornerRadius = 8
        button.tintColor = Colors.gray600
        button.backgroundColor = Colors.gray100
        button.titleLabel?.font = Typography.textSM
        button.setTitleColor(Colors.gray600, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 36).isActive = true
        
        button.imageView?.contentMode = .scaleAspectFit
        button.imageView?.widthAnchor.constraint(equalToConstant: 13).isActive = true
        button.imageView?.heightAnchor.constraint(equalToConstant: 13).isActive = true
        
        if #available(iOS 15.0, *) {
            var configuration = UIButton.Configuration.plain()
            
            configuration.imagePadding = 4
            configuration.titlePadding = 8
            button.configuration = configuration
        } else {
            button.imageEdgeInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 8)
            button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        }
        
        return button
    }
    
    private func updateButtonSelection(button: UIButton) {
        if let previousButton = selectedButton {
            previousButton.tintColor = Colors.gray600
            previousButton.backgroundColor = Colors.gray100
            previousButton.setTitleColor(Colors.gray600, for: .normal)
        }
        
        button.tintColor = Colors.gray100
        button.backgroundColor = Colors.greenBase
        button.setTitleColor(Colors.gray100, for: .normal)
        
        selectedButton = button
    }
    
    @objc
    private func filterButtonTapped(_ sender: UIButton) {
        let selectedCategory = categories[sender.tag]
        
        updateButtonSelection(button: sender)
        filterButtonAction?(selectedCategory)
    }
    
    func reloadTableViewData() {
        DispatchQueue.main.async {
            self.placesTableView.reloadData()   
        }
    }
    
    @objc
    private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let velocity = gesture.velocity(in: self)
        let translation = gesture.translation(in: self)
        
        switch gesture.state {
        case .changed:
            let newConstant = containerTopConstraint.constant + translation.y
            if newConstant <= 0 && newConstant >= frame.height * 0.5 {
                containerTopConstraint.constant = newConstant
                gesture.setTranslation(.zero, in: self)
            }
        case .ended:
            let finalPosition: CGFloat
            let halfScreenHeight = -frame.height * 0.25
            
            if velocity.y > 0 {
                finalPosition = -16
            } else {
                finalPosition = halfScreenHeight
            }
            
            UIView.animate(withDuration: 0.3, animations: {
                self.containerTopConstraint.constant = finalPosition
                self.layoutIfNeeded()
            })
            
        default: break
        }
    }
}
