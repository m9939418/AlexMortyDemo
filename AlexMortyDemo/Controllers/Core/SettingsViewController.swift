//
//  SettingsViewController.swift
//  AlexMortyDemo
//
//  Created by AlexYang on 2023/3/21.
//

import StoreKit
import SafariServices
import UIKit
import SwiftUI

class SettingsViewController: UIViewController {
    
    private var settingSwiftUIController: UIHostingController<RMSettingsView>?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "設定"
        addSwiftUIController()
    }
    
    private func addSwiftUIController() {
        let settingSwiftUIController = UIHostingController(
            rootView: RMSettingsView(
                viewModel: RMSettingsViewViewModel(
                    cellViewModel: RMSettingsOption.allCases.compactMap({
                        return RMSettingsCellViewModel(type: $0) { [weak self] option in
                            self?.handleTap(options: option)
                        }
                    })
                )
            )
        )
        addChild(settingSwiftUIController)
        settingSwiftUIController.didMove(toParent: self )
        
        view.addSubview(settingSwiftUIController.view)
        settingSwiftUIController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            settingSwiftUIController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            settingSwiftUIController.view.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            settingSwiftUIController.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            settingSwiftUIController.view.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
        ])
        
        self.settingSwiftUIController = settingSwiftUIController
    }
    
    private func handleTap(options: RMSettingsOption) {
        guard Thread.current.isMainThread else {
            return
        }
        if let url = options.targetUrl {
            //Open Website
            let vc = SFSafariViewController(url: url)
            present(vc, animated: true)
        } else if options == .rateApp {
            //Show rate prompt
            if let windowScene = view.window?.windowScene {
                SKStoreReviewController.requestReview(in:windowScene)
            }
        }
    }

}
