//
//  SplashViewController.swift
//  ExchangeRate
//
//  Created by Leo Gabuev on 13.05.2026.
//

import UIKit

final class SplashViewController: UIViewController {
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "bitcoinsign.arrow.trianglehead.counterclockwise.rotate.90"))
        imageView.tintColor = .systemYellow
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        setupLayot()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.switchToMainScreen()
        }
    }
    
    private func setupLayot() {
        view.addSubview(logoImageView)
        
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 100),
            logoImageView.heightAnchor.constraint(equalToConstant: 100)])
    }
    
    private func switchToMainScreen() {
        let mainVC = ExchangeViewController()
        let navigationController = UINavigationController(rootViewController: mainVC)
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else {
            let oldWindow = UIApplication.shared.windows.first
            oldWindow?.rootViewController = UINavigationController(rootViewController: mainVC)
            return
        }
        window.rootViewController = navigationController
        
        
        UIView.transition(with: window,
                          duration: 0.5,
                          options: .transitionCrossDissolve,
                          animations: nil)
        
    }
}
