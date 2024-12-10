//
//  FlowCoodinator.swift
//  Pocket
//
//  Created by Welinton Hoff on 10/12/2024.
//

import Foundation
import UIKit

class FlowCoodinator {
    private var navigationController: UINavigationController?
    
    public init() {
    }
    
    func start() -> UINavigationController? {
        let contentView = SplashView()
        let startViewController = SplashViewController(contentView: contentView)
        self.navigationController = UINavigationController(rootViewController: startViewController)
        
        return navigationController
    }
}

