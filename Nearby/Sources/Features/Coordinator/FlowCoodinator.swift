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
        let startViewController = SplashViewController(contentView: contentView, delegate: self)
        self.navigationController = UINavigationController(rootViewController: startViewController)
        
        return navigationController
    }
}

extension FlowCoodinator: SplashFlowDelegate {
    func decideNavigationFlow() {
        let contentView = WelcomeView()
        let welcomeViewController = WelcomeViewController(contentView: contentView)
        
        welcomeViewController.flowDelegate = self
        navigationController?.pushViewController(welcomeViewController, animated: true)
    }
}

extension FlowCoodinator: WelcomeFlowDelegate {
    func goToHome() {
        let homeViewController = HomeViewController()
        navigationController?.pushViewController(homeViewController, animated: true)
    }
}
