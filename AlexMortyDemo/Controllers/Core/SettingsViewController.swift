//
//  SettingsViewController.swift
//  AlexMortyDemo
//
//  Created by AlexYang on 2023/3/21.
//

import UIKit
import SwiftUI

class SettingsViewController: UIViewController {

    private let settingSwiftUIController = UIHostingController(
        rootView: RMSettingsView(
            viewModel: RMSettingsViewViewModel(
                cellViewModel: RMSettingsOption.allCases.compactMap({
                    return RMSettingsCellViewModel(type: $0)
                })
            )
        )
    )

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "設定"
        addSwiftUIController()
    }
    
    private func addSwiftUIController() {
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
    }

}
